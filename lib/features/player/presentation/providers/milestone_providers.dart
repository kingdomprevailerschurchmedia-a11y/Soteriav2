import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/milestone.dart';
import '../../domain/repositories/milestone_repository.dart';
import '../../data/repositories/firebase_milestone_repository.dart';
import '../../domain/services/milestone_evaluation_service.dart';
import 'statistics_providers.dart';
import 'progression_providers.dart';
import 'history_providers.dart';
import '../../../auth/providers/auth_providers.dart';

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

/// Orchestrator to trigger milestone evaluation when statistics change.
final Provider<void> milestoneEvaluationProvider = Provider<void>((ref) {
  final statsAsync = ref.watch(competitiveStatisticsProvider);
  final progressionAsync = ref.watch(competitiveProgressionProvider);
  final historyAsync = ref.watch(competitiveHistorySummaryProvider);
  final definitionsAsync = ref.watch(milestoneDefinitionsProvider);
  final playerStatesAsync = ref.watch(playerMilestonesProvider);

  if (statsAsync.hasValue &&
      progressionAsync.hasValue &&
      historyAsync.hasValue &&
      definitionsAsync.hasValue &&
      playerStatesAsync.hasValue) {
    final userId = ref.watch(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    final updated = ref
        .read(milestoneEvaluationServiceProvider)
        .evaluate(
          userId: userId,
          definitions: definitionsAsync.value!,
          statistics: statsAsync.value!,
          progression: progressionAsync.value!,
          history: historyAsync.value!,
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
