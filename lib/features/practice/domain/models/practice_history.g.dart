// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PracticeHistory _$PracticeHistoryFromJson(Map<String, dynamic> json) =>
    _PracticeHistory(
      totalSessions: (json['totalSessions'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      totalCorrect: (json['totalCorrect'] as num).toInt(),
      averageAccuracy: (json['averageAccuracy'] as num).toDouble(),
      categoryPerformance: (json['categoryPerformance'] as Map<String, dynamic>)
          .map(
            (k, e) => MapEntry(
              k,
              CategoryPerformance.fromJson(e as Map<String, dynamic>),
            ),
          ),
      difficultyPerformance:
          (json['difficultyPerformance'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              $enumDecode(_$DifficultyEnumMap, k),
              (e as num).toDouble(),
            ),
          ),
      trends: (json['trends'] as List<dynamic>)
          .map((e) => PracticeTrendPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      personalBests: PersonalBests.fromJson(
        json['personalBests'] as Map<String, dynamic>,
      ),
      recentSessions: (json['recentSessions'] as List<dynamic>)
          .map((e) => PracticeResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PracticeHistoryToJson(_PracticeHistory instance) =>
    <String, dynamic>{
      'totalSessions': instance.totalSessions,
      'totalQuestions': instance.totalQuestions,
      'totalCorrect': instance.totalCorrect,
      'averageAccuracy': instance.averageAccuracy,
      'categoryPerformance': instance.categoryPerformance,
      'difficultyPerformance': instance.difficultyPerformance.map(
        (k, e) => MapEntry(_$DifficultyEnumMap[k]!, e),
      ),
      'trends': instance.trends,
      'personalBests': instance.personalBests,
      'recentSessions': instance.recentSessions,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};

_PracticeTrendPoint _$PracticeTrendPointFromJson(Map<String, dynamic> json) =>
    _PracticeTrendPoint(
      timestamp: DateTime.parse(json['timestamp'] as String),
      accuracy: (json['accuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$PracticeTrendPointToJson(_PracticeTrendPoint instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'accuracy': instance.accuracy,
    };

_PersonalBests _$PersonalBestsFromJson(Map<String, dynamic> json) =>
    _PersonalBests(
      highestAccuracy: (json['highestAccuracy'] as num).toDouble(),
      mostQuestionsInSession: (json['mostQuestionsInSession'] as num).toInt(),
      bestScore: (json['bestScore'] as num).toInt(),
      longestSession: Duration(
        microseconds: (json['longestSession'] as num).toInt(),
      ),
    );

Map<String, dynamic> _$PersonalBestsToJson(_PersonalBests instance) =>
    <String, dynamic>{
      'highestAccuracy': instance.highestAccuracy,
      'mostQuestionsInSession': instance.mostQuestionsInSession,
      'bestScore': instance.bestScore,
      'longestSession': instance.longestSession.inMicroseconds,
    };
