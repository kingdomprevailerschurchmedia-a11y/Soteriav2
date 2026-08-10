import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_result.freezed.dart';
part 'score_result.g.dart';

@freezed
abstract class ScoreResult with _$ScoreResult {
  const factory ScoreResult({
    @Default(0) int baseScore,
    @Default(0) int speedBonus,
    @Default(0) int difficultyBonus,
    @Default(0) int streakBonus,
    @Default(0) int totalScore,
    @Default(0) int xpEarned,
    @Default(0) int coinsEarned,
    required DateTime timestamp,
  }) = _ScoreResult;

  factory ScoreResult.zero() => ScoreResult(timestamp: DateTime.now());

  factory ScoreResult.fromJson(Map<String, dynamic> json) =>
      _$ScoreResultFromJson(json);
}
