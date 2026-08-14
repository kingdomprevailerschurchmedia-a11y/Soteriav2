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
    
    // Firestore IN queries are limited.
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
  Future<void> updatePresence(String userId, {
    PresenceStatus? status,
    String? matchId,
    bool? showOnlineStatus,
    bool? showActivity,
    bool? showMatchStatus,
    bool heartbeatOnly = false,
  }) async {
    final updates = <String, dynamic>{
      'lastHeartbeatAt': FieldValue.serverTimestamp(),
    };

    if (!heartbeatOnly) {
      updates['lastSeenAt'] = FieldValue.serverTimestamp();
      if (status != null) updates['status'] = status.name;
      if (matchId != null) updates['currentMatchId'] = matchId;
      if (showOnlineStatus != null) updates['showOnlineStatus'] = showOnlineStatus;
      if (showActivity != null) updates['showActivity'] = showActivity;
      if (showMatchStatus != null) updates['showMatchStatus'] = showMatchStatus;
    }

    await _presenceCollection.doc(userId).set(updates, SetOptions(merge: true));
  }

  @override
  Future<void> setOffline(String userId) async {
    await updatePresence(userId, status: PresenceStatus.offline);
  }
}
