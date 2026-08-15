import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../quiz/domain/models/quiz_enums.dart';
import '../../../quiz/domain/models/question_result.dart';

part 'question_analytics_event.freezed.dart';
part 'question_analytics_event.g.dart';

@freezed
abstract class QuestionAnalyticsEvent with _$QuestionAnalyticsEvent {
  const factory QuestionAnalyticsEvent({
    required String eventId, // Deterministic: sessionId_questionId
    required String userId,
    required String questionId,
    required String version,
    required String categoryId,
    required Difficulty difficulty,
    required QuestionOutcome outcome,
    required Duration responseTime,
    required GameMode mode,
    required DateTime timestamp,
  }) = _QuestionAnalyticsEvent;

  factory QuestionAnalyticsEvent.fromResult({
    required String sessionId,
    required String userId,
    required QuestionResult result,
  }) {
    return QuestionAnalyticsEvent(
      eventId: '${sessionId}_${result.questionId}',
      userId: userId,
      questionId: result.questionId,
      version: result.questionVersion ?? '1.0.0',
      categoryId: result.categoryId ?? 'unknown',
      difficulty: result.difficulty ?? Difficulty.medium,
      outcome: result.outcome,
      responseTime: result.responseTime,
      mode: result.mode ?? GameMode.practice,
      timestamp: DateTime.now(),
    );
  }

  factory QuestionAnalyticsEvent.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnalyticsEventFromJson(json);
}
