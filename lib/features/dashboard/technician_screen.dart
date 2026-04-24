import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../auth/auth_provider.dart';

class TechnicianScreen extends ConsumerWidget {
  const TechnicianScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.greyDark,
      body: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),

          // Content
          Column(
            children: [
              // Top bar
              Container(
                height: 54,
                color: Colors.black.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  Image.asset('assets/images/supaquick_logo.png',
                    height: 30),
                  const Spacer(),
                  Text(
                    user?.name ?? 'Technician',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.logout,
                      color: Colors.white70, size: 20),
                    tooltip: 'Sign out',
                    onPressed: () async {
                      await ref.read(authNotifierProvider.notifier).signOut();
                      ref.read(currentUserProvider.notifier).state = null;
                      if (context.mounted) context.go(AppRoute.pinLogin);
                    },
                  ),
                ]),
              ),

              // Main content
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      Container(
                        width: 120, height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Ready to scan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Point the camera at the vehicle\'s license disk',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Scan button
                      SizedBox(
                        width: 280,
                        height: 64,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(
                            Icons.qr_code_scanner_rounded,
                            size: 24,
                          ),
                          label: const Text(
                            'Scan vehicle',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () => context.push(AppRoute.scanner),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom hint
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Technician mode',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Subtle background grid pattern
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
