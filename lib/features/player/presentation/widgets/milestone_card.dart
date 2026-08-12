import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../domain/models/milestone.dart';

class MilestoneCard extends StatelessWidget {
  final MilestoneProgress progress;
  final VoidCallback? onTap;

  const MilestoneCard({super.key, required this.progress, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress.isCompleted;
    final definition = progress.definition;

    return SoteriaCard(
      hasGlow: isCompleted,
      glowColor: SoteriaColors.gold,
      onTap: onTap,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Row(
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
                if (!isCompleted) ...[
                  SizedBox(height: SoteriaSpacing.sm),
                  _buildProgressSection(context),
                ] else ...[
                  SizedBox(height: SoteriaSpacing.xs),
                  _buildCompletionBadge(context),
                ],
              ],
            ),
          ),
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

  Widget _buildCompletionBadge(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: SoteriaColors.success,
          size: 12.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          'COMPLETED',
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
      default:
        return Icons.emoji_events_rounded;
    }
  }
}
