import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../../core/local_db/database.dart';
import '../../main.dart';
import '../auth/auth_provider.dart';

// ─── Service categories ──────────────────────────────────────

const Map<String, List<String>> kServiceCategories = {
  'Full Service': [
    'Minor Service',
    'Major Service',
    'Filter Service',
    'Full Inspection',
  ],
  'Tyre Service': [
    'Tyre Rotation',
    'Tyre Balancing',
    'Wheel Alignment',
    'Tyre Replacement',
    'Puncture Repair',
    'Spare Tyre Check',
  ],
  'Brake Service': [
    'Brake Pad Replacement',
    'Brake Disc Replacement',
    'Drum Brake Service',
    'Brake Fluid Replacement',
    'Brake Inspection',
  ],
  'Suspension & Steering': [
    'Shock Absorber Testing',
    'Shock Absorber Replacement',
    'Wheel Bearing Replacement',
    'Tie Rod Replacement',
    'Steering Fluid',
    'Suspension Inspection',
  ],
  'Electrical': [
    'Battery Test',
    'Battery Replacement',
    'Alternator Service',
    'Starter Motor Service',
    'Electrical Inspection',
    'Lighting Service',
  ],
  'Other': [
    'General Repair',
    'Body Work',
    'Air Conditioning',
    'Coolant Service',
    'Transmission Service',
    'Custom (see notes)',
  ],
};

// ─── Screen ──────────────────────────────────────────────────

class ServiceEntryScreen extends ConsumerStatefulWidget {
  const ServiceEntryScreen({super.key, required this.vehicleData});
  final Map<String, dynamic> vehicleData;

  @override
  ConsumerState<ServiceEntryScreen> createState() =>
    _ServiceEntryScreenState();
}

class _ServiceEntryScreenState extends ConsumerState<ServiceEntryScreen> {
  final _formKey      = GlobalKey<FormState>();
  final _jobCardCtrl  = TextEditingController();
  final _odomCtrl     = TextEditingController();
  final _notesCtrl    = TextEditingController();

  String?  _category;
  String?  _subService;
  DateTime _serviceDate = DateTime.now();
  bool     _isSaving    = false;

  @override
  void dispose() {
    _jobCardCtrl.dispose();
    _odomCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  bool get _canEditDate =>
    ref.read(currentUserProvider)?.role.canEditServiceDates ?? false;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _serviceDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary)),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _serviceDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_category == null || _subService == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a service category and type'),
        backgroundColor: AppColors.danger,
      ));
      return;
    }

    setState(() => _isSaving = true);
    try {
      final db          = ref.read(appDatabaseProvider);
      final user        = ref.read(currentUserProvider)!;
      final id          = const Uuid().v4();
      final serviceType = '$_category — $_subService';
      final vehicleId   = widget.vehicleData['vehicleId'] as String?
                          ?? const Uuid().v4();

      await db.into(db.serviceRecords).insert(ServiceRecordsCompanion(
        id:           Value(id),
        vehicleId:    Value(vehicleId),
        branchId:     Value(user.branchId),
        technicianId: Value(user.id),
        serviceType:  Value(serviceType),
        notes:        Value(_notesCtrl.text.trim().isEmpty
                        ? null : '${_jobCardCtrl.text.trim()} | ${_notesCtrl.text.trim()}'),
        odometer:     Value(int.parse(_odomCtrl.text.trim())),
        serviceDate:  Value(_serviceDate),
        createdAt:    Value(DateTime.now()),
        syncPending:  const Value(true),
      ));

      if (mounted) {
        context.push(AppRoute.photoCapture, extra: {'serviceId': id});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error saving service: $e'),
          backgroundColor: AppColors.danger,
        ));
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = widget.vehicleData;
    final user    = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Log service'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Vehicle info panel ──
            SizedBox(width: 240, child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(vehicle['licensePlate'] as String? ?? '',
                            style: const TextStyle(
                              color: Colors.white, fontSize: 20,
                              fontWeight: FontWeight.w800, letterSpacing: 1)),
                          const SizedBox(height: 2),
                          Text(
                            '${vehicle['year']} ${vehicle['make']} ${vehicle['model']}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12)),
                        ]),
                    ),
                    const SizedBox(height: 16),
                    _InfoRow('Colour', vehicle['colour'] as String? ?? ''),
                    if (vehicle['vin'] != null)
                      _InfoRow('VIN', vehicle['vin'] as String),
                    const Divider(height: 24),
                    const Text('TECHNICIAN', style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600,
                      letterSpacing: 1, color: AppColors.textMuted)),
                    const SizedBox(height: 6),
                    Text(user?.name ?? '', style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
                    Text(user?.role.displayName ?? '', style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            )),

            const SizedBox(width: 16),

            // ── Form panel ──
            Expanded(child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Service details', style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                      const SizedBox(height: 16),

                      // Job card + odometer
                      Row(children: [
                        Expanded(child: TextFormField(
                          controller: _jobCardCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Job card number',
                            hintText: 'e.g. JC-00123',
                            prefixIcon: Icon(Icons.receipt_long_outlined,
                              size: 18)),
                          validator: (v) => v == null || v.isEmpty
                            ? 'Enter job card number' : null,
                        )),
                        const SizedBox(width: 16),
                        Expanded(child: TextFormField(
                          controller: _odomCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly],
                          decoration: const InputDecoration(
                            labelText: 'Odometer (km)',
                            hintText: 'e.g. 87450',
                            prefixIcon: Icon(Icons.speed_outlined, size: 18)),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Enter odometer reading';
                            }
                            if (int.tryParse(v) == null) {
                              return 'Numbers only';
                            }
                            return null;
                          },
                        )),
                      ]),

                      const SizedBox(height: 16),

                      // Category + subservice
                      Row(children: [
                        Expanded(child: DropdownButtonFormField<String>(
                          value: _category,
                          decoration: const InputDecoration(
                            labelText: 'Service category',
                            prefixIcon: Icon(Icons.build_outlined, size: 18)),
                          items: kServiceCategories.keys.map((c) =>
                            DropdownMenuItem(value: c, child: Text(c))
                          ).toList(),
                          onChanged: (val) => setState(() {
                            _category   = val;
                            _subService = null;
                          }),
                          validator: (v) =>
                            v == null ? 'Select a category' : null,
                        )),
                        const SizedBox(width: 16),
                        Expanded(child: DropdownButtonFormField<String>(
                          value: _subService,
                          decoration: const InputDecoration(
                            labelText: 'Service type',
                            prefixIcon: Icon(Icons.tune_outlined, size: 18)),
                          items: _category == null ? [] :
                            kServiceCategories[_category]!.map((s) =>
                              DropdownMenuItem(value: s, child: Text(s))
                            ).toList(),
                          onChanged: _category == null ? null :
                            (val) => setState(() => _subService = val),
                          validator: (v) =>
                            v == null ? 'Select service type' : null,
                        )),
                      ]),

                      const SizedBox(height: 16),

                      // Date
                      InkWell(
                        onTap: _canEditDate ? _pickDate : null,
                        borderRadius: BorderRadius.circular(10),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Service date',
                            prefixIcon: const Icon(
                              Icons.calendar_today_outlined, size: 18),
                            suffixIcon: Icon(
                              _canEditDate
                                ? Icons.edit_outlined
                                : Icons.lock_outline,
                              size: 16,
                              color: AppColors.textMuted,
                            ),
                          ),
                          child: Text(
                            DateFormat('dd MMMM yyyy').format(_serviceDate),
                            style: const TextStyle(fontSize: 14)),
                        ),
                      ),
                      if (!_canEditDate)
                        const Padding(
                          padding: EdgeInsets.only(top: 4, left: 12),
                          child: Text(
                            'Date can only be changed by a salesman or manager',
                            style: TextStyle(
                              fontSize: 11, color: AppColors.textMuted)),
                        ),

                      const SizedBox(height: 16),

                      // Notes
                      Expanded(child: TextFormField(
                        controller: _notesCtrl,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          labelText: 'Notes (optional)',
                          hintText: 'Any additional details...',
                          alignLabelWithHint: true,
                        ),
                      )),

                      const SizedBox(height: 16),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: _isSaving
                            ? const SizedBox(width: 18, height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.camera_alt_outlined),
                          label: Text(_isSaving
                            ? 'Saving...' : 'Save & take photos'),
                          onPressed: _isSaving ? null : _save,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(children: [
      SizedBox(width: 55, child: Text(label, style: const TextStyle(
        fontSize: 11, color: AppColors.textSecondary))),
      Expanded(child: Text(value, style: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w600,
        color: AppColors.textPrimary))),
    ]),
  );
}
