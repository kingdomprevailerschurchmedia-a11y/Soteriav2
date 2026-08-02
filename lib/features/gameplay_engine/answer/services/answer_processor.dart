import 'package:soteria/features/gameplay_engine/answer/models/answer_submission.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_event.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_policy.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_validator.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_decision_engine.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Coordinates the answer processing pipeline.
class AnswerProcessor {
  final void Function(AnswerEvent) onEvent;

  AnswerProcessor({required this.onEvent});

  AnswerResult? process({
    required AnswerSubmission submission,
    required Question question,
    required GameLifecycle lifecycle,
    required TimerStatus timerStatus,
    required AnswerPolicy policy,
    required bool alreadySubmitted,
  }) {
    onEvent(AnswerSubmitted(submission));

    // 1. Validate
    final error = AnswerValidator.validate(
      submission: submission,
      lifecycle: lifecycle,
      timerStatus: timerStatus,
      alreadySubmitted: alreadySubmitted,
      allowMultipleSubmissions: policy.allowMultipleSubmissions,
    );

    if (error != null) {
      onEvent(AnswerRejected(error, submission));
      return null;
    }

    // 2. Decide
    final result = AnswerDecisionEngine.evaluate(
      submission: submission,
      question: question,
    );

    // 3. Emit
    onEvent(AnswerEvaluated(result));

    return result;
  }
}
