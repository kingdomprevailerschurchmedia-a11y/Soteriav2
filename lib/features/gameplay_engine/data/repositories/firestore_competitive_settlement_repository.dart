import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/competitive_settlement_repository.dart';
import '../../models/competitive_settlement.dart';
import '../../models/game_mode.dart';
import '../../../player/domain/repositories/player_progression_repository.dart';
import '../../../player/domain/models/xp_transaction.dart';

import '../../../player/data/repositories/firebase_player_progression_repository.dart';

class FirestoreCompetitiveSettlementRepository
    implements CompetitiveSettlementRepository {
  final IDatabaseService _database;
  final PlayerProgressionRepository _progressionRepository;

  FirestoreCompetitiveSettlementRepository(
    this._database,
    this._progressionRepository,
  );

  @override
  String generateSettlementId() =>
      _database.instance.collection('settlements').doc().id;

  @override
  Future<void> finalizeSettlement(CompetitiveSettlement settlement) async {
    // 1. Authoritative atomic update for settlement, coins, and XP
    await _database.instance.runTransaction((transaction) async {
      // Check if settlement already exists (idempotency)
      final settlementRef = _database.instance
          .collection('settlements')
          .doc(settlement.settlementId);
      final settlementSnapshot = await transaction.get(settlementRef);

      if (settlementSnapshot.exists) {
        final existing = CompetitiveSettlement.fromJson(
          settlementSnapshot.data()!,
        );
        if (existing.status == SettlementStatus.completed) {
          return;
        }
      }

      // Update settlement record
      transaction.set(settlementRef, settlement.toJson());

      // 2. Update player rewards (Coins and stats in Users collection)
      final userRef = _database.instance.collection('users').doc(settlement.uid);
      transaction.update(userRef, {
        'coins': FieldValue.increment(settlement.coinsWon),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      // 3. Authoritative Progression Update (XP)
      if (settlement.xpEarned > 0) {
        final xpSource = settlement.result.mode == GameMode.tournament
            ? XpSource.tournament
            : XpSource.versus;

        final xpTx = XpTransaction(
          transactionId: '${settlement.sessionId}_xp',
          userId: settlement.uid,
          amount: settlement.xpEarned,
          source: xpSource,
          referenceId: settlement.sessionId,
          createdAt: DateTime.now(),
        );

        if (_progressionRepository is FirebasePlayerProgressionRepository) {
          await (_progressionRepository as FirebasePlayerProgressionRepository)
              .processXpTransaction(transaction, xpTx);
        } else {
          // Fallback
          await _progressionRepository.applyXpTransaction(xpTx);
        }
      }

      // 4. Mark session as settled
      final sessionRef = _database.instance
          .collection('competitive_sessions')
          .doc(settlement.sessionId);
      transaction.update(sessionRef, {
        'status': 'settled',
        'settlementId': settlement.settlementId,
      });
    });
  }

  @override
  Future<CompetitiveSettlement?> getSettlementBySession(
    String sessionId,
  ) async {
    final query = await _database
        .collection('settlements')
        .where('sessionId', isEqualTo: sessionId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return CompetitiveSettlement.fromJson(query.docs.first.data());
  }

  @override
  Future<void> syncOfflineSettlement(CompetitiveSettlement settlement) async {
    await finalizeSettlement(
      settlement.copyWith(status: SettlementStatus.completed),
    );
  }
}
