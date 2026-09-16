// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_trend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PerformanceTrendPoint _$PerformanceTrendPointFromJson(
  Map<String, dynamic> json,
) => _PerformanceTrendPoint(
  date: DateTime.parse(json['date'] as String),
  value: (json['value'] as num).toDouble(),
  secondaryValue: (json['secondaryValue'] as num?)?.toDouble() ?? 0.0,
  label: json['label'] as String?,
);

Map<String, dynamic> _$PerformanceTrendPointToJson(
  _PerformanceTrendPoint instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'value': instance.value,
  'secondaryValue': instance.secondaryValue,
  'label': instance.label,
};

_PerformanceTrend _$PerformanceTrendFromJson(Map<String, dynamic> json) =>
    _PerformanceTrend(
      label: json['label'] as String,
      points: (json['points'] as List<dynamic>)
          .map((e) => PerformanceTrendPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageValue: (json['averageValue'] as num).toDouble(),
      minValue: (json['minValue'] as num).toDouble(),
      maxValue: (json['maxValue'] as num).toDouble(),
      changeValue: (json['changeValue'] as num).toDouble(),
      changePercentage: (json['changePercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$PerformanceTrendToJson(_PerformanceTrend instance) =>
    <String, dynamic>{
      'label': instance.label,
      'points': instance.points,
      'averageValue': instance.averageValue,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'changeValue': instance.changeValue,
      'changePercentage': instance.changePercentage,
    };
