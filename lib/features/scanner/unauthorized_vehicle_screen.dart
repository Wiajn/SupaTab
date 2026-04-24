import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/theme.dart';
import '../auth/auth_provider.dart';

// ─── Provider to fetch branch manager/owner details ──────────

final branchManagerProvider = FutureProvider<List<ManagerContact>>((ref) async {
  final user     = ref.watch(currentUserProvider);
  if (user == null) return [];
  final supabase = ref.watch(supabaseProvider);

  // Get admins and owners for this branch
  final res = await supabase
      .from('app_users')
      .select('name, role, phone')
      .eq('branch_id', user.branchId)
      .inFilter('role', ['admin', 'owner', 'superAdmin'])
      .eq('is_active', true)
      .order('role');

  return (res as List).map((u) => ManagerContact(
    name:  u['name'] as String,
    role:  u['role'] as String,
    phone: u['phone'] as String?,
  )).toList();
});

class ManagerContact {
  const ManagerContact({
    required this.name,
    required this.role,
    this.phone,
  });
  final String  name;
  final String  role;
  final String? phone;

  String get roleDisplay => switch (role) {
    'admin'      => 'Manager',
    'owner'      => 'Owner',
    'superAdmin' => 'Super Admin',
    _            => role,
  };
}

// ─── Screen ──────────────────────────────────────────────────

class UnauthorizedVehicleScreen extends ConsumerWidget {
  const UnauthorizedVehicleScreen({
    super.key,
    required this.vehicleData,
  });

  final Map<String, dynamic> vehicleData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final managersAsync = ref.watch(branchManagerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Vehicle not in fleet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left — vehicle info
            SizedBox(
              width: 260,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.greyDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicleData['licensePlate'] as String? ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${vehicleData['year']} ${vehicleData['make']} ${vehicleData['model']}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _Row('Colour', vehicleData['colour'] as String? ?? ''),
                      if (vehicleData['vin'] != null)
                        _Row('VIN', vehicleData['vin'] as String),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Right — warning + manager contacts
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Warning card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            width: 56, height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.directions_car_outlined,
                              color: AppColors.accent,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Vehicle not in fleet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'This vehicle is not registered in the fleet system. '
                                  'A manager or owner must authorise and log this service.',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Manager contacts card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contact your manager',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Ask them to come to the tablet to authorise this vehicle.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const Divider(height: 24),
                          managersAsync.when(
                            loading: () => const CircularProgressIndicator(
                              color: AppColors.primary),
                            error: (e, _) => const Text(
                              'Could not load manager details',
                              style: TextStyle(color: AppColors.danger)),
                            data: (managers) => managers.isEmpty
                              ? const Text(
                                  'No managers found for this branch',
                                  style: TextStyle(color: AppColors.textMuted))
                              : Column(
                                  children: managers.map((m) =>
                                    _ManagerTile(manager: m)).toList(),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Scan again button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Scan a different vehicle'),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _ManagerTile extends StatelessWidget {
  const _ManagerTile({required this.manager});
  final ManagerContact manager;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(children: [
      Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            manager.name.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(manager.name, style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary)),
            Text(manager.roleDisplay, style: const TextStyle(
              fontSize: 11, color: AppColors.textSecondary)),
          ],
        ),
      ),
      if (manager.phone != null)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Row(children: [
            const Icon(Icons.phone_outlined,
              size: 14, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(manager.phone!, style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: AppColors.primary)),
          ]),
        ),
    ]),
  );
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);
  final String label, value;
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
