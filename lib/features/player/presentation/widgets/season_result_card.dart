import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/models/season_result.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import 'rank_badge.dart';

class SeasonResultCard extends StatelessWidget {
  final SeasonResult result;
  final VoidCallback? onTap;

  const SeasonResultCard({super.key, required this.result, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isUnranked = result.finalTier.toLowerCase() == 'unranked';
    final reducedMotion = MediaQuery.of(context).disableAnimations;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
        padding: EdgeInsets.all(SoteriaSpacing.md),
        decoration: BoxDecoration(
          color: SoteriaColors.elevatedSurface.withValues(alpha: 0.8),
          borderRadius: SoteriaRadius.brMd,
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          boxShadow: reducedMotion
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            RankBadge(rankName: result.finalTier, tierId: result.finalTier),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.seasonName,
                    style: SoteriaTypography.titleMedium.copyWith(
                      color: SoteriaColors.textPrimary,
                      fontSize: 16.sp,
                    ),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: SoteriaSpacing.sm,
                    children: [
                      Text(
                        'Season ${result.seasonNumber}',
                        style: SoteriaTypography.bodySmall.copyWith(
                          color: SoteriaColors.textSecondary,
                        ),
                      ),
                      if (result.rankChange != 0) _buildRankChangeIndicator(),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isUnranked ? 'UNRANKED' : '#${result.finalPosition}',
                  style: SoteriaTypography.titleLarge.copyWith(
                    color: isUnranked
                        ? SoteriaColors.textSecondary
                        : SoteriaColors.gold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  '${result.finalRankPoints} RP',
                  style: SoteriaTypography.bodySmall.copyWith(
                    color: SoteriaColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(width: SoteriaSpacing.sm),
            const Icon(
              Icons.chevron_right_rounded,
              color: SoteriaColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankChangeIndicator() {
    final isPositive = result.rankChange > 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: (isPositive ? SoteriaColors.success : SoteriaColors.error)
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            size: 10.sp,
            color: isPositive ? SoteriaColors.success : SoteriaColors.error,
          ),
          SizedBox(width: 2.w),
          Text(
            '${result.rankChange.abs()}',
            style: SoteriaTypography.labelSmall.copyWith(
              fontSize: 9.sp,
              color: isPositive ? SoteriaColors.success : SoteriaColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
