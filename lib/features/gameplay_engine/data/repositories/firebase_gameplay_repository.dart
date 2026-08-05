import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';

class FirebaseGameplayRepository implements GameplayRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseGameplayRepository(this._firestore, this._auth);

  String? get _uid => _auth.currentUser?.uid;

  @override
  Future<void> saveSessionState(GameState state) async {
    // We only save "checkpoints" to Firebase to save bandwidth
    if (_uid == null) return;

    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('game_sessions')
        .doc(state.sessionId)
        .set({
          'lastUpdated': FieldValue.serverTimestamp(),
          'currentQuestionIndex': state.currentQuestionIndex,
          'score': state.score,
          'xp': state.xp,
          'lifecycle': state.lifecycle.name,
          'progress': state.progress,
        }, SetOptions(merge: true));
  }

  @override
  Future<GameState?> resumeSession(String sessionId) async {
    // Usually handled by local storage first, but could be used for cross-device resume
    return null;
  }

  @override
  Future<void> syncSessionMetadata(GameState state) async {
    await saveSessionState(state);
  }

  @override
  Future<void> recordGameResult(GameResult result) async {
    if (_uid == null) return;

    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('game_results')
        .doc(result.sessionId)
        .set(result.toJson());

    // Also update global player stats here in a real app
  }

  @override
  Future<GameState?> getActiveSession() async => null;

  @override
  Future<void> clearActiveSession() async {}
}
