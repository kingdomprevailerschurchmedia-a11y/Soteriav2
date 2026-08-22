import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/matchmaking_session.dart';
import '../../domain/models/matchmaking_status.dart';
import '../../domain/repositories/matchmaking_repository.dart';

class FirebaseMatchmakingRepository implements MatchmakingRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseMatchmakingRepository({
    required this._firestore,
    required this._auth,
  });

  CollectionReference<Map<String, dynamic>> get _pool =>
      _firestore.collection('matchmaking_pool');

  @override
  Future<MatchmakingSession> enterQueue({
    required Map<String, dynamic> configuration,
    required Map<String, dynamic> rankSnapshot,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final existing = await getActiveSession();
    if (existing != null) return existing;

    final docRef = _pool.doc();
    final session = MatchmakingSession(
      sessionId: docRef.id,
      userId: userId,
      status: MatchmakingStatus.searching,
      queuedAt: DateTime.now(),
      configuration: configuration,
      rankSnapshot: rankSnapshot,
    );

    await docRef.set(session.toJson());
    return session;
  }

  @override
  Future<void> cancelQueue(String sessionId) async {
    await _pool.doc(sessionId).update({
      'status': MatchmakingStatus.cancelled.name,
    });
  }

  @override
  Future<void> confirmMatch(String sessionId) async {
    await _pool.doc(sessionId).update({
      'isReady': true,
    });
  }

  @override
  Stream<MatchmakingSession?> observeSession(String sessionId) {
    return _pool.doc(sessionId).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return MatchmakingSession.fromJson(snapshot.data()!);
    });
  }

  @override
  Future<MatchmakingSession?> getActiveSession() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    final query = await _pool
        .where('userId', isEqualTo: userId)
        .where('status', whereIn: [
          MatchmakingStatus.searching.name,
          MatchmakingStatus.matchFound.name,
          MatchmakingStatus.confirming.name,
        ])
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return MatchmakingSession.fromJson(query.docs.first.data());
  }
}
