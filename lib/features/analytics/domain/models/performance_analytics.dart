import 'package:freezed_annotation/freezed_annotation.dart';
import 'analytics_enums.dart';
import 'performance_trend.dart';
import 'category_performance.dart';
import 'difficulty_performance.dart';
import 'consistency_metrics.dart';
import 'performance_insight.dart';

part 'performance_analytics.freezed.dart';
part 'performance_analytics.g.dart';

@freezed
abstract class PersonalPerformanceAnalytics
    with _$PersonalPerformanceAnalytics {
  @JsonSerializable(explicitToJson: true)
  const factory PersonalPerformanceAnalytics({
    required String playerId,
    required TimePeriod period,
    required int totalQuizzes,
    required int totalQuestions,
    required int totalCorrect,
    required int totalIncorrect,
    required int totalSkipped,
    required int totalTimedOut,
    required double averageAccuracy,
    required int averageScore,
    required int bestScore,
    required double bestAccuracy,
    required int bestStreak,
    required Duration averageResponseTime,
    required Duration fastestResponseTime,
    required Duration slowestResponseTime,
    required int totalXp,
    required List<CategoryPerformance> categoryPerformance,
    required List<DifficultyPerformance> difficultyPerformance,
    required PerformanceTrend accuracyTrend,
    required PerformanceTrend scoreTrend,
    required PerformanceTrend speedTrend,
    required PerformanceTrend xpTrend,
    required ConsistencyMetrics consistency,
    required List<PerformanceInsight> insights,
    required DateTime calculatedAt,
  }) = _PersonalPerformanceAnalytics;

  factory PersonalPerformanceAnalytics.fromJson(Map<String, dynamic> json) =>
      _$PersonalPerformanceAnalyticsFromJson(json);
}
