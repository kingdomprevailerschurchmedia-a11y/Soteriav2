import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../question_content/domain/entities/question.dart';
import '../../../gameplay_engine/answer/models/answer_result.dart';
import '../../../question_content/domain/entities/difficulty.dart';

part 'practice_result.freezed.dart';
part 'practice_result.g.dart';

@freezed
abstract class PracticeResult with _$PracticeResult {
  const factory PracticeResult({
    required String sessionId,
    required String userId,
    required DateTime completedAt,
    required int totalQuestions,
    required int answeredQuestions,
    required int correctAnswers,
    required int incorrectAnswers,
    required int skippedQuestions,
    required double accuracy,
    required int score,
    required Duration totalTime,
    required Map<String, CategoryPerformance> categoryPerformance,
    required Map<Difficulty, double> difficultyPerformance,
    required List<QuestionReviewItem> reviewItems,
    @Default([]) List<LearningInsight> insights,
    PracticeRecommendation? recommendation,
    @Default(0) int xpEarned,
    @Default(0) int coinsEarned,
    String? performanceMessage,
    @Default({}) Map<String, dynamic> metadata,
  }) = _PracticeResult;

  factory PracticeResult.fromJson(Map<String, dynamic> json) => _$PracticeResultFromJson(json);
}

@freezed
abstract class CategoryPerformance with _$CategoryPerformance {
  const factory CategoryPerformance({
    required String categoryId,
    required int total,
    required int correct,
    required double accuracy,
  }) = _CategoryPerformance;

  factory CategoryPerformance.fromJson(Map<String, dynamic> json) => _$CategoryPerformanceFromJson(json);
}

@freezed
abstract class QuestionReviewItem with _$QuestionReviewItem {
  const factory QuestionReviewItem({
    required String questionId,
    required String questionText,
    required List<String> selectedOptionIds,
    required List<String> correctOptionIds,
    required bool isCorrect,
    required bool isSkipped,
    String? explanation,
    required String categoryId,
    required Difficulty difficulty,
    required Duration responseTime,
  }) = _QuestionReviewItem;

  factory QuestionReviewItem.fromJson(Map<String, dynamic> json) => _$QuestionReviewItemFromJson(json);
}

@freezed
abstract class LearningInsight with _$LearningInsight {
  const factory LearningInsight({
    required String title,
    required String description,
    required LearningInsightType type,
    required bool isPositive,
  }) = _LearningInsight;

  factory LearningInsight.fromJson(Map<String, dynamic> json) => _$LearningInsightFromJson(json);
}

enum LearningInsightType {
  strength,
  weakness,
  improvement,  consistency,
  challenge,
}

@freezed
abstract class PracticeRecommendation with _$PracticeRecommendation {
  const factory PracticeRecommendation({
    required String title,
    required String description,
    required String categoryId,
    required Difficulty difficulty,
    required int questionCount,
    String? icon,
  }) = _PracticeRecommendation;

  factory PracticeRecommendation.fromJson(Map<String, dynamic> json) => _$PracticeRecommendationFromJson(json);
}
