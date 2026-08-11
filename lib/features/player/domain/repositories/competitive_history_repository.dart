import '../models/season_result.dart';

abstract class CompetitiveHistoryRepository {
  Future<List<SeasonResult>> getSeasonResults(
    String userId, {
    int limit = 20,
    dynamic startAfter,
  });
  Future<SeasonResult?> getSeasonResult(String userId, String seasonId);
  Future<SeasonResult?> getLatestSeasonResult(String userId);
  Future<SeasonResult?> getBestSeasonResult(String userId);
  Stream<List<SeasonResult>> watchSeasonHistory(
    String userId, {
    int limit = 50,
  });
}
