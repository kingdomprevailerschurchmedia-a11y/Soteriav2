import '../models/competitive_activity_event.dart';

abstract class ActivityRepository {
  /// Fetches a paginated list of competitive activity events for a user.
  Future<List<CompetitiveActivityEvent>> getActivityEvents(
    String userId, {
    int limit = 20,
    CompetitiveActivityEvent? lastEvent,
  });

  /// Persists a new activity event.
  Future<void> recordActivityEvent(CompetitiveActivityEvent event);

  /// Watches recent activity events for a user.
  Stream<List<CompetitiveActivityEvent>> watchRecentActivity(
    String userId, {
    int limit = 10,
  });
}
