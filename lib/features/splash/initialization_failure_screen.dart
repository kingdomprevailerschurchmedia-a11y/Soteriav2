import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';

class InitializationFailureScreen extends StatelessWidget {
  const InitializationFailureScreen({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -100,
              right: -100,
              child: AmbientGlow(
                color: SoteriaColors.error,
                size: 400,
                opacity: 0.15,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(SoteriaSpacing.lg),
                      decoration: BoxDecoration(
                        color: SoteriaColors.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: SoteriaColors.error.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.cloud_off_rounded,
                        color: SoteriaColors.error,
                        size: 64,
                      ),
                    ),
                    SizedBox(height: SoteriaSpacing.xl),
                    Text(
                      'CONNECTION FAILED',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        letterSpacing: 4,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: SoteriaSpacing.md),
                    Text(
                      'We encountered a problem connecting to our secure servers. Please check your internet connection and try again.',
                      textAlign: TextAlign.center,
                      style: context.bodyMedium.copyWith(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: SoteriaSpacing.xxl),
                    SoteriaButton.primary(
                      label: 'RETRY CONNECTION',
                      onPressed: onRetry,
                    ),
                    SizedBox(height: SoteriaSpacing.md),
                    SoteriaButton.ghost(
                      label: 'VIEW SYSTEM STATUS',
                      onPressed: () {
                        // TODO: Open status page
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
