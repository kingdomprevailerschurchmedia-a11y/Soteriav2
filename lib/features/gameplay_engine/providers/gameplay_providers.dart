import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/local_gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firebase_gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize this in main.dart and override it');
});

final localGameplayRepositoryProvider = Provider<GameplayRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalGameplayRepository(prefs);
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firebaseGameplayRepositoryProvider = Provider<GameplayRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  return FirebaseGameplayRepository(firestore, auth);
});

/// Orchestrator for gameplay data persistence.
final gameplayRepositoryProvider = Provider<GameplayRepository>((ref) {
  final local = ref.watch(localGameplayRepositoryProvider);
  final firebase = ref.watch(firebaseGameplayRepositoryProvider);

  return CompositeGameplayRepository(local: local, remote: firebase);
});

class CompositeGameplayRepository implements GameplayRepository {
  final GameplayRepository local;
  final GameplayRepository remote;

  CompositeGameplayRepository({required this.local, required this.remote});

  @override
  Future<void> saveSessionState(GameState state) async {
    await local.saveSessionState(state);
    // Remote sync is often async/backgrounded
    remote.saveSessionState(state).catchError((e) {
      // Log or queue for later
    });
  }

  @override
  Future<GameState?> resumeSession(String sessionId) =>
      local.resumeSession(sessionId);

  @override
  Future<void> syncSessionMetadata(GameState state) =>
      remote.syncSessionMetadata(state);

  @override
  Future<void> recordGameResult(GameResult result) async {
    await local.recordGameResult(result);
    await remote.recordGameResult(result);
  }

  @override
  Future<GameState?> getActiveSession() => local.getActiveSession();

  @override
  Future<void> clearActiveSession() => local.clearActiveSession();

  @override
  Future<List<GameResult>> getRecentResults(String uid, {GameMode? mode, int limit = 10}) {
    // Try to get from remote primarily for history
    return remote.getRecentResults(uid, mode: mode, limit: limit);
  }
}
