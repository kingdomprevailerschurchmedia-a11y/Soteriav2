import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/live_event.dart';
import '../../domain/models/event_participation.dart';
import '../../domain/repositories/event_repository.dart';

class FirebaseEventRepository implements EventRepository {
  final FirebaseFirestore _firestore;

  FirebaseEventRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _events =>
      _firestore.collection('competitive_events');

  CollectionReference<Map<String, dynamic>> get _participations =>
      _firestore.collection('event_participations');

  @override
  Future<List<LiveEvent>> getEvents() async {
    final snapshot = await _events.orderBy('startAt', descending: true).get();
    return snapshot.docs
        .map((doc) => LiveEvent.fromJson(doc.data()))
        .toList();
  }

  @override
  Stream<List<LiveEvent>> watchEvents() {
    return _events
        .orderBy('startAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LiveEvent.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<LiveEvent?> getEvent(String eventId) async {
    final doc = await _events.doc(eventId).get();
    if (!doc.exists) return null;
    return LiveEvent.fromJson(doc.data()!);
  }

  @override
  Stream<LiveEvent?> watchEvent(String eventId) {
    return _events.doc(eventId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return LiveEvent.fromJson(doc.data()!);
    });
  }

  @override
  Future<EventParticipation?> getParticipation(String eventId, String userId) async {
    final doc = await _participations.doc('${eventId}_$userId').get();
    if (!doc.exists) return null;
    return EventParticipation.fromJson(doc.data()!);
  }

  @override
  Stream<EventParticipation?> watchParticipation(String eventId, String userId) {
    return _participations.doc('${eventId}_$userId').snapshots().map((doc) {
      if (!doc.exists) return null;
      return EventParticipation.fromJson(doc.data()!);
    });
  }

  @override
  Future<void> joinEvent(String eventId, String userId) async {
    final docId = '${eventId}_$userId';
    await _firestore.runTransaction((transaction) async {
      final eventRef = _events.doc(eventId);
      final participationRef = _participations.doc(docId);

      final eventSnapshot = await transaction.get(eventRef);
      if (!eventSnapshot.exists) throw Exception('Event not found');

      final event = LiveEvent.fromJson(eventSnapshot.data()!);
      if (event.status != LiveEventStatus.live && 
          event.status != LiveEventStatus.upcoming) {
         throw Exception('Event is not open for joining');
      }

      final participationSnapshot = await transaction.get(participationRef);
      if (participationSnapshot.exists) return;

      final participation = EventParticipation(
        eventId: eventId,
        userId: userId,
        status: ParticipationStatus.joined,
        joinedAt: DateTime.now(),
      );

      transaction.set(participationRef, participation.toJson());
      transaction.update(eventRef, {'participantCount': FieldValue.increment(1)});
    });
  }

  @override
  Future<void> startEventSession(String eventId, String userId) async {
    final docId = '${eventId}_$userId';
    await _participations.doc(docId).update({
      'status': ParticipationStatus.inProgress.name,
      'startedAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> submitEventScore(String eventId, String userId, int score) async {
    final docId = '${eventId}_$userId';
    await _firestore.runTransaction((transaction) async {
      final eventRef = _events.doc(eventId);
      final participationRef = _participations.doc(docId);

      final eventSnapshot = await transaction.get(eventRef);
      if (!eventSnapshot.exists) throw Exception('Event not found');

      final event = LiveEvent.fromJson(eventSnapshot.data()!);
      if (event.status != LiveEventStatus.live && 
          event.status != LiveEventStatus.ending) {
         throw Exception('Event is no longer active');
      }

      transaction.update(participationRef, {
        'status': ParticipationStatus.completed.name,
        'score': score,
        'completedAt': DateTime.now().toIso8601String(),
      });
    });
  }

  @override
  Future<bool> checkEligibility(String eventId, String userId) async {
    final event = await getEvent(eventId);
    if (event == null) return false;
    if (event.status == LiveEventStatus.locked) return false;
    return true;
  }

  @override
  Stream<List<EventParticipation>> watchUserHistory(String userId) {
    return _participations
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: ParticipationStatus.completed.name)
        .orderBy('completedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EventParticipation.fromJson(doc.data()))
            .toList());
  }
}
