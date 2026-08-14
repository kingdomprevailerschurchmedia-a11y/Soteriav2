import 'package:soteria/features/player/domain/models/competitive_goal.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

class CompetitiveGoalEvaluationService {
  /// Evaluates a list of goals against authoritative data.
  List<CompetitiveGoal> evaluate({
    required List<CompetitiveGoal> activeGoals,
    required List<QuizResult> recentResults,
    required CompetitiveStatistics statistics,
    required PlayerProgression progression,
  }) {
    final updatedGoals = <CompetitiveGoal>[];

    for (final goal in activeGoals) {
      if (goal.isCompleted || goal.isExpired) continue;

      final double progress = _calculateProgress(
        goal: goal,
        recentResults: recentResults,
        statistics: statistics,
        progression: progression,
      );

      if (progress != goal.currentProgress) {
        final isNewlyCompleted = progress >= goal.target;
        updatedGoals.add(
          goal.copyWith(
            currentProgress: progress,
            status: isNewlyCompleted ? GoalStatus.completed : GoalStatus.active,
            completedAt: isNewlyCompleted ? DateTime.now() : null,
          ),
        );
      }
    }

    return updatedGoals;
  }

  double _calculateProgress({
    required CompetitiveGoal goal,
    required List<QuizResult> recentResults,
    required CompetitiveStatistics statistics,
    required PlayerProgression progression,
  }) {
    // Filter results that fall within the goal's time window
    final resultsInRange = recentResults
        .where(
          (r) =>
              r.completedAt.isAfter(goal.startAt) &&
              r.completedAt.isBefore(goal.endAt),
        )
        .toList();

    switch (goal.category) {
      case GoalCategory.gameCount:
        // Only count competitive games
        return resultsInRange
            .where(
              (r) =>
                  r.gameMode == GameMode.tournament ||
                  r.gameMode == GameMode.versus ||
                  r.gameMode == GameMode.pro,
            )
            .length
            .toDouble();

      case GoalCategory.win:
        return resultsInRange
            .where(
              (r) => r.performanceRating == 'S' || r.performanceRating == 'A',
            )
            .length
            .toDouble();

      case GoalCategory.score:
        if (resultsInRange.isEmpty) return 0.0;
        return resultsInRange
            .map((r) => r.finalScore)
            .reduce((a, b) => a > b ? a : b)
            .toDouble();

      case GoalCategory.rank:
        final targetTier = goal.metadata['targetTier'] ?? '';
        return _evaluateRankTier(
          progression.currentRankTier,
          targetTier,
        ).toDouble();

      case GoalCategory.streak:
        return statistics.career.currentStreak.toDouble();

      case GoalCategory.personalBest:
        return statistics.career.peakPosition.toDouble();

      case GoalCategory.achievement:
        return 0.0;
    }
  }

  int _evaluateRankTier(String currentTierId, String targetTierId) {
    final tiers = [
      'bronze',
      'silver',
      'gold',
      'platinum',
      'diamond',
      'master',
      'elite',
    ];
    final currentIndex = tiers.indexOf(currentTierId.toLowerCase());
    final targetIndex = tiers.indexOf(targetTierId.toLowerCase());

    if (targetIndex == -1) return 0;
    return currentIndex >= targetIndex ? 1 : 0;
  }
}
