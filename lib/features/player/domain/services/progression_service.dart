import '../models/player_progression.dart';
import '../models/rank_tier.dart';
import '../models/progression.dart';
import '../models/player_profile.dart';
import '../config/progression_config.dart';
import 'competitive_ranking_engine.dart';
import '../../../gameplay_engine/progression/services/level_engine.dart';

class ProgressionService {
  final CompetitiveRankingEngine _rankingEngine;

  ProgressionService({CompetitiveRankingEngine? rankingEngine})
      : _rankingEngine = rankingEngine ?? CompetitiveRankingEngine();

  /// Calculates the legacy progression model for compatibility.
  Progression calculateProgression(PlayerProfile? player) {
    if (player == null) return Progression.initial();

    final level = player.level;
    final totalXp = player.xp;
    final xpForCurrent = ProgressionConfig.xpRequiredForLevel(level);
    final xpForNext = ProgressionConfig.xpRequiredForLevel(level + 1);
    final xpInLevel = totalXp - xpForCurrent;
    final xpToNext = xpForNext - xpForCurrent;

    return Progression(
      level: level,
      currentXp: totalXp,
      nextLevelXp: xpForNext,
      xpInCurrentLevel: xpInLevel,
      progressPercentage: (xpInLevel / xpToNext).clamp(0.0, 1.0),
      xpRemaining: xpForNext - totalXp,
    );
  }

  /// Calculates the new progression state after adding XP.
  PlayerProgression addXp(PlayerProgression current, int amount) {
    final newLifetimeXp = current.lifetimeXp + amount;
    final newSeasonXp = current.seasonXp + amount;

    final engine = LevelEngine();
    final newLevel = engine.calculateLevel(newLifetimeXp);
    final xpInCurrentLevel = engine.xpIntoCurrentLevel(newLifetimeXp);

    final xpRequiredForCurrent =
        ProgressionConfig.xpRequiredForLevel(newLevel);
    final xpRequiredForNext =
        ProgressionConfig.xpRequiredForLevel(newLevel + 1);

    return current.copyWith(
      currentLevel: newLevel,
      currentXp: xpInCurrentLevel,
      lifetimeXp: newLifetimeXp,
      seasonXp: newSeasonXp,
      xpRequiredForCurrentLevel: xpRequiredForCurrent,
      xpRequiredForNextLevel: xpRequiredForNext,
      xpProgress: engine.calculateLevelProgress(newLifetimeXp),
      lastUpdated: DateTime.now(),
    );
  }

  /// Resolves the Rank Tier based on Rank Points.
  RankTier resolveRankTier(int points) {
    return _rankingEngine.calculateRankProgress(points).tier;
  }

  /// Calculates rank progress percentage.
  double calculateRankProgress(int points, RankTier tier) {
    return _rankingEngine.calculateRankProgress(points).progressPercentage;
  }
}
