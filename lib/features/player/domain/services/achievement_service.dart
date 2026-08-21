import '../models/achievement.dart';
import '../models/player_profile.dart';
import '../models/player_progression.dart';
import '../repositories/achievement_repository.dart';
import '../repositories/player_progression_repository.dart';
import '../repositories/player_repository.dart';
import 'achievement_registry.dart';

class AchievementService {
  final AchievementRepository _achievementRepository;
  final PlayerProgressionRepository _progressionRepository;
  final PlayerRepository _playerRepository;

  AchievementService({
    required this._achievementRepository,
    required this._progressionRepository,
    required this._playerRepository,
  });

  /// Authoritatively evaluates all achievements for a user.
  Future<void> evaluateAchievements(String userId) async {
    final profile = await _playerRepository.getPlayerProfile(userId);
    final progression = await _progressionRepository.getProgression(userId);

    if (profile == null || progression == null) return;

    final earnedAchievements = await _achievementRepository.watchPlayerAchievements(userId).first;
    final earnedIds = earnedAchievements.map((a) => a.achievementId).toSet();

    for (final definition in AchievementRegistry.definitions) {
      if (!definition.isActive || earnedIds.contains(definition.id)) continue;

      final double progress = _calculateProgress(
        definition: definition,
        profile: profile,
        progression: progression,
      );

      if (progress >= definition.threshold) {
        await _achievementRepository.unlockAchievement(userId, definition.id);
      }
    }
  }

  double _calculateProgress({
    required AchievementDefinition definition,
    required PlayerProfile profile,
    required PlayerProgression progression,
  }) {
    switch (definition.requirementType) {
      case AchievementRequirementType.level:
        return progression.currentLevel.toDouble();
      case AchievementRequirementType.xp:
        return progression.lifetimeXp.toDouble();
      case AchievementRequirementType.gamesPlayed:
        return profile.gamesPlayed.toDouble();
      case AchievementRequirementType.gamesWon:
        return profile.gamesWon.toDouble();
      case AchievementRequirementType.streak:
        return progression.longestStreak.toDouble();
      case AchievementRequirementType.accuracy:
        return profile.accuracy * 100;
      case AchievementRequirementType.correctAnswers:
        return profile.correctAnswers.toDouble();
      case AchievementRequirementType.score:
        return progression.lifetimeXp.toDouble();
      case AchievementRequirementType.tournamentWin:
        // We'd need specific win tracking for tournaments if different from gamesWon.
        return profile.tournamentMatches.toDouble(); // Placeholder if no win count yet
      case AchievementRequirementType.proWin:
        return profile.proSessions.toDouble(); // Placeholder
      case AchievementRequirementType.categoryMastery:
        final category = definition.metadata['category'] as String?;
        if (category == null) return 0.0;
        // In Story 11.3/11.4 we didn't explicitly add category mastery to profile yet,
        // but it's in the snapshot. Profile usually needs to be updated with it.
        return (profile.settings['categoryMastery']?[category] as num? ?? 0).toDouble();
      default:
        return 0.0;
    }
  }
}
