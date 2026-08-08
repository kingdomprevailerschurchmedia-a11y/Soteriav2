import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';

part 'difficulty_settings.freezed.dart';
part 'difficulty_settings.g.dart';

@freezed
class DifficultySettings with _$DifficultySettings {
  const factory DifficultySettings({
    required Difficulty difficulty,
    required int baseXP,
    required double xpMultiplier,
    required int baseCoins,
    required int timeLimitSeconds,
    required int penaltyPoints,
  }) = _DifficultySettings;

  factory DifficultySettings.fromJson(Map<String, dynamic> json) =>
      _$DifficultySettingsFromJson(json);
}
