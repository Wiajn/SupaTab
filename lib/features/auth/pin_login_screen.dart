import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../auth/auth_provider.dart';
import '../../shared/models/user_role.dart';

// ─── Provider ────────────────────────────────────────────────

final branchUsersProvider = FutureProvider<List<PinUser>>((ref) async {
  // Fetch all active users for PIN login
  // We use the service role via RLS bypass by querying publicly
  final res = await Supabase.instance.client
      .from('app_users')
      .select('id, name, role, pin_hash, branch_id')
      .eq('is_active', true)
      .order('name');

  return (res as List).map((u) => PinUser.fromMap(u)).toList();
});

class PinUser {
  const PinUser({
    required this.id,
    required this.name,
    required this.role,
    required this.pinHash,
    required this.branchId,
  });

  factory PinUser.fromMap(Map m) => PinUser(
    id:       m['id'] as String,
    name:     m['name'] as String,
    role:     UserRole.values.firstWhere(
      (r) => r.name == m['role'],
      orElse: () => UserRole.technician,
    ),
    pinHash:  m['pin_hash'] as String? ?? '',
    branchId: m['branch_id'] as String,
  );

  final String   id;
  final String   name;
  final UserRole role;
  final String   pinHash;
  final String   branchId;
}

// ─── Screen ──────────────────────────────────────────────────

class PinLoginScreen extends ConsumerStatefulWidget {
  const PinLoginScreen({super.key});

  @override
  ConsumerState<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends ConsumerState<PinLoginScreen> {
  PinUser? _selectedUser;
  String   _pin        = '';
  bool     _error      = false;
  bool     _logging    = false;

  void _selectUser(PinUser user) {
    setState(() {
      _selectedUser = user;
      _pin          = '';
      _error        = false;
    });
  }

  void _addDigit(String digit) {
    if (_pin.length >= 4 || _selectedUser == null) return;
    setState(() {
      _pin  += digit;
      _error = false;
    });
    if (_pin.length == 4) {
      _verifyPin();
    }
  }

  void _deleteDigit() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  Future<void> _verifyPin() async {
    if (_selectedUser == null) return;
    setState(() => _logging = true);

    await Future.delayed(const Duration(milliseconds: 300));

    if (_pin == _selectedUser!.pinHash) {
      // PIN correct — sign in with Supabase using the demo password
      // For PIN users we use a shared secret pattern
      try {
        // Get email for this user
        final userData = await Supabase.instance.client
            .from('app_users')
            .select('email')
            .eq('id', _selectedUser!.id)
            .single();

        final email = userData['email'] as String;

        await Supabase.instance.client.auth.signInWithPassword(
          email:    email,
          password: 'Fleet@${_pin}Demo',
        );

        // Set current user manually
        ref.read(currentUserProvider.notifier).state = AppUser(
          id:         _selectedUser!.id,
          name:       _selectedUser!.name,
          email:      email,
          role:       _selectedUser!.role,
          branchId:   _selectedUser!.branchId,
          branchName: '',
        );

        if (mounted) context.go(AppRoute.dashboard);
      } catch (_) {
        // Auth failed — still allow access with correct PIN
        // (offline PIN mode)
        ref.read(currentUserProvider.notifier).state = AppUser(
          id:         _selectedUser!.id,
          name:       _selectedUser!.name,
          email:      '',
          role:       _selectedUser!.role,
          branchId:   _selectedUser!.branchId,
          branchName: 'Lichtenburg',
        );
        if (mounted) context.go(AppRoute.dashboard);
      }
    } else {
      setState(() {
        _error  = true;
        _pin    = '';
        _logging = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(branchUsersProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(children: [
        // ── Left: user list ──
        Container(
          width: 280,
          color: AppColors.surface,
          child: Column(children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/supaquick_logo.png',
                    height: 32),
                  const SizedBox(height: 12),
                  const Text('Select your profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                  Text('Enter your PIN to continue',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    )),
                ],
              ),
            ),

            // User list
            Expanded(
              child: usersAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary)),
                error: (e, _) => Center(
                  child: Text('Error: $e',
                    style: const TextStyle(
                      color: AppColors.danger))),
                data: (users) => ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: users.length,
                  separatorBuilder: (_, __) =>
                    const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final u        = users[i];
                    final selected = _selectedUser?.id == u.id;
                    return InkWell(
                      onTap: () => _selectUser(u),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                        color: selected
                          ? AppColors.primary.withOpacity(0.08)
                          : null,
                        child: Row(children: [
                          // Avatar
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: selected
                                ? AppColors.primary
                                : AppColors.surfaceVariant,
                              borderRadius:
                                BorderRadius.circular(20)),
                            child: Center(child: Text(
                              u.name.substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: selected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              ))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Column(
                            crossAxisAlignment:
                              CrossAxisAlignment.start,
                            children: [
                              Text(u.name, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                              )),
                              Text(u.role.displayName,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                )),
                            ],
                          )),
                          if (selected)
                            const Icon(Icons.chevron_right,
                              color: AppColors.primary, size: 20),
                        ]),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Back to email login
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () => context.go(AppRoute.login),
                child: const Text('Sign in with email instead',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  )),
              ),
            ),
          ]),
        ),

        // ── Right: PIN pad ──
        Expanded(child: _selectedUser == null
          ? // No user selected
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app_rounded,
                  size: 64,
                  color: AppColors.textMuted.withOpacity(0.3)),
                const SizedBox(height: 16),
                const Text('Select a profile to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                  )),
              ],
            ))
          : // PIN entry
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User name
                Text(_selectedUser!.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  )),
                const SizedBox(height: 4),
                Text(_selectedUser!.role.displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  )),
                const SizedBox(height: 40),

                // PIN dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (i) {
                    final filled = i < _pin.length;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 18, height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _error
                          ? AppColors.danger
                          : filled
                            ? AppColors.primary
                            : AppColors.surfaceVariant,
                        border: Border.all(
                          color: _error
                            ? AppColors.danger
                            : filled
                              ? AppColors.primary
                              : AppColors.cardBorder,
                          width: 2,
                        ),
                      ),
                    );
                  }),
                ),

                // Error message
                const SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: _error ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Text('Incorrect PIN, try again',
                    style: TextStyle(
                      color: AppColors.danger,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    )),
                ),

                const SizedBox(height: 32),

                // Number pad
                if (_logging)
                  const CircularProgressIndicator(
                    color: AppColors.primary)
                else
                  SizedBox(
                    width: 280,
                    child: Column(children: [
                      // 1 2 3
                      _NumRow(['1', '2', '3']),
                      const SizedBox(height: 12),
                      // 4 5 6
                      _NumRow(['4', '5', '6']),
                      const SizedBox(height: 12),
                      // 7 8 9
                      _NumRow(['7', '8', '9']),
                      const SizedBox(height: 12),
                      // 0 + delete
                      Row(
                        mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 72),
                          _NumButton('0', _addDigit),
                          SizedBox(
                            width: 72, height: 72,
                            child: IconButton(
                              onPressed: _deleteDigit,
                              icon: const Icon(
                                Icons.backspace_outlined,
                                color: AppColors.textSecondary,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
              ],
            ),
        ),
      ]),
    );
  }

  Widget _NumRow(List<String> digits) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: digits.map((d) => _NumButton(d, _addDigit)).toList(),
  );
}

class _NumButton extends StatelessWidget {
  const _NumButton(this.digit, this.onTap);
  final String digit;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => onTap(digit),
    borderRadius: BorderRadius.circular(36),
    child: Container(
      width: 72, height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Center(child: Text(digit,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ))),
    ),
  );
}
