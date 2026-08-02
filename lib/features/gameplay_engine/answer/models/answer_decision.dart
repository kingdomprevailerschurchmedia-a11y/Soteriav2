/// Possible outcomes of an answer evaluation.
enum AnswerDecision {
  correct,
  wrong,
  partiallyCorrect,
  skipped,
  timeout,
  cancelled,
  invalid,
}
