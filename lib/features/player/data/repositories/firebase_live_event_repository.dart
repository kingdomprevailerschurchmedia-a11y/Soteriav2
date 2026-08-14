import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/live_event.dart';
import '../../domain/repositories/live_event_repository.dart';

class FirebaseLiveEventRepository implements LiveEventRepository {
  final FirebaseFirestore _firestore;

  FirebaseLiveEventRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _eventsCollection =>
      _firestore.collection('events');

  @override
  Future<List<LiveEvent>> getActiveEvents() async {
    final now = DateTime.now();
    final snapshot = await _eventsCollection
        .where('status', isEqualTo: LiveEventStatus.active.name)
        .where('endAt', isGreaterThan: now)
        .get();

    return snapshot.docs
        .map((doc) => LiveEvent.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<LiveEvent>> getUpcomingEvents() async {
    final now = DateTime.now();
    final snapshot = await _eventsCollection
        .where('status', isEqualTo: LiveEventStatus.upcoming.name)
        .where('startAt', isGreaterThan: now)
        .orderBy('startAt')
        .get();

    return snapshot.docs
        .map((doc) => LiveEvent.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<LiveEvent?> getEvent(String eventId) async {
    final doc = await _eventsCollection.doc(eventId).get();
    if (!doc.exists) return null;
    return LiveEvent.fromJson(doc.data()!);
  }

  @override
  Stream<List<LiveEvent>> watchActiveEvents() {
    return _eventsCollection
        .where('status', isEqualTo: LiveEventStatus.active.name)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => LiveEvent.fromJson(doc.data()))
          .where((event) => event.endAt.isAfter(DateTime.now()))
          .toList();
    });
  }

  @override
  Future<List<LiveEvent>> getEventHistory({int limit = 10}) async {
    final snapshot = await _eventsCollection
        .where('status', isEqualTo: LiveEventStatus.completed.name)
        .orderBy('endAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => LiveEvent.fromJson(doc.data()))
        .toList();
  }
}
