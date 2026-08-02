import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

/// Configuration for how progression is calculated for a specific game mode.
abstract class ProgressionPolicy {
  int get pointsPerCorrect;
  int get pointsPerWrong;
  int get pointsPerTimeout;

  double get xpMultiplier;
  int get xpPerCorrect;
  int get completionBonusXP;
  int get perfectRoundBonusXP;

  double get streakBonusMultiplier;
  bool get allowSpeedBonus;
}

class ProProgressionPolicy implements ProgressionPolicy {
  @override
  int get pointsPerCorrect => 100;
  @override
  int get pointsPerWrong => 0;
  @override
  int get pointsPerTimeout => 0;

  @override
  double get xpMultiplier => 1.5;
  @override
  int get xpPerCorrect => 20;
  @override
  int get completionBonusXP => 50;
  @override
  int get perfectRoundBonusXP => 100;

  @override
  double get streakBonusMultiplier => 0.1; // +10% per streak
  @override
  bool get allowSpeedBonus => true;
}

class PracticeProgressionPolicy implements ProgressionPolicy {
  @override
  int get pointsPerCorrect => 50;
  @override
  int get pointsPerWrong => 0;
  @override
  int get pointsPerTimeout => 0;

  @override
  double get xpMultiplier => 1.0;
  @override
  int get xpPerCorrect => 10;
  @override
  int get completionBonusXP => 10;
  @override
  int get perfectRoundBonusXP => 25;

  @override
  double get streakBonusMultiplier => 0.05; // +5% per streak
  @override
  bool get allowSpeedBonus => false;
}

class ProgressionPolicyResolver {
  static ProgressionPolicy resolve(GameMode mode) {
    switch (mode) {
      case GameMode.practice:
        return PracticeProgressionPolicy();
      default:
        return ProProgressionPolicy();
    }
  }
}
