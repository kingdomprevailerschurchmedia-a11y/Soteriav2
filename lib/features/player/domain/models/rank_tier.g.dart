// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_tier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankTier _$RankTierFromJson(Map<String, dynamic> json) => _RankTier(
  id: json['id'] as String,
  name: json['name'] as String,
  minPoints: (json['minPoints'] as num).toInt(),
  maxPoints: (json['maxPoints'] as num).toInt(),
  displayOrder: (json['displayOrder'] as num).toInt(),
  promotionThreshold: (json['promotionThreshold'] as num).toInt(),
  demotionThreshold: (json['demotionThreshold'] as num).toInt(),
  visualToken: json['visualToken'] as String,
);

Map<String, dynamic> _$RankTierToJson(_RankTier instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'minPoints': instance.minPoints,
  'maxPoints': instance.maxPoints,
  'displayOrder': instance.displayOrder,
  'promotionThreshold': instance.promotionThreshold,
  'demotionThreshold': instance.demotionThreshold,
  'visualToken': instance.visualToken,
};
