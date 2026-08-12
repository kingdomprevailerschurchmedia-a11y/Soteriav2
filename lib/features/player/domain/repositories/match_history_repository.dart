import '../models/competitive_match.dart';
import '../models/competitive_result.dart';

abstract interface class MatchHistoryRepository {
  /// Fetches a paginated list of competitive matches for a user.
  Future<List<CompetitiveMatch>> getMatchHistory(
    String userId, {
    int limit = 20,
    CompetitiveMatch? lastMatch,
    String? seasonId,
    String? mode,
    CompetitiveOutcome? outcome,
  });

  /// Fetches a single match detail by ID.
  Future<CompetitiveMatch?> getMatchDetail(String userId, String resultId);
}
