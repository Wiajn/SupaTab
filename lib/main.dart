import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/router.dart';
import 'app/theme.dart';
import 'core/local_db/database.dart';
import 'core/sync/sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force landscape on tablets
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Hide navigation bar and status bar completely
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  await Supabase.initialize(
    url: 'https://ikclitwfqmjqyheazbtv.supabase.co',
    anonKey: 'sb_publishable_m8U_-EVomiP2LYXhbgesvA_vqFSxBy-',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  final sharedPrefs = await SharedPreferences.getInstance();
  final db = AppDatabase();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        appDatabaseProvider.overrideWithValue(db),
      ],
      child: const FleetApp(),
    ),
  );
}

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('Override in main'),
);

final appDatabaseProvider = Provider<AppDatabase>(
  (_) => throw UnimplementedError('Override in main'),
);

class FleetApp extends ConsumerWidget {
  const FleetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Start sync service listener
    ref.watch(syncServiceProvider);

    return MaterialApp.router(
      title: 'Fleet Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
