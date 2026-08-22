import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../player/domain/models/goal.dart';
import '../../../player/presentation/providers/goal_providers.dart';
import '../../../player/presentation/screens/competitive_goals_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DailyGoalsSection extends ConsumerWidget {
  const DailyGoalsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyGoalsAsync = ref.watch(dailyGoalsProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/daily_goals_icon_transparent.png',
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'DAILY GOALS',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CompetitiveGoalsScreen()),
                ),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w900,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: SoteriaColors.muted,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          dailyGoalsAsync.when(
            data: (goals) => _buildGoalsRow(context, goals),
            loading: () => const _LoadingGoalsCard(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsRow(BuildContext context, List<dynamic> goals) {
    // If no goals, show a placeholder
    if (goals.isEmpty) {
      return SoteriaCard(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Center(
          child: Text(
            'Check back later for new goals!',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
        ),
      );
    }

    // Limit to 3 for the dashboard summary
    final displayGoals = goals.take(3).toList();
    final completedCount = goals.where((g) => g.isCompleted).length;

    return SoteriaCard(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      borderRadius: 24,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  completedCount == goals.length
                      ? 'All daily goals completed!'
                      : 'Complete daily goals to earn bonus XP!',
                  maxLines: 2,
                  minFontSize: 10,
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: displayGoals.asMap().entries.map((entry) {
              final index = entry.key;
              final goal = entry.value;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _GoalProgressIcon(
                    icon: _getIconForCategory(goal.definition.category),
                    current: goal.playerState?.currentProgress.toInt() ?? 0,
                    total: goal.definition.target.toInt(),
                    color: _getColorForIndex(index),
                    isCompleted: goal.isCompleted,
                  ),
                  if (index < displayGoals.length - 1) _VerticalDivider(),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategory(GoalCategory category) {
    switch (category) {
      case GoalCategory.win:
        return Icons.emoji_events_rounded;
      case GoalCategory.gameCount:
        return Icons.sports_esports_rounded;
      case GoalCategory.rank:
        return Icons.trending_up_rounded;
      case GoalCategory.score:
        return Icons.leaderboard_rounded;
      case GoalCategory.streak:
        return Icons.local_fire_department_rounded;
      case GoalCategory.achievement:
        return Icons.stars_rounded;
      case GoalCategory.personalBest:
        return Icons.bolt_rounded;
      case GoalCategory.correctAnswers:
        return Icons.fact_check_rounded;
      case GoalCategory.practiceCount:
        return Icons.menu_book_rounded;
      case GoalCategory.xpEarned:
        return Icons.trending_up_rounded;
      default:
        return Icons.flash_on_rounded;
    }
  }

  Color _getColorForIndex(int index) {
    const colors = [
      Color(0xFF9155FD),
      Color(0xFF2196F3),
      Color(0xFFFF9F43),
    ];
    return colors[index % colors.length];
  }
}

class _GoalProgressIcon extends StatelessWidget {
  const _GoalProgressIcon({
    required this.icon,
    required this.current,
    required this.total,
    required this.color,
    this.isCompleted = false,
  });

  final IconData icon;
  final int current;
  final int total;
  final Color color;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? SoteriaColors.success.withValues(alpha: 0.1) : color.withValues(alpha: 0.1),
            border: Border.all(
              color: isCompleted ? SoteriaColors.success : color.withValues(alpha: 0.5),
              width: 1.2,
            ),
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check_rounded : icon,
              size: 20.sp,
              color: isCompleted ? SoteriaColors.success : color,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          '$current/$total',
          style: context.labelSmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        height: 32.h,
        width: 1,
        color: Colors.white.withValues(alpha: 0.05),
      ),
    );
  }
}

class _LoadingGoalsCard extends StatelessWidget {
  const _LoadingGoalsCard();

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: SizedBox(
        height: 60.h,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
