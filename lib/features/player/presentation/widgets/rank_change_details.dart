import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/rank_change.dart';
import 'competitive_rank_badge.dart';

class RankChangeDetails extends StatelessWidget {
  final RankChange rankChange;
  final bool showPoints;

  const RankChangeDetails({
    super.key,
    required this.rankChange,
    this.showPoints = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RankSummary(
              rankName: rankChange.previousRank,
              label: 'PREVIOUS',
              opacity: 0.6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: SoteriaColors.textSecondary,
                size: 24.w,
              ),
            ),
            _RankSummary(
              rankName: rankChange.newRank,
              label: 'CURRENT',
              isHighlighted: true,
            ),
          ],
        ),
        if (showPoints) ...[
          SizedBox(height: SoteriaSpacing.lg),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.lg,
              vertical: SoteriaSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: _getChangeColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(SoteriaSpacing.sm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  rankChange.changeAmount >= 0
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: _getChangeColor(),
                  size: 16.w,
                ),
                SizedBox(width: SoteriaSpacing.xs),
                Text(
                  '${rankChange.changeAmount >= 0 ? '+' : ''}${rankChange.changeAmount} RP',
                  style: context.labelLarge.copyWith(
                    color: _getChangeColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' (${rankChange.newRankPoints} TOTAL)',
                  style: context.labelMedium.copyWith(
                    color: SoteriaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Color _getChangeColor() {
    if (rankChange.changeAmount > 0) return SoteriaColors.success;
    if (rankChange.changeAmount < 0) return SoteriaColors.error;
    return SoteriaColors.textSecondary;
  }
}

class _RankSummary extends StatelessWidget {
  final String rankName;
  final String label;
  final double opacity;
  final bool isHighlighted;

  const _RankSummary({
    required this.rankName,
    required this.label,
    this.opacity = 1.0,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final tierId = rankName.split(' ')[0].toLowerCase();

    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xs),
          CompetitiveRankBadge(
            rankName: rankName,
            tierId: tierId,
            size: RankBadgeSize.medium,
          ),
          SizedBox(height: SoteriaSpacing.xs),
          Text(
            rankName,
            style: context.titleMedium.copyWith(
              color:
                  isHighlighted
                      ? SoteriaColors.textPrimary
                      : SoteriaColors.textSecondary,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
