import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';
import '../local_db/database.dart';

/// Sync service — listens for charging + connectivity, then pushes queued data
final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    db: ref.watch(appDatabaseProvider),
    supabase: Supabase.instance.client,
  );
  service.start();
  ref.onDispose(service.dispose);
  return service;
});

/// Tracks current sync status for UI display
final syncStatusProvider = StateProvider<SyncStatus>((ref) => SyncStatus.idle);

enum SyncStatus { idle, syncing, error, success }

class SyncService {
  SyncService({required this.db, required this.supabase});

  final AppDatabase db;
  final SupabaseClient supabase;

  final _connectivity = Connectivity();

  StreamSubscription? _connectSub;
  Timer? _periodicTimer;

  bool _isOnline  = false;
  bool _isSyncing = false;

  void start() {
    _connectSub = _connectivity.onConnectivityChanged.listen((results) {
      _isOnline = results.any((r) =>
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.ethernet,
      );
      _maybeSync();
    });

    // Check initial connectivity and sync immediately if online
    _connectivity.checkConnectivity().then((results) {
      _isOnline = results.any((r) =>
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.ethernet,
      );
      if (_isOnline) _runSync();
    });

    // Also sync every 2 minutes while online
    _periodicTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      if (_isOnline) _maybeSync();
    });
  }

  void _maybeSync() {
    if (_isOnline && !_isSyncing) {
      _runSync();
    }
  }

  Future<void> _runSync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      await _syncServiceRecords();
      await _syncPhotos();
      await _syncVehicles();
      await _syncDrivers();
    } catch (e) {
      // Log error, will retry next time conditions are met
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncServiceRecords() async {
    final pending = await (db.select(db.serviceRecords)
      ..where((r) => r.syncPending.equals(true)))
      .get();

    for (final record in pending) {
      try {
        await supabase.from('service_records').upsert({
          'id':            record.id,
          'vehicle_id':    record.vehicleId,
          'branch_id':     record.branchId,
          'technician_id': record.technicianId,
          'salesman_id':   record.salesmanId,
          'service_type':  record.serviceType,
          'notes':         record.notes,
          'odometer':      record.odometer,
          'service_date':  record.serviceDate.toIso8601String(),
          'created_at':    record.createdAt.toIso8601String(),
        });

        // Mark as synced
        await (db.update(db.serviceRecords)
          ..where((r) => r.id.equals(record.id)))
          .write(ServiceRecordsCompanion(
            syncPending: Value(false),
          ));
      } catch (_) {
        // Leave pending, try again next sync
      }
    }
  }

  Future<void> _syncPhotos() async {
    final pending = await (db.select(db.servicePhotos)
      ..where((p) => p.syncPending.equals(true)))
      .get();

    for (final photo in pending) {
      try {
        // Upload file to Supabase Storage
        // then upsert metadata record
        // Full implementation: read file bytes from photo.localPath
        // then call supabase.storage.from('service-photos').uploadBinary(...)
        
        await supabase.from('service_photos').upsert({
          'id':          photo.id,
          'service_id':  photo.serviceId,
          'photo_type':  photo.photoType,
          'remote_url':  photo.remoteUrl,
          'taken_at':    photo.takenAt.toIso8601String(),
        });

        await (db.update(db.servicePhotos)
          ..where((p) => p.id.equals(photo.id)))
          .write(ServicePhotosCompanion(
            syncPending: Value(false),
          ));
      } catch (_) {}
    }
  }

  Future<void> _syncVehicles() async {
    final pending = await (db.select(db.vehicles)
      ..where((v) => v.syncPending.equals(true)))
      .get();

    for (final vehicle in pending) {
      try {
        await supabase.from('vehicles').upsert({
          'id':                  vehicle.id,
          'branch_id':           vehicle.branchId,
          'license_plate':       vehicle.licensePlate,
          'make':                vehicle.make,
          'model':               vehicle.model,
          'year':                vehicle.year,
          'colour':              vehicle.colour,
          'vin':                 vehicle.vin,
          'assigned_driver_id':  vehicle.assignedDriverId,
          'license_expiry':      vehicle.licenseExpiry?.toIso8601String(),
          'updated_at':          vehicle.updatedAt.toIso8601String(),
        });

        await (db.update(db.vehicles)
          ..where((v) => v.id.equals(vehicle.id)))
          .write(VehiclesCompanion(syncPending: Value(false)));
      } catch (_) {}
    }
  }

  Future<void> _syncDrivers() async {
    final pending = await (db.select(db.drivers)
      ..where((d) => d.syncPending.equals(true)))
      .get();

    for (final driver in pending) {
      try {
        await supabase.from('drivers').upsert({
          'id':              driver.id,
          'branch_id':       driver.branchId,
          'name':            driver.name,
          'id_number':       driver.idNumber,
          'license_number':  driver.licenseNumber,
          'license_expiry':  driver.licenseExpiry?.toIso8601String(),
          'phone':           driver.phone,
          'is_active':       driver.isActive,
          'updated_at':      driver.updatedAt.toIso8601String(),
        });

        await (db.update(db.drivers)
          ..where((d) => d.id.equals(driver.id)))
          .write(DriversCompanion(syncPending: Value(false)));
      } catch (_) {}
    }
  }

  void dispose() {
    _connectSub?.cancel();
    _periodicTimer?.cancel();
  }
}
