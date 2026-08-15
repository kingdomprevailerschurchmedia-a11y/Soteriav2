import 'package:soteria/features/player/domain/config/progression_config.dart';

class LevelEngine {
  /// Determines the level for a given amount of total XP.
  int calculateLevel(int totalXP) {
    if (totalXP <= 0) return 1;

    int level = 1;
    while (totalXP >= ProgressionConfig.xpRequiredForLevel(level + 1)) {
      level++;
      if (level >= ProgressionConfig.maxLevel) break;
    }
    return level;
  }

  /// Calculates the amount of XP earned within the current level.
  int xpIntoCurrentLevel(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    final xpAtStartOfLevel = ProgressionConfig.xpRequiredForLevel(currentLevel);
    return (totalXP - xpAtStartOfLevel).clamp(0, 999999999);
  }

  /// Calculates the progress percentage (0.0 to 1.0) within the current level.
  double calculateLevelProgress(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    if (currentLevel >= ProgressionConfig.maxLevel) return 1.0;

    final xpAtStartOfLevel = ProgressionConfig.xpRequiredForLevel(currentLevel);
    final xpToReachNextLevel =
        ProgressionConfig.xpRequiredForLevel(currentLevel + 1);

    final xpInCurrentLevel = totalXP - xpAtStartOfLevel;
    final totalXpNeededInLevel = xpToReachNextLevel - xpAtStartOfLevel;

    if (totalXpNeededInLevel <= 0) return 1.0;

    return (xpInCurrentLevel / totalXpNeededInLevel).clamp(0.0, 1.0);
  }

  /// Calculates XP remaining to reach the next level.
  int xpRemainingToNextLevel(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    if (currentLevel >= ProgressionConfig.maxLevel) return 0;

    final xpToReachNextLevel =
        ProgressionConfig.xpRequiredForLevel(currentLevel + 1);
    return (xpToReachNextLevel - totalXP).clamp(0, 999999999);
  }
}
