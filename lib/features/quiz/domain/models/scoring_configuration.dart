import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';

part 'scoring_configuration.freezed.dart';
part 'scoring_configuration.g.dart';

@freezed
abstract class ScoringConfiguration with _$ScoringConfiguration {
  const factory ScoringConfiguration({
    required Map<Difficulty, int> basePoints,
    required Map<Difficulty, double> difficultyMultipliers,
    @Default(0.1) double streakBonusMultiplier,
    @Default(1.0) double maxStreakBonus,
    @Default(50) int maxSpeedBonus,
    @Default(0.5) double speedBonusThreshold, // Answering in < 50% of time gives bonus
    @Default(10) int xpPerCorrect,
    @Default(1.0) double xpMultiplier,
  }) = _ScoringConfiguration;

  factory ScoringConfiguration.standard() => {
        Difficulty.easy: 100,
        Difficulty.medium: 200,
        Difficulty.hard: 300,
        Difficulty.expert: 500,
      }.asStandard();

  factory ScoringConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ScoringConfigurationFromJson(json);
}

extension ScoringConfigurationX on Map<Difficulty, int> {
  ScoringConfiguration asStandard() {
    return ScoringConfiguration(
      basePoints: this,
      difficultyMultipliers: {
        Difficulty.easy: 1.0,
        Difficulty.medium: 1.2,
        Difficulty.hard: 1.5,
        Difficulty.expert: 2.0,
      },
    );
  }
}
