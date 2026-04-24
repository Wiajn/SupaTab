import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import 'auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey            = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authNotifierProvider.notifier).signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );

    final authState = ref.read(authNotifierProvider);
    if (authState.hasError && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authState.error.toString()),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Left panel — brand
          Expanded(
            flex: 5,
            child: Container(
              color: AppColors.primary,
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.directions_car_rounded,
                    color: Colors.white, size: 56),
                  const SizedBox(height: 24),
                  const Text(
                    'Fleet\nManager',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Digital service management\nfor your entire fleet',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Powered by SupaQuick',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right panel — form
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.surface,
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 48),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your branch credentials',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined, size: 20),
                      ),
                      validator: (v) =>
                        v == null || v.isEmpty ? 'Enter your email' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                            size: 20,
                          ),
                          onPressed: () =>
                            setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) =>
                        v == null || v.length < 6 ? 'Enter your password' : null,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _login,
                        child: isLoading
                          ? const SizedBox(
                              width: 20, height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Sign in'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: TextButton(
                        onPressed: () => context.go(AppRoute.pinLogin),
                        child: const Text(
                          'Sign in with PIN instead',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    ),
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
