import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/rank_progress.dart';

enum RankProgressVariant { default_, compact, large, hero }

class RankProgressBar extends StatelessWidget {
  final RankProgress progress;
  final RankProgressVariant variant;
  final bool showLabels;
  final bool showCurrentRP;

  const RankProgressBar({
    super.key,
    required this.progress,
    this.variant = RankProgressVariant.default_,
    this.showLabels = true,
    this.showCurrentRP = true,
  });

  @override
  Widget build(BuildContext context) {
    final double height = _getHeight();
    final Color color = _getRankColor();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabels && variant != RankProgressVariant.compact) ...[
          _buildLabels(context),
          SizedBox(height: SoteriaSpacing.xs),
        ],
        Semantics(
          label: _getSemanticsLabel(),
          value: '${(progress.progressPercentage * 100).toInt()}%',
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: SoteriaColors.border,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.progressPercentage,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withValues(alpha: 0.7), color],
                  ),
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 4.w,
                      offset: Offset(0, 2.w),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showLabels && variant == RankProgressVariant.hero) ...[
          SizedBox(height: SoteriaSpacing.sm),
          _buildHeroFooter(context),
        ],
      ],
    );
  }

  Widget _buildLabels(BuildContext context) {
    return Row(
      mainAxisAlignment: progress.isMaxRank || !showCurrentRP
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      children: [
        if (showCurrentRP)
          Text(
            '${progress.currentRP} RP',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (!progress.isMaxRank)
          Text(
            '${progress.rpToNextRank} RP TO ${progress.nextRank?.toUpperCase()}',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.textSecondary,
              letterSpacing: 0.5,
            ),
          )
        else
          Text(
            'MAX RANK REACHED',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildHeroFooter(BuildContext context) {
    return Center(
      child: Text(
        '${(progress.progressPercentage * 100).toInt()}% PROGRESS',
        style: context.labelMedium.copyWith(
          color: SoteriaColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  double _getHeight() {
    switch (variant) {
      case RankProgressVariant.compact:
        return 4.h;
      case RankProgressVariant.large:
        return 12.h;
      case RankProgressVariant.hero:
        return 16.h;
      default:
        return 8.h;
    }
  }

  Color _getRankColor() {
    switch (progress.tier.id.toLowerCase()) {
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
      case 'silver':
        return SoteriaColors.silver;
      case 'bronze':
        return SoteriaColors.bronze;
      default:
        return SoteriaColors.primary;
    }
  }

  String _getSemanticsLabel() {
    if (progress.isMaxRank) {
      return 'Maximum rank reached: ${progress.currentRank}.';
    }
    return '${progress.currentRP} of ${progress.maximumRP + 1} rank points. '
        '${(progress.progressPercentage * 100).toInt()} percent progress toward ${progress.nextRank}.';
  }
}
