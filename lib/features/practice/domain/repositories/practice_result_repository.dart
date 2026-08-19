import '../models/practice_result.dart';

abstract interface class PracticeResultRepository {
  /// Records a completed practice session result.
  Future<void> recordResult(PracticeResult result, {bool rewardsEligible = true});

  /// Fetches recent practice results for a user.
  Future<List<PracticeResult>> getRecentResults(
    String userId, {
    int limit = 10,
  });

  /// Fetches paginated practice results.
  Future<List<PracticeResult>> getResults(
    String userId, {
    int limit = 20,
    PracticeResult? lastResult,
    String? categoryId,
  });

  /// Deletes a practice result (optional, for cleanup/privacy).
  Future<void> deleteResult(String userId, String resultId);
}
