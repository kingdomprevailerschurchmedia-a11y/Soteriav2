import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../gameplay_engine/models/versus_match.dart';
import '../../domain/repositories/versus_match_repository.dart';

class FirebaseVersusMatchRepository implements VersusMatchRepository {
  final FirebaseFirestore _firestore;

  FirebaseVersusMatchRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _matches =>
      _firestore.collection('versus_matches');

  @override
  Stream<VersusMatch?> observeMatch(String matchId) {
    return _matches.doc(matchId).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return VersusMatch.fromJson(snapshot.data()!);
    });
  }

  @override
  Future<void> setReady(String matchId, String userId) async {
    final doc = await _matches.doc(matchId).get();
    if (!doc.exists) return;
    
    final match = VersusMatch.fromJson(doc.data()!);
    final isPlayerA = match.playerAId == userId;
    
    await _matches.doc(matchId).update({
      if (isPlayerA) 'playerAReady': true else 'playerBReady': true,
    });
  }

  @override
  Future<void> updateSessionId(String matchId, String userId, String sessionId) async {
    final doc = await _matches.doc(matchId).get();
    if (!doc.exists) return;
    
    final match = VersusMatch.fromJson(doc.data()!);
    final isPlayerA = match.playerAId == userId;
    
    await _matches.doc(matchId).update({
      if (isPlayerA) 'playerASessionId': sessionId else 'playerBSessionId': sessionId,
    });
  }

  @override
  Future<void> abandonMatch(String matchId, String userId) async {
    await _matches.doc(matchId).update({
      'status': MatchStatus.abandoned.name,
      'abandonedBy': userId,
    });
  }

  @override
  Future<void> updateScore(String matchId, String userId, int score) async {
    final doc = await _matches.doc(matchId).get();
    if (!doc.exists) return;
    final match = VersusMatch.fromJson(doc.data()!);
    final isPlayerA = match.playerAId == userId;

    await _matches.doc(matchId).update({
      if (isPlayerA) 'playerAScore': score else 'playerBScore': score,
    });
  }

  @override
  Future<void> updateProgress(String matchId, String userId, int progress) async {
    final doc = await _matches.doc(matchId).get();
    if (!doc.exists) return;
    final match = VersusMatch.fromJson(doc.data()!);
    final isPlayerA = match.playerAId == userId;

    await _matches.doc(matchId).update({
      if (isPlayerA) 'playerAProgress': progress else 'playerBProgress': progress,
    });
  }

  @override
  Future<void> completeMatch(String matchId, String userId) async {
    // In a real backend, this would trigger result processing
    await _matches.doc(matchId).update({
      'status': MatchStatus.finishing.name,
    });
  }
}
