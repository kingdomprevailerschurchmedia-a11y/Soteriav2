import '../models/question_analytics.dart';
import '../../../quiz/domain/models/question_result.dart';

abstract class QuestionAnalyticsRepository {
  /// Client-side: Records an individual question attempt.
  /// Secure and idempotent via deterministic ID.
  Future<void> recordEvent(String sessionId, String userId, QuestionResult result);

  /// Admin-side: Fetches aggregates for a specific question version.
  Future<QuestionAnalytics?> getQuestionAnalytics(String questionId, String version);
  
  /// Admin-side: Fetches version history for a question.
  Future<List<QuestionAnalytics>> getQuestionVersionHistory(String questionId);
  
  /// Admin-side: Identifies questions needing review.
  Future<List<QuestionAnalytics>> getReviewSignals({
    double lowAccuracyThreshold = 0.3,
    double highAccuracyThreshold = 0.95,
  });

  /// Legacy/Internal: Directly updates metrics (Admin only).
  Future<void> updateMetrics(QuestionResult result);
}
