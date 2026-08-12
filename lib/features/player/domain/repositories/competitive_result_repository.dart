import '../models/competitive_result.dart';

abstract interface class CompetitiveResultRepository {
  /// Records a new competitive match result.
  Future<void> recordResult(CompetitiveResult result);

  /// Fetches recent competitive results for a user.
  Future<List<CompetitiveResult>> getRecentResults(
    String userId, {
    int limit = 10,
  });

  /// Fetches paginated and filtered results.
  Future<List<CompetitiveResult>> getResults(
    String userId, {
    int limit = 20,
    CompetitiveResult? lastResult,
    String? seasonId,
    String? mode,
    CompetitiveOutcome? outcome,
  });

  /// Watches for new results.
  Stream<List<CompetitiveResult>> watchRecentResults(
    String userId, {
    int limit = 10,
  });
}
