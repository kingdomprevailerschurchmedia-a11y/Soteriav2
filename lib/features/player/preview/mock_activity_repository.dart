import '../domain/models/competitive_activity_event.dart';
import '../domain/repositories/activity_repository.dart';

class MockActivityRepository extends ActivityRepository {
  MockActivityRepository(this._events, this._isLoading);

  final List<CompetitiveActivityEvent> _events;
  final bool _isLoading;

  @override
  Future<List<CompetitiveActivityEvent>> getActivityEvents(
    String userId, {
    int limit = 20,
    CompetitiveActivityEvent? lastEvent,
  }) async {
    if (_isLoading) {
      await Future.delayed(const Duration(seconds: 10));
    }
    return _events;
  }

  @override
  Future<void> recordActivityEvent(CompetitiveActivityEvent event) async {}

  @override
  Stream<List<CompetitiveActivityEvent>> watchRecentActivity(
    String userId, {
    int limit = 10,
  }) {
    return Stream.value(_events.take(limit).toList());
  }
}
