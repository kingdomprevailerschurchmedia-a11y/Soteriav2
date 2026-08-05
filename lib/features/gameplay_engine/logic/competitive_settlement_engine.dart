import '../models/game_result.dart';
import '../models/competitive_session.dart';
import '../progression/models/reward_summary.dart';

class CompetitiveSettlementEngine {
  /// Validates a competitive result against the original session config.
  static bool validateResult(CompetitiveSession session, GameResult result) {
    // 1. Check question count consistency
    if (result.totalQuestions != session.config.questionCount) return false;

    // 2. Check time validity (minimal sanity check)
    if (result.totalDuration.inSeconds < 1) return false;

    return true;
  }

  /// Calculates final rewards for a competitive session.
  static RewardSummary calculateRewards({
    required CompetitiveSession session,
    required GameResult result,
  }) {
    final entryFee = session.config.entryFee;
    final accuracy = result.accuracy;

    // Base XP from correct answers
    final baseXP = result.correctAnswers * 50;

    // Multiplier based on difficulty
    final difficultyMultiplier = _getDifficultyMultiplier(
      session.config.difficulty.name,
    );

    // Perfect Session Bonus
    final perfectBonus = accuracy >= 1.0 ? 500 : 0;

    // Streak Bonus (placeholder logic)
    final streakBonus = result.maxStreak * 10;

    // Coins Returned (Return entry fee if accuracy > 70%, for example)
    int coinsWon = 0;
    if (accuracy >= 0.9) {
      coinsWon = (entryFee * 1.5).toInt();
    } else if (accuracy >= 0.7) {
      coinsWon = entryFee; // Money back
    }

    return RewardSummary(
      baseXP: (baseXP * difficultyMultiplier).toInt(),
      bonusXP: (perfectBonus * difficultyMultiplier).toInt(),
      baseCoins: coinsWon,
      perfectScoreBonus: perfectBonus,
      streakBonus: streakBonus,
    );
  }

  static double _getDifficultyMultiplier(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'intermediate':
        return 1.5;
      case 'advanced':
        return 2.0;
      case 'expert':
        return 3.0;
      case 'adaptive':
        return 2.0;
      default:
        return 1.0;
    }
  }
}
