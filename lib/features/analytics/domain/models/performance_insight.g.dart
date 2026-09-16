// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PerformanceInsight _$PerformanceInsightFromJson(Map<String, dynamic> json) =>
    _PerformanceInsight(
      type: $enumDecode(_$InsightTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      metricLabel: json['metricLabel'] as String,
      metricValue: json['metricValue'] as String,
      direction: $enumDecode(_$TrendDirectionEnumMap, json['direction']),
      confidence: $enumDecode(_$InsightConfidenceEnumMap, json['confidence']),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      recommendation: json['recommendation'] as String?,
    );

Map<String, dynamic> _$PerformanceInsightToJson(_PerformanceInsight instance) =>
    <String, dynamic>{
      'type': _$InsightTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'metricLabel': instance.metricLabel,
      'metricValue': instance.metricValue,
      'direction': _$TrendDirectionEnumMap[instance.direction]!,
      'confidence': _$InsightConfidenceEnumMap[instance.confidence]!,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'recommendation': instance.recommendation,
    };

const _$InsightTypeEnumMap = {
  InsightType.improvement: 'improvement',
  InsightType.strength: 'strength',
  InsightType.opportunity: 'opportunity',
  InsightType.speed: 'speed',
  InsightType.accuracy: 'accuracy',
  InsightType.consistency: 'consistency',
  InsightType.category: 'category',
  InsightType.difficulty: 'difficulty',
  InsightType.streak: 'streak',
  InsightType.personalBest: 'personalBest',
  InsightType.insufficientData: 'insufficientData',
};

const _$TrendDirectionEnumMap = {
  TrendDirection.improving: 'improving',
  TrendDirection.stable: 'stable',
  TrendDirection.declining: 'declining',
  TrendDirection.insufficientData: 'insufficientData',
};

const _$InsightConfidenceEnumMap = {
  InsightConfidence.high: 'high',
  InsightConfidence.medium: 'medium',
  InsightConfidence.low: 'low',
  InsightConfidence.insufficientData: 'insufficientData',
};
