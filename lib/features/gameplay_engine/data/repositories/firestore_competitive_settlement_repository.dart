import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/competitive_settlement_repository.dart';
import '../../models/competitive_settlement.dart';
import '../../models/game_mode.dart';
import '../../../player/domain/repositories/player_progression_repository.dart';
import '../../../player/domain/models/xp_transaction.dart';
import '../../../player/domain/models/competitive_result.dart';

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
        final data = settlementSnapshot.data()!;
        if (data['status'] == 'completed') {
          return;
        }
      }

      // VITAL SECURITY: Recalculate settlement facts from session if possible
      // For Versus and Tournament, we should ideally fetch the Match/Tournament doc
      // and verify the outcome.
      
      // Update settlement record
      transaction.set(settlementRef, settlement.toJson());

      // VITAL SECURITY: Re-verify Versus Wager if applicable
      if (settlement.result.mode == GameMode.versus) {
         // In a real production app, we would fetch the VersusMatch doc here
         // and verify the wager and outcome.
      }

      // 2. Update player rewards (Coins and stats in Users collection)
      final userRef = _database.instance.collection('users').doc(settlement.uid);
      final walletRef = _database.instance.collection('wallets').doc(settlement.uid);
      final gameProfileRef = _database.instance.collection('user_game_profiles').doc(settlement.uid);

      final txId = _database.instance.collection('wallet_transactions').doc().id;

      transaction.update(userRef, {
        'coins': FieldValue.increment(settlement.coinsWon),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      // Sync Wallet & Game Profile
      transaction.set(walletRef, {
        'coins': FieldValue.increment(settlement.coinsWon),
        'lifetimeCoinsEarned': FieldValue.increment(settlement.coinsWon),
        'lastTransactionId': (settlement.coinsWon > 0) ? txId : null,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      transaction.set(gameProfileRef, {
        'coins': FieldValue.increment(settlement.coinsWon),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Log coin transaction if coins were won
      if (settlement.coinsWon > 0) {
        final txId = _database.instance.collection('wallet_transactions').doc().id;
        final walletTxRef = _database.instance.collection('wallet_transactions').doc(txId);
        
        final txData = {
          'userId': settlement.uid,
          'type': 'coins',
          'currency': 'coins',
          'direction': 'credit',
          'amount': settlement.coinsWon,
          'transactionType': 'reward',
          'source': _mapModeToRewardSource(settlement.result.mode),
          'referenceId': settlement.sessionId,
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'metadata': {
            'sessionId': settlement.sessionId,
            'mode': settlement.result.mode.name,
            'wager': settlement.coinsWagered,
            'platformFee': settlement.platformFee,
            'tournamentId': settlement.tournamentId,
            'placement': settlement.placement,
          },
        };

        transaction.set(walletTxRef, txData);
        
        // Update last transaction ID for security rule verification
        transaction.update(userRef, {
          'lastCoinTransactionId': txId,
        });

        // Also sync to legacy coin_transactions if still used
        final coinTxRef = _database.instance.collection('coin_transactions').doc(txId);
        transaction.set(coinTxRef, txData);
      }

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
          // Fallback - should ideally be avoided for atomicity
          await _progressionRepository.applyXpTransaction(xpTx);
        }
      }

      // 4. Authoritative Rank Point (RP) Update - USING TRANSACTION-AWARE METHOD
      final compResult = CompetitiveResult(
        resultId: settlement.sessionId,
        userId: settlement.uid,
        seasonId: 'current_season', 
        outcome: _mapToCompetitiveOutcome(settlement),
        mode: settlement.result.mode.name,
        score: settlement.result.finalScore,
        completedAt: settlement.timestamp,
      );
      
      await _progressionRepository.applyCompetitiveResultInTransaction(transaction, compResult);

      // 5. Mark session as settled
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

  String _mapModeToRewardSource(GameMode mode) {
    switch (mode) {
      case GameMode.pro:
        return 'proReward';
      case GameMode.versus:
        return 'versusReward';
      case GameMode.tournament:
        return 'tournamentReward';
      default:
        return 'competitiveReward';
    }
  }

  CompetitiveOutcome _mapToCompetitiveOutcome(CompetitiveSettlement settlement) {
    if (settlement.result.mode == GameMode.tournament) {
      return CompetitiveOutcome.placement;
    }
    
    // For Versus
    if (settlement.coinsWon > settlement.coinsWagered) {
      return CompetitiveOutcome.win;
    } else if (settlement.coinsWon == settlement.coinsWagered && settlement.coinsWagered > 0) {
      return CompetitiveOutcome.draw;
    } else {
      return CompetitiveOutcome.loss;
    }
  }
}
