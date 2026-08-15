import '../models/game_result.dart';
import '../models/competitive_session.dart';
import '../progression/models/reward_summary.dart';
import '../progression/models/progression_policy.dart';
import '../progression/services/xp_manager.dart';

class CompetitiveSettlementEngine {
  /// Validates a competitive result against the original session config.
  static bool validateResult(CompetitiveSession session, GameResult result) {
    // 1. Check question count consistency
    if (result.totalQuestions != session.config.questionCount) return false;

    // 2. Check time validity (minimal sanity check)
    if (result.totalDuration.inSeconds < 1) return false;

    return true;
  }

  /// Calculates final rewards for a competitive session using authoritative policies.
  static RewardSummary calculateRewards({
    required CompetitiveSession session,
    required GameResult result,
  }) {
    final entryFee = session.config.entryFee;
    final accuracy = result.accuracy;

    final policy = ProgressionPolicyResolver.resolve(
      result.mode,
      difficulty: session.config.difficulty.name,
    );

    // Calculate XP using authoritative XPManager
    final xpFromAnswers = result.correctAnswers * (policy.xpPerCorrect * policy.xpMultiplier).toInt();
    final roundBonus = XPManager.calculateRoundBonus(
      totalQuestions: result.totalQuestions,
      correctAnswers: result.correctAnswers,
      policy: policy,
    );

    // Streak Bonus (placeholder logic maintained but unified if needed)
    final streakBonus = result.maxStreak * 10;

    // Coins Returned (Return entry fee if accuracy > 70%, for example)
    int coinsWon = 0;
    if (accuracy >= 0.9) {
      coinsWon = (entryFee * 1.5).toInt();
    } else if (accuracy >= 0.7) {
      coinsWon = entryFee; // Money back
    }

    return RewardSummary(
      baseXP: xpFromAnswers,
      bonusXP: roundBonus,
      baseCoins: coinsWon,
      perfectScoreBonus: accuracy >= 1.0 ? policy.perfectRoundBonusXP : 0,
      streakBonus: streakBonus,
    );
  }
}
