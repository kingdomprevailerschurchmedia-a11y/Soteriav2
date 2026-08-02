import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';

class ScoreEngine {
  /// Calculates the score delta for a single answer result.
  static int calculateDelta({
    required AnswerResult result,
    required ProgressionPolicy policy,
    required int currentStreak,
  }) {
    if (result.isCorrect) {
      int score = policy.pointsPerCorrect;

      // Apply streak bonus
      if (currentStreak > 0) {
        double bonus = score * (currentStreak * policy.streakBonusMultiplier);
        // Cap streak bonus at 100% of base points to avoid infinite scaling
        score += bonus.clamp(0.0, policy.pointsPerCorrect.toDouble()).toInt();
      }

      // Apply speed bonus if applicable
      if (policy.allowSpeedBonus) {
        final responseTimeMs =
            result.metadata['responseTimeMs'] as int? ?? 10000;
        score += _calculateSpeedBonus(responseTimeMs);
      }

      return score;
    } else if (result.isWrong) {
      return -policy.pointsPerWrong;
    } else {
      // Timeout or skipped
      return -policy.pointsPerTimeout;
    }
  }

  static int _calculateSpeedBonus(int responseTimeMs) {
    if (responseTimeMs < 1000) return 50; // Super fast
    if (responseTimeMs < 2500) return 25; // Fast
    if (responseTimeMs < 5000) return 10; // Decent
    return 0;
  }
}
