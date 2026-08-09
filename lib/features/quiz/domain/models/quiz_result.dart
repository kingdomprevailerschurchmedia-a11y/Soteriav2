import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_result.freezed.dart';
part 'quiz_result.g.dart';

@freezed
abstract class QuizResult with _$QuizResult {
  const factory QuizResult({
    required int finalScore,
    required double accuracy,
    required int correctAnswers,
    required int wrongAnswers,
    required int skipped,
    required Duration averageResponseTime,
    required int longestStreak,
    required int xpEarned,
    required int coinsEarned,
    @Default([]) List<String> achievements,
    required String rank,
    required String performanceGrade,
    required DateTime timestamp,
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}
