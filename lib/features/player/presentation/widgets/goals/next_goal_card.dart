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
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              SoteriaColors.primary.withOpacity(0.2),
              SoteriaColors.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(SoteriaSpacing.lg),
          border: Border.all(color: SoteriaColors.primary.withOpacity(0.3)),
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
                  ),
                ),
                Icon(Icons.flag_rounded, color: SoteriaColors.primary, size: 20.w),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              progress.definition.title,
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: SoteriaSpacing.xs),
            Text(
              progress.definition.description,
              style: context.bodySmall.copyWith(color: SoteriaColors.textSecondary),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: progress.progressPercentage,
                      backgroundColor: SoteriaColors.border,
                      color: SoteriaColors.primary,
                      minHeight: 8.h,
                    ),
                  ),
                ),
                SizedBox(width: SoteriaSpacing.md),
                Text(
                  '${(progress.progressPercentage * 100).toInt()}%',
                  style: context.labelSmall.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
