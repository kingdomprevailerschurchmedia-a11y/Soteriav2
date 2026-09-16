// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consistency_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConsistencyMetrics _$ConsistencyMetricsFromJson(Map<String, dynamic> json) =>
    _ConsistencyMetrics(
      accuracyVariance: (json['accuracyVariance'] as num).toDouble(),
      scoreVariance: (json['scoreVariance'] as num).toDouble(),
      consistencyScore: (json['consistencyScore'] as num).toDouble(),
      consistencyLevel: json['consistencyLevel'] as String,
      streakStability: (json['streakStability'] as num).toInt(),
    );

Map<String, dynamic> _$ConsistencyMetricsToJson(_ConsistencyMetrics instance) =>
    <String, dynamic>{
      'accuracyVariance': instance.accuracyVariance,
      'scoreVariance': instance.scoreVariance,
      'consistencyScore': instance.consistencyScore,
      'consistencyLevel': instance.consistencyLevel,
      'streakStability': instance.streakStability,
    };
