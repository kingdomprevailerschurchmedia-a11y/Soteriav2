import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../providers/milestone_providers.dart';
import '../../providers/achievement_providers.dart';
import '../../../domain/models/milestone.dart';
import '../../../domain/models/achievement.dart';

import 'package:go_router/go_router.dart';
import '../../../../../core/navigation/soteria_routes.dart';

class AchievementSummarySection extends ConsumerWidget {
  final List<PlayerAchievement> earned;
  final int total;
  final VoidCallback? onViewAll;

  const AchievementSummarySection({
    super.key,
    required this.earned,
    required this.total,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextMilestoneAsync = ref.watch(nextCompetitiveMilestoneProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ACHIEVEMENTS',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.gold,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(SoteriaRoutes.achievements),
              child: Text(
                '${earned.length} / $total EARNED',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        
        // Horizontal list of earned achievements
        if (earned.isNotEmpty) ...[
          SizedBox(
            height: 64.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: earned.length,
              separatorBuilder: (_, __) => SizedBox(width: SoteriaSpacing.md),
              itemBuilder: (context, index) {
                final achievement = earned[index];
                return _AchievementBadge(achievement: achievement);
              },
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
        ],

        // Next Milestone Card
        nextMilestoneAsync.when(
          data: (next) => next != null 
            ? _NextMilestoneCard(progress: next, onTap: onViewAll)
            : const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),

        if (earned.isEmpty && nextMilestoneAsync.value == null)
          SoteriaCard(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: Center(
              child: Text(
                'No achievements unlocked yet.',
                style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
              ),
            ),
          ),
      ],
    );
  }
}

class _NextMilestoneCard extends StatelessWidget {
  final MilestoneProgress progress;
  final VoidCallback? onTap;

  const _NextMilestoneCard({required this.progress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      onTap: onTap,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.flag_rounded,
              color: SoteriaColors.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEXT MILESTONE',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 8.sp,
                  ),
                ),
                Text(
                  progress.definition.name,
                  style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progress.progressPercentage,
                    backgroundColor: Colors.white10,
                    valueColor: const AlwaysStoppedAnimation(SoteriaColors.primary),
                    minHeight: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Text(
            '${(progress.progressPercentage * 100).toInt()}%',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final PlayerAchievement achievement;

  const _AchievementBadge({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2)),
      ),
      child: Icon(
        Icons.emoji_events_rounded,
        color: SoteriaColors.gold,
        size: 24.sp,
      ),
    );
  }
}
