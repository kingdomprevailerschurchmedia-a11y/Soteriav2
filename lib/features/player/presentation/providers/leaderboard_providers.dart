import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../data/repositories/firebase_leaderboard_repository.dart';
import '../../../../core/identity/providers/identity_providers.dart';

// --- Repositories ---
final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return FirebaseLeaderboardRepository(FirebaseFirestore.instance);
});

// --- Active Season Info ---
final currentSeasonIdProvider = Provider<String?>((ref) {
  // Hook for future Season integration. For now returning a placeholder.
  return 'season_2026_1';
});

// --- Paginated Leaderboard ---
final leaderboardPageProvider = FutureProvider.family<List<LeaderboardEntry>, int>((
  ref,
  page,
) async {
  final seasonId = ref.watch(currentSeasonIdProvider);
  final repository = ref.watch(leaderboardRepositoryProvider);

  // Basic pagination logic using offsets/cursors would be more complex in Riverpod
  // For this story, we'll implement a simple top list and support 'more' in a controller.
  return repository.getLeaderboardPage(seasonId: seasonId, limit: 50);
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
