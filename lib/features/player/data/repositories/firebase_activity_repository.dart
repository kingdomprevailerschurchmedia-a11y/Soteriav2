import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_activity_event.dart';
import '../../domain/repositories/activity_repository.dart';

class FirebaseActivityRepository implements ActivityRepository {
  final FirebaseFirestore _firestore;

  FirebaseActivityRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _activityCollection(
    String userId,
  ) => _firestore
      .collection('users')
      .doc(userId)
      .collection('competitive_activity');

  @override
  Future<List<CompetitiveActivityEvent>> getActivityEvents(
    String userId, {
    int limit = 20,
    CompetitiveActivityEvent? lastEvent,
  }) async {
    var query = _activityCollection(
      userId,
    ).orderBy('createdAt', descending: true).limit(limit);

    if (lastEvent != null) {
      // In a real Firestore implementation, we'd use a DocumentSnapshot for startAfter.
      // For this simplified repository, we'll use the createdAt timestamp if unique,
      // but ideally we should fetch the actual document snapshot.
      query = query.startAfter([lastEvent.createdAt]);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => CompetitiveActivityEvent.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> recordActivityEvent(CompetitiveActivityEvent event) async {
    await _activityCollection(event.userId).doc(event.id).set(event.toJson());
  }

  @override
  Stream<List<CompetitiveActivityEvent>> watchRecentActivity(
    String userId, {
    int limit = 10,
  }) {
    return _activityCollection(userId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CompetitiveActivityEvent.fromJson(doc.data()))
              .toList(),
        );
  }
}
