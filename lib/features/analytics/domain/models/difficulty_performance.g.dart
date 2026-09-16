// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DifficultyPerformance _$DifficultyPerformanceFromJson(
  Map<String, dynamic> json,
) => _DifficultyPerformance(
  difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
  totalQuizzes: (json['totalQuizzes'] as num).toInt(),
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  correctAnswers: (json['correctAnswers'] as num).toInt(),
  accuracy: (json['accuracy'] as num).toDouble(),
  averageScore: (json['averageScore'] as num).toInt(),
  averageResponseTime: Duration(
    microseconds: (json['averageResponseTime'] as num).toInt(),
  ),
);

Map<String, dynamic> _$DifficultyPerformanceToJson(
  _DifficultyPerformance instance,
) => <String, dynamic>{
  'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
  'totalQuizzes': instance.totalQuizzes,
  'totalQuestions': instance.totalQuestions,
  'correctAnswers': instance.correctAnswers,
  'accuracy': instance.accuracy,
  'averageScore': instance.averageScore,
  'averageResponseTime': instance.averageResponseTime.inMicroseconds,
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};
