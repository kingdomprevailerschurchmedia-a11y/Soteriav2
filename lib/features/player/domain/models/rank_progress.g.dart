// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankProgress _$RankProgressFromJson(Map<String, dynamic> json) =>
    _RankProgress(
      currentRank: json['currentRank'] as String,
      currentRP: (json['currentRP'] as num).toInt(),
      minimumRP: (json['minimumRP'] as num).toInt(),
      maximumRP: (json['maximumRP'] as num).toInt(),
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
      nextRank: json['nextRank'] as String?,
      rpToNextRank: (json['rpToNextRank'] as num?)?.toInt(),
      isMaxRank: json['isMaxRank'] as bool? ?? false,
      isUnranked: json['isUnranked'] as bool? ?? false,
      tier: RankTier.fromJson(json['tier'] as Map<String, dynamic>),
      division: (json['division'] as num).toInt(),
    );

Map<String, dynamic> _$RankProgressToJson(_RankProgress instance) =>
    <String, dynamic>{
      'currentRank': instance.currentRank,
      'currentRP': instance.currentRP,
      'minimumRP': instance.minimumRP,
      'maximumRP': instance.maximumRP,
      'progressPercentage': instance.progressPercentage,
      'nextRank': instance.nextRank,
      'rpToNextRank': instance.rpToNextRank,
      'isMaxRank': instance.isMaxRank,
      'isUnranked': instance.isUnranked,
      'tier': instance.tier,
      'division': instance.division,
    };
