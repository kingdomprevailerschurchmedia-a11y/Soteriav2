import 'dart:math';
import '../models/player_progression.dart';
import '../models/rank_tier.dart';
import '../models/progression.dart';
import '../models/player_profile.dart';
import '../config/progression_config.dart';

class ProgressionService {
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

    // Calculate new level
    int level = current.currentLevel;
    int xpInCurrentLevel = current.currentXp + amount;

    while (true) {
      int xpToNext =
          ProgressionConfig.xpRequiredForLevel(level + 1) -
          ProgressionConfig.xpRequiredForLevel(level);

      if (xpInCurrentLevel >= xpToNext) {
        xpInCurrentLevel -= xpToNext;
        level++;
      } else {
        break;
      }
    }

    final xpRequiredForCurrent = ProgressionConfig.xpRequiredForLevel(level);
    final xpRequiredForNext = ProgressionConfig.xpRequiredForLevel(level + 1);
    final xpToNext = xpRequiredForNext - xpRequiredForCurrent;

    return current.copyWith(
      currentLevel: level,
      currentXp: xpInCurrentLevel,
      lifetimeXp: newLifetimeXp,
      seasonXp: newSeasonXp,
      xpRequiredForCurrentLevel: xpRequiredForCurrent,
      xpRequiredForNextLevel: xpRequiredForNext,
      xpProgress: (xpInCurrentLevel / xpToNext).clamp(0.0, 1.0),
      lastUpdated: DateTime.now(),
    );
  }

  /// Resolves the Rank Tier based on Rank Points.
  RankTier resolveRankTier(int points) {
    return ProgressionConfig.rankTiers.firstWhere(
      (tier) => points >= tier.minPoints && points <= tier.maxPoints,
      orElse: () => ProgressionConfig.rankTiers.first,
    );
  }

  /// Calculates rank progress percentage.
  double calculateRankProgress(int points, RankTier tier) {
    if (tier.id == 'elite') return 1.0;
    final range = tier.maxPoints - tier.minPoints;
    if (range <= 0) return 0.0;
    return ((points - tier.minPoints) / range).clamp(0.0, 1.0);
  }
}
