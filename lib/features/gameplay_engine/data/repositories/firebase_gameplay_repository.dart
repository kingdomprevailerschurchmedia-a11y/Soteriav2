import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

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

  @override
  Future<List<GameResult>> getRecentResults(String uid, {GameMode? mode, int limit = 10}) async {
    var query = _firestore
        .collection('users')
        .doc(uid)
        .collection('game_results')
        .orderBy('timestamp', descending: true);

    if (mode != null) {
      // Note: If using multiple filters with orderBy, an index might be needed
      // For simplicity, we might filter in-memory if mode is specified and no index exists
      // or assume the index exists.
      // query = query.where('mode', isEqualTo: mode.name);
    }

    final snapshot = await query.limit(limit).get();
    
    var results = snapshot.docs.map((doc) => GameResult.fromJson(doc.data())).toList();
    
    if (mode != null) {
      results = results.where((r) {
        // Need to check how mode is stored in GameResult json. 
        // GameResult doesn't have mode explicitly, but it comes from GameState.
        // Wait, GameResult should probably have mode.
        return true; // Placeholder until GameResult is updated or mode is verified
      }).toList();
    }
    
    return results;
  }
}
