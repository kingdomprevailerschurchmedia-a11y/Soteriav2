import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';
import 'question_result.dart';

part 'quiz_result.freezed.dart';
part 'quiz_result.g.dart';

@freezed
abstract class QuizResult with _$QuizResult {
  const factory QuizResult({
    required String sessionId,
    required String playerId,
    required GameMode gameMode,
    required String category,
    required Difficulty difficulty,
    required int totalQuestions,
    required int answeredQuestions,
    required int correctAnswers,
    required int wrongAnswers,
    required int skipped,
    required int timedOut,
    required double accuracy,
    required int finalScore,
    required int xpEarned,
    @Default(0) int coinsEarned,
    required int longestStreak,
    required int finalStreak,
    required Duration averageResponseTime,
    required Duration fastestResponseTime,
    required Duration slowestResponseTime,
    required List<QuestionResult> questionResults,
    @Default([]) List<PowerUpType> powerUpsUsed,
    required DateTime completedAt,
    DateTime? createdAt,
    required Duration completionTime,
    required String performanceRating,
    @Default(1) int version,
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}
