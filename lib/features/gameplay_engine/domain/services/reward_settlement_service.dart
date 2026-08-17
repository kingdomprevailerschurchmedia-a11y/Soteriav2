import '../config/competitive_reward_config.dart';
import '../../models/game_result.dart';
import '../../models/game_mode.dart';
import '../../models/competitive_settlement.dart';
import '../../../question_content/domain/entities/difficulty.dart';

class RewardSettlementService {
  CompetitiveSettlement calculateProSettlement({
    required String settlementId,
    required GameResult result,
    required Difficulty difficulty,
    required int questionCount,
  }) {
    final entryFee = CompetitiveRewardConfig.proEntryFees[difficulty] ?? 0;
    
    // 1. Calculate Coins
    final maxRewardsForDifficulty = CompetitiveRewardConfig.proMaxRewards[difficulty] ?? {};
    final maxReward = maxRewardsForDifficulty[questionCount] ?? 0;
    final coinPayoutPercentage = CompetitiveRewardConfig.getProCoinPayoutPercentage(result.accuracy);
    final coinsWon = (maxReward * coinPayoutPercentage).round();

    // 2. Calculate XP
    final baseXpPerCorrect = CompetitiveRewardConfig.proBaseXpPerCorrect[difficulty] ?? 0;
    final xpMultiplier = CompetitiveRewardConfig.getProXpMultiplier(result.accuracy);
    final xpEarned = (result.correctAnswers * baseXpPerCorrect * xpMultiplier).round();

    return CompetitiveSettlement(
      settlementId: settlementId,
      sessionId: result.sessionId,
      uid: result.playerId,
      result: result,
      coinsWagered: entryFee,
      coinsWon: coinsWon,
      xpEarned: xpEarned,
      timestamp: DateTime.now(),
    );
  }

  CompetitiveSettlement calculateVersusSettlement({
    required String settlementId,
    required GameResult result,
    required int wagerPerPlayer,
    required VersusOutcome outcome,
  }) {
    // VITAL SECURITY: Validate wager against authoritative config
    if (!CompetitiveRewardConfig.versusWagers.contains(wagerPerPlayer)) {
      throw Exception('Invalid Versus wager: $wagerPerPlayer');
    }

    // 1. Calculate Coins
    int coinsWon = 0;
    int platformFee = 0;
    
    if (outcome == VersusOutcome.win || outcome == VersusOutcome.dominantWin) {
      final totalPot = wagerPerPlayer * 2;
      platformFee = (totalPot * CompetitiveRewardConfig.versusPlatformFeePercentage).round();
      coinsWon = totalPot - platformFee;
    }

    // 2. Calculate XP
    final baseXpPerCorrect = CompetitiveRewardConfig.getVersusBaseXpPerCorrect(outcome);
    final accuracyBonusMultiplier = CompetitiveRewardConfig.getVersusAccuracyBonusMultiplier(result.accuracy);
    final xpEarned = (result.correctAnswers * baseXpPerCorrect * (1 + accuracyBonusMultiplier)).round();

    return CompetitiveSettlement(
      settlementId: settlementId,
      sessionId: result.sessionId,
      uid: result.playerId,
      result: result,
      coinsWagered: wagerPerPlayer,
      coinsWon: coinsWon,
      platformFee: platformFee,
      xpEarned: xpEarned,
      timestamp: DateTime.now(),
    );
  }

  CompetitiveSettlement calculateTournamentSettlement({
    required String settlementId,
    required GameResult result,
    required String tournamentId,
    required int placement,
    required int coinsReward,
    required int xpReward,
  }) {
    return CompetitiveSettlement(
      settlementId: settlementId,
      sessionId: result.sessionId,
      uid: result.playerId,
      result: result,
      coinsWagered: 0, 
      coinsWon: coinsReward,
      xpEarned: xpReward,
      tournamentId: tournamentId,
      placement: placement,
      timestamp: DateTime.now(),
    );
  }
}
