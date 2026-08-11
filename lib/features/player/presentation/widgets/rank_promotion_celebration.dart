import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../domain/models/rank_change.dart';
import 'rank_badge.dart';

class RankPromotionCelebration extends StatelessWidget {
  final RankChange rankChange;
  final VoidCallback onContinue;

  const RankPromotionCelebration({
    super.key,
    required this.rankChange,
    required this.onContinue,
  });

  static Future<void> show(
    BuildContext context, {
    required RankChange rankChange,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => RankPromotionCelebration(
        rankChange: rankChange,
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
                'PROMOTED',
                style: context.displaySmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 8.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xl),
              Hero(
                tag: 'rank_badge_${rankChange.newRank}',
                child: Transform.scale(
                  scale: 1.5,
                  child: RankBadge(
                    rankName: rankChange.newRank,
                    tierId: rankChange.newRank.split(' ')[0].toLowerCase(),
                  ),
                ),
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              Text(
                rankChange.newRank.toUpperCase(),
                style: context.headlineLarge.copyWith(
                  color: SoteriaColors.textPrimary,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: SoteriaSpacing.sm),
              Text(
                '+${rankChange.changeAmount} RANK POINTS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              Text(
                'You have ascended to a new competitive division. Keep climbing!',
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
