import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/player_presence.dart';
import '../../domain/repositories/presence_repository.dart';

class FirebasePresenceRepository implements PresenceRepository {
  final FirebaseFirestore _firestore;

  FirebasePresenceRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _presenceCollection =>
      _firestore.collection('presence');

  @override
  Stream<PlayerPresence?> watchPresence(String userId) {
    return _presenceCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return PlayerPresence.fromJson(doc.data()!);
    });
  }

  @override
  Stream<Map<String, PlayerPresence>> watchPresenceMultiple(List<String> userIds) {
    if (userIds.isEmpty) return Stream.value({});
    
    // Firestore IN queries are limited to 10/30 items depending on version.
    // For a real app, we might need to chunk this or use multiple listeners.
    // Assuming friends list is reasonably small or chunked elsewhere.
    return _presenceCollection
        .where(FieldPath.documentId, whereIn: userIds.take(30).toList())
        .snapshots()
        .map((snapshot) {
          final map = <String, PlayerPresence>{};
          for (final doc in snapshot.docs) {
            map[doc.id] = PlayerPresence.fromJson(doc.data());
          }
          return map;
        });
  }

  @override
  Future<void> updateStatus(String userId, PresenceStatus status, {String? matchId}) async {
    await _presenceCollection.doc(userId).set({
      'userId': userId,
      'status': status.name,
      'lastSeenAt': FieldValue.serverTimestamp(),
      'currentMatchId': matchId,
    }, SetOptions(merge: true));
  }

  @override
  Future<void> updatePrivacy(String userId, {bool? showOnlineStatus, bool? showActivity}) async {
    final updates = <String, dynamic>{};
    if (showOnlineStatus != null) updates['showOnlineStatus'] = showOnlineStatus;
    if (showActivity != null) updates['showActivity'] = showActivity;
    
    if (updates.isNotEmpty) {
      await _presenceCollection.doc(userId).update(updates);
    }
  }

  @override
  Future<void> setOffline(String userId) async {
    await updateStatus(userId, PresenceStatus.offline);
  }
}
