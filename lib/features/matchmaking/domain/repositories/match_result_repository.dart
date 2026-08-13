import '../models/competitive_match_result.dart';

abstract class MatchResultRepository {
  /// Fetches the final result of a versus match.
  Future<CompetitiveMatchResult?> getMatchResult(String matchId, String userId);

  /// Requests a rematch for the given match.
  Future<void> requestRematch(String matchId, String userId);

  /// Observes the match result (for real-time updates while processing).
  Stream<CompetitiveMatchResult?> observeMatchResult(String matchId, String userId);
}
