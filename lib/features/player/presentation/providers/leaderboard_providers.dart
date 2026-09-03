import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../data/repositories/firebase_leaderboard_repository.dart';
import '../../domain/models/rank_movement_event.dart';
import '../../domain/services/leaderboard_insights_service.dart';
import '../../domain/config/leaderboard_config.dart';
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
final playerLeaderboardEntryFamily = StreamProvider.family<LeaderboardEntry?, String?>((
  ref,
  seasonId,
) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) return Stream.value(null);

  return ref
      .watch(leaderboardRepositoryProvider)
      .watchPlayerEntry(userId: session.uid!, seasonId: seasonId);
});

final playerLeaderboardEntryProvider = Provider<AsyncValue<LeaderboardEntry?>>((ref) {
  final seasonId = ref.watch(currentSeasonIdProvider);
  return ref.watch(playerLeaderboardEntryFamily(seasonId));
});

final playerRankPositionFamily = FutureProvider.family<int, String?>((ref, seasonId) async {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) return -1;

  return ref
      .watch(leaderboardRepositoryProvider)
      .getPlayerRankPosition(userId: session.uid!, seasonId: seasonId);
});

final playerRankPositionProvider = Provider<AsyncValue<int>>((ref) {
  final seasonId = ref.watch(currentSeasonIdProvider);
  return ref.watch(playerRankPositionFamily(seasonId));
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
  bool _hasReachedMax = false;
  LeaderboardEntry? _lastEntry;

  LeaderboardController(this._repository, this._seasonId)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    _hasReachedMax = false;
    _lastEntry = null;
    state = const AsyncValue.loading();
    try {
      final entries = await _repository.getLeaderboardPage(
        seasonId: _seasonId,
        limit: LeaderboardConfig.defaultPageSize,
      );
      
      if (entries.length < LeaderboardConfig.defaultPageSize) {
        _hasReachedMax = true;
      }
      
      if (entries.isNotEmpty) {
        _lastEntry = entries.last;
      }
      
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Updates only the first page results while preserving subsequent pages if they exist.
  /// Used for real-time updates from Firestore stream.
  void updateFirstPage(List<LeaderboardEntry> entries) {
    if (state.value == null || _lastEntry == null) {
      // If we don't have data yet or haven't paged, just set the state
      state = AsyncValue.data(entries);
      if (entries.isNotEmpty) {
        _lastEntry = entries.last;
      }
      return;
    }

    final currentList = state.value!;
    if (currentList.length <= LeaderboardConfig.defaultPageSize) {
      // We only have the first page anyway
      state = AsyncValue.data(entries);
      if (entries.isNotEmpty) {
        _lastEntry = entries.last;
      }
    } else {
      // Merge: Keep the new first page and append the rest of the existing list
      // This is a bit naive for real-time pagination but works for the top 50
      final rest = currentList.sublist(LeaderboardConfig.defaultPageSize);
      state = AsyncValue.data([...entries, ...rest]);
      // We don't update _lastEntry here because it's used for fetching page 3+ 
      // and we only updated page 1.
    }
  }

  Future<void> loadMore() async {
    if (state.value == null || state.isLoading || _hasReachedMax) return;

    try {
      final entries = await _repository.getLeaderboardPage(
        seasonId: _seasonId,
        limit: LeaderboardConfig.defaultPageSize,
        lastCursor: _lastEntry,
      );

      if (entries.length < LeaderboardConfig.defaultPageSize) {
        _hasReachedMax = true;
      }

      if (entries.isNotEmpty) {
        _lastEntry = entries.last;
        state = AsyncValue.data([...state.value!, ...entries]);
      }
    } catch (e) {
      // Don't set state to error to avoid losing current list, 
      // but maybe notify UI somehow or just log.
      print('Error loading more leaderboard entries: $e');
    }
  }
}

final leaderboardControllerProvider =
    StateNotifierProvider.family<
      LeaderboardController,
      AsyncValue<List<LeaderboardEntry>>,
      String?
    >((ref, seasonId) {
      final controller = LeaderboardController(
        ref.watch(leaderboardRepositoryProvider),
        seasonId,
      );

      // Listen to real-time updates for the first page (top 50)
      final sub = ref.watch(leaderboardRepositoryProvider)
          .watchLeaderboard(seasonId: seasonId, limit: LeaderboardConfig.defaultPageSize)
          .listen((entries) {
            controller.updateFirstPage(entries);
          });
      
      ref.onDispose(() => sub.cancel());

      return controller;
    });
