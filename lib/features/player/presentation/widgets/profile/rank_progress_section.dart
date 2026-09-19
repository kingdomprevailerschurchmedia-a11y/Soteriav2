import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/player_progression.dart';
import '../../../domain/services/competitive_ranking_engine.dart';
import '../competitive_rank_badge.dart';

class RankProgressSection extends StatelessWidget {
  final PlayerProgression progression;

  const RankProgressSection({super.key, required this.progression});

  @override
  Widget build(BuildContext context) {
    final engine = CompetitiveRankingEngine();
    final rankInfo = engine.calculateRankProgress(progression.rankPoints);

    return SoteriaCard(
      padding: EdgeInsets.all(20.r),
      borderRadius: 24,
      blur: 5.0,
      opacity: 0.02,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium_rounded, color: SoteriaColors.gold, size: 20.r),
              SizedBox(width: 12.w),
              Text(
                'Rank Progress',
                style: context.titleSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              const Spacer(),
              Text(
                progression.currentRank,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.chevron_right_rounded, color: SoteriaColors.gold, size: 18.r),
            ],
          ),
          SoteriaSpacing.gapLG,
          Row(
            children: [
              CompetitiveRankBadge(
                rankName: '',
                tierId: progression.currentRankTier.toLowerCase(),
                size: RankBadgeSize.medium,
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SoteriaProgressBar(
                      progress: rankInfo.progressPercentage,
                      color: const Color(0xFF7C4DFF),
                      height: 10.h,
                      hasGlow: true,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${progression.currentXp} / ${progression.xpRequiredForNextLevel - progression.xpRequiredForCurrentLevel} XP',
                      style: context.labelSmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
