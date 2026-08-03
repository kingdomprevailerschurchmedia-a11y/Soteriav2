import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/widgets/animations/soteria_animations.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B012A),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Pattern Asset
          Image.asset(
            'assets/images/splash_bg.png',
            fit: BoxFit.cover,
          ),

          // 2. Bottom Glow Arc
          Positioned(
            bottom: -150,
            left: -100,
            right: -100,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                    const Color(0xFF7C4DFF).withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),
          
          // Bright center point for the bottom glow
          Positioned(
            bottom: -5,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 100,
                height: 10,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C4DFF).withValues(alpha: 0.8),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with subtle background glow
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF7C4DFF).withValues(alpha: 0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    SoteriaScaleIn(
                      duration: const Duration(milliseconds: 1000),
                      child: Image.asset(
                        'assets/images/logo_icon.png',
                        width: 130,
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SoteriaFadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Text(
                        'SOTERIA',
                        style: context.displayMedium.copyWith(
                          letterSpacing: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 42,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'COMPETE. LEARN. RISE.',
                        style: context.bodySmall.copyWith(
                          letterSpacing: 2,
                          color: const Color(0xFFD8B24A),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
