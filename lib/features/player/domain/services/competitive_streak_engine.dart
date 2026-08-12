import '../models/competitive_streak.dart';
import '../models/competitive_result.dart';
import '../models/momentum.dart';
import '../../../quiz/domain/models/quiz_result.dart';

class CompetitiveStreakEngine {
  /// Calculates the updated win streak based on a new competitive result.
  CompetitiveStreak updateWinStreak({
    required CompetitiveStreak currentStreak,
    required CompetitiveResult result,
  }) {
    if (result.outcome == CompetitiveOutcome.win) {
      final newCurrent = currentStreak.current + 1;
      final newBest = newCurrent > currentStreak.best
          ? newCurrent
          : currentStreak.best;
      final newSeasonBest = newCurrent > currentStreak.seasonBest
          ? newCurrent
          : currentStreak.seasonBest;

      return currentStreak.copyWith(
        current: newCurrent,
        best: newBest,
        seasonBest: newSeasonBest,
        lastQualifiedAt: result.completedAt,
        status: StreakStatus.active,
        updatedAt: DateTime.now(),
      );
    } else if (result.outcome == CompetitiveOutcome.loss) {
      return currentStreak.copyWith(
        current: 0,
        status: StreakStatus.broken,
        updatedAt: DateTime.now(),
      );
    }

    // Draws or placements might not affect the win streak,
    // or might "pause" it. Rule: Pause streak.
    return currentStreak.copyWith(updatedAt: DateTime.now());
  }

  /// Derives momentum based on recent history.
  CompetitiveMomentum calculateMomentum({
    required String userId,
    required List<CompetitiveResult> recentResults,
    required CompetitiveStreak currentStreak,
    required List<QuizResult> recentQuizResults,
  }) {
    final signals = <String>[];
    double intensity = 0.0;
    MomentumState state = MomentumState.none;
    String reason = "No recent activity";

    if (recentResults.isEmpty) {
      return CompetitiveMomentum(
        userId: userId,
        state: state,
        reason: reason,
        intensity: intensity,
        updatedAt: DateTime.now(),
      );
    }

    // 1. Check Win Streak Signal
    if (currentStreak.current >= 3) {
      signals.add("${currentStreak.current} Consecutive Wins");
      intensity += (currentStreak.current * 0.1).clamp(0.0, 0.5);
    }

    // 2. Check Recent Performance (Last 5 games)
    final last5 = recentResults.take(5).toList();
    final winCount = last5
        .where((r) => r.outcome == CompetitiveOutcome.win)
        .length;

    if (winCount >= 4) {
      state = MomentumState.peak;
      reason = "Dominant performance";
      intensity = 1.0;
    } else if (winCount >= 3 || currentStreak.current >= 2) {
      state = MomentumState.strong;
      reason = "Consistent success";
      intensity = 0.7;
    } else if (winCount >= 1) {
      state = MomentumState.building;
      reason = "Gathering momentum";
      intensity = 0.3;
    } else {
      state = MomentumState.cooling;
      reason = "Recent setbacks";
      intensity = 0.1;
    }

    // 3. Add Quiz Signals (e.g. S-tier ratings)
    final sTiers = recentQuizResults
        .where((r) => r.performanceRating == 'S')
        .length;
    if (sTiers > 0) {
      signals.add("$sTiers Perfect Ratings");
      intensity = (intensity + 0.2).clamp(0.0, 1.0);
    }

    return CompetitiveMomentum(
      userId: userId,
      state: state,
      reason: reason,
      intensity: intensity,
      updatedAt: DateTime.now(),
      recentSignals: signals,
    );
  }
}
