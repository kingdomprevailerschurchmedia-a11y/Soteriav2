import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/practice_result.dart';
import '../../domain/repositories/practice_result_repository.dart';
import '../../../player/domain/repositories/player_progression_repository.dart';
import '../../../player/data/repositories/firebase_player_progression_repository.dart';
import '../../../player/domain/models/xp_transaction.dart';
import '../../../player/domain/repositories/leaderboard_repository.dart';
import '../../../player/data/models/player_profile_dto.dart';
import '../../../player/domain/models/player_progression.dart';
import '../../../player/domain/services/progression_service.dart';

class FirestorePracticeResultRepository implements PracticeResultRepository {
  final FirebaseFirestore _firestore;
  final PlayerProgressionRepository _progressionRepository;
  final LeaderboardRepository _leaderboardRepository;
  final ProgressionService _progressionService;

  FirestorePracticeResultRepository(
    this._firestore, 
    this._progressionRepository,
    this._leaderboardRepository,
    this._progressionService,
  );

  CollectionReference<Map<String, dynamic>> _resultsCollection(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('practice_results');

  @override
  Future<void> recordResult(PracticeResult result, {bool rewardsEligible = true}) async {
    final uid = result.userId;
    final sessionId = result.sessionId;

    await _firestore.runTransaction((transaction) async {
      final playerRef = _firestore.collection('users').doc(uid);
      final walletRef = _firestore.collection('wallets').doc(uid);
      final gameProfileRef = _firestore.collection('user_game_profiles').doc(uid);
      final resultRef = _resultsCollection(uid).doc(sessionId);

      // 1. ALL READS FIRST
      final playerDoc = await transaction.get(playerRef);
      if (!playerDoc.exists) throw Exception('Player not found');
      
      final resultDoc = await transaction.get(resultRef);
      if (resultDoc.exists) return; // Idempotency

      final data = playerDoc.data() ?? {};
      final now = DateTime.now();
      final lastDate = data['lastPracticeSessionDate'] != null 
          ? (data['lastPracticeSessionDate'] is Timestamp 
              ? (data['lastPracticeSessionDate'] as Timestamp).toDate() 
              : DateTime.parse(data['lastPracticeSessionDate']))
          : null;
      
      final isNewDay = lastDate == null || 
          lastDate.year != now.year || 
          lastDate.month != now.month || 
          lastDate.day != now.day;

      final dailyCount = isNewDay ? 0 : (data['dailyPracticeSessionsPlayed'] ?? 0);
      final isEligible = dailyCount < 5;

      // 2. LOGIC & WRITES
      final actualXp = isEligible ? result.xpEarned : 0;
      final actualCoins = isEligible ? result.coinsEarned : 0;

      // Update Result with actual rewards
      final finalResult = result.copyWith(
        xpEarned: actualXp,
        coinsEarned: actualCoins,
      );
      transaction.set(resultRef, finalResult.toJson());

      // Update Player Stats
      transaction.update(playerRef, {
        'coins': FieldValue.increment(actualCoins),
        'practiceSessions': FieldValue.increment(1),
        'dailyPracticeSessionsPlayed': isNewDay ? 1 : FieldValue.increment(1),
        'lastPracticeSessionDate': Timestamp.fromDate(now),
        'totalQuestionsAnswered': FieldValue.increment(result.totalQuestions),
        'correctAnswers': FieldValue.increment(result.correctAnswers),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update Wallet & Game Profile
      if (actualCoins > 0) {
        transaction.set(walletRef, {
          'coins': FieldValue.increment(actualCoins),
          'lifetimeCoinsEarned': FieldValue.increment(actualCoins),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        transaction.set(gameProfileRef, {
          'coins': FieldValue.increment(actualCoins),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // Log Transaction
        final txRef = _firestore.collection('wallet_transactions').doc();
        transaction.set(txRef, {
          'userId': uid,
          'type': 'coins',
          'currency': 'coins',
          'direction': 'credit',
          'amount': actualCoins,
          'transactionType': 'reward',
          'source': 'practice',
          'referenceId': sessionId,
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'metadata': {'sessionId': sessionId},
        });
      }

      // Progression Update (XP)
      if (actualXp > 0) {
        final progressionDoc = _firestore.collection('player_progression').doc(uid);
        final progressionSnapshot = await transaction.get(progressionDoc);

        PlayerProgression currentProg;
        if (!progressionSnapshot.exists) {
          currentProg = PlayerProgression.initial(uid, 'current_season');
        } else {
          currentProg = PlayerProgression.fromJson(progressionSnapshot.data()!);
        }

        final updatedProg = _progressionService.addXp(currentProg, actualXp);
        transaction.set(progressionDoc, updatedProg.toJson());

        // Sync Leaderboard (Inside Transaction)
        final profile = PlayerProfileDto.fromFirestore(playerDoc);
        await _leaderboardRepository.syncLeaderboardEntry(
          profile: profile,
          progression: updatedProg,
          transaction: transaction,
        );

        // Record XP Transaction
        final xpTxRef = _firestore.collection('xp_transactions').doc('${sessionId}_xp');
        final xpTx = XpTransaction(
          transactionId: '${sessionId}_xp',
          userId: uid,
          amount: actualXp,
          source: XpSource.quizCompletion,
          referenceId: sessionId,
          createdAt: now,
        );
        transaction.set(xpTxRef, xpTx.toJson());
      }
    });
  }

  @override
  Future<List<PracticeResult>> getRecentResults(
    String userId, {
    int limit = 10,
  }) async {
    final snapshot = await _resultsCollection(userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => PracticeResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<PracticeResult>> getResults(
    String userId, {
    int limit = 20,
    PracticeResult? lastResult,
    String? categoryId,
  }) async {
    var query = _resultsCollection(userId)
        .orderBy('completedAt', descending: true)
        .limit(limit);

    if (categoryId != null) {
      query = query.where('categoryPerformance.$categoryId', isNull: false);
    }

    if (lastResult != null) {
      query = query.startAfter([lastResult.completedAt]);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => PracticeResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<PracticeResult>> getResultsByDateRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    final snapshot = await _resultsCollection(userId)
        .where('completedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('completedAt', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('completedAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => PracticeResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> deleteResult(String userId, String resultId) async {
    await _resultsCollection(userId).doc(resultId).delete();
  }
}
