import 'package:freezed_annotation/freezed_annotation.dart';

part 'consistency_metrics.freezed.dart';
part 'consistency_metrics.g.dart';

@freezed
abstract class ConsistencyMetrics with _$ConsistencyMetrics {
  const factory ConsistencyMetrics({
    required double accuracyVariance,
    required double scoreVariance,
    required double consistencyScore, // 0.0 to 1.0
    required String consistencyLevel, // e.g., "Highly Consistent"
    required int streakStability,
  }) = _ConsistencyMetrics;

  factory ConsistencyMetrics.fromJson(Map<String, dynamic> json) =>
      _$ConsistencyMetricsFromJson(json);
}
