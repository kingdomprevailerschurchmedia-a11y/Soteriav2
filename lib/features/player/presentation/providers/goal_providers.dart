import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/goal.dart';
import '../../domain/repositories/goal_repository.dart';
import '../../data/repositories/firebase_goal_repository.dart';
import '../../domain/services/goal_evaluation_service.dart';
import '../../domain/services/progression_reward_service.dart';
import '../../domain/config/goal_registry.dart';
import 'statistics_providers.dart';
import 'progression_providers.dart';
import 'history_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../quiz/presentation/providers/history_providers.dart';

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return FirebaseGoalRepository(FirebaseFirestore.instance);
});

final goalEvaluationServiceProvider = Provider<GoalEvaluationService>((ref) {
  return GoalEvaluationService();
});

final progressionRewardServiceProvider = Provider<ProgressionRewardService>((ref) {
  return ProgressionRewardService();
});

final playerGoalsProvider = StreamProvider<List<PlayerGoal>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(goalRepositoryProvider).watchActiveGoals(userId);
});

final goalProgressProvider = Provider<AsyncValue<List<GoalProgress>>>((ref) {
  return ref.watch(playerGoalsProvider).whenData((playerGoals) {
    return playerGoals.map((pg) {
      final definitionId = pg.goalId; // Registry lookup handles dynamic IDs via internal logic if needed
      // Actually GoalRegistry.getById takes the definition ID.
      // FirebaseGoalRepository.refreshGoals uses def.id for pg.goalId.
      final definition = GoalRegistry.getById(pg.goalId);
      if (definition == null) return null;
      return GoalProgress(definition: definition, playerState: pg);
    }).whereType<GoalProgress>().toList();
  });
});

final dailyGoalsProvider = Provider<AsyncValue<List<GoalProgress>>>((ref) {
  return ref.watch(goalProgressProvider).whenData(
        (goals) => goals.where((g) => g.definition.type == GoalType.daily).toList(),
      );
});

final weeklyGoalsProvider = Provider<AsyncValue<List<GoalProgress>>>((ref) {
  return ref.watch(goalProgressProvider).whenData(
        (goals) => goals.where((g) => g.definition.type == GoalType.weekly).toList(),
      );
});

final seasonalGoalsProvider = Provider<AsyncValue<List<GoalProgress>>>((ref) {
  return ref.watch(goalProgressProvider).whenData(
        (goals) => goals.where((g) => g.definition.type == GoalType.seasonal).toList(),
      );
});

final careerGoalsProvider = Provider<AsyncValue<List<GoalProgress>>>((ref) {
  return ref.watch(goalProgressProvider).whenData(
        (goals) => goals.where((g) => g.definition.type == GoalType.career).toList(),
      );
});

final nextGoalProvider = Provider<AsyncValue<GoalProgress?>>((ref) {
  return ref.watch(goalProgressProvider).whenData((goals) {
    if (goals.isEmpty) return null;
    final active = goals.where((g) => g.playerState?.isActive ?? false).toList();
    if (active.isEmpty) return null;
    active.sort((a, b) => b.progressPercentage.compareTo(a.progressPercentage));
    return active.first;
  });
});

final goalHistoryProvider = FutureProvider<List<PlayerGoal>>((ref) async {
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
          playerGoals: goalsAsync.value!,
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
