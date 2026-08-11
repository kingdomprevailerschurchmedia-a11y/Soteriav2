import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/models/xp_transaction.dart';
import '../../domain/models/competitive_result.dart';
import '../../domain/models/rank_change.dart';
import '../../domain/models/rank_transaction.dart';
import '../../domain/repositories/player_progression_repository.dart';
import '../../domain/services/progression_service.dart';
import '../../domain/services/competitive_ranking_engine.dart';

class FirebasePlayerProgressionRepository
    implements PlayerProgressionRepository {
  final FirebaseFirestore _firestore;
  final ProgressionService _progressionService;
  final CompetitiveRankingEngine _rankingEngine;

  FirebasePlayerProgressionRepository(
    this._firestore,
    this._progressionService,
    this._rankingEngine,
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
      return PlayerProgression.initial(userId, 'current_season');
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
    // Implement Idempotency check
    final existing = await _xpTransactionCollection
        .where('transactionId', isEqualTo: transaction.transactionId)
        .get();

    if (existing.docs.isNotEmpty) {
      return; // Already applied
    }

    await _firestore.runTransaction((tx) async {
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

      final updated = _progressionService.addXp(current, transaction.amount);

      tx.set(progressionDoc, updated.toJson());
      tx.set(
        _xpTransactionCollection.doc(transaction.transactionId),
        transaction.toJson(),
      );
    });
  }

  @override
  Future<RankChange> applyCompetitiveResult(CompetitiveResult result) async {
    // 1. Idempotency Check
    final existingTx = await _rankTransactionCollection
        .where('resultId', isEqualTo: result.resultId)
        .limit(1)
        .get();

    if (existingTx.docs.isNotEmpty) {
      // Return historical change if possible, or re-calculate (idempotent result)
      final txData = RankTransaction.fromJson(existingTx.docs.first.data());
      // We'd ideally fetch the RankChange record here, but for now we'll throw or return a cached view
      throw Exception(
        'Competitive result ${result.resultId} already processed.',
      );
    }

    return await _firestore.runTransaction((tx) async {
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
      final updated = current.copyWith(
        currentRank: rankChange.newRank,
        rankPoints: rankChange.newRankPoints,
        // rankProgress and tierId will be updated by providers or derived
        lastUpdated: DateTime.now(),
      );

      // 4. Create Transaction Record
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
    });
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
