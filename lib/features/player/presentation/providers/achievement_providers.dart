import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/achievement.dart';
import '../../domain/services/achievement_registry.dart';
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
