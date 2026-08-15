import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/goal.dart';
import '../presentation/providers/goal_providers.dart';
import '../presentation/screens/competitive_goals_screen.dart';

class GoalPreviewWrapper extends StatelessWidget {
  final List<PlayerGoal> goals;
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
  static List<PlayerGoal> mockGoals() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final nextWeek = now.add(const Duration(days: 7));

    return [
      PlayerGoal(
        goalId: 'daily_games_3',
        userId: 'u1',
        status: GoalStatus.active,
        currentProgress: 2,
        startedAt: now,
        expiresAt: tomorrow,
      ),
      PlayerGoal(
        goalId: 'daily_wins_2',
        userId: 'u1',
        status: GoalStatus.completed,
        currentProgress: 2,
        startedAt: now,
        expiresAt: tomorrow,
        completedAt: now,
      ),
      PlayerGoal(
        goalId: 'weekly_games_20',
        userId: 'u1',
        status: GoalStatus.active,
        currentProgress: 15,
        startedAt: now,
        expiresAt: nextWeek,
      ),
      PlayerGoal(
        goalId: 'weekly_wins_10',
        userId: 'u1',
        status: GoalStatus.active,
        currentProgress: 4,
        startedAt: now,
        expiresAt: nextWeek,
      ),
      PlayerGoal(
        goalId: 'daily_games_3_expired',
        userId: 'u1',
        status: GoalStatus.expired,
        currentProgress: 1,
        startedAt: now.subtract(const Duration(days: 2)),
        expiresAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  static Widget full() => GoalPreviewWrapper(goals: mockGoals());
  static Widget empty() => const GoalPreviewWrapper(goals: []);
  static Widget loading() =>
      const GoalPreviewWrapper(goals: [], isLoading: true);
}
