import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../domain/models/competitive_statistics.dart';

class PerformanceInsightWidget extends StatelessWidget {
  final PerformanceInsight insight;

  const PerformanceInsightWidget({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color:
            (insight.isPositive ? SoteriaColors.success : SoteriaColors.primary)
                .withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              (insight.isPositive
                      ? SoteriaColors.success
                      : SoteriaColors.primary)
                  .withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            insight.isPositive
                ? Icons.auto_awesome_rounded
                : Icons.info_outline_rounded,
            color: insight.isPositive
                ? SoteriaColors.success
                : SoteriaColors.primary,
            size: 20.sp,
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: insight.isPositive
                        ? SoteriaColors.success
                        : SoteriaColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  insight.description,
                  style: context.bodySmall.copyWith(
                    color: SoteriaColors.textSecondary,
                  ),
                ),
                if (insight.recommendation != null) ...[
                  SizedBox(height: SoteriaSpacing.xs),
                  Text(
                    'Tip: ${insight.recommendation}',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
