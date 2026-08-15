import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/competitive_profile.dart';
import '../../domain/models/season_result.dart';
import 'progression_providers.dart';
import 'season_providers.dart';
import 'leaderboard_providers.dart';
import 'history_providers.dart';
import 'reward_providers.dart';
import 'milestone_providers.dart';
import 'personal_record_providers.dart';
import 'streak_providers.dart';
import 'achievement_providers.dart';
import '../../providers/player_providers.dart';
import 'service_providers.dart';

final Provider<AsyncValue<CompetitiveProfile>>
competitiveProfileProvider = Provider<AsyncValue<CompetitiveProfile>>((ref) {
  final playerAsync = ref.watch(currentPlayerStreamProvider);
  final progressionAsync = ref.watch(competitiveProgressionProvider);
  final seasonAsync = ref.watch(currentSeasonProvider);
  final positionAsync = ref.watch(playerRankPositionProvider);
  final historyAsync = ref.watch(competitiveHistorySummaryProvider);
  final rewardsAsync = ref.watch(playerRewardsProvider);
  final milestonesAsync = ref.watch(playerMilestonesProvider);
  final milestoneDefinitionsAsync = ref.watch(milestoneDefinitionsProvider);
  final personalRecordsAsync = ref.watch(currentUserPersonalRecordsProvider);
  final streakAsync = ref.watch(currentWinStreakProvider);
  final achievementsAsync = ref.watch(playerAchievementsStreamProvider);
  final achievementDefinitionsAsync = ref.watch(achievementDefinitionsProvider);
  final statsService = ref.watch(statisticsServiceProvider);

  // Evaluation is triggered by separate orchestrator or screen to avoid cycles

  // Check for loading states
  final isLoading =
      playerAsync.isLoading ||
      progressionAsync.isLoading ||
      historyAsync.isLoading ||
      milestonesAsync.isLoading ||
      personalRecordsAsync.isLoading ||
      streakAsync.isLoading ||
      achievementsAsync.isLoading;

  if (isLoading) {
    return const AsyncValue.loading();
  }

  // Critical errors
  if (playerAsync.hasError) {
    return AsyncValue.error(playerAsync.error!, playerAsync.stackTrace!);
  }
  if (progressionAsync.hasError) {
    return AsyncValue.error(
      progressionAsync.error!,
      progressionAsync.stackTrace!,
    );
  }

  final player = playerAsync.value;
  final progression = progressionAsync.value;

  // If we don't have basic player/progression data, we can't show the profile
  if (player == null || progression == null) {
    return const AsyncValue.loading();
  }

  // Handle partial data for history, season, rewards, and position
  final history =
      historyAsync.value ?? CompetitiveHistory(userId: player.uid);
  final currentSeason = seasonAsync.value;
  final rewards = rewardsAsync.value ?? [];
  final globalPosition = positionAsync.value ?? -1;
  final milestones = milestonesAsync.value ?? [];
  final definitionsCount = milestoneDefinitionsAsync.value?.length ?? 0;
  final personalRecords = personalRecordsAsync.value ?? [];
  final streak = streakAsync.value;
  final earnedAchievements = achievementsAsync.value ?? [];
  final totalAchievementsCount = achievementDefinitionsAsync.length;

  final careerSummary = statsService.calculateCareerSummary(
    userId: player.uid,
    profile: player,
    history: history,
    records: personalRecords,
  );

  return AsyncValue.data(
    CompetitiveProfile(
      identity: player,
      progression: progression,
      currentSeason: currentSeason,
      globalPosition: globalPosition,
      history: history,
      recentRewards: List.from(rewards)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      totalRewards: rewards.length,
      completedMilestones: milestones
          .where(
            (m) => m.status.name == 'completed' || m.status.name == 'claimed',
          )
          .toList(),
      totalMilestones: definitionsCount,
      earnedAchievements: earnedAchievements,
      totalAchievements: totalAchievementsCount,
      personalRecords: personalRecords,
      careerSummary: careerSummary,
      streak: streak,
    ),
  );
});
