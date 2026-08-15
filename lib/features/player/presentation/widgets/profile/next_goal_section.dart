import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/goal.dart';
import '../../providers/goal_providers.dart';
import '../../screens/goal_details_screen.dart';

class NextGoalSection extends ConsumerWidget {
  const NextGoalSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextGoalAsync = ref.watch(nextGoalProvider);

    return nextGoalAsync.when(
      data: (progress) {
        if (progress == null) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.only(bottom: SoteriaSpacing.lg),
          child: SoteriaCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => GoalDetailsScreen(progress: progress)),
            ),
            child: Row(
              children: [
                _buildIcon(progress.definition.category),
                SizedBox(width: SoteriaSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NEXT GOAL',
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        progress.definition.title,
                        style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: SoteriaSpacing.xs),
                      LinearProgressIndicator(
                        value: progress.progressPercentage,
                        backgroundColor: SoteriaColors.border,
                        color: SoteriaColors.primary,
                        minHeight: 4.h,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: SoteriaSpacing.md),
                Text(
                  '${(progress.progressPercentage * 100).toInt()}%',
                  style: context.labelSmall.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildIcon(GoalCategory category) {
    IconData iconData;
    switch (category) {
      case GoalCategory.win: iconData = Icons.emoji_events_rounded; break;
      case GoalCategory.gameCount: iconData = Icons.sports_esports_rounded; break;
      case GoalCategory.rank: iconData = Icons.military_tech_rounded; break;
      case GoalCategory.score: iconData = Icons.analytics_rounded; break;
      case GoalCategory.streak: iconData = Icons.local_fire_department_rounded; break;
      case GoalCategory.achievement: iconData = Icons.stars_rounded; break;
      case GoalCategory.personalBest: iconData = Icons.auto_awesome_rounded; break;
    }

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: SoteriaColors.primary, size: 20.w),
    );
  }
}
