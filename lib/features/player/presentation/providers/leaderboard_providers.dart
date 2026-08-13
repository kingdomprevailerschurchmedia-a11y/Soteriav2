import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../data/repositories/firebase_leaderboard_repository.dart';
import '../../domain/models/rank_movement_event.dart';
import '../../domain/services/leaderboard_insights_service.dart';
import '../../../../core/identity/providers/identity_providers.dart';

// --- Repositories ---
final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return FirebaseLeaderboardRepository(FirebaseFirestore.instance);
});

// --- Services ---
final leaderboardInsightsServiceProvider = Provider<LeaderboardInsightsService>((ref) {
  return LeaderboardInsightsService();
});

// --- Active Season Info ---
final currentSeasonIdProvider = Provider<String?>((ref) {
  return 'season_2026_1';
});

// --- Paginated Leaderboard ---
final leaderboardPageProvider = FutureProvider.family<List<LeaderboardEntry>, int>((
  ref,
  page,
) async {
  final seasonId = ref.watch(currentSeasonIdProvider);
  final repository = ref.watch(leaderboardRepositoryProvider);
  return repository.getLeaderboardPage(seasonId: seasonId, limit: 50);
});

// --- Total Players ---
final leaderboardTotalPlayersProvider = FutureProvider<int>((ref) async {
  final seasonId = ref.watch(currentSeasonIdProvider);
  return ref.watch(leaderboardRepositoryProvider).getTotalPlayers(seasonId: seasonId);
});

// --- Player Rank State ---
final playerLeaderboardEntryProvider = FutureProvider<LeaderboardEntry?>((
  ref,
) async {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) return null;

  final seasonId = ref.watch(currentSeasonIdProvider);
  return ref
      .watch(leaderboardRepositoryProvider)
      .getPlayerEntry(userId: session.uid!, seasonId: seasonId);
});

final playerRankPositionProvider = FutureProvider<int>((ref) async {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) return -1;

  final seasonId = ref.watch(currentSeasonIdProvider);
  return ref
      .watch(leaderboardRepositoryProvider)
      .getPlayerRankPosition(userId: session.uid!, seasonId: seasonId);
});

// --- Rank Movement History ---
final rankMovementHistoryProvider = FutureProvider<List<RankMovementEvent>>((ref) async {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) return [];

  final seasonId = ref.watch(currentSeasonIdProvider);
  return ref
      .watch(leaderboardRepositoryProvider)
      .getPositionHistory(userId: session.uid!, seasonId: seasonId);
});

// --- Around Player View ---
final leaderboardAroundPlayerProvider = FutureProvider<List<LeaderboardEntry>>((
  ref,
) async {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) return [];

  final seasonId = ref.watch(currentSeasonIdProvider);
  return ref
      .watch(leaderboardRepositoryProvider)
      .getLeaderboardAroundPlayer(userId: session.uid!, seasonId: seasonId);
});

// --- Neighborhood ---
final leaderboardNeighborhoodProvider = Provider<AsyncValue<LeaderboardNeighborhoodData>>((ref) {
  final aroundAsync = ref.watch(leaderboardAroundPlayerProvider);
  final session = ref.watch(sessionProvider);

  return aroundAsync.whenData((entries) {
    if (entries.isEmpty) return const LeaderboardNeighborhoodData();

    final playerIndex = entries.indexWhere((e) => e.userId == session.uid);
    if (playerIndex == -1) return const LeaderboardNeighborhoodData();

    return LeaderboardNeighborhoodData(
      playerAbove: playerIndex > 0 ? entries[playerIndex - 1] : null,
      currentPlayer: entries[playerIndex],
      playerBelow: playerIndex < entries.length - 1 ? entries[playerIndex + 1] : null,
    );
  });
});

class LeaderboardNeighborhoodData {
  final LeaderboardEntry? playerAbove;
  final LeaderboardEntry? currentPlayer;
  final LeaderboardEntry? playerBelow;

  const LeaderboardNeighborhoodData({
    this.playerAbove,
    this.currentPlayer,
    this.playerBelow,
  });
}

// --- Insights ---
final leaderboardInsightsProvider = Provider<AsyncValue<List<LeaderboardInsight>>>((ref) {
  final playerEntryAsync = ref.watch(playerLeaderboardEntryProvider);
  final totalPlayersAsync = ref.watch(leaderboardTotalPlayersProvider);
  final historyAsync = ref.watch(rankMovementHistoryProvider);
  final neighborhoodAsync = ref.watch(leaderboardNeighborhoodProvider);
  final service = ref.watch(leaderboardInsightsServiceProvider);

  if (playerEntryAsync.isLoading || totalPlayersAsync.isLoading || historyAsync.isLoading) {
    return const AsyncValue.loading();
  }

  return playerEntryAsync.when(
    data: (playerEntry) {
      if (playerEntry == null) return const AsyncValue.data([]);
      
      final totalPlayers = totalPlayersAsync.value ?? 0;
      final history = historyAsync.value ?? [];
      final playerAbove = neighborhoodAsync.value?.playerAbove;

      return AsyncValue.data(service.generateInsights(
        playerEntry: playerEntry,
        totalPlayers: totalPlayers,
        history: history,
        playerAbove: playerAbove,
      ));
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

// --- Controller for complex pagination ---
class LeaderboardController
    extends StateNotifier<AsyncValue<List<LeaderboardEntry>>> {
  final LeaderboardRepository _repository;
  final String? _seasonId;

  LeaderboardController(this._repository, this._seasonId)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final entries = await _repository.getLeaderboardPage(seasonId: _seasonId);
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    if (state.value == null || state.isLoading) return;

    // In a real Firebase impl, we'd use the last DocumentSnapshot as cursor.
    // For now, we'll keep it simple as the UI focus is on the architecture foundation.
  }
}

final leaderboardControllerProvider =
    StateNotifierProvider<
      LeaderboardController,
      AsyncValue<List<LeaderboardEntry>>
    >((ref) {
      return LeaderboardController(
        ref.watch(leaderboardRepositoryProvider),
        ref.watch(currentSeasonIdProvider),
      );
    });
