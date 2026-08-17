import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../domain/models/goal.dart';

class NextGoalCard extends StatelessWidget {
  final GoalProgress progress;
  final VoidCallback? onTap;

  const NextGoalCard({super.key, required this.progress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              SoteriaColors.primary.withOpacity(0.15),
              SoteriaColors.surface.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: SoteriaColors.primary.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NEXT TARGET',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.primary,
                    letterSpacing: 1.2,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Icon(Icons.flag_rounded, color: SoteriaColors.primary, size: 16.w),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              progress.definition.title,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              progress.definition.description,
              style: context.bodySmall.copyWith(
                color: SoteriaColors.textSecondary,
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: progress.progressPercentage,
                      backgroundColor: Colors.white.withOpacity(0.05),
                      color: SoteriaColors.primary,
                      minHeight: 6.h,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  '${(progress.progressPercentage * 100).toInt()}%',
                  style: context.labelSmall.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
