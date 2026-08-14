import '../models/live_event.dart';

abstract class LiveEventRepository {
  Future<List<LiveEvent>> getActiveEvents();
  Future<List<LiveEvent>> getUpcomingEvents();
  Future<LiveEvent?> getEvent(String eventId);
  Stream<List<LiveEvent>> watchActiveEvents();
  Future<List<LiveEvent>> getEventHistory({int limit = 10});
}
