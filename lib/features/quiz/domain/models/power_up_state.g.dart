// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_up_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PowerUpState _$PowerUpStateFromJson(Map<String, dynamic> json) =>
    _PowerUpState(
      type: $enumDecode(_$PowerUpTypeEnumMap, json['type']),
      status:
          $enumDecodeNullable(_$PowerUpStatusEnumMap, json['status']) ??
          PowerUpStatus.available,
      remainingUses: (json['remainingUses'] as num?)?.toInt() ?? 1,
      cooldownRemaining: json['cooldownRemaining'] == null
          ? Duration.zero
          : Duration(microseconds: (json['cooldownRemaining'] as num).toInt()),
      usageHistory:
          (json['usageHistory'] as List<dynamic>?)
              ?.map((e) => PowerUpUsage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PowerUpStateToJson(_PowerUpState instance) =>
    <String, dynamic>{
      'type': _$PowerUpTypeEnumMap[instance.type]!,
      'status': _$PowerUpStatusEnumMap[instance.status]!,
      'remainingUses': instance.remainingUses,
      'cooldownRemaining': instance.cooldownRemaining.inMicroseconds,
      'usageHistory': instance.usageHistory,
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

const _$PowerUpStatusEnumMap = {
  PowerUpStatus.available: 'available',
  PowerUpStatus.used: 'used',
  PowerUpStatus.disabled: 'disabled',
  PowerUpStatus.locked: 'locked',
  PowerUpStatus.activating: 'activating',
  PowerUpStatus.active: 'active',
  PowerUpStatus.completed: 'completed',
  PowerUpStatus.failed: 'failed',
};
