import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../domain/models/rank_change.dart';
import '../widgets/competitive_rank_badge.dart';
import '../widgets/rank_change_details.dart';

class RankPromotionScreen extends StatelessWidget {
  final RankChange rankChange;
  final VoidCallback onContinue;

  const RankPromotionScreen({
    super.key,
    required this.rankChange,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final isMajorPromotion = rankChange.isTierChange;
    final rankColor = _getRankColor(rankChange.newRank.split(' ')[0]);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Dim
          GestureDetector(
            onTap: onContinue,
            child: Container(color: Colors.black.withValues(alpha: 0.9)),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Celebration Title
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: SoteriaAnimations.slow,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          isMajorPromotion ? 'TIER ASCENDED' : 'PROMOTED',
                          style: context.displaySmall.copyWith(
                            color: rankColor,
                            letterSpacing: 8.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: SoteriaSpacing.sm),
                        Text(
                          'SEASON ${rankChange.seasonId.toUpperCase()}',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.textSecondary,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: SoteriaSpacing.xxl),

                  // Rank Badge Reveal
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: SoteriaAnimations.extraSlow,
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: CompetitiveRankBadge(
                      tierId: rankChange.newRank.split(' ')[0].toLowerCase(),
                      rankName: rankChange.newRank,
                      size: RankBadgeSize.extraLarge,
                      hasGlow: true,
                    ),
                  ),

                  SizedBox(height: SoteriaSpacing.xxl),

                  // Rank Details
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: SoteriaAnimations.slow,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 10 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: RankChangeDetails(rankChange: rankChange),
                  ),

                  SizedBox(height: SoteriaSpacing.xxxl),

                  // Motivational Message
                  Text(
                    _getMotivationalMessage(),
                    textAlign: TextAlign.center,
                    style: context.bodyLarge.copyWith(
                      color: SoteriaColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: SoteriaSpacing.xxxl),

                  // Action
                  SoteriaButton.primary(
                    label: 'CONTINUE',
                    onPressed: onContinue,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivationalMessage() {
    if (rankChange.isTierChange) {
      return 'You have reached a new competitive tier. Your journey to the top is gaining momentum.';
    }
    return 'Your skills are improving. Keep competing to reach the next division.';
  }

  Color _getRankColor(String tierName) {
    switch (tierName.toLowerCase()) {
      case 'gold':
        return SoteriaColors.gold;
      case 'platinum':
        return SoteriaColors.platinum;
      case 'diamond':
        return SoteriaColors.diamond;
      case 'master':
        return SoteriaColors.master;
      case 'elite':
        return SoteriaColors.elite;
      default:
        return SoteriaColors.primary;
    }
  }
}
