// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CareerStatistics _$CareerStatisticsFromJson(Map<String, dynamic> json) =>
    _CareerStatistics(
      gamesPlayed: (json['gamesPlayed'] as num).toInt(),
      gamesWon: (json['gamesWon'] as num).toInt(),
      gamesLost: (json['gamesLost'] as num).toInt(),
      winRate: (json['winRate'] as num).toDouble(),
      totalQuestionsAnswered: (json['totalQuestionsAnswered'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      highestStreak: (json['highestStreak'] as num).toInt(),
      bestRank: json['bestRank'] as String,
      peakPosition: (json['peakPosition'] as num).toInt(),
      seasonsPlayed: (json['seasonsPlayed'] as num).toInt(),
    );

Map<String, dynamic> _$CareerStatisticsToJson(_CareerStatistics instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'gamesLost': instance.gamesLost,
      'winRate': instance.winRate,
      'totalQuestionsAnswered': instance.totalQuestionsAnswered,
      'correctAnswers': instance.correctAnswers,
      'accuracy': instance.accuracy,
      'currentStreak': instance.currentStreak,
      'highestStreak': instance.highestStreak,
      'bestRank': instance.bestRank,
      'peakPosition': instance.peakPosition,
      'seasonsPlayed': instance.seasonsPlayed,
    };

_SeasonStatistics _$SeasonStatisticsFromJson(Map<String, dynamic> json) =>
    _SeasonStatistics(
      seasonId: json['seasonId'] as String,
      seasonName: json['seasonName'] as String,
      gamesPlayed: (json['gamesPlayed'] as num).toInt(),
      gamesWon: (json['gamesWon'] as num).toInt(),
      gamesLost: (json['gamesLost'] as num).toInt(),
      winRate: (json['winRate'] as num).toDouble(),
      totalPoints: (json['totalPoints'] as num).toInt(),
      averagePoints: (json['averagePoints'] as num).toDouble(),
      bestScore: (json['bestScore'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
      currentPosition: (json['currentPosition'] as num?)?.toInt(),
      currentWinStreak: (json['currentWinStreak'] as num?)?.toInt() ?? 0,
      highestWinStreak: (json['highestWinStreak'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SeasonStatisticsToJson(_SeasonStatistics instance) =>
    <String, dynamic>{
      'seasonId': instance.seasonId,
      'seasonName': instance.seasonName,
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'gamesLost': instance.gamesLost,
      'winRate': instance.winRate,
      'totalPoints': instance.totalPoints,
      'averagePoints': instance.averagePoints,
      'bestScore': instance.bestScore,
      'accuracy': instance.accuracy,
      'currentPosition': instance.currentPosition,
      'currentWinStreak': instance.currentWinStreak,
      'highestWinStreak': instance.highestWinStreak,
    };

_PerformanceTrend _$PerformanceTrendFromJson(Map<String, dynamic> json) =>
    _PerformanceTrend(
      state: $enumDecode(_$TrendStateEnumMap, json['state']),
      changePercentage: (json['changePercentage'] as num).toDouble(),
      metricName: json['metricName'] as String,
      dataPoints:
          (json['dataPoints'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PerformanceTrendToJson(_PerformanceTrend instance) =>
    <String, dynamic>{
      'state': _$TrendStateEnumMap[instance.state]!,
      'changePercentage': instance.changePercentage,
      'metricName': instance.metricName,
      'dataPoints': instance.dataPoints,
    };

const _$TrendStateEnumMap = {
  TrendState.improving: 'improving',
  TrendState.stable: 'stable',
  TrendState.declining: 'declining',
  TrendState.insufficientData: 'insufficientData',
};

_PerformanceInsight _$PerformanceInsightFromJson(Map<String, dynamic> json) =>
    _PerformanceInsight(
      title: json['title'] as String,
      description: json['description'] as String,
      isPositive: json['isPositive'] as bool,
      recommendation: json['recommendation'] as String?,
    );

Map<String, dynamic> _$PerformanceInsightToJson(_PerformanceInsight instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'isPositive': instance.isPositive,
      'recommendation': instance.recommendation,
    };

_CompetitiveStatistics _$CompetitiveStatisticsFromJson(
  Map<String, dynamic> json,
) => _CompetitiveStatistics(
  userId: json['userId'] as String,
  career: CareerStatistics.fromJson(json['career'] as Map<String, dynamic>),
  currentSeason: json['currentSeason'] == null
      ? null
      : SeasonStatistics.fromJson(
          json['currentSeason'] as Map<String, dynamic>,
        ),
  trends: (json['trends'] as List<dynamic>)
      .map((e) => PerformanceTrend.fromJson(e as Map<String, dynamic>))
      .toList(),
  insights: (json['insights'] as List<dynamic>)
      .map((e) => PerformanceInsight.fromJson(e as Map<String, dynamic>))
      .toList(),
  recentForm:
      (json['recentForm'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$CompetitiveStatisticsToJson(
  _CompetitiveStatistics instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'career': instance.career,
  'currentSeason': instance.currentSeason,
  'trends': instance.trends,
  'insights': instance.insights,
  'recentForm': instance.recentForm,
};
