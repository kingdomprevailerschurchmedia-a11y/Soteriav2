import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';

class LevelUpCelebration extends StatelessWidget {
  final int previousLevel;
  final int newLevel;
  final VoidCallback onContinue;

  const LevelUpCelebration({
    super.key,
    required this.previousLevel,
    required this.newLevel,
    required this.onContinue,
  });

  static Future<void> show(
    BuildContext context, {
    required int previousLevel,
    required int newLevel,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => LevelUpCelebration(
        previousLevel: previousLevel,
        newLevel: newLevel,
        onContinue: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: SoteriaAnimations.slow,
      curve: SoteriaAnimations.bounce,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Center(
        child: SoteriaCard(
          margin: EdgeInsets.all(SoteriaSpacing.xl),
          padding: EdgeInsets.symmetric(
            vertical: SoteriaSpacing.xxl,
            horizontal: SoteriaSpacing.xl,
          ),
          hasGlow: true,
          glowColor: SoteriaColors.gold,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'LEVEL UP!',
                style: context.displaySmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LevelIndicator(level: previousLevel, isPrevious: true),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SoteriaSpacing.lg,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: SoteriaColors.gold,
                      size: 32.sp,
                    ),
                  ),
                  _LevelIndicator(level: newLevel, isPrevious: false),
                ],
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              Text(
                'Congratulations! You have reached a new milestone.',
                textAlign: TextAlign.center,
                style: context.bodyMedium,
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              SoteriaButton.primary(
                label: 'CONTINUE',
                onPressed: onContinue,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelIndicator extends StatelessWidget {
  final int level;
  final bool isPrevious;

  const _LevelIndicator({required this.level, required this.isPrevious});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPrevious
                ? Colors.white.withValues(alpha: 0.05)
                : SoteriaColors.gold.withValues(alpha: 0.15),
            border: Border.all(
              color: isPrevious ? SoteriaColors.muted : SoteriaColors.gold,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              level.toString(),
              style: context.headlineLarge.copyWith(
                color: isPrevious ? SoteriaColors.muted : SoteriaColors.gold,
              ),
            ),
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          isPrevious ? 'PREVIOUS' : 'NEW',
          style: context.labelSmall.copyWith(
            color: isPrevious ? SoteriaColors.muted : SoteriaColors.gold,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
