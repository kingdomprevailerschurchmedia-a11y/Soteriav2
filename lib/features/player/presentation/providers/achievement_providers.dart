import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/achievement.dart';
import '../../domain/services/achievement_registry.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../providers/player_providers.dart';
import '../../../auth/providers/auth_providers.dart';

import '../../domain/services/achievement_service.dart';
import 'progression_providers.dart';

/// Provider for all available achievement definitions.
final achievementDefinitionsProvider = Provider<List<AchievementDefinition>>((ref) {
  return AchievementRegistry.definitions;
});

/// Provider for the Achievement Service.
final achievementServiceProvider = Provider<AchievementService>((ref) {
  return AchievementService(
    achievementRepository: ref.watch(achievementRepositoryProvider),
    progressionRepository: ref.watch(playerProgressionRepositoryProvider),
    playerRepository: ref.watch(playerRepositoryProvider),
  );
});

final achievementClaimControllerProvider =
    NotifierProvider<AchievementClaimNotifier, AsyncValue<void>>(
      AchievementClaimNotifier.new,
    );

class AchievementClaimNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> claim({
    required String userId,
    required String achievementId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(achievementServiceProvider).claimAchievement(userId, achievementId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Stream provider for the current player's earned achievements.
final playerAchievementsStreamProvider =
    StreamProvider<List<PlayerAchievement>>((ref) {
      final session = ref.watch(sessionProvider);
      if (!session.isAuthenticated || session.uid == null) {
        return Stream.value([]);
      }

      return ref
          .watch(achievementRepositoryProvider)
          .watchPlayerAchievements(session.uid!);
    });

/// Computed provider for a map of achievement ID to player state.
final playerAchievementMapProvider = Provider<Map<String, PlayerAchievement>>((ref) {
  final achievements = ref.watch(playerAchievementsStreamProvider).value ?? [];
  return {for (final a in achievements) a.achievementId: a};
});

/// Provider for Achievement progress, combined with definitions.
final achievementProgressProvider = Provider<AsyncValue<List<AchievementProgress>>>((ref) {
  final playerStatesAsync = ref.watch(playerAchievementsStreamProvider);
  final definitions = ref.watch(achievementDefinitionsProvider);

  if (playerStatesAsync.isLoading) return const AsyncValue.loading();
  if (playerStatesAsync.hasError) return AsyncValue.error(playerStatesAsync.error!, playerStatesAsync.stackTrace!);

  final playerStates = playerStatesAsync.value ?? [];
  final progress = definitions.map((def) {
    final state = playerStates.firstWhere(
      (s) => s.achievementId == def.id,
      orElse: () => PlayerAchievement(
        userId: '',
        achievementId: def.id,
        status: AchievementStatus.inProgress,
        currentValue: 0.0,
        targetValue: def.threshold,
      ),
    );
    return AchievementProgress(definition: def, playerState: state);
  }).toList();

  return AsyncValue.data(progress);
});

class AchievementProgress {
  final AchievementDefinition definition;
  final PlayerAchievement playerState;

  AchievementProgress({required this.definition, required this.playerState});

  bool get isCompleted =>
      playerState.status == AchievementStatus.unlocked ||
      playerState.status == AchievementStatus.claimed;
  
  bool get isClaimed => playerState.status == AchievementStatus.claimed;

  double get progressPercentage => (playerState.currentValue / definition.threshold).clamp(0.0, 1.0);
}

/// Provider for recently earned achievements, sorted by unlock time.
final recentAchievementsProvider = Provider<List<PlayerAchievement>>((ref) {
  final achievements = ref.watch(playerAchievementsStreamProvider).value ?? [];
  final sorted = List<PlayerAchievement>.from(achievements)
    ..sort((a, b) => (b.unlockedAt ?? DateTime(0)).compareTo(a.unlockedAt ?? DateTime(0)));
  return sorted;
});

/// Provider for achievement progress summary.
final achievementSummaryProvider = Provider<AchievementSummary>((ref) {
  final allDefinitions = ref.watch(achievementDefinitionsProvider);
  final earnedMap = ref.watch(playerAchievementMapProvider);

  final totalCount = allDefinitions.length;
  final earnedCount = earnedMap.length;
  
  return AchievementSummary(
    earnedCount: earnedCount,
    totalCount: totalCount,
    progressPercentage: totalCount > 0 ? earnedCount / totalCount : 0,
  );
});

/// Orchestrator to trigger achievement evaluation when player stats change.
final achievementEvaluationProvider = Provider<void>((ref) {
  final playerAsync = ref.watch(currentPlayerStreamProvider);
  final progressionAsync = ref.watch(competitiveProgressionProvider);
  
  // We watch these to trigger re-evaluation when they change
  if (playerAsync.hasValue && progressionAsync.hasValue) {
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (userId != null) {
      // Use a microtask to avoid side-effects during build if this is called during a build phase
      Future.microtask(() {
        ref.read(achievementServiceProvider).evaluateAchievements(userId);
      });
    }
  }
});

class AchievementSummary {
  final int earnedCount;
  final int totalCount;
  final double progressPercentage;

  AchievementSummary({
    required this.earnedCount,
    required this.totalCount,
    required this.progressPercentage,
  });
}
