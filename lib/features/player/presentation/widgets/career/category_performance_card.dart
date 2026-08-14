import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../analytics/domain/models/category_performance.dart';

class CategoryPerformanceCard extends StatelessWidget {
  final List<CategoryPerformance> performance;

  const CategoryPerformanceCard({
    super.key,
    required this.performance,
  });

  @override
  Widget build(BuildContext context) {
    if (performance.isEmpty) return const SizedBox.shrink();

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
            'CATEGORY PERFORMANCE',
            style: SoteriaTypography.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          ...performance.take(5).map((cp) => _buildCategoryRow(context, cp)),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context, CategoryPerformance cp) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cp.category, style: SoteriaTypography.bodyMedium),
              Text(
                '${(cp.accuracy * 100).toInt()}%',
                style: SoteriaTypography.bodyMedium.copyWith(
                  color: _getAccuracyColor(cp.accuracy),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(2.r),
            child: LinearProgressIndicator(
              value: cp.accuracy,
              backgroundColor: SoteriaColors.border,
              valueColor: AlwaysStoppedAnimation(_getAccuracyColor(cp.accuracy)),
              minHeight: 4.h,
            ),
          ),
        ],
      ),
    );
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 0.8) return SoteriaColors.success;
    if (accuracy >= 0.6) return SoteriaColors.warning;
    return SoteriaColors.error;
  }
}
