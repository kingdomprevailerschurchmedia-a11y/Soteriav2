import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/competitive_goal.dart';

class CompetitiveGoalCard extends StatelessWidget {
  final CompetitiveGoal goal;
  final VoidCallback? onTap;

  const CompetitiveGoalCard({super.key, required this.goal, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isCompleted = goal.isCompleted;
    final progress = goal.progressPercentage;

    return Semantics(
      label: 'Goal: ${goal.title}. Progress: ${(progress * 100).toInt()}%.',
      child: SoteriaCard(
        onTap: onTap,
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        hasGlow: isCompleted,
        glowColor: SoteriaColors.success,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTypeBadge(context),
                if (!isCompleted) _buildExpiryBadge(context),
                if (isCompleted)
                  Icon(
                    Icons.check_circle_rounded,
                    color: SoteriaColors.success,
                    size: 16.sp,
                  ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              goal.title,
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: isCompleted ? Colors.white38 : Colors.white,
              ),
            ),
            SizedBox(height: SoteriaSpacing.xs),
            Text(
              goal.description,
              style: context.bodySmall.copyWith(
                color: isCompleted ? Colors.white24 : Colors.white70,
              ),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            _buildProgressBar(context),
            SizedBox(height: SoteriaSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${goal.currentProgress.toInt()} / ${goal.target.toInt()}',
                  style: context.labelSmall.copyWith(
                    color: isCompleted
                        ? SoteriaColors.success
                        : SoteriaColors.muted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (goal.rewardId != null) _buildRewardBadge(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(BuildContext context) {
    final color = _getTypeColor();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        goal.type.name.toUpperCase(),
        style: context.labelSmall.copyWith(
          color: color,
          fontSize: 8.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildExpiryBadge(BuildContext context) {
    final remaining = goal.endAt.difference(DateTime.now());
    String label;
    if (remaining.inHours > 24) {
      label = '${remaining.inDays}d left';
    } else if (remaining.inHours > 0) {
      label = '${remaining.inHours}h left';
    } else {
      label = '${remaining.inMinutes}m left';
    }

    return Text(
      label,
      style: context.labelSmall.copyWith(color: SoteriaColors.muted),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: LinearProgressIndicator(
        value: goal.progressPercentage,
        minHeight: 4.h,
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        valueColor: AlwaysStoppedAnimation(
          goal.isCompleted ? SoteriaColors.success : SoteriaColors.primary,
        ),
      ),
    );
  }

  Widget _buildRewardBadge(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.stars_rounded, color: SoteriaColors.gold, size: 12.sp),
        SizedBox(width: 4.w),
        Text(
          'REWARD',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getTypeColor() {
    switch (goal.type) {
      case GoalType.daily:
        return Colors.blueAccent;
      case GoalType.weekly:
        return Colors.purpleAccent;
      case GoalType.seasonal:
        return SoteriaColors.gold;
      case GoalType.career:
        return SoteriaColors.primary;
    }
  }
}
