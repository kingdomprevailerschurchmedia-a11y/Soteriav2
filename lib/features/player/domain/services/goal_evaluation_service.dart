import '../models/goal.dart';
import '../models/competitive_statistics.dart';
import '../models/player_progression.dart';
import '../config/goal_registry.dart';
import '../../../quiz/domain/models/quiz_result.dart';
import '../../../quiz/domain/models/quiz_enums.dart';

class GoalEvaluationService {
  /// Evaluates a list of player goals against authoritative data.
  List<PlayerGoal> evaluate({
    required List<PlayerGoal> playerGoals,
    required List<QuizResult> recentResults,
    required CompetitiveStatistics statistics,
    required PlayerProgression progression,
    List<GoalDefinition>? definitions,
  }) {
    final updatedGoals = <PlayerGoal>[];
    final now = DateTime.now();

    for (final playerGoal in playerGoals) {
      if (playerGoal.isCompleted || playerGoal.isExpired) continue;

      // Check for expiration
      if (now.isAfter(playerGoal.expiresAt)) {
        updatedGoals.add(playerGoal.copyWith(status: GoalStatus.expired));
        continue;
      }

      final definitionId = _resolveDefinitionId(playerGoal.goalId);
      final definition = definitions?.firstWhere((d) => d.id == definitionId, orElse: () => GoalRegistry.getById(definitionId)!) ?? GoalRegistry.getById(definitionId);
      
      if (definition == null) continue;

      final double progress = _calculateProgress(
        definition: definition,
        playerGoal: playerGoal,
        recentResults: recentResults,
        statistics: statistics,
        progression: progression,
      );

      final clampedProgress = progress.clamp(0.0, definition.target);

      if (clampedProgress != playerGoal.currentProgress) {
        final isNewlyCompleted = clampedProgress >= definition.target;
        updatedGoals.add(
          playerGoal.copyWith(
            currentProgress: clampedProgress,
            status: isNewlyCompleted ? GoalStatus.completed : GoalStatus.active,
            completedAt: isNewlyCompleted ? DateTime.now() : playerGoal.completedAt,
          ),
        );
      }
    }

    return updatedGoals;
  }

  double _calculateProgress({
    required GoalDefinition definition,
    required PlayerGoal playerGoal,
    required List<QuizResult> recentResults,
    required CompetitiveStatistics statistics,
    required PlayerProgression progression,
  }) {
    // Filter results that fall within the goal's time window
    final resultsInRange = recentResults
        .where(
          (r) =>
              r.completedAt.isAfter(playerGoal.startedAt) &&
              r.completedAt.isBefore(playerGoal.expiresAt),
        )
        .toList();

    switch (definition.category) {
      case GoalCategory.gameCount:
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
        final targetTier = definition.metadata['targetTier'] ?? '';
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

  String _resolveDefinitionId(String goalId) {
    final parts = goalId.split('_');
    if (parts.length > 3 && (parts[0] == 'daily' || parts[0] == 'weekly')) {
       return parts.take(3).join('_');
    }
    return goalId;
  }
}
