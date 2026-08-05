import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLifecycleProvider);

    final size = MediaQuery.of(context).size;

    // ======================================================
    // DESIGN VALUES (measured from the artwork)
    // ======================================================

    const double logoCenterFactor = 0.48;

    final double logoSize = size.width * 0.22;

    final double titleSize = size.width < 360
        ? 28
        : size.width < 420
        ? 34
        : 36;

    final double subtitleSize = size.width < 360
        ? 10.5
        : size.width < 420
        ? 12.5
        : 13.5;

    return Scaffold(
      backgroundColor: const Color(0xFF0B012A),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset('assets/images/splash_bg.png', fit: BoxFit.cover),

          // Content
          Positioned(
            top: size.height * logoCenterFactor - logoSize / 2,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                SoteriaScaleIn(
                  duration: const Duration(milliseconds: 900),
                  child: Image.asset(
                    'assets/images/logo_icon.png',
                    width: logoSize,
                    height: logoSize,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                SoteriaFadeIn(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    'SOTERIA',
                    style: context.displayMedium.copyWith(
                      color: Colors.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 8,
                      height: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                SoteriaFadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: Text(
                    'COMPETE. LEARN. RISE.',
                    style: context.bodySmall.copyWith(
                      color: const Color(0xFFD8B24A),
                      fontSize: subtitleSize,
                      letterSpacing: 2.8,
                      fontWeight: FontWeight.w600,
                    ),
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
