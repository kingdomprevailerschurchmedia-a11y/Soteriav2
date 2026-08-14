import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_goal.dart';
import '../presentation/providers/goal_providers.dart';
import '../presentation/screens/competitive_goals_screen.dart';

class GoalPreviewWrapper extends StatelessWidget {
  final List<CompetitiveGoal> goals;
  final bool isLoading;

  const GoalPreviewWrapper({
    super.key,
    required this.goals,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        playerGoalsProvider.overrideWith((ref) => Stream.value(goals)),
        goalRefreshProvider.overrideWith((ref) async {}),
        goalEvaluationProvider.overrideWith((ref) {}),
      ],
      child: const CompetitiveGoalsScreen(),
    );
  }
}

class GoalPreviews {
  static List<CompetitiveGoal> mockGoals() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final nextWeek = now.add(const Duration(days: 7));

    return [
      CompetitiveGoal(
        id: '1',
        userId: 'u1',
        type: GoalType.daily,
        category: GoalCategory.gameCount,
        title: 'Daily Participation',
        description: 'Play 3 competitive games today.',
        target: 3,
        currentProgress: 2,
        status: GoalStatus.active,
        startAt: now,
        endAt: tomorrow,
      ),
      CompetitiveGoal(
        id: '2',
        userId: 'u1',
        type: GoalType.daily,
        category: GoalCategory.win,
        title: 'Winner',
        description: 'Win 2 games today.',
        target: 2,
        currentProgress: 2,
        status: GoalStatus.completed,
        startAt: now,
        endAt: tomorrow,
      ),
      CompetitiveGoal(
        id: '3',
        userId: 'u1',
        type: GoalType.weekly,
        category: GoalCategory.win,
        title: 'Weekly Dominance',
        description: 'Win 10 games this week.',
        target: 10,
        currentProgress: 4,
        status: GoalStatus.active,
        startAt: now,
        endAt: nextWeek,
        rewardId: 'rew_123',
      ),
      CompetitiveGoal(
        id: '4',
        userId: 'u1',
        type: GoalType.career,
        category: GoalCategory.rank,
        title: 'Reach Gold I',
        description: 'Climb to the top of Gold tier.',
        target: 1,
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: now,
        endAt: now.add(const Duration(days: 30)),
        metadata: {'targetTier': 'Gold I'},
      ),
    ];
  }

  static Widget full() => GoalPreviewWrapper(goals: mockGoals());
  static Widget empty() => const GoalPreviewWrapper(goals: []);
  static Widget loading() =>
      const GoalPreviewWrapper(goals: [], isLoading: true);
}
