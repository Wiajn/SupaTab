import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../app/theme.dart';
import '../auth/auth_provider.dart';

final vehicleHistoryProvider = FutureProvider.family<VehicleHistory, String>(
  (ref, vehicleId) async {
    final supabase = ref.watch(supabaseProvider);
    final vehicleRes = await supabase
        .from('vehicles')
        .select('*, drivers(name, phone)')
        .eq('id', vehicleId)
        .single();
    final servicesRes = await supabase
        .from('service_records')
        .select('*, app_users(name), service_photos(*)')
        .eq('vehicle_id', vehicleId)
        .order('service_date', ascending: false);
    return VehicleHistory(
      vehicle:  VehicleDetail.fromMap(vehicleRes),
      services: (servicesRes as List).map((s) => ServiceEntry.fromMap(s)).toList(),
    );
  },
);

class VehicleHistory {
  const VehicleHistory({required this.vehicle, required this.services});
  final VehicleDetail      vehicle;
  final List<ServiceEntry> services;
}

class VehicleDetail {
  const VehicleDetail({
    required this.id, required this.licensePlate, required this.make,
    required this.model, required this.year, required this.colour,
    this.vin, this.driverName, this.driverPhone,
  });
  factory VehicleDetail.fromMap(Map m) {
    final d = m['drivers'] as Map?;
    return VehicleDetail(
      id: m['id'] as String, licensePlate: m['license_plate'] as String,
      make: m['make'] as String, model: m['model'] as String,
      year: m['year'] as int, colour: m['colour'] as String,
      vin: m['vin'] as String?,
      driverName: d?['name'] as String?, driverPhone: d?['phone'] as String?,
    );
  }
  final String id, licensePlate, make, model, colour;
  final int year;
  final String? vin, driverName, driverPhone;
}

class ServiceEntry {
  const ServiceEntry({
    required this.id, required this.serviceType, required this.serviceDate,
    required this.odometer, required this.technicianName,
    this.notes, this.photoCount = 0,
  });
  factory ServiceEntry.fromMap(Map m) {
    final tech   = m['app_users'] as Map?;
    final photos = (m['service_photos'] as List? ?? []);
    return ServiceEntry(
      id: m['id'] as String, serviceType: m['service_type'] as String,
      serviceDate: DateTime.parse(m['service_date'] as String),
      odometer: m['odometer'] as int,
      technicianName: tech?['name'] as String? ?? 'Unknown',
      notes: m['notes'] as String?, photoCount: photos.length,
    );
  }
  final String id, serviceType, technicianName;
  final DateTime serviceDate;
  final int odometer, photoCount;
  final String? notes;
  String get category => serviceType.contains('—') ? serviceType.split('—').first.trim() : serviceType;
  String get subType  => serviceType.contains('—') ? serviceType.split('—').last.trim()  : serviceType;
}

class VehicleDetailScreen extends ConsumerWidget {
  const VehicleDetailScreen({super.key, required this.vehicleId});
  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(vehicleHistoryProvider(vehicleId));
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Vehicle history')),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error:   (e, _) => _ErrorState(message: e.toString()),
        data:    (h) => _Body(history: h),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.history});
  final VehicleHistory history;

  @override
  Widget build(BuildContext context) {
    final v = history.vehicle;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Left panel
        SizedBox(width: 260, child: Column(children: [
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(v.licensePlate, style: const TextStyle(
                    color: Colors.white, fontSize: 22,
                    fontWeight: FontWeight.w800, letterSpacing: 2)),
                  Text('${v.year} ${v.make} ${v.model}',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                ])),
              const SizedBox(height: 14),
              _InfoRow('Colour', v.colour),
              if (v.vin != null) _InfoRow('VIN', v.vin!),
              const Divider(height: 20),
              if (v.driverName != null) ...[
                const Text('DRIVER', style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600,
                  letterSpacing: 1, color: AppColors.textMuted)),
                const SizedBox(height: 8),
                Row(children: [
                  Container(
                    width: 34, height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(17)),
                    child: Center(child: Text(
                      v.driverName!.substring(0, 1),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700, color: AppColors.accent)))),
                  const SizedBox(width: 10),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(v.driverName!, style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
                    if (v.driverPhone != null)
                      Text(v.driverPhone!, style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
                  ]),
                ]),
              ] else
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.warning.withOpacity(0.3))),
                  child: const Row(children: [
                    Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 16),
                    SizedBox(width: 8),
                    Text('No driver assigned', style: TextStyle(
                      fontSize: 12, color: AppColors.warning, fontWeight: FontWeight.w500)),
                  ])),
            ]),
          )),
          const SizedBox(height: 12),
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('SUMMARY', style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600,
                letterSpacing: 1, color: AppColors.textMuted)),
              const SizedBox(height: 10),
              _StatRow('Total services', '${history.services.length}'),
              if (history.services.isNotEmpty) ...[
                _StatRow('Last service',
                  DateFormat('dd MMM yyyy').format(history.services.first.serviceDate)),
                _StatRow('Last odometer',
                  '${NumberFormat('#,###').format(history.services.first.odometer)} km'),
              ],
            ]),
          )),
        ])),

        const SizedBox(width: 16),

        // Timeline
        Expanded(child: history.services.isEmpty
          ? Card(child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history_rounded, size: 56,
                  color: AppColors.textMuted.withOpacity(0.3)),
                const SizedBox(height: 14),
                const Text('No service history yet',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                    color: AppColors.textMuted)),
              ])))
          : Card(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Service history (${history.services.length} records)',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                Expanded(child: ListView.builder(
                  itemCount: history.services.length,
                  itemBuilder: (_, i) => _TimelineEntry(
                    entry:  history.services[i],
                    isLast: i == history.services.length - 1,
                  ),
                )),
              ]),
            )),
        ),
      ]),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.entry, required this.isLast});
  final ServiceEntry entry;
  final bool         isLast;

  Color get _color => switch (entry.category) {
    'Full Service'          => AppColors.accent,
    'Tyre Service'          => AppColors.blue,
    'Brake Service'         => AppColors.primary,
    'Suspension & Steering' => AppColors.warning,
    'Electrical'            => const Color(0xFF9FBBE0),
    _                       => AppColors.textSecondary,
  };

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 28, child: Column(children: [
        Container(width: 14, height: 14,
          decoration: BoxDecoration(
            color: _color, shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2))),
        if (!isLast) Expanded(child: Container(width: 2, color: AppColors.cardBorder)),
      ])),
      const SizedBox(width: 12),
      Expanded(child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _color.withOpacity(0.3))),
              child: Text(entry.category, style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w700,
                color: _color, letterSpacing: 0.3))),
            const Spacer(),
            Text(DateFormat('dd MMM yyyy').format(entry.serviceDate),
              style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ]),
          const SizedBox(height: 5),
          Text(entry.subType, style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600,
            color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.speed_outlined, size: 13, color: AppColors.textMuted),
            const SizedBox(width: 4),
            Text('${NumberFormat('#,###').format(entry.odometer)} km',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(width: 14),
            const Icon(Icons.person_outline, size: 13, color: AppColors.textMuted),
            const SizedBox(width: 4),
            Text(entry.technicianName,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ]),
          if (entry.notes != null && entry.notes!.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(entry.notes!, style: const TextStyle(
              fontSize: 12, color: AppColors.textSecondary,
              fontStyle: FontStyle.italic)),
          ],
          if (entry.photoCount > 0) ...[
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.photo_library_outlined, size: 13, color: AppColors.accent),
              const SizedBox(width: 4),
              Text('${entry.photoCount} photos',
                style: const TextStyle(fontSize: 11, color: AppColors.accent,
                  fontWeight: FontWeight.w500)),
            ]),
          ],
        ]),
      )),
    ]),
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(children: [
      SizedBox(width: 55, child: Text(label, style: const TextStyle(
        fontSize: 11, color: AppColors.textSecondary))),
      Expanded(child: Text(value, style: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
    ]),
  );
}

class _StatRow extends StatelessWidget {
  const _StatRow(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(children: [
      Expanded(child: Text(label, style: const TextStyle(
        fontSize: 12, color: AppColors.textSecondary))),
      Text(value, style: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
    ]),
  );
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.error_outline_rounded, size: 56, color: AppColors.danger),
      const SizedBox(height: 14),
      const Text('Could not load vehicle history',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary)),
      const SizedBox(height: 8),
      Text(message, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    ],
  ));
}
