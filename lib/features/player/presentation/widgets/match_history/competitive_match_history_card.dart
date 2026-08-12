import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';

class CompetitiveMatchHistoryCard extends StatelessWidget {
  final CompetitiveMatch match;
  final VoidCallback? onTap;

  const CompetitiveMatchHistoryCard({
    super.key,
    required this.match,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final result = match.result;
    final isWin = result.outcome == CompetitiveOutcome.win;
    final color = _getResultColor();

    return SoteriaCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildResultIndicator(color),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(SoteriaSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildModeBadge(context, result.mode),
                        const Spacer(),
                        Text(
                          DateFormat('MMM d, HH:mm').format(result.completedAt),
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.muted,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SoteriaSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getResultText(),
                              style: context.titleLarge.copyWith(
                                fontWeight: FontWeight.w900,
                                color: color,
                                letterSpacing: -0.5,
                              ),
                            ),
                            if (match.rankChange != null) ...[
                              SizedBox(height: SoteriaSpacing.xs),
                              _buildRankChangeInfo(context),
                            ],
                          ],
                        ),
                        _buildPrimaryStats(context),
                      ],
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

  Widget _buildResultIndicator(Color color) {
    return Container(
      width: 6.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(SoteriaRadius.md),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
    );
  }

  Widget _buildModeBadge(BuildContext context, String mode) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.sm,
        vertical: SoteriaSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Text(
        mode.toUpperCase(),
        style: context.labelSmall.copyWith(
          color: SoteriaColors.muted,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          fontSize: 8.sp,
        ),
      ),
    );
  }

  Widget _buildRankChangeInfo(BuildContext context) {
    final change = match.rankChange!;
    final isPositive = change.changeAmount > 0;

    return Row(
      children: [
        Icon(
          isPositive ? Icons.add_rounded : Icons.remove_rounded,
          size: 12.sp,
          color: isPositive ? SoteriaColors.success : SoteriaColors.error,
        ),
        Text(
          '${change.changeAmount.abs()} RP',
          style: context.labelSmall.copyWith(
            color: isPositive ? SoteriaColors.success : SoteriaColors.error,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          change.newRank,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          match.result.score.toString(),
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            color: SoteriaColors.textPrimary,
          ),
        ),
        if (match.quizResult != null)
          Text(
            '${(match.quizResult!.accuracy * 100).toInt()}% ACC',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontSize: 8.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Color _getResultColor() {
    switch (match.result.outcome) {
      case CompetitiveOutcome.win:
        return SoteriaColors.success;
      case CompetitiveOutcome.loss:
        return SoteriaColors.error;
      case CompetitiveOutcome.draw:
        return SoteriaColors.info;
      case CompetitiveOutcome.placement:
        return SoteriaColors.gold;
    }
  }

  String _getResultText() {
    switch (match.result.outcome) {
      case CompetitiveOutcome.win:
        return 'VICTORY';
      case CompetitiveOutcome.loss:
        return 'DEFEAT';
      case CompetitiveOutcome.draw:
        return 'DRAW';
      case CompetitiveOutcome.placement:
        return 'PLACEMENT';
    }
  }
}
