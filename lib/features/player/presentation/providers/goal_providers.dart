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
import '../../../auth/providers/auth_providers.dart';
import '../../../quiz/presentation/providers/history_providers.dart';
import '../../../practice/presentation/providers/practice_history_providers.dart';
import '../../../rewards/presentation/providers/rewards_providers.dart';

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
  // This provider now only triggers the evaluation via the controller
  // to avoid side-effects in a raw provider and handle concurrency.
  ref.listen(playerGoalsProvider, (prev, next) {
    if (next.hasValue) {
       _triggerEvaluation(ref);
    }
  });
  
  ref.listen(competitiveStatisticsProvider, (prev, next) {
    if (next.hasValue) {
      _triggerEvaluation(ref);
    }
  });
});

bool _isEvaluating = false;

Future<void> _triggerEvaluation(Ref ref) async {
  if (_isEvaluating) return;
  _isEvaluating = true;

  try {
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    final goals = ref.read(playerGoalsProvider).value;
    final results = ref.read(historyListProvider).value;
    final practice = ref.read(practiceHistoryListProvider).value;
    final stats = ref.read(competitiveStatisticsProvider).value;
    final progression = ref.read(competitiveProgressionProvider).value;

    if (goals == null || results == null || practice == null || stats == null || progression == null) {
      return;
    }

    final updated = ref.read(goalEvaluationServiceProvider).evaluate(
      playerGoals: goals,
      recentResults: results,
      practiceResults: practice,
      statistics: stats,
      progression: progression,
    );

    if (updated.isNotEmpty) {
      final repository = ref.read(goalRepositoryProvider);
      final rewardService = ref.read(progressionRewardServiceProvider);
      final walletRepo = ref.read(walletRepositoryProvider);
      final applyXp = ref.read(applyXpTransactionProvider);

      for (var goal in updated) {
        // Check if newly completed for automated rewards
        if (goal.status == GoalStatus.completed) {
          // Process XP rewards
          final xpTx = rewardService.processGoalReward(
            userId: userId,
            goalId: goal.goalId,
            goalState: goal,
          );
          if (xpTx != null) {
            try {
              await applyXp(xpTx);
            } catch (e) {
              print('Failed to apply XP for goal ${goal.goalId}: $e');
            }
          }

          // Process Coin rewards
          final coinAmount = rewardService.getGoalCoinReward(goal.goalId);
          if (coinAmount != null && coinAmount > 0) {
            try {
              await walletRepo.creditCurrency(
                userId: userId,
                amount: coinAmount,
                currency: 'coins',
                source: 'goal_completion',
                referenceId: goal.instanceId,
                description: 'Reward for completing goal',
              );
            } catch (e) {
              print('Failed to apply Coins for goal ${goal.goalId}: $e');
            }
          }

          // Mark as claimed locally before updating DB to prevent re-processing
          // if evaluation triggers again before DB syncs.
          goal = goal.copyWith(
            status: GoalStatus.claimed,
            claimedAt: DateTime.now(),
          );
        }

        await repository.updateGoalProgress(goal);
      }
    }
  } finally {
    _isEvaluating = false;
  }
}

/// Provider to ensure goals are refreshed/generated for the current period.
final goalRefreshProvider = FutureProvider<void>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return;

  await ref.read(goalRepositoryProvider).refreshGoals(userId);
});
