import 'package:freezed_annotation/freezed_annotation.dart';
import 'analytics_enums.dart';

part 'performance_insight.freezed.dart';
part 'performance_insight.g.dart';

@freezed
abstract class PerformanceInsight with _$PerformanceInsight {
  const factory PerformanceInsight({
    required InsightType type,
    required String title,
    required String description,
    required String metricLabel,
    required String metricValue,
    required TrendDirection direction,
    required InsightConfidence confidence,
    required DateTime generatedAt,
    String? recommendation,
  }) = _PerformanceInsight;

  factory PerformanceInsight.fromJson(Map<String, dynamic> json) =>
      _$PerformanceInsightFromJson(json);
}
