import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../app/theme.dart';
import '../auth/auth_provider.dart';

// ─── Provider ────────────────────────────────────────────────

final reportsDataProvider = FutureProvider<ReportsData>((ref) async {
  final supabase = ref.watch(supabaseProvider);

  // All branches summary
  final branchRes = await supabase
      .from('branch_dashboard_summary')
      .select();

  // Services this month across all branches
  final now        = DateTime.now();
  final monthStart = DateTime(now.year, now.month, 1).toIso8601String();
  final servicesRes = await supabase
      .from('service_records')
      .select('id, service_type, service_date, branch_id, branches(name)')
      .gte('service_date', monthStart)
      .order('service_date', ascending: false);

  // Service type breakdown
  final Map<String, int> typeBreakdown = {};
  for (final s in servicesRes as List) {
    final type = s['service_type'] as String;
    final category = type.contains('—')
      ? type.split('—').first.trim()
      : type;
    typeBreakdown[category] = (typeBreakdown[category] ?? 0) + 1;
  }

  // Per branch this month
  final Map<String, int> branchServices = {};
  for (final s in servicesRes as List) {
    final name = (s['branches'] as Map?)?['name'] as String? ?? 'Unknown';
    branchServices[name] = (branchServices[name] ?? 0) + 1;
  }

  return ReportsData(
    branches:       (branchRes as List)
                      .map((b) => BranchReport.fromMap(b)).toList(),
    typeBreakdown:  typeBreakdown,
    branchServices: branchServices,
    totalThisMonth: (servicesRes as List).length,
  );
});

// ─── Models ──────────────────────────────────────────────────

class ReportsData {
  const ReportsData({
    required this.branches,
    required this.typeBreakdown,
    required this.branchServices,
    required this.totalThisMonth,
  });
  final List<BranchReport> branches;
  final Map<String, int>   typeBreakdown;
  final Map<String, int>   branchServices;
  final int                totalThisMonth;
}

class BranchReport {
  const BranchReport({
    required this.name,
    required this.city,
    required this.totalVehicles,
    required this.activeDrivers,
    required this.servicesLast30Days,
    this.lastServiceAt,
  });

  factory BranchReport.fromMap(Map m) => BranchReport(
    name:               m['branch_name'] ?? '',
    city:               m['city'] ?? '',
    totalVehicles:      m['total_vehicles'] ?? 0,
    activeDrivers:      m['active_drivers'] ?? 0,
    servicesLast30Days: m['services_last_30_days'] ?? 0,
    lastServiceAt:      m['last_service_at'] != null
        ? DateTime.tryParse(m['last_service_at']) : null,
  );

  final String    name;
  final String    city;
  final int       totalVehicles;
  final int       activeDrivers;
  final int       servicesLast30Days;
  final DateTime? lastServiceAt;
}

// ─── Screen ──────────────────────────────────────────────────

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(reportsDataProvider);
    final monthName = DateFormat('MMMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              label: const Text('Super Admin View',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
            ),
          ),
        ],
      ),
      body: dataAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(
          child: Text('Error: $e',
            style: const TextStyle(color: AppColors.danger))),
        data: (data) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top KPIs
              Row(children: [
                _KpiCard('Total branches',
                  '${data.branches.length}',
                  Icons.store_rounded,
                  AppColors.primary),
                const SizedBox(width: 12),
                _KpiCard('Services this month',
                  '${data.totalThisMonth}',
                  Icons.build_rounded,
                  AppColors.success),
                const SizedBox(width: 12),
                _KpiCard('Total vehicles',
                  '${data.branches.fold(0, (s, b) => s + b.totalVehicles)}',
                  Icons.directions_car_rounded,
                  AppColors.info),
                const SizedBox(width: 12),
                _KpiCard('Total drivers',
                  '${data.branches.fold(0, (s, b) => s + b.activeDrivers)}',
                  Icons.people_rounded,
                  AppColors.warning),
              ]),

              const SizedBox(height: 16),

              // Main content
              Expanded(child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Branch table
                  Expanded(flex: 3, child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Branch performance — $monthName',
                            style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                          const SizedBox(height: 12),
                          // Header
                          const Row(children: [
                            Expanded(flex: 3, child: Text('Branch',
                              style: TextStyle(fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted))),
                            Expanded(child: Text('Vehicles',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted))),
                            Expanded(child: Text('Drivers',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted))),
                            Expanded(child: Text('Services',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted))),
                            Expanded(child: Text('Last service',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted))),
                          ]),
                          const Divider(height: 16),
                          Expanded(child: ListView.separated(
                            itemCount: data.branches.length,
                            separatorBuilder: (_, __) =>
                              const Divider(height: 1),
                            itemBuilder: (_, i) {
                              final b = data.branches[i];
                              final lastSvc = b.lastServiceAt != null
                                ? DateFormat('d MMM, HH:mm')
                                    .format(b.lastServiceAt!)
                                : '—';
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                                child: Row(children: [
                                  Expanded(flex: 3, child: Column(
                                    crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                    children: [
                                      Text(b.name, style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary)),
                                      Text(b.city, style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary)),
                                    ])),
                                  Expanded(child: Text('${b.totalVehicles}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary))),
                                  Expanded(child: Text('${b.activeDrivers}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary))),
                                  Expanded(child: Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.success
                                          .withOpacity(0.1),
                                        borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Text('${b.servicesLast30Days}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.success))))),
                                  Expanded(child: Text(lastSvc,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary))),
                                ]),
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                  )),

                  const SizedBox(width: 16),

                  // Right column
                  SizedBox(width: 260, child: Column(children: [
                    // Service type breakdown
                    Card(child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('By service category',
                            style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                          const SizedBox(height: 12),
                          ...() {
                            final entries = data.typeBreakdown.entries
                                .toList()
                              ..sort((a, b) =>
                                b.value.compareTo(a.value));
                            final maxVal = entries.isEmpty ? 1
                              : entries.first.value;
                            return entries.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(children: [
                                Expanded(child: Text(e.key,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary),
                                  overflow: TextOverflow.ellipsis)),
                                const SizedBox(width: 8),
                                SizedBox(width: 70, child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: e.value / maxVal,
                                    minHeight: 10,
                                    backgroundColor: AppColors.surfaceVariant,
                                    valueColor: const AlwaysStoppedAnimation(
                                      AppColors.chartBlue)))),
                                const SizedBox(width: 6),
                                Text('${e.value}', style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary)),
                              ]),
                            ));
                          }(),
                        ],
                      ),
                    )),

                    const SizedBox(height: 16),

                    // Branch activity this month
                    Card(child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Services by branch',
                            style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                          const SizedBox(height: 12),
                          ...() {
                            final entries = data.branchServices.entries
                                .toList()
                              ..sort((a, b) =>
                                b.value.compareTo(a.value));
                            final maxVal = entries.isEmpty ? 1
                              : entries.first.value;
                            return entries.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(children: [
                                Expanded(child: Text(e.key,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary),
                                  overflow: TextOverflow.ellipsis)),
                                const SizedBox(width: 8),
                                SizedBox(width: 70, child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: e.value / maxVal,
                                    minHeight: 10,
                                    backgroundColor: AppColors.surfaceVariant,
                                    valueColor: const AlwaysStoppedAnimation(
                                      AppColors.primary)))),
                                const SizedBox(width: 6),
                                Text('${e.value}', style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary)),
                              ]),
                            ));
                          }(),
                        ],
                      ),
                    )),
                  ])),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(this.label, this.value, this.icon, this.color);
  final String   label;
  final String   value;
  final IconData icon;
  final Color    color;

  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Row(children: [
      Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 20)),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value, style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w800, color: color)),
        Text(label, style: const TextStyle(
          fontSize: 11, color: AppColors.textSecondary)),
      ]),
    ]),
  ));
}
