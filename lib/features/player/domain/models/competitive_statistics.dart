import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_statistics.freezed.dart';
part 'competitive_statistics.g.dart';

enum TrendState { improving, stable, declining, insufficientData }

@freezed
abstract class CareerStatistics with _$CareerStatistics {
  const factory CareerStatistics({
    required int gamesPlayed,
    required int gamesWon,
    required int gamesLost,
    required double winRate,
    required int totalQuestionsAnswered,
    required int correctAnswers,
    required double accuracy,
    required int currentStreak,
    required int highestStreak,
    required String bestRank,
    required int peakPosition,
    required int seasonsPlayed,
  }) = _CareerStatistics;

  factory CareerStatistics.fromJson(Map<String, dynamic> json) =>
      _$CareerStatisticsFromJson(json);
}

@freezed
abstract class SeasonStatistics with _$SeasonStatistics {
  const factory SeasonStatistics({
    required String seasonId,
    required String seasonName,
    required int gamesPlayed,
    required int gamesWon,
    required int gamesLost,
    required double winRate,
    required int totalPoints,
    required double averagePoints,
    required int bestScore,
    required double accuracy,
    int? currentPosition,
    @Default(0) int currentWinStreak,
    @Default(0) int highestWinStreak,
  }) = _SeasonStatistics;

  factory SeasonStatistics.fromJson(Map<String, dynamic> json) =>
      _$SeasonStatisticsFromJson(json);
}

@freezed
abstract class PerformanceTrend with _$PerformanceTrend {
  const factory PerformanceTrend({
    required TrendState state,
    required double changePercentage,
    required String metricName,
    @Default([]) List<double> dataPoints,
  }) = _PerformanceTrend;

  factory PerformanceTrend.fromJson(Map<String, dynamic> json) =>
      _$PerformanceTrendFromJson(json);
}

@freezed
abstract class PerformanceInsight with _$PerformanceInsight {
  const factory PerformanceInsight({
    required String title,
    required String description,
    required bool isPositive,
    String? recommendation,
  }) = _PerformanceInsight;

  factory PerformanceInsight.fromJson(Map<String, dynamic> json) =>
      _$PerformanceInsightFromJson(json);
}

@freezed
abstract class CompetitiveStatistics with _$CompetitiveStatistics {
  const factory CompetitiveStatistics({
    required String userId,
    required CareerStatistics career,
    required SeasonStatistics? currentSeason,
    required List<PerformanceTrend> trends,
    required List<PerformanceInsight> insights,
    @Default([]) List<String> recentForm, // 'W', 'L', etc.
  }) = _CompetitiveStatistics;

  factory CompetitiveStatistics.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveStatisticsFromJson(json);
}
