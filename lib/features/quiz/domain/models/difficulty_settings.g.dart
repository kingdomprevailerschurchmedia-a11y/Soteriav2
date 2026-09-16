// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DifficultySettings _$DifficultySettingsFromJson(Map<String, dynamic> json) =>
    _DifficultySettings(
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
      baseXP: (json['baseXP'] as num).toInt(),
      xpMultiplier: (json['xpMultiplier'] as num).toDouble(),
      baseCoins: (json['baseCoins'] as num).toInt(),
      timeLimitSeconds: (json['timeLimitSeconds'] as num).toInt(),
      penaltyPoints: (json['penaltyPoints'] as num).toInt(),
    );

Map<String, dynamic> _$DifficultySettingsToJson(_DifficultySettings instance) =>
    <String, dynamic>{
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'baseXP': instance.baseXP,
      'xpMultiplier': instance.xpMultiplier,
      'baseCoins': instance.baseCoins,
      'timeLimitSeconds': instance.timeLimitSeconds,
      'penaltyPoints': instance.penaltyPoints,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};
