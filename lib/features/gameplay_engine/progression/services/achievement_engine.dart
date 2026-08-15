import '../../../player/domain/models/achievement.dart';
import '../../../player/domain/services/achievement_registry.dart';
import '../models/progress_snapshot.dart';
import '../models/progression_result.dart';

class AchievementEngine {
  /// Analyzes a progression result and career context to return a list of newly unlocked achievement IDs.
  static List<String> checkAchievements({
    required ProgressionResult result,
    required Map<String, dynamic> careerContext,
    bool isRoundEnd = false,
  }) {
    final List<String> unlocked = [];

    for (final definition in AchievementRegistry.definitions) {
      if (!definition.isActive) continue;

      if (_isNewlyUnlocked(definition, result, careerContext, isRoundEnd)) {
        unlocked.add(definition.id);
      }
    }

    return unlocked;
  }

  static bool _isNewlyUnlocked(
    AchievementDefinition definition,
    ProgressionResult result,
    Map<String, dynamic> careerContext,
    bool isRoundEnd,
  ) {
    final beforeValue = _getValue(definition, result.before, careerContext, isRoundEnd, isBefore: true);
    final afterValue = _getValue(definition, result.after, careerContext, isRoundEnd, isBefore: false);

    return afterValue >= definition.threshold && beforeValue < definition.threshold;
  }

  static double _getValue(
    AchievementDefinition definition,
    ProgressSnapshot snapshot,
    Map<String, dynamic> careerContext,
    bool isRoundEnd, {
    required bool isBefore,
  }) {
    switch (definition.requirementType) {
      case AchievementRequirementType.score:
        if (definition.metadata['singleMatch'] == true) {
          return snapshot.sessionScore.toDouble();
        }
        // Score in snapshot is already "total" (baseline + session)
        return snapshot.score.toDouble();
      case AchievementRequirementType.xp:
        return snapshot.totalXP.toDouble();
      case AchievementRequirementType.level:
        return snapshot.level.toDouble();
      case AchievementRequirementType.streak:
        return snapshot.currentStreak.toDouble();
      case AchievementRequirementType.gamesPlayed:
        final baseline = careerContext['gamesPlayed'] as int? ?? 0;
        // careerContext for gamesPlayed usually reflects the state BEFORE this round.
        return (isRoundEnd && !isBefore) ? (baseline + 1).toDouble() : baseline.toDouble();
      case AchievementRequirementType.gamesWon:
        final baseline = careerContext['gamesWon'] as int? ?? 0;
        // This is hard to know mid-round. Typically wins are checked at round end.
        return (isRoundEnd && !isBefore && snapshot.lives > 0) ? (baseline + 1).toDouble() : baseline.toDouble();
      case AchievementRequirementType.correctAnswers:
        final baseline = careerContext['correctAnswers'] as int? ?? 0;
        return (baseline + snapshot.sessionCorrectAnswers).toDouble();
      case AchievementRequirementType.accuracy:
        // Accuracy is best calculated at round end from career context
        return (careerContext['accuracy'] as double? ?? 0.0) * 100;
      case AchievementRequirementType.categoryMastery:
        final category = definition.metadata['category'] as String?;
        if (category == null) return 0.0;
        final careerMastery = (careerContext['categoryMastery'] as Map<String, dynamic>? ?? {})[category] as int? ?? 0;
        final sessionMastery = snapshot.sessionCategoryMastery[category] ?? 0;
        return (careerMastery + sessionMastery).toDouble();
      default:
        return 0.0;
    }
  }
}
