import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../../shared/models/user_role.dart';
import '../auth/auth_provider.dart';
import 'unauthorized_vehicle_screen.dart';

class ConfirmVehicleScreen extends ConsumerStatefulWidget {
  const ConfirmVehicleScreen({super.key, required this.vehicleData});
  final Map<String, dynamic> vehicleData;

  @override
  ConsumerState<ConfirmVehicleScreen> createState() =>
      _ConfirmVehicleScreenState();
}

class _ConfirmVehicleScreenState extends ConsumerState<ConfirmVehicleScreen> {
  bool _isLoading = false;

  Future<String?> _checkVehicleInFleet() async {
    final existing = await Supabase.instance.client
        .from('vehicles')
        .select('id')
        .eq('license_plate', widget.vehicleData['licensePlate'] as String)
        .maybeSingle();
    return existing?['id'] as String?;
  }

  Future<String> _getOrCreateVehicle() async {
    final supabase = Supabase.instance.client;
    final user     = ref.read(currentUserProvider)!;

    final existing = await supabase
        .from('vehicles')
        .select('id')
        .eq('license_plate', widget.vehicleData['licensePlate'] as String)
        .maybeSingle();

    if (existing != null) return existing['id'] as String;

    final res = await supabase
        .from('vehicles')
        .insert({
      'license_plate': widget.vehicleData['licensePlate'],
      'make':          widget.vehicleData['make'],
      'model':         widget.vehicleData['model'],
      'year':          widget.vehicleData['year'],
      'colour':        widget.vehicleData['colour'],
      'vin':           widget.vehicleData['vin'],
      'branch_id':     user.branchId,
      'updated_at':    DateTime.now().toIso8601String(),
    })
        .select('id')
        .single();

    return res['id'] as String;
  }

  Future<void> _logService() async {
    setState(() => _isLoading = true);
    try {
      final role = ref.read(currentUserProvider)?.role;

      if (role == UserRole.technician || role == UserRole.salesman) {
        final existingId = await _checkVehicleInFleet();
        if (existingId == null) {
          if (mounted) {
            await Navigator.push(context, MaterialPageRoute(
              builder: (_) => UnauthorizedVehicleScreen(
                  vehicleData: widget.vehicleData),
            ));
          }
          setState(() => _isLoading = false);
          return;
        }
        if (mounted) {
          context.push(AppRoute.serviceEntry, extra: {
            'licensePlate': widget.vehicleData['licensePlate'],
            'make':         widget.vehicleData['make'],
            'model':        widget.vehicleData['model'],
            'year':         widget.vehicleData['year'],
            'colour':       widget.vehicleData['colour'],
            'vin':          widget.vehicleData['vin'],
            'vehicleId':    existingId,
          });
        }
      } else {
        final vehicleId = await _getOrCreateVehicle();
        if (mounted) {
          context.push(AppRoute.serviceEntry, extra: {
            'licensePlate': widget.vehicleData['licensePlate'],
            'make':         widget.vehicleData['make'],
            'model':        widget.vehicleData['model'],
            'year':         widget.vehicleData['year'],
            'colour':       widget.vehicleData['colour'],
            'vin':          widget.vehicleData['vin'],
            'vehicleId':    vehicleId,
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.danger,
        ));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _viewHistory() async {
    setState(() => _isLoading = true);
    try {
      final vehicleId = await _getOrCreateVehicle();
      if (mounted) context.push('/vehicle/$vehicleId');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.danger,
        ));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final v    = widget.vehicleData;
    final role = ref.watch(currentUserProvider)?.role;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Confirm vehicle details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.greyDark,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(v['licensePlate'] as String? ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 26,
                                    fontWeight: FontWeight.w800, letterSpacing: 2)),
                            const SizedBox(height: 2),
                            Text('${v['year']} ${v['make']} ${v['model']}',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _DetailRow('Colour', v['colour'] as String? ?? ''),
                      if (v['vin'] != null)
                        _DetailRow('VIN', v['vin'] as String),
                      if (v['vehicleType'] != null)
                        _DetailRow('Type', v['vehicleType'] as String),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              flex: 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('What would you like to do?',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.md),
                      if (_isLoading)
                        const Center(child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                              color: AppColors.primary),
                        ))
                      else ...[
                        ElevatedButton.icon(
                          icon: const Icon(Icons.build_rounded),
                          label: const Text('Log a service'),
                          onPressed: _logService,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        if (role != UserRole.technician)
                          OutlinedButton.icon(
                            icon: const Icon(Icons.history),
                            label: const Text('View service history'),
                            onPressed: _viewHistory,
                          ),
                        const SizedBox(height: AppSpacing.sm),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.qr_code_scanner),
                          label: const Text('Scan different vehicle'),
                          onPressed: () => context.pop(),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.2))),
                        child: Row(children: [
                          const Icon(Icons.verified_outlined,
                              color: AppColors.primary, size: 16),
                          const SizedBox(width: 8),
                          Expanded(child: Text(
                              'Details read from PDF417 license disk barcode',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.primary))),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);
  final String label, value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 80, child: Text(label,
          style: Theme.of(context).textTheme.bodyMedium)),
      Expanded(child: Text(value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600))),
    ]),
  );
}