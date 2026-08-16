import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../domain/models/season_result.dart';
import '../competitive_rank_badge.dart';

class SeasonComparisonCard extends StatelessWidget {
  final SeasonResult current;
  final SeasonResult previous;

  const SeasonComparisonCard({
    super.key,
    required this.current,
    required this.previous,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.5),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEASON COMPARISON',
            style: SoteriaTypography.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Row(
            children: [
              Expanded(child: _buildSeasonSummary(context, previous, 'PREVIOUS')),
              Container(
                width: 1,
                height: 60.h,
                color: SoteriaColors.border.withValues(alpha: 0.5),
                margin: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              ),
              Expanded(child: _buildSeasonSummary(context, current, 'CURRENT')),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _buildComparisonRow(
            context,
            'Rank Points',
            current.finalRankPoints.toDouble(),
            previous.finalRankPoints.toDouble(),
            isHigherBetter: true,
          ),
          _buildComparisonRow(
            context,
            'Global Position',
            current.finalPosition.toDouble(),
            previous.finalPosition.toDouble(),
            isHigherBetter: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonSummary(BuildContext context, SeasonResult result, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: SoteriaTypography.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
        SizedBox(height: SoteriaSpacing.xs),
        Row(
          children: [
            CompetitiveRankBadge(
              rankName: result.finalTier,
              tierId: result.finalTier,
              size: RankBadgeSize.small,
            ),
            SizedBox(width: SoteriaSpacing.xs),
            Expanded(
              child: Text(
                'Season ${result.seasonNumber}',
                style: SoteriaTypography.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildComparisonRow(
    BuildContext context,
    String label,
    double currentVal,
    double previousVal, {
    required bool isHigherBetter,
  }) {
    final diff = currentVal - previousVal;
    final isImprovement = isHigherBetter ? diff > 0 : diff < 0;
    final isSame = diff == 0;

    return Padding(
      padding: EdgeInsets.only(top: SoteriaSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: SoteriaTypography.bodyMedium.copyWith(color: SoteriaColors.muted)),
          Row(
            children: [
              Text(
                currentVal.toInt().toString(),
                style: SoteriaTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: SoteriaSpacing.xs),
              if (!isSame)
                Icon(
                  isImprovement ? Icons.trending_up : Icons.trending_down,
                  size: 16.w,
                  color: isImprovement ? SoteriaColors.success : SoteriaColors.error,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
