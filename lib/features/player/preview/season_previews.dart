import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_season.dart';
import '../domain/models/milestone.dart';
import '../domain/models/rank_progress.dart';
import '../domain/models/rank_tier.dart';
import '../domain/models/season_reward_definition.dart';
import '../presentation/providers/season_providers.dart';
import '../presentation/providers/rank_providers.dart';
import '../presentation/providers/milestone_providers.dart';
import '../presentation/providers/reward_providers.dart';
import '../presentation/providers/leaderboard_providers.dart';
import '../presentation/screens/competitive_season_screen.dart';
import '../domain/models/leaderboard_entry.dart';
import '../domain/repositories/leaderboard_repository.dart';
import '../domain/models/rank_movement_event.dart';

class MockLeaderboardRepository implements LeaderboardRepository {
  @override Future<List<LeaderboardEntry>> getLeaderboardPage({String? seasonId, int limit = 50, lastCursor}) async => [];
  @override Future<LeaderboardEntry?> getPlayerEntry({required String userId, String? seasonId}) async => null;
  @override Future<List<LeaderboardEntry>> getLeaderboardAroundPlayer({required String userId, String? seasonId, int windowSize = 5}) async => [];
  @override Future<int> getPlayerRankPosition({required String userId, String? seasonId}) async => 0;
  @override Future<int> getTotalPlayers({String? seasonId}) async => 0;
  @override Future<List<RankMovementEvent>> getPositionHistory({required String userId, String? seasonId, int limit = 50}) async => [];
  @override Future<void> recordMovement(RankMovementEvent event) async {}
  @override Future<List<LeaderboardEntry>> getEntriesByUserIds(List<String> userIds, {String? seasonId}) async => [];
}

class SeasonPreviews {
  static List<Override> _overrides({
    required CompetitiveSeason season,
    RankProgress? rank,
  }) {
    return [
      currentSeasonProvider.overrideWith((ref) => Stream.value(season)),
      if (rank != null) rankProgressProvider.overrideWithValue(AsyncValue.data(rank)),
      milestoneProgressProvider.overrideWithValue(const AsyncValue.data([])),
      seasonRewardDefinitionsProvider(season.seasonId).overrideWith((ref) => Future.value([])),
      leaderboardRepositoryProvider.overrideWithValue(MockLeaderboardRepository()),
    ];
  }

  static Widget active() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's1',
        name: 'Cyber Frontier',
        status: SeasonStatus.active,
        startAt: DateTime.now().subtract(const Duration(days: 10)),
        endAt: DateTime.now().add(const Duration(days: 12)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 1,
        description: 'Master the digital world and claim your rewards.',
      ),
      rank: RankProgress(
        currentRank: 'Gold II',
        currentRP: 2450,
        minimumRP: 2000,
        maximumRP: 3000,
        progressPercentage: 0.45,
        tier: const RankTier(id: 'gold', name: 'Gold', promotionThreshold: 2000, demotionThreshold: 1500, displayOrder: 3, maxPoints: 3000, minPoints: 2000, visualToken: 'gold_token'),
        division: 2,
      ),
    ),
    child: const CompetitiveSeasonScreen(),
  );

  static Widget upcoming() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's2',
        name: 'Neon Nights',
        status: SeasonStatus.upcoming,
        startAt: DateTime.now().add(const Duration(days: 5)),
        endAt: DateTime.now().add(const Duration(days: 35)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 2,
      ),
    ),
    child: const CompetitiveSeasonScreen(),
  );

  static Widget endingSoon() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's1',
        name: 'Cyber Frontier',
        status: SeasonStatus.ending,
        startAt: DateTime.now().subtract(const Duration(days: 28)),
        endAt: DateTime.now().add(const Duration(hours: 4)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 1,
      ),
    ),
    child: const CompetitiveSeasonScreen(),
  );

  static Widget completed() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's0',
        name: 'Legacy Void',
        status: SeasonStatus.completed,
        startAt: DateTime.now().subtract(const Duration(days: 60)),
        endAt: DateTime.now().subtract(const Duration(days: 30)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 0,
      ),
    ),
    child: const CompetitiveSeasonScreen(),
  );
}
