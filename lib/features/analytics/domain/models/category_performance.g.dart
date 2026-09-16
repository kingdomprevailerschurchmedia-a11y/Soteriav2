// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryPerformance _$CategoryPerformanceFromJson(Map<String, dynamic> json) =>
    _CategoryPerformance(
      category: json['category'] as String,
      totalQuizzes: (json['totalQuizzes'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
      averageScore: (json['averageScore'] as num).toInt(),
      bestScore: (json['bestScore'] as num).toInt(),
      averageResponseTime: Duration(
        microseconds: (json['averageResponseTime'] as num).toInt(),
      ),
      totalXp: (json['totalXp'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryPerformanceToJson(
  _CategoryPerformance instance,
) => <String, dynamic>{
  'category': instance.category,
  'totalQuizzes': instance.totalQuizzes,
  'totalQuestions': instance.totalQuestions,
  'correctAnswers': instance.correctAnswers,
  'accuracy': instance.accuracy,
  'averageScore': instance.averageScore,
  'bestScore': instance.bestScore,
  'averageResponseTime': instance.averageResponseTime.inMicroseconds,
  'totalXp': instance.totalXp,
};
