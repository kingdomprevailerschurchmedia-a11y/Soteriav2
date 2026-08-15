import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

/// Configuration for how progression is calculated for a specific game mode.
abstract class ProgressionPolicy {
  GameMode get mode;
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
  GameMode get mode => GameMode.pro;

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
  GameMode get mode => GameMode.practice;

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

class TournamentProgressionPolicy implements ProgressionPolicy {
  @override
  GameMode get mode => GameMode.tournament;

  @override
  int get pointsPerCorrect => 200; // Higher stakes
  @override
  int get pointsPerWrong => -50; // Penalty in tournaments
  @override
  int get pointsPerTimeout => -100; // Large penalty for timeout

  @override
  double get xpMultiplier => 2.5; // Tournament XP boost
  @override
  int get xpPerCorrect => 50;
  @override
  int get completionBonusXP => 200;
  @override
  int get perfectRoundBonusXP => 1000;

  @override
  double get streakBonusMultiplier => 0.2; // +20% per streak
  @override
  bool get allowSpeedBonus => true;
}

class VSProgressionPolicy implements ProgressionPolicy {
  final double difficultyMultiplier;

  VSProgressionPolicy({this.difficultyMultiplier = 1.0});

  @override
  GameMode get mode => GameMode.versus;

  @override
  int get pointsPerCorrect => 150;
  @override
  int get pointsPerWrong => 0;
  @override
  int get pointsPerTimeout => 0;

  @override
  double get xpMultiplier => 2.0 * difficultyMultiplier;
  @override
  int get xpPerCorrect => 25;
  @override
  int get completionBonusXP => 50;
  @override
  int get perfectRoundBonusXP => 500;

  @override
  double get streakBonusMultiplier => 0.15;
  @override
  bool get allowSpeedBonus => true;
}

class ProgressionPolicyResolver {
  static ProgressionPolicy resolve(
    GameMode mode, {
    String? difficulty,
    double? difficultyMultiplier,
  }) {
    final diffMultiplier =
        difficultyMultiplier ?? _getDifficultyMultiplier(difficulty);

    switch (mode) {
      case GameMode.practice:
        return PracticeProgressionPolicy();
      case GameMode.tournament:
        return TournamentProgressionPolicy();
      case GameMode.versus:
        return VSProgressionPolicy(difficultyMultiplier: diffMultiplier);
      default:
        return ProProgressionPolicy();
    }
  }

  static double _getDifficultyMultiplier(String? difficulty) {
    switch (difficulty?.toLowerCase()) {
      case 'intermediate':
        return 1.5;
      case 'advanced':
        return 2.0;
      case 'expert':
        return 3.0;
      case 'adaptive':
        return 2.0;
      default:
        return 1.0;
    }
  }
}
