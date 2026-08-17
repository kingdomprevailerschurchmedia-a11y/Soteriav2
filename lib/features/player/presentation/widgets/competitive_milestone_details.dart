import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../domain/models/milestone.dart';
import '../../domain/models/season_reward_definition.dart';

class CompetitiveMilestoneDetails extends StatelessWidget {
  final MilestoneProgress progress;
  final VoidCallback? onClaim;
  final bool isClaiming;

  const CompetitiveMilestoneDetails({
    super.key,
    required this.progress,
    this.onClaim,
    this.isClaiming = false,
  });

  @override
  Widget build(BuildContext context) {
    final definition = progress.definition;
    final playerState = progress.playerState;
    final isCompleted = progress.isCompleted;
    final isClaimed = playerState?.status == MilestoneStatus.claimed;

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      decoration: const BoxDecoration(
        color: SoteriaColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: isCompleted
                  ? SoteriaColors.gold.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.03),
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted
                    ? SoteriaColors.gold.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.05),
              ),
            ),
            child: (definition.id == 'first_game' ||
                        definition.id == 'welcome_bonus') &&
                    isCompleted
                ? Center(
                    child: Image.asset(
                      definition.id == 'first_game'
                          ? 'assets/icons/first_step_icon.png'
                          : 'assets/icons/star_icon.png',
                      width: 40.w,
                      height: 40.w,
                      fit: BoxFit.contain,
                    ),
                  )
                : Icon(
                    isCompleted
                        ? _getIconData(definition.icon)
                        : Icons.lock_outline_rounded,
                    color:
                        isCompleted ? SoteriaColors.gold : SoteriaColors.muted,
                    size: 40.sp,
                  ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            definition.name,
            style: context.headlineSmall.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: SoteriaSpacing.xs),
          Text(
            definition.category.name.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: SoteriaColors.primary,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Text(
            definition.description,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(color: SoteriaColors.textSecondary),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          _buildProgressInfo(context),
          SizedBox(height: SoteriaSpacing.xxl),
          if (definition.rewardType != null) _buildRewardSection(context),
          SizedBox(height: SoteriaSpacing.xxxl),
          if (isCompleted && !isClaimed && onClaim != null)
            SoteriaButton.reward(
              label: 'CLAIM REWARD',
              onPressed: onClaim,
              isLoading: isClaiming,
              isFullWidth: true,
            )
          else if (isClaimed)
            SoteriaButton.secondary(
              label: 'ALREADY CLAIMED',
              onPressed: null,
              isFullWidth: true,
            )
          else
            SoteriaButton.secondary(
              label: 'CLOSE',
              onPressed: () => Navigator.pop(context),
              isFullWidth: true,
            ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }

  Widget _buildProgressInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PROGRESS',
              style: context.labelSmall.copyWith(color: SoteriaColors.muted),
            ),
            Text(
              '${progress.playerState?.currentProgress.toInt() ?? 0} / ${progress.definition.threshold.toInt()}',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.sm),
        SoteriaProgressBar(
          progress: progress.progressPercentage,
          height: 8,
          hasGlow: true,
        ),
      ],
    );
  }

  Widget _buildRewardSection(BuildContext context) {
    final definition = progress.definition;
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Row(
        children: [
          _getRewardIcon(definition.rewardType!),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REWARD',
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                ),
                Text(
                  '${definition.rewardAmount} ${definition.rewardType!.name.toUpperCase()}',
                  style: context.titleMedium.copyWith(
                    color: SoteriaColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRewardIcon(RewardType type) {
    IconData iconData;
    Color color;

    switch (type) {
      case RewardType.coins:
        iconData = Icons.monetization_on_rounded;
        color = SoteriaColors.gold;
        break;
      case RewardType.xp:
        iconData = Icons.bolt_rounded;
        color = SoteriaColors.xpColor;
        break;
      default:
        iconData = Icons.card_giftcard_rounded;
        color = SoteriaColors.secondary;
    }

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: color, size: 24.sp),
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
