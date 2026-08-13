import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../domain/models/milestone.dart';
import '../../domain/models/season_reward_definition.dart';

class MilestoneCard extends StatelessWidget {
  final MilestoneProgress progress;
  final VoidCallback? onTap;
  final VoidCallback? onClaim;
  final bool isClaiming;

  const MilestoneCard({
    super.key,
    required this.progress,
    this.onTap,
    this.onClaim,
    this.isClaiming = false,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress.isCompleted;
    final definition = progress.definition;
    final isClaimed = progress.playerState?.status == MilestoneStatus.claimed;

    return SoteriaCard(
      hasGlow: isCompleted && !isClaimed,
      glowColor: SoteriaColors.gold,
      onTap: onTap,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Column(
        children: [
          Row(
            children: [
              _buildIcon(context, isCompleted),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      definition.name,
                      style: context.titleSmall.copyWith(
                        color: isCompleted
                            ? SoteriaColors.gold
                            : SoteriaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      definition.description,
                      style: context.bodySmall.copyWith(
                        color: SoteriaColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (definition.rewardAmount != null) _buildRewardBadge(context),
            ],
          ),
          if (!isCompleted) ...[
            SizedBox(height: SoteriaSpacing.md),
            _buildProgressSection(context),
          ] else if (!isClaimed && onClaim != null) ...[
            SizedBox(height: SoteriaSpacing.md),
            _buildClaimSection(context),
          ] else if (isClaimed) ...[
            SizedBox(height: SoteriaSpacing.sm),
            _buildCompletionBadge(context, 'CLAIMED'),
          ] else ...[
            SizedBox(height: SoteriaSpacing.sm),
            _buildCompletionBadge(context, 'COMPLETED'),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, bool isCompleted) {
    final definition = progress.definition;
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: isCompleted
            ? SoteriaColors.gold.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(
          color: isCompleted
              ? SoteriaColors.gold.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Icon(
        isCompleted
            ? _getIconData(definition.icon)
            : Icons.lock_outline_rounded,
        color: isCompleted ? SoteriaColors.gold : SoteriaColors.muted,
        size: 24.sp,
      ),
    );
  }

  Widget _buildRewardBadge(BuildContext context) {
    final definition = progress.definition;
    final color = _getRewardColor(definition.rewardType!);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.sm,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SoteriaSpacing.xs),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getRewardIcon(definition.rewardType!),
            color: color,
            size: 10.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            '${definition.rewardAmount}',
            style: context.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PROGRESS',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                fontSize: 8.sp,
              ),
            ),
            Text(
              '${progress.playerState?.currentProgress.toInt() ?? 0} / ${progress.definition.threshold.toInt()}',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 8.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        SoteriaProgressBar(
          progress: progress.progressPercentage,
          height: 4,
          color: SoteriaColors.primary,
        ),
      ],
    );
  }

  Widget _buildClaimSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32.h,
      child: ElevatedButton(
        onPressed: isClaiming ? null : onClaim,
        style: ElevatedButton.styleFrom(
          backgroundColor: SoteriaColors.gold,
          foregroundColor: Colors.black,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SoteriaSpacing.sm),
          ),
        ),
        child: isClaiming
            ? SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
                ),
              )
            : Text(
                'CLAIM REWARD',
                style: context.labelSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
      ),
    );
  }

  Widget _buildCompletionBadge(BuildContext context, String label) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: SoteriaColors.success,
          size: 12.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.success,
            fontWeight: FontWeight.bold,
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'stars_rounded':
        return Icons.stars_rounded;
      case 'emoji_events_rounded':
        return Icons.emoji_events_rounded;
      case 'military_tech_rounded':
        return Icons.military_tech_rounded;
      case 'workspace_premium_rounded':
        return Icons.workspace_premium_rounded;
      case 'diamond_rounded':
        return Icons.diamond_rounded;
      case 'public_rounded':
        return Icons.public_rounded;
      case 'auto_awesome_rounded':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.emoji_events_rounded;
    }
  }

  IconData _getRewardIcon(RewardType type) {
    switch (type) {
      case RewardType.coins:
        return Icons.monetization_on_rounded;
      case RewardType.xp:
        return Icons.bolt_rounded;
      default:
        return Icons.card_giftcard_rounded;
    }
  }

  Color _getRewardColor(RewardType type) {
    switch (type) {
      case RewardType.coins:
        return SoteriaColors.gold;
      case RewardType.xp:
        return SoteriaColors.xpColor;
      default:
        return SoteriaColors.secondary;
    }
  }
}
