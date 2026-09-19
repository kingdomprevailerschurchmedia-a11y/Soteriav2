import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../providers/milestone_providers.dart';
import '../../../domain/models/milestone.dart';
import '../../../domain/models/achievement.dart';

import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/features/player/domain/services/achievement_registry.dart';

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
            Row(
              children: [
                Icon(Icons.military_tech_rounded, color: SoteriaColors.gold, size: 20.r),
                SizedBox(width: 12.w),
                Text(
                  'Achievements',
                  style: context.titleSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => context.push(SoteriaRoutes.achievements),
              child: Row(
                children: [
                  Text(
                    '${earned.length} / $total EARNED',
                    style: context.labelSmall.copyWith(
                      color: const Color(0xFF7C4DFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.chevron_right_rounded, color: const Color(0xFF7C4DFF), size: 18.r),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        
        // Next Milestone Card
        nextMilestoneAsync.when(
          data: (next) => next != null 
            ? _NextMilestoneCard(progress: next, onTap: () => context.push(SoteriaRoutes.achievements))
            : const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
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
      padding: EdgeInsets.all(16.r),
      borderRadius: 24,
      blur: 5.0,
      opacity: 0.02,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: Row(
        children: [
          Container(
            width: 72.r,
            height: 72.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/next_milestone.png',
                width: 36.r,
                height: 36.r,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.rocket_launch_rounded,
                  color: const Color(0xFF7C4DFF),
                  size: 32.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next Milestone',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  progress.definition.name,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 20.sp,
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
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          valueColor: const AlwaysStoppedAnimation(Color(0xFF7C4DFF)),
                          minHeight: 8.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      '${(progress.progressPercentage * 100).toInt()}%',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.secondary,
                        fontWeight: FontWeight.w900,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 24.r),
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
    final definition = AchievementRegistry.getById(achievement.achievementId);
    
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: definition != null && (definition.id == 'first_game' || definition.id == 'welcome_bonus')
            ? Image.asset(
                definition.id == 'first_game' 
                    ? 'assets/icons/first_step_icon.png'
                    : 'assets/icons/star_icon.png',
                width: 32.w,
                height: 32.w,
              )
            : Icon(
                _getIcon(definition?.icon),
                color: SoteriaColors.gold,
                size: 28.sp,
              ),
      ),
    );
  }

  IconData _getIcon(String? iconName) {
    switch (iconName) {
      case 'stars_rounded': return Icons.stars_rounded;
      case 'military_tech_rounded': return Icons.military_tech_rounded;
      case 'workspace_premium_rounded': return Icons.workspace_premium_rounded;
      case 'local_fire_department_rounded': return Icons.local_fire_department_rounded;
      case 'bolt_rounded': return Icons.bolt_rounded;
      case 'trending_up_rounded': return Icons.trending_up_rounded;
      case 'shield_rounded': return Icons.shield_rounded;
      case 'play_arrow_rounded': return Icons.play_arrow_rounded;
      case 'sports_esports_rounded': return Icons.sports_esports_rounded;
      case 'emoji_events_rounded': return Icons.emoji_events_rounded;
      case 'psychology_rounded': return Icons.psychology_rounded;
      case 'auto_awesome_rounded': return Icons.auto_awesome_rounded;
      case 'calendar_today_rounded': return Icons.calendar_today_rounded;
      default: return Icons.emoji_events_rounded;
    }
  }
}
