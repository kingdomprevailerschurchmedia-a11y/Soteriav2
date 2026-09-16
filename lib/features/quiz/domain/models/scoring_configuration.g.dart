// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoring_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoringConfiguration _$ScoringConfigurationFromJson(
  Map<String, dynamic> json,
) => _ScoringConfiguration(
  basePoints: (json['basePoints'] as Map<String, dynamic>).map(
    (k, e) => MapEntry($enumDecode(_$DifficultyEnumMap, k), (e as num).toInt()),
  ),
  difficultyMultipliers: (json['difficultyMultipliers'] as Map<String, dynamic>)
      .map(
        (k, e) => MapEntry(
          $enumDecode(_$DifficultyEnumMap, k),
          (e as num).toDouble(),
        ),
      ),
  streakBonusMultiplier:
      (json['streakBonusMultiplier'] as num?)?.toDouble() ?? 0.1,
  maxStreakBonus: (json['maxStreakBonus'] as num?)?.toDouble() ?? 1.0,
  maxSpeedBonus: (json['maxSpeedBonus'] as num?)?.toInt() ?? 50,
  speedBonusThreshold: (json['speedBonusThreshold'] as num?)?.toDouble() ?? 0.5,
  xpPerCorrect: (json['xpPerCorrect'] as num?)?.toInt() ?? 10,
  xpMultiplier: (json['xpMultiplier'] as num?)?.toDouble() ?? 1.0,
);

Map<String, dynamic> _$ScoringConfigurationToJson(
  _ScoringConfiguration instance,
) => <String, dynamic>{
  'basePoints': instance.basePoints.map(
    (k, e) => MapEntry(_$DifficultyEnumMap[k]!, e),
  ),
  'difficultyMultipliers': instance.difficultyMultipliers.map(
    (k, e) => MapEntry(_$DifficultyEnumMap[k]!, e),
  ),
  'streakBonusMultiplier': instance.streakBonusMultiplier,
  'maxStreakBonus': instance.maxStreakBonus,
  'maxSpeedBonus': instance.maxSpeedBonus,
  'speedBonusThreshold': instance.speedBonusThreshold,
  'xpPerCorrect': instance.xpPerCorrect,
  'xpMultiplier': instance.xpMultiplier,
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};
