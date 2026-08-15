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

  /// Calculates the new daily streak count.
  static int calculateDailyStreak({
    required int currentDailyStreak,
    required String? lastEngagementDate,
    required String currentEngagementDate,
    required bool Function(String, String) isConsecutive,
    required bool Function(String, String) isSameDay,
  }) {
    if (lastEngagementDate == null) {
      return 1;
    }

    if (isSameDay(lastEngagementDate, currentEngagementDate)) {
      return currentDailyStreak;
    }

    if (isConsecutive(lastEngagementDate, currentEngagementDate)) {
      return currentDailyStreak + 1;
    }

    // Missed day(s)
    return 1;
  }

  /// Determines if a streak recovery is possible (Future hook).
  static bool canRecoverStreak({
    required int brokenStreak,
    required int availableRecoveryLifelines,
  }) {
    return brokenStreak >= 5 && availableRecoveryLifelines > 0;
  }
}
