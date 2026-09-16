// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momentum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveMomentum _$CompetitiveMomentumFromJson(Map<String, dynamic> json) =>
    _CompetitiveMomentum(
      userId: json['userId'] as String,
      state: $enumDecode(_$MomentumStateEnumMap, json['state']),
      reason: json['reason'] as String,
      intensity: (json['intensity'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      recentSignals:
          (json['recentSignals'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CompetitiveMomentumToJson(
  _CompetitiveMomentum instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'state': _$MomentumStateEnumMap[instance.state]!,
  'reason': instance.reason,
  'intensity': instance.intensity,
  'updatedAt': instance.updatedAt.toIso8601String(),
  'recentSignals': instance.recentSignals,
};

const _$MomentumStateEnumMap = {
  MomentumState.none: 'none',
  MomentumState.building: 'building',
  MomentumState.strong: 'strong',
  MomentumState.peak: 'peak',
  MomentumState.cooling: 'cooling',
};
