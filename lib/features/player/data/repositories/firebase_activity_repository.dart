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
  Future<List<CompetitiveActivityEvent>> getSocialActivityFeed(
    String userId,
    List<String> userIds, {
    int limit = 20,
    CompetitiveActivityEvent? lastEvent,
  }) async {
    if (userIds.isEmpty) return [];

    var query = _firestore.collectionGroup('competitive_activity')
        .where('userId', whereIn: userIds.take(30).toList())
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (lastEvent != null) {
      query = query.startAfter([lastEvent.createdAt]);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => CompetitiveActivityEvent.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<CompetitiveActivityEvent>> getActivityEvents(
    String userId, {
    int limit = 20,
    CompetitiveActivityEvent? lastEvent,
  }) async {
    return getSocialActivityFeed(userId, [userId], limit: limit, lastEvent: lastEvent);
  }

  @override
  Future<void> recordActivityEvent(CompetitiveActivityEvent event) async {
    await _activityCollection(event.userId).doc(event.id).set(event.toJson());
  }

  @override
  Stream<List<CompetitiveActivityEvent>> watchSocialActivity(
    List<String> userIds, {
    int limit = 20,
  }) {
    if (userIds.isEmpty) return Stream.value([]);

    // Using collectionGroup to find activities across all users
    // Then filtering by userId in the list. 
    // In a high-scale app, we might want a flat root collection 'activities' with visibility rules.
    return _firestore.collectionGroup('competitive_activity')
        .where('userId', whereIn: userIds.take(30).toList())
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
