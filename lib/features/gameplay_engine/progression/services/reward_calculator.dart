import 'package:soteria/features/gameplay_engine/progression/models/progression_event.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_result.dart';

class RewardCalculator {
  /// Analyzes the progression result and determines if any rewards should be granted.
  static List<ProgressionEvent> calculateRewards(ProgressionResult result) {
    final List<ProgressionEvent> events = [];

    // Level Up Rewards
    if (result.leveledUp) {
      events.add(RewardEarnedEvent('LEVEL_UP_BONUS', result.after.level * 100));
      events.add(RewardEarnedEvent('MYSTERY_BOX', 1));
    }

    // Streak Milestone Rewards
    if (result.after.currentStreak > 0 &&
        result.after.currentStreak % 10 == 0 &&
        result.after.currentStreak != result.before.currentStreak) {
      events.add(
        RewardEarnedEvent('STREAK_BONUS', result.after.currentStreak * 5),
      );
    }

    return events;
  }
}
