import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';
import 'package:soteria/core/widgets/animations/soteria_animations.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch app lifecycle to ensure it initializes
    ref.watch(appLifecycleProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: Stack(
          children: [
            // Ambient Lighting
            const Positioned(
              top: -100,
              left: -100,
              child: AmbientGlow(color: SoteriaColors.primary, size: 400),
            ),
            const Positioned(
              bottom: -150,
              right: -100,
              child: AmbientGlow(
                color: SoteriaColors.secondary,
                size: 500,
                opacity: 0.2,
              ),
            ),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SoteriaBlurTransition(
                    duration: Duration(milliseconds: 800),
                    child: SoteriaScaleIn(
                      duration: Duration(milliseconds: 600),
                      child: Icon(
                        Icons.shield_rounded,
                        size: 80,
                        color: SoteriaColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.lg),
                  SoteriaFadeIn(
                    delay: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        Text(
                          'SOTERIA',
                          style: context.displayMedium.copyWith(
                            letterSpacing: 8,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: SoteriaSpacing.xs),
                        Text(
                          'PREMIUM COMPETITIVE LEARNING',
                          style: context.bodySmall.copyWith(
                            letterSpacing: 2,
                            color: SoteriaColors.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.xxl),
                  const SoteriaFadeIn(
                    delay: Duration(milliseconds: 800),
                    child: SoteriaLoader(size: 32),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
