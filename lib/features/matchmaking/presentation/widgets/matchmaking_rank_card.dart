import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../player/presentation/widgets/competitive_rank_badge.dart';

class MatchmakingRankCard extends StatelessWidget {
  final String rankName;
  final String tier;
  final int points;

  const MatchmakingRankCard({
    super.key,
    required this.rankName,
    required this.tier,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          CompetitiveRankBadge(
            rankName: rankName,
            tierId: tier.toLowerCase(),
            size: RankBadgeSize.medium,
          ),
          SizedBox(width: SoteriaSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURRENT RANK',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                '$rankName $tier'.toUpperCase(),
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                '$points RP',
                style: context.bodySmall.copyWith(color: SoteriaColors.gold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
