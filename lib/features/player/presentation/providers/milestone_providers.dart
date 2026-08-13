import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/milestone.dart';
import '../../domain/repositories/milestone_repository.dart';
import '../../data/repositories/firebase_milestone_repository.dart';
import '../../domain/services/milestone_evaluation_service.dart';
import 'statistics_providers.dart';
import 'progression_providers.dart';
import 'history_providers.dart';
import 'season_providers.dart';
import 'reward_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/reward_grant.dart';
import '../../domain/models/season_reward_definition.dart';

final milestoneRepositoryProvider = Provider<MilestoneRepository>((ref) {
  return FirebaseMilestoneRepository(FirebaseFirestore.instance);
});

final milestoneEvaluationServiceProvider = Provider<MilestoneEvaluationService>(
  (ref) {
    return MilestoneEvaluationService();
  },
);

final milestoneDefinitionsProvider = FutureProvider<List<MilestoneDefinition>>((
  ref,
) {
  return ref.watch(milestoneRepositoryProvider).getMilestoneDefinitions();
});

final playerMilestonesProvider = StreamProvider<List<PlayerMilestone>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(milestoneRepositoryProvider).watchPlayerMilestones(userId);
});

final milestoneProgressProvider = Provider<AsyncValue<List<MilestoneProgress>>>(
  (ref) {
    final definitionsAsync = ref.watch(milestoneDefinitionsProvider);
    final playerStatesAsync = ref.watch(playerMilestonesProvider);

    if (definitionsAsync.isLoading || playerStatesAsync.isLoading) {
      return const AsyncValue.loading();
    }

    if (definitionsAsync.hasError)
      return AsyncValue.error(
        definitionsAsync.error!,
        definitionsAsync.stackTrace!,
      );
    if (playerStatesAsync.hasError)
      return AsyncValue.error(
        playerStatesAsync.error!,
        playerStatesAsync.stackTrace!,
      );

    final definitions = definitionsAsync.value ?? [];
    final playerStates = playerStatesAsync.value ?? [];

    final progress = definitions.map((def) {
      final state = playerStates.firstWhere(
        (s) => s.milestoneId == def.id,
        orElse: () => PlayerMilestone(
          userId: '',
          milestoneId: def.id,
          status: MilestoneStatus.locked,
          currentProgress: 0.0,
        ),
      );
      return MilestoneProgress(definition: def, playerState: state);
    }).toList();

    return AsyncValue.data(progress);
  },
);

final nextCompetitiveMilestoneProvider = Provider<AsyncValue<MilestoneProgress?>>(
  (ref) {
    final milestonesAsync = ref.watch(milestoneProgressProvider);

    return milestonesAsync.whenData((milestones) {
      final inProgress = milestones.where((m) => !m.isCompleted).toList();
      if (inProgress.isEmpty) return null;

      // Sort by progress percentage descending to find the closest one
      inProgress.sort((a, b) => b.progressPercentage.compareTo(a.progressPercentage));
      return inProgress.first;
    });
  },
);

/// Orchestrator to trigger milestone evaluation when statistics change.
final Provider<void> milestoneEvaluationProvider = Provider<void>((ref) {
  final statsAsync = ref.watch(competitiveStatisticsProvider);
  final progressionAsync = ref.watch(competitiveProgressionProvider);
  final historyAsync = ref.watch(competitiveHistorySummaryProvider);
  final definitionsAsync = ref.watch(milestoneDefinitionsProvider);
  final playerStatesAsync = ref.watch(playerMilestonesProvider);
  final currentSeasonAsync = ref.watch(currentSeasonProvider);

  if (statsAsync.hasValue &&
      progressionAsync.hasValue &&
      historyAsync.hasValue &&
      definitionsAsync.hasValue &&
      playerStatesAsync.hasValue &&
      currentSeasonAsync.hasValue) {
    final userId = ref.watch(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    final definitions = definitionsAsync.value!;
    final updated = ref
        .read(milestoneEvaluationServiceProvider)
        .evaluate(
          userId: userId,
          definitions: definitions,
          statistics: statsAsync.value!,
          progression: progressionAsync.value!,
          history: historyAsync.value!,
          currentStates: playerStatesAsync.value!,
        );

    if (updated.isNotEmpty) {
      final repository = ref.read(milestoneRepositoryProvider);
      final rewardRepository = ref.read(rewardRepositoryProvider);
      final seasonId = currentSeasonAsync.value?.seasonId ?? 'career';

      for (final milestone in updated) {
        repository.updateMilestoneState(milestone);

        // Grant reward if completed
        if (milestone.status == MilestoneStatus.completed) {
          final definition = definitions.firstWhere(
            (d) => d.id == milestone.milestoneId,
          );

          if (definition.rewardType != null && definition.rewardAmount != null) {
            final grant = RewardGrant(
              grantId: 'milestone_${milestone.milestoneId}_$userId',
              rewardId: milestone.milestoneId,
              seasonId: seasonId,
              userId: userId,
              type: definition.rewardType!,
              amount: definition.rewardAmount!,
              status: GrantStatus.eligible,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            rewardRepository.grantReward(grant);
          }
        }
      }
    }
  }
});
