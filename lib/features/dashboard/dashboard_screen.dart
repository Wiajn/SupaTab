import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../auth/auth_provider.dart';

// ─── Providers ───────────────────────────────────────────────

final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return DashboardData.empty();
  final supabase = ref.watch(supabaseProvider);

  final now        = DateTime.now();
  final monthStart = DateTime(now.year, now.month, 1).toIso8601String();

  // Determine which branches this user can see
  List<String> branchIds = [];
  if (user.role.canViewCrossBranch) {
    final all = await supabase.from('branches').select('id');
    branchIds = (all as List).map((b) => b['id'] as String).toList();
  } else if (user.role.canViewOwnedBranches) {
    final owned = await supabase
        .from('branch_owners')
        .select('branch_id')
        .eq('owner_id', user.id);
    branchIds = (owned as List).map((b) => b['branch_id'] as String).toList();
    if (branchIds.isEmpty) branchIds = [user.branchId];
  } else {
    branchIds = [user.branchId];
  }

  final vehiclesRes = await supabase
      .from('vehicles')
      .select('id')
      .inFilter('branch_id', branchIds);

  final servicesRes = await supabase
      .from('service_records')
      .select('id, service_type, service_date, vehicles(license_plate, make, model)')
      .inFilter('branch_id', branchIds)
      .gte('service_date', monthStart)
      .order('service_date', ascending: false);

  List<BranchSummary> branches = [];
  try {
    final branchRes = await supabase
        .from('branch_dashboard_summary')
        .select()
        .inFilter('branch_id', branchIds);
    branches = (branchRes as List).map((b) => BranchSummary.fromMap(b)).toList();
  } catch (_) {}

  final Map<String, int> serviceTypes = {};
  for (final s in servicesRes as List) {
    final type = s['service_type'] as String;
    serviceTypes[type] = (serviceTypes[type] ?? 0) + 1;
  }

  final recent = (servicesRes as List).take(6).map((s) {
    final v = s['vehicles'] as Map?;
    return RecentService(
      plate:       v?['license_plate'] ?? '',
      makeModel:   '${v?['make'] ?? ''} ${v?['model'] ?? ''}',
      serviceType: s['service_type'] ?? '',
      date:        DateTime.tryParse(s['service_date'] ?? '') ?? now,
    );
  }).toList();

  return DashboardData(
    totalVehicles:     (vehiclesRes as List).length,
    servicesThisMonth: (servicesRes as List).length,
    branches:          branches,
    serviceTypes:      serviceTypes,
    recentServices:    recent,
  );
});

// ─── Models ──────────────────────────────────────────────────

class DashboardData {
  const DashboardData({
    required this.totalVehicles,
    required this.servicesThisMonth,
    required this.branches,
    required this.serviceTypes,
    required this.recentServices,
  });
  factory DashboardData.empty() => const DashboardData(
    totalVehicles: 0, servicesThisMonth: 0,
    branches: [], serviceTypes: {}, recentServices: [],
  );
  final int totalVehicles;
  final int servicesThisMonth;
  final List<BranchSummary> branches;
  final Map<String, int> serviceTypes;
  final List<RecentService> recentServices;
}

class BranchSummary {
  const BranchSummary({
    required this.name, required this.city,
    required this.totalVehicles, required this.servicesLast30Days,
    this.lastServiceAt,
  });
  factory BranchSummary.fromMap(Map m) => BranchSummary(
    name:               m['branch_name'] ?? '',
    city:               m['city'] ?? '',
    totalVehicles:      m['total_vehicles'] ?? 0,
    servicesLast30Days: m['services_last_30_days'] ?? 0,
    lastServiceAt:      m['last_service_at'] != null
        ? DateTime.tryParse(m['last_service_at']) : null,
  );
  final String name;
  final String city;
  final int totalVehicles;
  final int servicesLast30Days;
  final DateTime? lastServiceAt;
}

class RecentService {
  const RecentService({
    required this.plate, required this.makeModel,
    required this.serviceType, required this.date,
  });
  final String plate;
  final String makeModel;
  final String serviceType;
  final DateTime date;
}

// ─── Dashboard Screen ─────────────────────────────────────────

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user      = ref.watch(currentUserProvider);
    final dataAsync = ref.watch(dashboardDataProvider);
    final monthName = DateFormat('MMMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _TopBar(user: user),
          Expanded(
            child: dataAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.primary)),
              error: (e, _) => Center(
                child: Text('Error: $e',
                  style: const TextStyle(color: AppColors.danger))),
              data: (data) => Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left
                    SizedBox(width: 270, child: Column(children: [
                      Row(children: [
                        Expanded(child: _KpiCard(
                          label: 'Vehicles serviced',
                          value: '${data.servicesThisMonth}',
                          sub: monthName,
                          color: AppColors.primary,
                          fg: Colors.white,
                        )),
                        const SizedBox(width: 8),
                        Expanded(child: _KpiCard(
                          label: 'Fleet vehicles',
                          value: '${data.totalVehicles}',
                          sub: 'Registered',
                          color: AppColors.surface,
                          fg: AppColors.textPrimary,
                          bordered: true,
                        )),
                      ]),
                      const SizedBox(height: 10),
                      Expanded(child: _BranchCard(branches: data.branches)),
                    ])),

                    const SizedBox(width: 10),

                    // Centre
                    Expanded(child: Column(children: [
                      SizedBox(height: 210,
                        child: _TrendsCard(types: data.serviceTypes)),
                      const SizedBox(height: 10),
                      Expanded(child: _InsightCard(branches: data.branches)),
                    ])),

                    const SizedBox(width: 10),

                    // Right
                    SizedBox(width: 270, child: Column(children: [
                      SizedBox(height: 210,
                        child: _TopModelsCard(services: data.recentServices)),
                      const SizedBox(height: 10),
                      Expanded(child: _RecordsCard(services: data.recentServices)),
                    ])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────

class _TopBar extends ConsumerWidget {
  const _TopBar({this.user});
  final dynamic user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 54,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(children: [
        Image.asset('assets/images/supaquick_logo.png', height: 34),
        const SizedBox(width: 14),
        Container(width: 1, height: 30, color: AppColors.cardBorder),
        const SizedBox(width: 14),
        const Text('Fleet Management Dashboard',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        const Spacer(),
        _Nav('Dashboard', Icons.dashboard_rounded, true, () {}),
        _Nav('Scan Vehicle', Icons.qr_code_scanner, false,
          () => context.push(AppRoute.scanner)),
        if (user?.role.canManageDrivers == true)
          _Nav('Drivers', Icons.people_outline, false,
            () => context.push(AppRoute.drivers)),
        if (user?.role.canViewReports == true)
          _Nav('Reports', Icons.bar_chart_rounded, false,
            () => context.push(AppRoute.reports)),
        const SizedBox(width: 8),
        Container(width: 1, height: 30, color: AppColors.cardBorder),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined,
            color: AppColors.textSecondary, size: 22),
          onPressed: () async {
            await ref.read(authNotifierProvider.notifier).signOut();
            ref.read(currentUserProvider.notifier).state = null;
            if (context.mounted) context.go(AppRoute.pinLogin);
          },
          tooltip: 'Sign out',
        ),
      ]),
    );
  }
}

class _Nav extends StatelessWidget {
  const _Nav(this.label, this.icon, this.active, this.onTap);
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: active ? BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ) : null,
      child: Row(children: [
        Icon(icon, size: 15,
          color: active ? Colors.white : AppColors.textSecondary),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500,
          color: active ? Colors.white : AppColors.textSecondary,
        )),
      ]),
    ),
  );
}

// ─── KPI Card ────────────────────────────────────────────────

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.label, required this.value, required this.sub,
    required this.color, required this.fg, this.bordered = false,
  });
  final String label, value, sub;
  final Color color, fg;
  final bool bordered;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(AppRadius.md),
      border: bordered ? Border.all(color: AppColors.cardBorder) : null,
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(value, style: TextStyle(
        fontSize: 34, fontWeight: FontWeight.w800,
        color: fg, letterSpacing: -1,
      )),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(
        fontSize: 10, fontWeight: FontWeight.w600,
        color: fg.withOpacity(0.8), letterSpacing: 0.3,
      )),
      Text(sub, style: TextStyle(
        fontSize: 10, color: fg.withOpacity(0.6))),
    ]),
  );
}

// ─── Branch Activity ──────────────────────────────────────────

class _BranchCard extends StatelessWidget {
  const _BranchCard({required this.branches});
  final List<BranchSummary> branches;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Branch Activity', style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(child: Text('Branch',
            style: Theme.of(context).textTheme.bodyMedium)),
          Text('Last service',
            style: Theme.of(context).textTheme.bodyMedium),
        ]),
        const Divider(height: 10),
        Expanded(child: branches.isEmpty
          ? const Center(child: Text('No branch data',
              style: TextStyle(color: AppColors.textMuted)))
          : ListView.separated(
              itemCount: branches.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final b = branches[i];
                final t = b.lastServiceAt != null
                  ? DateFormat('d MMM, h:mm a').format(b.lastServiceAt!)
                  : 'No services yet';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(children: [
                    Container(
                      width: 26, height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.store_rounded,
                        size: 13, color: AppColors.primary)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(b.name, style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary))),
                    Text(t, style: const TextStyle(
                      fontSize: 10, color: AppColors.textSecondary)),
                  ]),
                );
              },
            )),
      ]),
    ),
  );
}

// ─── Service Trends ───────────────────────────────────────────

class _TrendsCard extends StatelessWidget {
  const _TrendsCard({required this.types});
  final Map<String, int> types;

  @override
  Widget build(BuildContext context) {
    final entries = types.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maxVal = entries.isEmpty ? 1
      : entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Service Trends by Type', style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w700,
            color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          Expanded(child: entries.isEmpty
            ? const Center(child: Text('No services this month',
                style: TextStyle(color: AppColors.textMuted)))
            : ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (_, i) {
                  final e = entries[i];
                  return Row(children: [
                    SizedBox(width: 100, child: Text(e.key,
                      style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary),
                      overflow: TextOverflow.ellipsis)),
                    Expanded(child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: e.value / maxVal,
                        minHeight: 14,
                        backgroundColor: AppColors.surfaceVariant,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.chartBlue)),
                    )),
                    const SizedBox(width: 6),
                    Text('${e.value}', style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
                  ]);
                },
              )),
        ]),
      ),
    );
  }
}

// ─── Fleet Insight ────────────────────────────────────────────

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.branches});
  final List<BranchSummary> branches;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Fleet Insight', style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Expanded(child: branches.isEmpty
          ? const Center(child: Text('No data',
              style: TextStyle(color: AppColors.textMuted)))
          : ListView.separated(
              itemCount: branches.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final b = branches[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(children: [
                    Container(
                      width: 34, height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.directions_car,
                        size: 16, color: AppColors.textSecondary)),
                    const SizedBox(width: 10),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.name, style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                        Text('${b.city} · ${b.totalVehicles} vehicles',
                          style: const TextStyle(
                            fontSize: 10, color: AppColors.textSecondary)),
                      ])),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                      child: Text('${b.servicesLast30Days}',
                        style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w800,
                          color: AppColors.primary))),
                  ]),
                );
              },
            )),
      ]),
    ),
  );
}

// ─── Top Models ───────────────────────────────────────────────

class _TopModelsCard extends StatelessWidget {
  const _TopModelsCard({required this.services});
  final List<RecentService> services;

  @override
  Widget build(BuildContext context) {
    final Map<String, int> models = {};
    for (final s in services) {
      final k = s.makeModel.trim();
      if (k.isNotEmpty) models[k] = (models[k] ?? 0) + 1;
    }
    final sorted = models.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maxVal = sorted.isEmpty ? 1 : sorted.first.value;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Top Vehicle Models', style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w700,
            color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          Expanded(child: sorted.isEmpty
            ? const Center(child: Text('No data yet',
                style: TextStyle(color: AppColors.textMuted)))
            : ListView.separated(
                itemCount: sorted.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (_, i) {
                  final e = sorted[i];
                  return Row(children: [
                    Expanded(child: Text(e.key,
                      style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary),
                      overflow: TextOverflow.ellipsis)),
                    SizedBox(width: 70, child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: e.value / maxVal,
                        minHeight: 6,
                        backgroundColor: AppColors.surfaceVariant,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.chartBlue)))),
                    const SizedBox(width: 6),
                    Text('${e.value}', style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
                  ]);
                },
              )),
        ]),
      ),
    );
  }
}

// ─── Recent Records ───────────────────────────────────────────

class _RecordsCard extends StatelessWidget {
  const _RecordsCard({required this.services});
  final List<RecentService> services;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Expanded(child: Text('Verified Service Records',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
              color: AppColors.textPrimary))),
          TextButton(onPressed: () {},
            child: const Text('View all',
              style: TextStyle(fontSize: 11, color: AppColors.primary))),
        ]),
        const SizedBox(height: 4),
        Expanded(child: services.isEmpty
          ? const Center(child: Text(
              'No services yet.\nScan a vehicle to get started!',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted)))
          : ListView.separated(
              itemCount: services.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final s = services[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(children: [
                    Container(
                      width: 42, height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.directions_car,
                        color: AppColors.textSecondary, size: 20)),
                    const SizedBox(width: 8),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.plate, style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                        Text(s.makeModel, style: const TextStyle(
                          fontSize: 11, color: AppColors.primary,
                          fontWeight: FontWeight.w500)),
                        Text(s.serviceType, style: const TextStyle(
                          fontSize: 10, color: AppColors.textSecondary)),
                      ])),
                    Text(DateFormat('d MMM').format(s.date),
                      style: const TextStyle(
                        fontSize: 10, color: AppColors.textMuted)),
                  ]),
                );
              },
            )),
      ]),
    ),
  );
}
