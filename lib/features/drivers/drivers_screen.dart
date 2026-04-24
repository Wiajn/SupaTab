import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../app/theme.dart';
import '../auth/auth_provider.dart';

// ─── Provider ────────────────────────────────────────────────

final driversProvider = FutureProvider<List<DriverRecord>>((ref) async {
  final user     = ref.watch(currentUserProvider);
  if (user == null) return [];
  final supabase = ref.watch(supabaseProvider);

  final res = await supabase
      .from('drivers')
      .select('*, vehicles(id, license_plate, make, model)')
      .eq('branch_id', user.branchId)
      .eq('is_active', true)
      .order('name');

  return (res as List).map((d) => DriverRecord.fromMap(d)).toList();
});

final vehiclesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user     = ref.watch(currentUserProvider);
  if (user == null) return [];
  final supabase = ref.watch(supabaseProvider);

  final res = await supabase
      .from('vehicles')
      .select('id, license_plate, make, model')
      .eq('branch_id', user.branchId)
      .order('license_plate');

  return List<Map<String, dynamic>>.from(res as List);
});

// ─── Model ───────────────────────────────────────────────────

class DriverRecord {
  const DriverRecord({
    required this.id,
    required this.name,
    required this.phone,
    required this.isActive,
    this.idNumber,
    this.licenseNumber,
    this.licenseExpiry,
    this.assignedVehicleId,
    this.assignedVehiclePlate,
    this.assignedVehicleModel,
  });

  factory DriverRecord.fromMap(Map m) {
    final vehicle = m['vehicles'] as Map?;
    return DriverRecord(
      id:                   m['id'] as String,
      name:                 m['name'] as String,
      phone:                m['phone'] as String? ?? '',
      isActive:             m['is_active'] as bool? ?? true,
      idNumber:             m['id_number'] as String?,
      licenseNumber:        m['license_number'] as String?,
      licenseExpiry:        m['license_expiry'] != null
          ? DateTime.tryParse(m['license_expiry']) : null,
      assignedVehicleId:    vehicle?['id'] as String?,
      assignedVehiclePlate: vehicle?['license_plate'] as String?,
      assignedVehicleModel: vehicle != null
          ? '${vehicle['make']} ${vehicle['model']}' : null,
    );
  }

  final String  id;
  final String  name;
  final String  phone;
  final bool    isActive;
  final String? idNumber;
  final String? licenseNumber;
  final DateTime? licenseExpiry;
  final String? assignedVehicleId;
  final String? assignedVehiclePlate;
  final String? assignedVehicleModel;

  bool get licenseExpiringSoon {
    if (licenseExpiry == null) return false;
    return licenseExpiry!.difference(DateTime.now()).inDays < 30;
  }
}

// ─── Screen ──────────────────────────────────────────────────

class DriversScreen extends ConsumerWidget {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user       = ref.watch(currentUserProvider);
    final driversAsync = ref.watch(driversProvider);
    final canAdd     = user?.role.canManageBranchUsers ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Driver management'),
        actions: [
          if (canAdd)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person_add_outlined, size: 16),
                label: const Text('Add driver'),
                onPressed: () => _showDriverDialog(context, ref, null),
              ),
            ),
        ],
      ),
      body: driversAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(
          child: Text('Error: $e',
            style: const TextStyle(color: AppColors.danger))),
        data: (drivers) => drivers.isEmpty
          ? const Center(child: Text('No drivers found',
              style: TextStyle(color: AppColors.textMuted)))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary row
                  Row(children: [
                    _SummaryChip(
                      label: 'Total drivers',
                      value: '${drivers.length}',
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    _SummaryChip(
                      label: 'Assigned',
                      value: '${drivers.where((d) =>
                        d.assignedVehicleId != null).length}',
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 12),
                    _SummaryChip(
                      label: 'Unassigned',
                      value: '${drivers.where((d) =>
                        d.assignedVehicleId == null).length}',
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 12),
                    _SummaryChip(
                      label: 'License expiring',
                      value: '${drivers.where((d) =>
                        d.licenseExpiringSoon).length}',
                      color: AppColors.danger,
                    ),
                  ]),
                  const SizedBox(height: 16),

                  // Driver list
                  Expanded(child: Card(
                    child: ListView.separated(
                      itemCount: drivers.length,
                      separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                      itemBuilder: (_, i) =>
                        _DriverTile(
                          driver: drivers[i],
                          canEdit: user?.role.canManageDrivers ?? false,
                          canAdd:  canAdd,
                          onEdit: () => _showDriverDialog(
                            context, ref, drivers[i]),
                          onReassign: () => _showReassignDialog(
                            context, ref, drivers[i]),
                          onDeactivate: canAdd
                            ? () => _deactivate(context, ref, drivers[i])
                            : null,
                        ),
                    ),
                  )),
                ],
              ),
            ),
      ),
    );
  }

  Future<void> _showDriverDialog(
      BuildContext context, WidgetRef ref, DriverRecord? driver) async {
    await showDialog(
      context: context,
      builder: (_) => _DriverDialog(driver: driver, ref: ref),
    );
    ref.invalidate(driversProvider);
  }

  Future<void> _showReassignDialog(
      BuildContext context, WidgetRef ref, DriverRecord driver) async {
    await showDialog(
      context: context,
      builder: (_) => _ReassignDialog(driver: driver, ref: ref),
    );
    ref.invalidate(driversProvider);
  }

  Future<void> _deactivate(
      BuildContext context, WidgetRef ref, DriverRecord driver) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Deactivate driver'),
        content: Text(
          'Are you sure you want to deactivate ${driver.name}? '
          'They will no longer appear in the active drivers list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Deactivate')),
        ],
      ),
    );

    if (confirm == true) {
      await Supabase.instance.client
          .from('drivers')
          .update({'is_active': false})
          .eq('id', driver.id);
      ref.invalidate(driversProvider);
    }
  }
}

// ─── Driver tile ─────────────────────────────────────────────

class _DriverTile extends StatelessWidget {
  const _DriverTile({
    required this.driver,
    required this.canEdit,
    required this.canAdd,
    required this.onEdit,
    required this.onReassign,
    this.onDeactivate,
  });

  final DriverRecord driver;
  final bool         canEdit;
  final bool         canAdd;
  final VoidCallback onEdit;
  final VoidCallback onReassign;
  final VoidCallback? onDeactivate;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(children: [
      // Avatar
      Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(22)),
        child: Center(child: Text(
          driver.name.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700,
            color: AppColors.primary))),
      ),
      const SizedBox(width: 14),

      // Info
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(driver.name, style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary)),
            if (driver.licenseExpiringSoon) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.danger.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4)),
                child: const Text('License expiring',
                  style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w600,
                    color: AppColors.danger))),
            ],
          ]),
          const SizedBox(height: 2),
          Text(driver.phone, style: const TextStyle(
            fontSize: 12, color: AppColors.textSecondary)),
          if (driver.licenseExpiry != null)
            Text(
              'License expires: ${DateFormat('dd MMM yyyy').format(driver.licenseExpiry!)}',
              style: TextStyle(
                fontSize: 11,
                color: driver.licenseExpiringSoon
                  ? AppColors.danger : AppColors.textMuted)),
        ],
      )),

      // Vehicle assignment
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: driver.assignedVehicleId != null
            ? AppColors.success.withOpacity(0.08)
            : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: driver.assignedVehicleId != null
              ? AppColors.success.withOpacity(0.3)
              : AppColors.cardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              driver.assignedVehiclePlate ?? 'Unassigned',
              style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700,
                color: driver.assignedVehicleId != null
                  ? AppColors.success : AppColors.textMuted)),
            if (driver.assignedVehicleModel != null)
              Text(driver.assignedVehicleModel!,
                style: const TextStyle(
                  fontSize: 11, color: AppColors.textSecondary)),
          ],
        ),
      ),

      const SizedBox(width: 12),

      // Actions
      if (canEdit) ...[
        IconButton(
          icon: const Icon(Icons.swap_horiz_rounded,
            color: AppColors.info, size: 20),
          tooltip: 'Reassign vehicle',
          onPressed: onReassign,
        ),
        IconButton(
          icon: const Icon(Icons.edit_outlined,
            color: AppColors.textSecondary, size: 20),
          tooltip: 'Edit driver',
          onPressed: onEdit,
        ),
        if (onDeactivate != null)
          IconButton(
            icon: const Icon(Icons.person_off_outlined,
              color: AppColors.danger, size: 20),
            tooltip: 'Deactivate driver',
            onPressed: onDeactivate,
          ),
      ],
    ]),
  );
}

// ─── Summary chip ─────────────────────────────────────────────

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color  color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Row(children: [
      Text(value, style: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w800, color: color)),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(
        fontSize: 12, color: AppColors.textSecondary)),
    ]),
  );
}

// ─── Driver dialog (add/edit) ─────────────────────────────────

class _DriverDialog extends StatefulWidget {
  const _DriverDialog({this.driver, required this.ref});
  final DriverRecord? driver;
  final WidgetRef     ref;

  @override
  State<_DriverDialog> createState() => _DriverDialogState();
}

class _DriverDialogState extends State<_DriverDialog> {
  final _nameCtrl    = TextEditingController();
  final _phoneCtrl   = TextEditingController();
  final _idCtrl      = TextEditingController();
  final _licCtrl     = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.driver != null) {
      _nameCtrl.text  = widget.driver!.name;
      _phoneCtrl.text = widget.driver!.phone;
      _idCtrl.text    = widget.driver!.idNumber ?? '';
      _licCtrl.text   = widget.driver!.licenseNumber ?? '';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _idCtrl.dispose();
    _licCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);

    try {
      final user = widget.ref.read(currentUserProvider)!;
      final data = {
        'branch_id':      user.branchId,
        'name':           _nameCtrl.text.trim(),
        'phone':          _phoneCtrl.text.trim(),
        'id_number':      _idCtrl.text.trim().isEmpty
                            ? null : _idCtrl.text.trim(),
        'license_number': _licCtrl.text.trim().isEmpty
                            ? null : _licCtrl.text.trim(),
        'updated_at':     DateTime.now().toIso8601String(),
      };

      if (widget.driver == null) {
        await Supabase.instance.client.from('drivers').insert(data);
      } else {
        await Supabase.instance.client
            .from('drivers')
            .update(data)
            .eq('id', widget.driver!.id);
      }
      if (mounted) Navigator.pop(context);
    } catch (_) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.driver == null ? 'Add driver' : 'Edit driver'),
    content: SizedBox(
      width: 400,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: _nameCtrl,
          decoration: const InputDecoration(labelText: 'Full name')),
        const SizedBox(height: 12),
        TextField(controller: _phoneCtrl,
          decoration: const InputDecoration(labelText: 'Phone number'),
          keyboardType: TextInputType.phone),
        const SizedBox(height: 12),
        TextField(controller: _idCtrl,
          decoration: const InputDecoration(labelText: 'ID number (optional)')),
        const SizedBox(height: 12),
        TextField(controller: _licCtrl,
          decoration: const InputDecoration(
            labelText: 'License number (optional)')),
      ]),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel')),
      ElevatedButton(
        onPressed: _saving ? null : _save,
        child: Text(_saving ? 'Saving...'
          : widget.driver == null ? 'Add' : 'Save')),
    ],
  );
}

// ─── Reassign dialog ─────────────────────────────────────────

class _ReassignDialog extends StatefulWidget {
  const _ReassignDialog({required this.driver, required this.ref});
  final DriverRecord driver;
  final WidgetRef    ref;

  @override
  State<_ReassignDialog> createState() => _ReassignDialogState();
}

class _ReassignDialogState extends State<_ReassignDialog> {
  String? _selectedVehicleId;
  bool    _saving = false;

  @override
  void initState() {
    super.initState();
    _selectedVehicleId = widget.driver.assignedVehicleId;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      // Remove from old vehicle
      if (widget.driver.assignedVehicleId != null) {
        await Supabase.instance.client
            .from('vehicles')
            .update({'assigned_driver_id': null})
            .eq('id', widget.driver.assignedVehicleId!);
      }
      // Assign to new vehicle
      if (_selectedVehicleId != null) {
        await Supabase.instance.client
            .from('vehicles')
            .update({'assigned_driver_id': widget.driver.id})
            .eq('id', _selectedVehicleId!);
      }
      if (mounted) Navigator.pop(context);
    } catch (_) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesAsync = widget.ref.watch(vehiclesProvider);

    return AlertDialog(
      title: Text('Reassign vehicle — ${widget.driver.name}'),
      content: SizedBox(
        width: 400,
        child: vehiclesAsync.when(
          loading: () => const CircularProgressIndicator(),
          error:   (e, _) => Text('Error: $e'),
          data:    (vehicles) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select vehicle to assign:',
                style: TextStyle(color: AppColors.textSecondary,
                  fontSize: 13)),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedVehicleId,
                decoration: const InputDecoration(
                  labelText: 'Vehicle'),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('Unassign (no vehicle)')),
                  ...vehicles.map((v) => DropdownMenuItem(
                    value: v['id'] as String,
                    child: Text(
                      '${v['license_plate']} — ${v['make']} ${v['model']}'),
                  )),
                ],
                onChanged: (val) =>
                  setState(() => _selectedVehicleId = val),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Saving...' : 'Reassign')),
      ],
    );
  }
}
