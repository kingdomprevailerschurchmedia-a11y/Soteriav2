import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/competitive_settlement_repository.dart';
import '../../models/competitive_settlement.dart';

class FirestoreCompetitiveSettlementRepository
    implements CompetitiveSettlementRepository {
  final IDatabaseService _database;

  FirestoreCompetitiveSettlementRepository(this._database);

  @override
  String generateSettlementId() =>
      FirebaseFirestore.instance.collection('settlements').doc().id;

  @override
  Future<void> finalizeSettlement(CompetitiveSettlement settlement) async {
    // In a real implementation, this would be a Firestore Transaction
    // to ensure coins and status are updated together.

    // Check if settlement already exists (idempotency)
    final existing = await getSettlementBySession(settlement.sessionId);
    if (existing != null && existing.status == SettlementStatus.completed) {
      return;
    }

    await _database
        .collection('settlements')
        .doc(settlement.settlementId)
        .set(settlement.toJson());

    // Update player rewards and release reservation
    await _database.collection('players').doc(settlement.uid).update({
      'coins': FieldValue.increment(settlement.coinsWon),
      'xp': FieldValue.increment(settlement.xpEarned),
    });

    // Mark session as settled
    await _database
        .collection('competitive_sessions')
        .doc(settlement.sessionId)
        .update({'status': 'settled', 'settlementId': settlement.settlementId});
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
