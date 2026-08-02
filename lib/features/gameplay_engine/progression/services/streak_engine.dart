import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';

class StreakEngine {
  /// Calculates the new streak based on the answer result.
  static int updateCurrentStreak({
    required int currentStreak,
    required AnswerResult result,
  }) {
    if (result.isCorrect) {
      return currentStreak + 1;
    } else if (result.isWrong || result.metadata['timeout'] == true) {
      return 0; // Break streak
    }
    return currentStreak; // Keep streak on skip if defined by game rules
  }

  /// Updates the max streak if the current streak exceeds it.
  static int updateMaxStreak({
    required int currentStreak,
    required int maxStreak,
  }) {
    return currentStreak > maxStreak ? currentStreak : maxStreak;
  }

  /// Checks if a streak milestone has been reached.
  static bool isMilestone(int streak) {
    if (streak <= 0) return false;
    if (streak <= 10) return streak % 5 == 0; // 5, 10
    return streak % 10 == 0; // 20, 30, ...
  }

  /// Determines if a streak recovery is possible (Future hook).
  static bool canRecoverStreak({
    required int brokenStreak,
    required int availableRecoveryLifelines,
  }) {
    return brokenStreak >= 5 && availableRecoveryLifelines > 0;
  }
}
