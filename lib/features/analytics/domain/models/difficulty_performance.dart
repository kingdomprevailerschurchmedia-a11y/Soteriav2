import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../quiz/domain/models/quiz_enums.dart';

part 'difficulty_performance.freezed.dart';
part 'difficulty_performance.g.dart';

@freezed
abstract class DifficultyPerformance with _$DifficultyPerformance {
  const factory DifficultyPerformance({
    required Difficulty difficulty,
    required int totalQuizzes,
    required int totalQuestions,
    required int correctAnswers,
    required double accuracy,
    required int averageScore,
    required Duration averageResponseTime,
  }) = _DifficultyPerformance;

  factory DifficultyPerformance.fromJson(Map<String, dynamic> json) =>
      _$DifficultyPerformanceFromJson(json);
}
