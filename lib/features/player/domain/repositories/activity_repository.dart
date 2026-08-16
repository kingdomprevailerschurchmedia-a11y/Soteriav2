import '../models/competitive_activity_event.dart';

abstract class ActivityRepository {
  /// Fetches a paginated list of competitive activity events for a user.
  Future<List<CompetitiveActivityEvent>> getSocialActivityFeed(
    String userId,
    List<String> userIds, {
    int limit = 20,
    CompetitiveActivityEvent? lastEvent,
    List<ActivityVisibility>? visibilities,
  });

  /// Persists a new activity event.
  Future<void> recordActivityEvent(CompetitiveActivityEvent event);

  /// Watches recent activity events for a user.
  Stream<List<CompetitiveActivityEvent>> watchSocialActivity(
    List<String> userIds, {
    int limit = 20,
    List<ActivityVisibility>? visibilities,
  });
}
