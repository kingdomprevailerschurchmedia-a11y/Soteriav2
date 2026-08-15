import '../models/daily_engagement.dart';

abstract class EngagementRepository {
  /// Records a qualifying activity for the player.
  /// Returns the updated streak count if successful.
  Future<int> recordEngagement({
    required String userId,
    required String activityType,
    required String activityId,
    required String timezone,
  });

  /// Watches the daily engagement for a specific date range.
  Stream<List<DailyEngagement>> watchEngagements(
    String userId, {
    required DateTime start,
    required DateTime end,
  });

  /// Gets the current engagement for today in the user's timezone.
  Future<DailyEngagement?> getTodayEngagement(String userId, String timezone);
}
