import 'package:soteria/features/gameplay_engine/answer/models/answer_submission.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Pure logic engine that evaluates an answer and calculates rewards.
class AnswerDecisionEngine {
  static AnswerResult evaluate({
    required AnswerSubmission submission,
    required Question question,
  }) {
    final isCorrect = question.areAnswersCorrect(submission.selectedOptionIds);

    // Simplistic XP calculation for now (Story 3.7 will refine this)
    int xp = 0;
    AnswerDecision decision = AnswerDecision.wrong;

    if (isCorrect) {
      decision = AnswerDecision.correct;
      xp = question.xpValue;

      // Speed bonus placeholder
      if (submission.responseTime.inSeconds < 5) {
        xp += 5;
      }
    }

    return AnswerResult(
      submissionId: submission.submissionId,
      questionId: question.id,
      decision: decision,
      correctOptionIds: question.correctAnswers,
      xpEarned: xp,
      timestamp: DateTime.now(),
      metadata: {'responseTimeMs': submission.responseTime.inMilliseconds},
    );
  }
}
