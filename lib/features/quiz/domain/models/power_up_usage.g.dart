// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_up_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PowerUpUsage _$PowerUpUsageFromJson(Map<String, dynamic> json) =>
    _PowerUpUsage(
      usageId: json['usageId'] as String,
      type: $enumDecode(_$PowerUpTypeEnumMap, json['type']),
      sessionId: json['sessionId'] as String,
      roundIndex: (json['roundIndex'] as num).toInt(),
      questionId: json['questionId'] as String,
      activatedAt: DateTime.parse(json['activatedAt'] as String),
      result: json['result'] as Map<String, dynamic>? ?? const {},
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$PowerUpUsageToJson(_PowerUpUsage instance) =>
    <String, dynamic>{
      'usageId': instance.usageId,
      'type': _$PowerUpTypeEnumMap[instance.type]!,
      'sessionId': instance.sessionId,
      'roundIndex': instance.roundIndex,
      'questionId': instance.questionId,
      'activatedAt': instance.activatedAt.toIso8601String(),
      'result': instance.result,
      'duration': instance.duration?.inMicroseconds,
    };

const _$PowerUpTypeEnumMap = {
  PowerUpType.fiftyFifty: 'fiftyFifty',
  PowerUpType.pauseTimer: 'pauseTimer',
  PowerUpType.askAudience: 'askAudience',
  PowerUpType.extraTime: 'extraTime',
  PowerUpType.doubleXP: 'doubleXP',
  PowerUpType.shield: 'shield',
  PowerUpType.revealCategory: 'revealCategory',
};
