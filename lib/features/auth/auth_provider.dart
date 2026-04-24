import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../shared/models/user_role.dart';

// Supabase client shorthand
final supabaseProvider = Provider<SupabaseClient>(
  (_) => Supabase.instance.client,
);

// Auth state stream — drives router redirects
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(supabaseProvider).auth.onAuthStateChange.map(
    (event) => event.session?.user,
  );
});

// Typed current user model
class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.branchId,
    required this.branchName,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String branchId;
  final String branchName;

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id:         map['id'] as String,
      name:       map['name'] as String,
      email:      map['email'] as String,
      role:       UserRole.values.firstWhere(
        (r) => r.name == map['role'],
        orElse: () => UserRole.technician,
      ),
      branchId:   map['branch_id'] as String,
      branchName: (map['branches'] as Map?)?['name'] as String? ?? '',
    );
  }
}

// Current user — fetched once after login, cached in memory
final currentUserProvider = StateProvider<AppUser?>((ref) => null);

// Auth notifier handles login/logout
final authNotifierProvider = NotifierProvider<AuthNotifier, AsyncValue<void>>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  SupabaseClient get _supabase => ref.read(supabaseProvider);

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Invalid credentials');
      }

      await _loadCurrentUser(response.user!.id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// PIN-based login (after initial email auth, daily PIN unlock)
  Future<void> signInWithPin(String userId, String pin) async {
    state = const AsyncValue.loading();
    try {
      // Verify PIN against local DB hash
      // (full implementation in auth_service.dart)
      await _loadCurrentUser(userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    ref.read(currentUserProvider.notifier).state = null;
  }

  Future<void> _loadCurrentUser(String userId) async {
    final data = await _supabase
        .from('app_users')
        .select('*, branches(name)')
        .eq('id', userId)
        .single();

    ref.read(currentUserProvider.notifier).state = AppUser.fromMap(data);
  }
}
