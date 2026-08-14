import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_goal.dart';
import '../../domain/repositories/goal_repository.dart';
import '../../data/repositories/firebase_goal_repository.dart';
import '../../domain/services/competitive_goal_evaluation_service.dart';
import 'statistics_providers.dart';
import 'progression_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../quiz/presentation/providers/history_providers.dart';

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return FirebaseGoalRepository(FirebaseFirestore.instance);
});

final goalEvaluationServiceProvider =
    Provider<CompetitiveGoalEvaluationService>((ref) {
      return CompetitiveGoalEvaluationService();
    });

final playerGoalsProvider = StreamProvider<List<CompetitiveGoal>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(goalRepositoryProvider).watchActiveGoals(userId);
});

final dailyGoalsProvider = Provider<AsyncValue<List<CompetitiveGoal>>>((ref) {
  return ref
      .watch(playerGoalsProvider)
      .whenData(
        (goals) => goals.where((g) => g.type == GoalType.daily).toList(),
      );
});

final weeklyGoalsProvider = Provider<AsyncValue<List<CompetitiveGoal>>>((ref) {
  return ref
      .watch(playerGoalsProvider)
      .whenData(
        (goals) => goals.where((g) => g.type == GoalType.weekly).toList(),
      );
});

final seasonalGoalsProvider = Provider<AsyncValue<List<CompetitiveGoal>>>((
  ref,
) {
  return ref
      .watch(playerGoalsProvider)
      .whenData(
        (goals) => goals.where((g) => g.type == GoalType.seasonal).toList(),
      );
});

final careerGoalsProvider = Provider<AsyncValue<List<CompetitiveGoal>>>((ref) {
  return ref
      .watch(playerGoalsProvider)
      .whenData(
        (goals) => goals.where((g) => g.type == GoalType.career).toList(),
      );
});

final nextGoalProvider = Provider<AsyncValue<CompetitiveGoal?>>((ref) {
  return ref.watch(playerGoalsProvider).whenData((goals) {
    if (goals.isEmpty) return null;
    
    // Prioritize nearly completed goals
    final activeGoals = goals.where((g) => g.status == GoalStatus.active).toList();
    if (activeGoals.isEmpty) return null;
    
    activeGoals.sort((a, b) => b.progressPercentage.compareTo(a.progressPercentage));
    return activeGoals.first;
  });
});

final goalHistoryProvider = FutureProvider<List<CompetitiveGoal>>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return [];
  return ref.read(goalRepositoryProvider).getGoalHistory(userId);
});

/// Orchestrator to trigger goal evaluation.
final goalEvaluationProvider = Provider<void>((ref) {
  final goalsAsync = ref.watch(playerGoalsProvider);
  final resultsAsync = ref.watch(historyListProvider);
  final statsAsync = ref.watch(competitiveStatisticsProvider);
  final progressionAsync = ref.watch(competitiveProgressionProvider);

  if (goalsAsync.hasValue &&
      resultsAsync.hasValue &&
      statsAsync.hasValue &&
      progressionAsync.hasValue) {
    final userId = ref.watch(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    final updated = ref
        .read(goalEvaluationServiceProvider)
        .evaluate(
          activeGoals: goalsAsync.value!,
          recentResults: resultsAsync.value!,
          statistics: statsAsync.value!,
          progression: progressionAsync.value!,
        );

    if (updated.isNotEmpty) {
      final repository = ref.read(goalRepositoryProvider);
      for (final goal in updated) {
        repository.updateGoalProgress(goal);
      }
    }
  }
});

/// Provider to ensure goals are refreshed/generated for the current period.
final goalRefreshProvider = FutureProvider<void>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return;

  await ref.read(goalRepositoryProvider).refreshGoals(userId);
});
