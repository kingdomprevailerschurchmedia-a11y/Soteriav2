import '../models/progress_snapshot.dart';
import '../models/progression_result.dart';

class AchievementEngine {
  /// Analyzes a progression result and returns a list of unlocked achievement IDs.
  static List<String> checkAchievements(ProgressionResult result) {
    final List<String> unlocked = [];

    // Score Milestones
    if (_hasReached(result, (s) => s.score, 1000)) unlocked.add('score_1k');
    if (_hasReached(result, (s) => s.score, 5000)) unlocked.add('score_5k');
    if (_hasReached(result, (s) => s.score, 10000)) unlocked.add('score_10k');

    // Streak Milestones
    if (_hasReached(result, (s) => s.currentStreak, 10))
      unlocked.add('streak_10');
    if (_hasReached(result, (s) => s.currentStreak, 50))
      unlocked.add('streak_50');
    if (_hasReached(result, (s) => s.currentStreak, 100))
      unlocked.add('streak_100');

    // Level Milestones
    if (_hasReached(result, (s) => s.level, 10)) unlocked.add('level_10');
    if (_hasReached(result, (s) => s.level, 25)) unlocked.add('level_25');
    if (_hasReached(result, (s) => s.level, 50)) unlocked.add('level_50');

    return unlocked;
  }

  /// Specialized check for tournament-specific achievements.
  static List<String> checkTournamentAchievements({
    required int rank,
    required int participants,
    required bool isPerfect,
  }) {
    final List<String> unlocked = [];

    if (rank == 1) unlocked.add('tournament_winner');
    if (rank <= 3) unlocked.add('tournament_podium');
    if (rank <= 10) unlocked.add('tournament_top_10');
    if (isPerfect) unlocked.add('tournament_perfect');

    return unlocked;
  }

  static bool _hasReached(
    ProgressionResult result,
    num Function(ProgressSnapshot) getValue,
    num threshold,
  ) {
    return getValue(result.after) >= threshold &&
        getValue(result.before) < threshold;
  }
}
