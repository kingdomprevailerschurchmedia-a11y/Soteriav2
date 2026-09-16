// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonalPerformanceAnalytics _$PersonalPerformanceAnalyticsFromJson(
  Map<String, dynamic> json,
) => _PersonalPerformanceAnalytics(
  playerId: json['playerId'] as String,
  period: $enumDecode(_$TimePeriodEnumMap, json['period']),
  totalQuizzes: (json['totalQuizzes'] as num).toInt(),
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  totalCorrect: (json['totalCorrect'] as num).toInt(),
  totalIncorrect: (json['totalIncorrect'] as num).toInt(),
  totalSkipped: (json['totalSkipped'] as num).toInt(),
  totalTimedOut: (json['totalTimedOut'] as num).toInt(),
  averageAccuracy: (json['averageAccuracy'] as num).toDouble(),
  averageScore: (json['averageScore'] as num).toInt(),
  bestScore: (json['bestScore'] as num).toInt(),
  bestAccuracy: (json['bestAccuracy'] as num).toDouble(),
  bestStreak: (json['bestStreak'] as num).toInt(),
  averageResponseTime: Duration(
    microseconds: (json['averageResponseTime'] as num).toInt(),
  ),
  fastestResponseTime: Duration(
    microseconds: (json['fastestResponseTime'] as num).toInt(),
  ),
  slowestResponseTime: Duration(
    microseconds: (json['slowestResponseTime'] as num).toInt(),
  ),
  totalXp: (json['totalXp'] as num).toInt(),
  categoryPerformance: (json['categoryPerformance'] as List<dynamic>)
      .map((e) => CategoryPerformance.fromJson(e as Map<String, dynamic>))
      .toList(),
  difficultyPerformance: (json['difficultyPerformance'] as List<dynamic>)
      .map((e) => DifficultyPerformance.fromJson(e as Map<String, dynamic>))
      .toList(),
  accuracyTrend: PerformanceTrend.fromJson(
    json['accuracyTrend'] as Map<String, dynamic>,
  ),
  scoreTrend: PerformanceTrend.fromJson(
    json['scoreTrend'] as Map<String, dynamic>,
  ),
  speedTrend: PerformanceTrend.fromJson(
    json['speedTrend'] as Map<String, dynamic>,
  ),
  xpTrend: PerformanceTrend.fromJson(json['xpTrend'] as Map<String, dynamic>),
  consistency: ConsistencyMetrics.fromJson(
    json['consistency'] as Map<String, dynamic>,
  ),
  insights: (json['insights'] as List<dynamic>)
      .map((e) => PerformanceInsight.fromJson(e as Map<String, dynamic>))
      .toList(),
  calculatedAt: DateTime.parse(json['calculatedAt'] as String),
);

Map<String, dynamic> _$PersonalPerformanceAnalyticsToJson(
  _PersonalPerformanceAnalytics instance,
) => <String, dynamic>{
  'playerId': instance.playerId,
  'period': _$TimePeriodEnumMap[instance.period]!,
  'totalQuizzes': instance.totalQuizzes,
  'totalQuestions': instance.totalQuestions,
  'totalCorrect': instance.totalCorrect,
  'totalIncorrect': instance.totalIncorrect,
  'totalSkipped': instance.totalSkipped,
  'totalTimedOut': instance.totalTimedOut,
  'averageAccuracy': instance.averageAccuracy,
  'averageScore': instance.averageScore,
  'bestScore': instance.bestScore,
  'bestAccuracy': instance.bestAccuracy,
  'bestStreak': instance.bestStreak,
  'averageResponseTime': instance.averageResponseTime.inMicroseconds,
  'fastestResponseTime': instance.fastestResponseTime.inMicroseconds,
  'slowestResponseTime': instance.slowestResponseTime.inMicroseconds,
  'totalXp': instance.totalXp,
  'categoryPerformance': instance.categoryPerformance
      .map((e) => e.toJson())
      .toList(),
  'difficultyPerformance': instance.difficultyPerformance
      .map((e) => e.toJson())
      .toList(),
  'accuracyTrend': instance.accuracyTrend.toJson(),
  'scoreTrend': instance.scoreTrend.toJson(),
  'speedTrend': instance.speedTrend.toJson(),
  'xpTrend': instance.xpTrend.toJson(),
  'consistency': instance.consistency.toJson(),
  'insights': instance.insights.map((e) => e.toJson()).toList(),
  'calculatedAt': instance.calculatedAt.toIso8601String(),
};

const _$TimePeriodEnumMap = {
  TimePeriod.last7Days: 'last7Days',
  TimePeriod.last30Days: 'last30Days',
  TimePeriod.last90Days: 'last90Days',
  TimePeriod.allTime: 'allTime',
};
