import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/goal.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';

class CompetitiveGoalCard extends StatelessWidget {
  final GoalProgress progress;
  final VoidCallback? onTap;

  const CompetitiveGoalCard({super.key, required this.progress, this.onTap});

  @override
  Widget build(BuildContext context) {
    final definition = progress.definition;
    final playerState = progress.playerState;
    final isCompleted = progress.isCompleted;
    final progressValue = progress.progressPercentage;

    return Semantics(
      label: 'Goal: ${definition.title}. Progress: ${(progressValue * 100).toInt()}%.',
      child: SoteriaCard(
        onTap: onTap,
        padding: EdgeInsets.all(SoteriaSpacing.md),
        hasGlow: isCompleted,
        glowColor: SoteriaColors.success,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTypeBadge(context),
                if (!isCompleted && !progress.isExpired) _buildExpiryBadge(context),
                if (progress.isExpired) _buildExpiredBadge(context),
                if (isCompleted)
                  Icon(
                    Icons.check_circle_rounded,
                    color: SoteriaColors.success,
                    size: 16.sp,
                  ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              definition.title,
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: isCompleted ? Colors.white38 : Colors.white,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              definition.description,
              style: context.bodySmall.copyWith(
                color: isCompleted ? Colors.white24 : Colors.white70,
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            _buildProgressBar(context),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${playerState?.currentProgress.toInt() ?? 0} / ${definition.target.toInt()}',
                  style: context.labelSmall.copyWith(
                    color: isCompleted
                        ? SoteriaColors.success
                        : SoteriaColors.muted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (definition.rewardAmount != null) _buildRewardBadge(context),
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
        progress.definition.type.name.toUpperCase(),
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
    if (progress.playerState == null) return const SizedBox.shrink();
    final remaining = progress.playerState!.expiresAt.difference(DateTime.now());
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

  Widget _buildExpiredBadge(BuildContext context) {
    return Text(
      'EXPIRED',
      style: context.labelSmall.copyWith(color: SoteriaColors.error, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: LinearProgressIndicator(
        value: progress.progressPercentage,
        minHeight: 4.h,
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        valueColor: AlwaysStoppedAnimation(
          progress.isCompleted ? SoteriaColors.success : SoteriaColors.primary,
        ),
      ),
    );
  }

  Widget _buildRewardBadge(BuildContext context) {
    final definition = progress.definition;
    final isXP = definition.rewardType == RewardType.xp;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isXP)
          Image.asset(
            'assets/icons/flash_icon.png',
            width: 14.sp,
            height: 14.sp,
            fit: BoxFit.contain,
          )
        else
          Image.asset(
            'assets/icons/coin_icon.png',
            width: 14.sp,
            height: 14.sp,
            fit: BoxFit.contain,
          ),
        SizedBox(width: 6.w),
        Text(
          '${definition.rewardAmount}',
          style: context.labelSmall.copyWith(
            color: isXP ? SoteriaColors.xpColor : SoteriaColors.gold,
            fontWeight: FontWeight.w900,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          'REWARD',
          style: context.labelSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.4),
            fontWeight: FontWeight.w900,
            fontSize: 9.sp,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Color _getTypeColor() {
    switch (progress.definition.type) {
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
