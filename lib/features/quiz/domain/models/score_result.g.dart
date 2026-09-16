// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoreResult _$ScoreResultFromJson(Map<String, dynamic> json) => _ScoreResult(
  baseScore: (json['baseScore'] as num?)?.toInt() ?? 0,
  speedBonus: (json['speedBonus'] as num?)?.toInt() ?? 0,
  difficultyBonus: (json['difficultyBonus'] as num?)?.toInt() ?? 0,
  streakBonus: (json['streakBonus'] as num?)?.toInt() ?? 0,
  totalScore: (json['totalScore'] as num?)?.toInt() ?? 0,
  xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
  coinsEarned: (json['coinsEarned'] as num?)?.toInt() ?? 0,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$ScoreResultToJson(_ScoreResult instance) =>
    <String, dynamic>{
      'baseScore': instance.baseScore,
      'speedBonus': instance.speedBonus,
      'difficultyBonus': instance.difficultyBonus,
      'streakBonus': instance.streakBonus,
      'totalScore': instance.totalScore,
      'xpEarned': instance.xpEarned,
      'coinsEarned': instance.coinsEarned,
      'timestamp': instance.timestamp.toIso8601String(),
    };
