import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/repositories/post_game_repository.dart';
import '../../models/game_result.dart';
import '../../../player/domain/repositories/player_progression_repository.dart';
import '../../../player/domain/models/xp_transaction.dart';

import '../../../player/data/repositories/firebase_player_progression_repository.dart';

class FirestorePostGameRepository implements PostGameRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final SharedPreferences _prefs;
  final PlayerProgressionRepository _progressionRepository;

  static const String _syncQueueKey = 'post_game_sync_queue';

  FirestorePostGameRepository(
    this._firestore,
    this._auth,
    this._prefs,
    this._progressionRepository,
  );

  String? get _uid => _auth.currentUser?.uid;

  @override
  Future<void> syncProgress(GameResult result) async {
    if (_uid == null) {
      await addToSyncQueue(result);
      return;
    }

    // Authoritative atomic update for all rewards (coins, stats, and XP)
    await _firestore.runTransaction((transaction) async {
      final userRef = _firestore.collection('users').doc(_uid);
      final userDoc = await transaction.get(userRef);

      if (!userDoc.exists) return;

      // 1. Update Identity stats and non-progression rewards (coins)
      final currentCoins = userDoc.data()?['coins'] ?? 0;

      transaction.update(userRef, {
        'coins': currentCoins + result.rewards.totalCoins,
        'totalQuestionsAnswered': FieldValue.increment(
          result.correctAnswers + result.wrongAnswers,
        ),
        'correctAnswers': FieldValue.increment(result.correctAnswers),
        'lastActive': FieldValue.serverTimestamp(),
      });

      // Also save the session result as a record
      final sessionRef = userRef.collection('game_results').doc(
        result.sessionId,
      );
      transaction.set(sessionRef, result.toJson());

      // 2. Authoritative Progression Update (XP)
      if (result.rewards.totalXP > 0) {
        final xpTx = XpTransaction(
          transactionId: '${result.sessionId}_xp',
          userId: _uid!,
          amount: result.rewards.totalXP,
          source: XpSource.quizCompletion,
          referenceId: result.sessionId,
          createdAt: DateTime.now(),
        );

        if (_progressionRepository is FirebasePlayerProgressionRepository) {
          await (_progressionRepository as FirebasePlayerProgressionRepository)
              .processXpTransaction(transaction, xpTx);
        } else {
          // Fallback if not using Firestore implementation (unlikely in prod)
          await _progressionRepository.applyXpTransaction(xpTx);
        }
      }
    });
  }

  @override
  Future<List<String>> unlockAchievements(GameResult result) async {
    // This would typically involve checking multiple criteria
    // For now, let's return a mock list or simple logic
    final newlyUnlocked = <String>[];
    if (result.accuracy >= 1.0) newlyUnlocked.add('perfect_score');
    if (result.maxStreak >= 10) newlyUnlocked.add('streak_10');

    return newlyUnlocked;
  }

  @override
  Future<void> saveSessionSummary(GameResult result) async {
    if (_uid == null) return;
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('session_summaries')
        .doc(result.sessionId)
        .set(result.toJson());
  }

  @override
  Future<void> addToSyncQueue(GameResult result) async {
    final queue = await getOfflineSyncQueue();
    queue.add(result);
    await _prefs.setString(
      _syncQueueKey,
      jsonEncode(queue.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<List<GameResult>> getOfflineSyncQueue() async {
    final data = _prefs.getString(_syncQueueKey);
    if (data == null) return [];
    final List<dynamic> list = jsonDecode(data);
    return list.map((e) => GameResult.fromJson(e)).toList();
  }

  @override
  Future<void> removeFromSyncQueue(String sessionId) async {
    final queue = await getOfflineSyncQueue();
    queue.removeWhere((e) => e.sessionId == sessionId);
    await _prefs.setString(
      _syncQueueKey,
      jsonEncode(queue.map((e) => e.toJson()).toList()),
    );
  }
}
