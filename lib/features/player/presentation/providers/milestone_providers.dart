import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';
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
import '../../domain/models/season_result.dart';
import '../../domain/config/milestone_registry.dart';
import '../../domain/services/progression_reward_service.dart';

final milestoneRepositoryProvider = Provider<MilestoneRepository>((ref) {
  return FirebaseMilestoneRepository(FirebaseFirestore.instance);
});

final milestoneClaimControllerProvider =
    NotifierProvider<MilestoneClaimNotifier, AsyncValue<void>>(
      MilestoneClaimNotifier.new,
    );

class MilestoneClaimNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> claim({
    required String userId,
    required String milestoneId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(milestoneRepositoryProvider).claimMilestone(userId, milestoneId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final milestoneEvaluationServiceProvider = Provider<MilestoneEvaluationService>(
  (ref) {
    return MilestoneEvaluationService();
  },
);

final progressionRewardServiceProvider = Provider<ProgressionRewardService>((ref) {
  return ProgressionRewardService();
});

final milestoneDefinitionsProvider = FutureProvider<List<MilestoneDefinition>>((
  ref,
) async {
  return MilestoneRegistry.definitions;
});

final playerMilestonesProvider = StreamProvider<List<PlayerMilestone>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(milestoneRepositoryProvider).watchPlayerMilestones(userId);
});

final milestoneProgressProvider = Provider<AsyncValue<List<MilestoneProgress>>>(
  (ref) {
    final playerStatesAsync = ref.watch(playerMilestonesProvider);

    if (playerStatesAsync.isLoading) {
      return const AsyncValue.loading();
    }

    if (playerStatesAsync.hasError)
      return AsyncValue.error(
        playerStatesAsync.error!,
        playerStatesAsync.stackTrace!,
      );

    final definitions = MilestoneRegistry.definitions;
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
  final playerStatesAsync = ref.watch(playerMilestonesProvider);

  if (statsAsync.hasValue &&
      progressionAsync.hasValue &&
      playerStatesAsync.hasValue) {
    final userId = ref.watch(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    final updated = ref
        .read(milestoneEvaluationServiceProvider)
        .evaluate(
          userId: userId,
          statistics: statsAsync.value!,
          progression: progressionAsync.value!,
          history: null,
          currentStates: playerStatesAsync.value!,
        );

    if (updated.isNotEmpty) {
      final repository = ref.read(milestoneRepositoryProvider);
      for (final milestone in updated) {
        repository.updateMilestoneState(milestone);
      }
    }
  }
});
