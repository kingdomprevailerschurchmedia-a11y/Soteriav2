import '../models/live_event.dart';
import '../models/event_participation.dart';

abstract class EventRepository {
  Future<List<LiveEvent>> getEvents();
  Stream<List<LiveEvent>> watchEvents();
  Future<LiveEvent?> getEvent(String eventId);
  Stream<LiveEvent?> watchEvent(String eventId);

  Future<EventParticipation?> getParticipation(String eventId, String userId);
  Stream<EventParticipation?> watchParticipation(String eventId, String userId);

  Future<void> joinEvent(String eventId, String userId);
  Future<void> startEventSession(String eventId, String userId);
  Future<void> submitEventScore(String eventId, String userId, int score);
  
  Future<bool> checkEligibility(String eventId, String userId);

  Stream<List<EventParticipation>> watchUserHistory(String userId);
}
