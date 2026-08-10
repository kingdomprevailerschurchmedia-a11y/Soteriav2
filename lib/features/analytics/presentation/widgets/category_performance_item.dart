import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/category_performance.dart';

class CategoryPerformanceItem extends StatelessWidget {
  final CategoryPerformance performance;

  const CategoryPerformanceItem({super.key, required this.performance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                performance.category,
                style: SoteriaTypography.titleSmall.copyWith(color: SoteriaColors.textPrimary),
              ),
              Text(
                '${(performance.accuracy * 100).toInt()}% Accuracy',
                style: SoteriaTypography.labelSmall.copyWith(color: SoteriaColors.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Stack(
            children: [
              Container(
                height: 6.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: SoteriaColors.border.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: performance.accuracy,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [SoteriaColors.primary, SoteriaColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(3.r),
                    boxShadow: [
                      BoxShadow(
                        color: SoteriaColors.primary.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${performance.totalQuizzes} Quizzes',
                style: SoteriaTypography.bodySmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                'Avg Score: ${performance.averageScore}',
                style: SoteriaTypography.bodySmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
