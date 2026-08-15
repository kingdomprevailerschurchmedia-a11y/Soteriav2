import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/goal.dart';

class GoalSummaryCard extends StatelessWidget {
  final List<GoalProgress> activeGoals;
  final VoidCallback onTap;

  const GoalSummaryCard({
    super.key,
    required this.activeGoals,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final completedCount = activeGoals.where((g) => g.isCompleted).length;
    final totalCount = activeGoals.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return SoteriaCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACTIVE MISSIONS',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.sm),
                Text(
                  '$completedCount OF $totalCount COMPLETED',
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: SoteriaColors.textPrimary,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.md),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 4.h,
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                    valueColor: const AlwaysStoppedAnimation(
                      SoteriaColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: SoteriaSpacing.lg),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: SoteriaColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_right_rounded,
              color: SoteriaColors.primary,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
