import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/models/xp_transaction.dart';
import '../../domain/models/competitive_result.dart';
import '../../domain/models/rank_change.dart';
import '../../domain/models/rank_transaction.dart';
import '../../domain/repositories/player_progression_repository.dart';
import '../../domain/services/progression_service.dart';
import '../../domain/services/competitive_ranking_engine.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../domain/repositories/player_repository.dart';

class FirebasePlayerProgressionRepository
    implements PlayerProgressionRepository {
  final FirebaseFirestore _firestore;
  final ProgressionService _progressionService;
  final CompetitiveRankingEngine _rankingEngine;
  final LeaderboardRepository _leaderboardRepository;
  final PlayerRepository _playerRepository;

  FirebasePlayerProgressionRepository(
    this._firestore,
    this._progressionService,
    this._rankingEngine,
    this._leaderboardRepository,
    this._playerRepository,
  );

  CollectionReference<Map<String, dynamic>> get _progressionCollection =>
      _firestore.collection('player_progression');

  CollectionReference<Map<String, dynamic>> get _xpTransactionCollection =>
      _firestore.collection('xp_transactions');

  CollectionReference<Map<String, dynamic>> get _rankTransactionCollection =>
      _firestore.collection('rank_transactions');

  CollectionReference<Map<String, dynamic>> get _rankHistoryCollection =>
      _firestore.collection('rank_history');

  @override
  Stream<PlayerProgression> watchProgression(String userId) {
    return _progressionCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) {
        // Return initial state for new users instead of throwing
        return PlayerProgression.initial(userId, 'current_season');
      }
      return PlayerProgression.fromJson(doc.data()!);
    });
  }

  @override
  Future<PlayerProgression?> getProgression(String userId) async {
    final doc = await _progressionCollection.doc(userId).get();
    if (!doc.exists) {
      return null;
    }
    return PlayerProgression.fromJson(doc.data()!);
  }

  @override
  Future<void> updateProgression(PlayerProgression progression) async {
    await _progressionCollection
        .doc(progression.userId)
        .set(progression.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> applyXpTransaction(XpTransaction transaction) async {
    final txDoc = _xpTransactionCollection.doc(transaction.transactionId);

    await _firestore.runTransaction((tx) async {
      await processXpTransaction(tx, transaction);
    });
  }

  /// Internal helper to process an XP transaction within an existing Firestore transaction.
  /// Used by other repositories to ensure atomicity across features.
  Future<void> processXpTransaction(
    Transaction tx,
    XpTransaction transaction,
  ) async {
    final txDoc = _xpTransactionCollection.doc(transaction.transactionId);

    // 1. Idempotency check inside the atomic transaction
    final txSnapshot = await tx.get(txDoc);
    if (txSnapshot.exists) {
      return; // Already applied
    }

    final progressionDoc = _progressionCollection.doc(transaction.userId);
    final snapshot = await tx.get(progressionDoc);

    PlayerProgression current;
    if (!snapshot.exists) {
      current = PlayerProgression.initial(
        transaction.userId,
        'current_season',
      );
    } else {
      current = PlayerProgression.fromJson(snapshot.data()!);
    }

    // 2. Extra safety: Check if this specific transaction ID was the last one processed
    if (current.lastXpTransactionId == transaction.transactionId) {
      return;
    }

    final updated = _progressionService
        .addXp(current, transaction.amount)
        .copyWith(lastXpTransactionId: transaction.transactionId);

    tx.set(progressionDoc, updated.toJson());
    tx.set(txDoc, transaction.toJson());
  }

  @override
  Future<RankChange> applyCompetitiveResult(CompetitiveResult result) async {
    return await _firestore.runTransaction((tx) async {
      return await applyCompetitiveResultInTransaction(tx, result);
    });
  }

  @override
  Future<RankChange> applyCompetitiveResultInTransaction(
    dynamic transaction,
    CompetitiveResult result,
  ) async {
    final tx = transaction as Transaction;
    
    // 1. Idempotency Check (Session Level)
    final existingTx = await _rankTransactionCollection
        .where('resultId', isEqualTo: result.resultId)
        .limit(1)
        .get();

    if (existingTx.docs.isNotEmpty) {
       throw Exception(
        'Competitive result ${result.resultId} already processed.',
      );
    }

    final progressionDoc = _progressionCollection.doc(result.userId);
    final snapshot = await tx.get(progressionDoc);

    PlayerProgression current;
    if (!snapshot.exists) {
      current = PlayerProgression.initial(result.userId, result.seasonId);
    } else {
      current = PlayerProgression.fromJson(snapshot.data()!);
    }

    // 2. Ranking Engine Calculation
    final rankChange = _rankingEngine.calculateRankChange(
      currentProgression: current,
      result: result,
    );

    // 3. Update Progression
    final progress = _rankingEngine.calculateRankProgress(rankChange.newRankPoints);

    final updated = current.copyWith(
      currentRank: rankChange.newRank,
      currentRankTier: progress.tier.id,
      rankPoints: rankChange.newRankPoints,
      rankProgress: progress.progressPercentage,
      seasonRankPoints: current.seasonId == result.seasonId
          ? rankChange.newRankPoints
          : current.seasonRankPoints,
      lastRankTransactionId: '${result.resultId}_tx',
      lastUpdated: DateTime.now(),
    );

    // 4. Update Leaderboard (Sync in transaction)
    final profile = await _playerRepository.getPlayerProfile(result.userId);
    if (profile != null) {
      await _leaderboardRepository.syncLeaderboardEntry(
        profile: profile,
        progression: updated,
        seasonId: result.seasonId,
        transaction: tx,
      );
      // Also sync global
      await _leaderboardRepository.syncLeaderboardEntry(
        profile: profile,
        progression: updated,
        seasonId: null,
        transaction: tx,
      );
    }

    // 5. Create Transaction Record
    final rankTx = RankTransaction(
      transactionId: '${result.resultId}_tx',
      userId: result.userId,
      seasonId: result.seasonId,
      resultId: result.resultId,
      previousRankPoints: rankChange.previousRankPoints,
      changeAmount: rankChange.changeAmount,
      newRankPoints: rankChange.newRankPoints,
      timestamp: DateTime.now(),
    );

    tx.set(progressionDoc, updated.toJson());
    tx.set(
      _rankTransactionCollection.doc(rankTx.transactionId),
      rankTx.toJson(),
    );
    tx.set(
      _rankHistoryCollection.doc(rankChange.changeId),
      rankChange.toJson(),
    );

    return rankChange;
  }

  @override
  Future<List<XpTransaction>> getXpTransactions(
    String userId, {
    int limit = 20,
  }) async {
    final snapshot = await _xpTransactionCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => XpTransaction.fromJson(doc.data()))
        .toList();
  }
}
