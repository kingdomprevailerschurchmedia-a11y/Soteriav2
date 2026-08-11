import '../models/leaderboard_entry.dart';

abstract class LeaderboardRepository {
  /// Fetches a paginated list of entries for a specific season.
  /// If [seasonId] is null, fetches the global/all-time leaderboard.
  Future<List<LeaderboardEntry>> getLeaderboardPage({
    String? seasonId,
    int limit = 50,
    dynamic lastCursor,
  });

  /// Retrieves the specific position and entry for a user.
  Future<LeaderboardEntry?> getPlayerEntry({
    required String userId,
    String? seasonId,
  });

  /// Retrieves entries surrounding a specific player.
  Future<List<LeaderboardEntry>> getLeaderboardAroundPlayer({
    required String userId,
    String? seasonId,
    int windowSize = 5,
  });

  /// Efficiently calculates the player's numeric rank position.
  Future<int> getPlayerRankPosition({required String userId, String? seasonId});
}
