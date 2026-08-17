import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../gameplay_engine/domain/repositories/competitive_settlement_repository.dart';
import '../../../gameplay_engine/domain/services/reward_settlement_service.dart';
import '../../../gameplay_engine/models/game_result.dart';

class FirestoreTournamentRewardRepository {
  final FirebaseFirestore _firestore;
  final CompetitiveSettlementRepository _settlementRepository;
  final RewardSettlementService _rewardService = RewardSettlementService();

  FirestoreTournamentRewardRepository(this._firestore, this._settlementRepository);

  Future<void> settleTournamentResult({
    required String userId,
    required String tournamentId,
    required int placement,
    required GameResult gameResult,
  }) async {
    // 1. Fetch tournament reward configuration
    final tournamentDoc = await _firestore.collection('tournaments').doc(tournamentId).get();
    if (!tournamentDoc.exists) throw Exception('Tournament not found');

    final data = tournamentDoc.data()!;
    final rewardDistribution = data['rewardDistribution'] as Map<String, dynamic>? ?? {};
    final xpDistribution = data['xpDistribution'] as Map<String, dynamic>? ?? {};

    // Determine reward based on placement
    int coinReward = _getDistributionValue(rewardDistribution, placement);
    int xpReward = _getDistributionValue(xpDistribution, placement);

    // 2. Calculate settlement
    final settlement = _rewardService.calculateTournamentSettlement(
      settlementId: '${tournamentId}_${userId}_settlement',
      result: gameResult,
      tournamentId: tournamentId,
      placement: placement,
      coinsReward: coinReward,
      xpReward: xpReward,
    );

    // 3. Apply settlement via central repository
    await _settlementRepository.finalizeSettlement(settlement);
  }

  int _getDistributionValue(Map<String, dynamic> distribution, int placement) {
    if (distribution.containsKey(placement.toString())) {
      return (distribution[placement.toString()] as num).toInt();
    }
    
    // Check for ranges in keys like "5-8"
    for (var entry in distribution.entries) {
      if (entry.key.contains('-')) {
        final parts = entry.key.split('-');
        if (parts.length == 2) {
          final start = int.tryParse(parts[0].trim());
          final end = int.tryParse(parts[1].trim());
          if (start != null && end != null && placement >= start && placement <= end) {
            return (entry.value as num).toInt();
          }
        }
      }
    }
    return 0;
  }
}
