import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';

class XPManager {
  /// Calculates the XP delta for a single answer result.
  static int calculateXPDelta({
    required AnswerResult result,
    required ProgressionPolicy policy,
  }) {
    if (!result.isCorrect) return 0;

    // Base XP defined in the policy
    double xp = policy.xpPerCorrect.toDouble();

    // Apply event/mode multiplier
    xp *= policy.xpMultiplier;

    // Future: Add bonuses for difficulty, specific tags, etc.

    return xp.toInt();
  }

  /// Calculates potential bonuses at the end of a round.
  static int calculateRoundBonus({
    required int totalQuestions,
    required int correctAnswers,
    required ProgressionPolicy policy,
  }) {
    int bonus = 0;

    // Completion bonus
    if (correctAnswers > 0) {
      bonus += policy.completionBonusXP;
    }

    // Perfect round bonus
    if (correctAnswers == totalQuestions && totalQuestions > 0) {
      bonus += policy.perfectRoundBonusXP;
    }

    return bonus;
  }
}
