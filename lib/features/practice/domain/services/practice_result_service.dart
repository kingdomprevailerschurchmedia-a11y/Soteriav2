import '../../../../features/gameplay_engine/models/game_state.dart';
import '../../../../features/gameplay_engine/models/game_result.dart';
import '../../../../features/gameplay_engine/answer/models/answer_result.dart';
import '../../../../features/gameplay_engine/answer/models/answer_decision.dart';
import '../../../../features/question_content/domain/entities/difficulty.dart';
import '../models/practice_result.dart';
import 'practice_insight_engine.dart';
import 'practice_recommendation_service.dart';

class PracticeResultService {
  /// Finalizes a practice session by calculating detailed results and performance metrics.
  static PracticeResult calculateResult(GameState state, {List<GameResult> history = const []}) {
    final now = DateTime.now();
    final totalQuestions = state.questions.length;
    final answers = state.answerHistory;

    int correct = 0;
    int incorrect = 0;
    int skipped = 0;

    final Map<String, List<bool>> catResults = {};
    final Map<Difficulty, List<bool>> diffResults = {};
    final List<QuestionReviewItem> reviewItems = [];

    for (final question in state.questions) {
      final answer = answers.cast<AnswerResult>().firstWhere(
        (a) => a.questionId == question.id,
        orElse: () => AnswerResult(
          submissionId: 'skipped_${question.id}',
          questionId: question.id,
          decision: AnswerDecision.wrong,
          correctOptionIds: question.correctOptionIds,
          timestamp: DateTime.now(),
        ),
      );

      final isCorrect = answer.isCorrect;
      final isSkipped = answer.selectedOptionIds.isEmpty;

      if (isCorrect) {
        correct++;
      } else if (isSkipped) {
        skipped++;
      } else {
        incorrect++;
      }

      // Track by category
      catResults.putIfAbsent(question.categoryId, () => []).add(isCorrect);
      // Track by difficulty
      diffResults.putIfAbsent(question.difficulty, () => []).add(isCorrect);

      reviewItems.add(QuestionReviewItem(
        questionId: question.id,
        questionText: question.text,
        selectedOptionIds: answer.selectedOptionIds,
        correctOptionIds: question.correctOptionIds,
        isCorrect: isCorrect,
        isSkipped: isSkipped,
        explanation: question.explanation,
        categoryId: question.categoryId,
        difficulty: question.difficulty,
        responseTime: answer.responseTime,
      ));
    }

    final answeredQuestions = correct + incorrect;
    final accuracy = answeredQuestions > 0 ? (correct / answeredQuestions) : 0.0;

    final categoryPerformance = catResults.map((catId, results) {
      final total = results.length;
      final catCorrect = results.where((r) => r).length;
      return MapEntry(
        catId,
        CategoryPerformance(
          categoryId: catId,
          total: total,
          correct: catCorrect,
          accuracy: total > 0 ? (catCorrect / total) : 0.0,
        ),
      );
    });

    final difficultyPerformance = diffResults.map((diff, results) {
      final total = results.where((r) => r).length;
      return MapEntry(diff, results.isNotEmpty ? (total / results.length) : 0.0);
    });

    var result = PracticeResult(
      sessionId: state.sessionId,
      completedAt: now,
      totalQuestions: totalQuestions,
      answeredQuestions: answeredQuestions,
      correctAnswers: correct,
      incorrectAnswers: incorrect,
      skippedQuestions: skipped,
      accuracy: accuracy,
      score: state.score,
      totalTime: state.startTime != null ? now.difference(state.startTime!) : Duration.zero,
      categoryPerformance: categoryPerformance,
      difficultyPerformance: difficultyPerformance,
      reviewItems: reviewItems,
      xpEarned: state.xp,
      performanceMessage: _getPerformanceMessage(accuracy),
    );

    final insights = PracticeInsightEngine.generateInsights(result, history: history);
    result = result.copyWith(insights: insights);

    final recommendation = PracticeRecommendationService.recommendNext(result);
    result = result.copyWith(recommendation: recommendation);

    return result.copyWith(
      metadata: {
        'strengths': _detectStrengths(categoryPerformance),
        'weaknesses': _detectWeaknesses(categoryPerformance),
      },
    );
  }

  static List<String> _detectStrengths(Map<String, CategoryPerformance> performance) {
    return performance.values
        .where((p) => p.total >= 3 && p.accuracy >= 0.8)
        .map((p) => p.categoryId)
        .toList();
  }

  static List<String> _detectWeaknesses(Map<String, CategoryPerformance> performance) {
    return performance.values
        .where((p) => p.total >= 3 && p.accuracy < 0.6)
        .map((p) => p.categoryId)
        .toList();
  }

  static String _getPerformanceMessage(double accuracy) {
    if (accuracy >= 0.95) return 'Exceptional! Mastery achieved.';
    if (accuracy >= 0.85) return 'Excellent work! You have a strong grasp.';
    if (accuracy >= 0.70) return 'Great job! Keep refining your knowledge.';
    if (accuracy >= 0.50) return 'Good progress. A bit more practice will help.';
    return 'Keep practicing! Review your answers to improve.';
  }
}
