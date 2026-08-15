import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

/// Configurable rules for answer submissions.
abstract class AnswerPolicy {
  bool get allowMultipleSubmissions;
  bool get allowRetriesOnWrong;
  bool get lockAfterFirstSubmission;
}

class ProAnswerPolicy implements AnswerPolicy {
  @override
  bool get allowMultipleSubmissions => false;
  @override
  bool get allowRetriesOnWrong => false;
  @override
  bool get lockAfterFirstSubmission => true;
}

class PracticeAnswerPolicy implements AnswerPolicy {
  @override
  bool get allowMultipleSubmissions => false;
  @override
  bool get allowRetriesOnWrong => false;
  @override
  bool get lockAfterFirstSubmission => true;
}

class AnswerPolicyResolver {
  static AnswerPolicy resolve(GameMode mode) {
    switch (mode) {
      case GameMode.practice:
        return PracticeAnswerPolicy();
      case GameMode.pro:
      case GameMode.versus:
      case GameMode.tournament:
      case GameMode.challenge:
      case GameMode.dailyQuiz:
      case GameMode.event:
        return ProAnswerPolicy();
    }
  }
}
