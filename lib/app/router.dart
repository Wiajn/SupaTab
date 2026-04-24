import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/auth_provider.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/pin_login_screen.dart';
import '../features/auth/splash_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/technician_screen.dart';
import '../app/theme.dart';
import '../features/scanner/scanner_screen.dart';
import '../features/scanner/confirm_vehicle_screen.dart';
import '../features/service_entry/service_entry_screen.dart';
import '../features/service_entry/photo_capture_screen.dart';
import '../features/vehicle/vehicle_detail_screen.dart';
import '../features/drivers/drivers_screen.dart';
import '../features/reports/reports_screen.dart';
import '../shared/models/user_role.dart';

class AppRoute {
  static const splash         = '/';
  static const login          = '/login';
  static const pinLogin       = '/pin';
  static const dashboard      = '/dashboard';
  static const scanner        = '/scanner';
  static const confirmVehicle = '/scanner/confirm';
  static const serviceEntry   = '/service-entry';
  static const photoCapture   = '/service-entry/photos';
  static const vehicleDetail  = '/vehicle/:vehicleId';
  static const drivers        = '/drivers';
  static const reports        = '/reports';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoute.splash,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn  = authState.valueOrNull != null;
      final hasUser     = ref.read(currentUserProvider) != null;
      final loc         = state.matchedLocation;
      final isOnSplash  = loc == AppRoute.splash;
      final isOnLogin   = loc == AppRoute.login;
      final isOnPin     = loc == AppRoute.pinLogin;
      final isPublic    = isOnSplash || isOnLogin || isOnPin;

      if (!isLoggedIn && !hasUser && !isPublic) return AppRoute.pinLogin;
      if ((isLoggedIn || hasUser) && isOnLogin) return AppRoute.dashboard;
      if ((isLoggedIn || hasUser) && isOnPin)   return AppRoute.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoute.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.pinLogin,
        builder: (_, __) => const PinLoginScreen(),
      ),
      GoRoute(
        path: AppRoute.dashboard,
        builder: (_, __) {
          final user = ref.read(currentUserProvider);
          if (user?.role.isTechnician == true) {
            return const TechnicianScreen();
          }
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: AppRoute.scanner,
        builder: (_, __) => const ScannerScreen(),
      ),
      GoRoute(
        path: AppRoute.confirmVehicle,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return ConfirmVehicleScreen(vehicleData: extra);
        },
      ),
      GoRoute(
        path: AppRoute.serviceEntry,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return ServiceEntryScreen(vehicleData: extra);
        },
      ),
      GoRoute(
        path: AppRoute.photoCapture,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return PhotoCaptureScreen(serviceId: extra['serviceId'] as String);
        },
      ),
      GoRoute(
        path: AppRoute.vehicleDetail,
        builder: (context, state) {
          final vehicleId = state.pathParameters['vehicleId']!;
          return VehicleDetailScreen(vehicleId: vehicleId);
        },
      ),
      GoRoute(
        path: AppRoute.drivers,
        redirect: (context, state) => _guardRole(
          ref, UserRole.admin, state.matchedLocation),
        builder: (_, __) => const DriversScreen(),
      ),
      GoRoute(
        path: AppRoute.reports,
        redirect: (context, state) => _guardRole(
          ref, UserRole.admin, state.matchedLocation),
        builder: (_, __) => const ReportsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded,
            size: 56, color: AppColors.danger),
          const SizedBox(height: 16),
          const Text('Something went wrong',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('${state.error}',
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ],
      )),
    ),
  );
});

String? _guardRole(Ref ref, UserRole required, String currentPath) {
  final user = ref.read(currentUserProvider);
  if (user == null || !user.role.canAccess(required)) {
    return AppRoute.dashboard;
  }
  return null;
}
