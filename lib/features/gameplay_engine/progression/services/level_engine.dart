import 'package:soteria/features/gameplay_engine/progression/models/level_config.dart';

class LevelEngine {
  final LevelConfig config;

  LevelEngine({this.config = const LevelConfig()});

  /// Determines the level for a given amount of total XP.
  int calculateLevel(int totalXP) {
    if (totalXP < 0) return 1;

    int level = 1;
    // We could use binary search or a mathematical inverse if the formula is simple enough,
    // but for 1-100 levels a loop is fine and robust to config changes.
    while (totalXP >= config.xpRequiredForLevel(level + 1)) {
      level++;
      if (level >= 1000) break; // Maximum level safety cap
    }
    return level;
  }

  /// Calculates the progress percentage (0.0 to 1.0) within the current level.
  double calculateLevelProgress(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    final xpAtStartOfLevel = config.xpRequiredForLevel(currentLevel);
    final xpToReachNextLevel = config.xpRequiredForLevel(currentLevel + 1);

    final xpInCurrentLevel = totalXP - xpAtStartOfLevel;
    final totalXpNeededInLevel = xpToReachNextLevel - xpAtStartOfLevel;

    if (totalXpNeededInLevel <= 0) return 1.0;

    return (xpInCurrentLevel / totalXpNeededInLevel).clamp(0.0, 1.0);
  }

  /// Calculates XP remaining to reach the next level.
  int xpRemainingToNextLevel(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    final xpToReachNextLevel = config.xpRequiredForLevel(currentLevel + 1);
    return (xpToReachNextLevel - totalXP).clamp(0, double.maxFinite.toInt());
  }
}
