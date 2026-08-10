import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_performance.freezed.dart';
part 'category_performance.g.dart';

@freezed
abstract class CategoryPerformance with _$CategoryPerformance {
  const factory CategoryPerformance({
    required String category,
    required int totalQuizzes,
    required int totalQuestions,
    required int correctAnswers,
    required double accuracy,
    required int averageScore,
    required int bestScore,
    required Duration averageResponseTime,
    required int totalXp,
  }) = _CategoryPerformance;

  factory CategoryPerformance.fromJson(Map<String, dynamic> json) =>
      _$CategoryPerformanceFromJson(json);
}
