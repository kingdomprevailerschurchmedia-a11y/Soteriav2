import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_trend.freezed.dart';
part 'performance_trend.g.dart';

@freezed
abstract class PerformanceTrendPoint with _$PerformanceTrendPoint {
  const factory PerformanceTrendPoint({
    required DateTime date,
    required double value,
    @Default(0.0) double secondaryValue,
    String? label,
  }) = _PerformanceTrendPoint;

  factory PerformanceTrendPoint.fromJson(Map<String, dynamic> json) =>
      _$PerformanceTrendPointFromJson(json);
}

@freezed
abstract class PerformanceTrend with _$PerformanceTrend {
  const factory PerformanceTrend({
    required String label,
    required List<PerformanceTrendPoint> points,
    required double averageValue,
    required double minValue,
    required double maxValue,
    required double changeValue,
    required double changePercentage,
  }) = _PerformanceTrend;

  factory PerformanceTrend.fromJson(Map<String, dynamic> json) =>
      _$PerformanceTrendFromJson(json);
}
