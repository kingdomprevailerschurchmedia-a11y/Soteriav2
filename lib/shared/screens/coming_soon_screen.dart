import 'package:flutter/material.dart';
import '../../core/design_system/colors/soteria_colors.dart';
import '../../core/design_system/spacing/soteria_spacing.dart';
import '../../core/design_system/typography/soteria_typography.dart';
import '../../core/design_system/animations/soteria_animation_widgets.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({
    super.key,
    required this.featureName,
    this.category = 'Feature',
    this.estimatedArrival,
    this.showBackButton = false,
  });

  final String featureName;
  final String category;
  final String? estimatedArrival;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoteriaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SoteriaScaleIn(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: SoteriaColors.primary.withValues(alpha: 0.1),
                    border: Border.all(
                      color: SoteriaColors.primary.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: SoteriaColors.primary,
                    size: 64,
                  ),
                ),
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              SoteriaFadeIn(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  category.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: SoteriaSpacing.sm),
              SoteriaFadeIn(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  featureName,
                  style: context.displaySmall.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: SoteriaSpacing.md),
              SoteriaFadeIn(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  'Our engineers are currently hardening this sector. Stay tuned for a premium experience.',
                  style: context.bodyMedium.copyWith(
                    color: SoteriaColors.muted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (estimatedArrival != null) ...[
                SizedBox(height: SoteriaSpacing.xl),
                SoteriaFadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'ESTIMATED: $estimatedArrival',
                      style: context.labelSmall.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
