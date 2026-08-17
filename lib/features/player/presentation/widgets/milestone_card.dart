import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../../../core/design_system/components/soteria_button.dart';
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

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1638).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildIcon(context, isCompleted),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            definition.name,
                            style: context.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            definition.description,
                            style: context.bodySmall.copyWith(
                              color: SoteriaColors.textSecondary,
                              fontSize: 11.sp,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (definition.rewardAmount != null) _buildRewardBadge(context),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildProgressSection(context, isCompleted, isClaimed),
                if (isCompleted && !isClaimed && onClaim != null) ...[
                  SizedBox(height: 12.h),
                  _buildClaimButton(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, bool isCompleted) {
    final definition = progress.definition;
    return Container(
      width: 48.r,
      height: 48.r,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: (definition.id == 'first_game' || definition.id == 'welcome_bonus') && isCompleted
          ? Center(
              child: Image.asset(
                definition.id == 'first_game' 
                    ? 'assets/icons/first_step_icon.png'
                    : 'assets/icons/star_icon.png',
                width: 24.w,
                height: 24.w,
              ),
            )
          : Icon(
              isCompleted ? _getIconData(definition.icon) : Icons.lock_outline_rounded,
              color: isCompleted ? SoteriaColors.gold : Colors.white24,
              size: 20.sp,
            ),
    );
  }

  Widget _buildRewardBadge(BuildContext context) {
    final definition = progress.definition;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1638).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/coin_icon.png', width: 12.w),
          SizedBox(width: 4.w),
          Text(
            '${definition.rewardAmount}',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w900,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, bool isCompleted, bool isClaimed) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PROGRESS',
              style: context.labelSmall.copyWith(
                color: Colors.white24,
                fontSize: 9.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              isClaimed ? 'CLAIMED' : '${progress.playerState?.currentProgress.toInt() ?? 0} / ${progress.definition.threshold.toInt()}',
              style: context.labelSmall.copyWith(
                color: isCompleted ? SoteriaColors.success : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: isCompleted ? 1.0 : progress.progressPercentage,
            minHeight: 4.h,
            backgroundColor: Colors.white.withValues(alpha: 0.05),
            valueColor: AlwaysStoppedAnimation<Color>(
              isCompleted ? SoteriaColors.success : SoteriaColors.secondary
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClaimButton(BuildContext context) {
    return SoteriaButton.reward(
      label: 'CLAIM REWARD',
      onPressed: onClaim,
      isLoading: isClaiming,
      isFullWidth: true,
      size: SoteriaButtonSize.sm,
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
}
