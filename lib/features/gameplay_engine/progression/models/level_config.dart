import 'dart:math';

class LevelConfig {
  final int baseXP;
  final double exponent;
  final int linearFactor;

  const LevelConfig({
    this.baseXP = 100,
    this.exponent = 1.5,
    this.linearFactor = 50,
  });

  /// Calculates total XP required to REACH a specific level.
  /// Formula: baseXP * (level - 1)^exponent + linearFactor * (level - 1)
  int xpRequiredForLevel(int level) {
    if (level <= 1) return 0;

    final n = level - 1;
    final exponentialPart = baseXP * pow(n, exponent);
    final linearPart = linearFactor * n;

    return (exponentialPart + linearPart).toInt();
  }

  /// Calculates how much XP is needed specifically WITHIN the current level to reach the next.
  int xpRequiredBetweenLevels(int currentLevel) {
    return xpRequiredForLevel(currentLevel + 1) -
        xpRequiredForLevel(currentLevel);
  }
}
