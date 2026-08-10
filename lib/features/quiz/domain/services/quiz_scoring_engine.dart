import '../models/question.dart';
import '../models/player_answer.dart';
import '../models/score_result.dart';
import '../models/scoring_configuration.dart';
import '../models/quiz_enums.dart';

class QuizScoringEngine {
  final ScoringConfiguration config;

  QuizScoringEngine({required this.config});

  ScoreResult calculate(
    Question question,
    PlayerAnswer answer,
    int currentStreak,
  ) {
    if (!answer.isCorrect || answer.isTimedOut || answer.isSkipped) {
      return ScoreResult.zero();
    }

    // 1. Base Score
    final baseScore = config.basePoints[question.difficulty] ?? 100;

    // 2. Difficulty Bonus
    final difficultyMultiplier =
        config.difficultyMultipliers[question.difficulty] ?? 1.0;
    final difficultyBonus = ((baseScore * difficultyMultiplier) - baseScore)
        .toInt();

    // 3. Speed Bonus
    int speedBonus = 0;
    final totalAvailableTime = Duration(seconds: question.estimatedTime);
    if (totalAvailableTime.inMilliseconds > 0) {
      final responseRatio =
          answer.responseTime.inMilliseconds /
          totalAvailableTime.inMilliseconds;

      // If answered in less than config.speedBonusThreshold (e.g. 50% of time)
      if (responseRatio < config.speedBonusThreshold) {
        // Linear scale for speed bonus: faster is better
        final speedFactor = 1.0 - (responseRatio / config.speedBonusThreshold);
        speedBonus = (config.maxSpeedBonus * speedFactor).toInt();
      }
    }

    // 4. Streak Bonus
    // Bonus = baseScore * (streak * multiplier), capped at maxStreakBonus
    final streakBonusRate = (currentStreak * config.streakBonusMultiplier)
        .clamp(0.0, config.maxStreakBonus);
    final streakBonus = (baseScore * streakBonusRate).toInt();

    // 5. Total Score
    final totalScore = baseScore + difficultyBonus + speedBonus + streakBonus;

    // 6. XP Calculation
    final xpEarned =
        (config.xpPerCorrect * config.xpMultiplier * difficultyMultiplier)
            .toInt();

    return ScoreResult(
      baseScore: baseScore,
      speedBonus: speedBonus,
      difficultyBonus: difficultyBonus,
      streakBonus: streakBonus,
      totalScore: totalScore,
      xpEarned: xpEarned,
      timestamp: DateTime.now(),
    );
  }

  int calculateNewStreak(int currentStreak, PlayerAnswer answer) {
    if (answer.isCorrect) {
      return currentStreak + 1;
    }
    // Timed out and Incorrect reset streak. Skips might be different but usually reset too for competitive.
    return 0;
  }
}
