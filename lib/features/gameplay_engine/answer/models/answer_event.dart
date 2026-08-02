import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_submission.dart';

/// Sealed class for all events related to the Answer Engine.
sealed class AnswerEvent {}

class AnswerSubmitted extends AnswerEvent {
  final AnswerSubmission submission;
  AnswerSubmitted(this.submission);
}

class AnswerEvaluated extends AnswerEvent {
  final AnswerResult result;
  AnswerEvaluated(this.result);
}

class AnswerRejected extends AnswerEvent {
  final String reason;
  final AnswerSubmission submission;
  AnswerRejected(this.reason, this.submission);
}

class QuestionCompleted extends AnswerEvent {
  final String questionId;
  QuestionCompleted(this.questionId);
}
