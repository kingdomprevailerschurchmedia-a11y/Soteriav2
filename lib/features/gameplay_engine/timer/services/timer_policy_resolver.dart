import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_policy.dart';

class TimerPolicyResolver implements TimerPolicy {
  @override
  Duration getDuration({
    required GameMode mode,
    required QuestionDifficulty difficulty,
    double accessibilityMultiplier = 1.0,
  }) {
    int baseSeconds = 15;

    switch (mode) {
      case GameMode.practice:
        baseSeconds = _getPracticeSeconds(difficulty);
        break;
      case GameMode.pro:
        baseSeconds = _getProSeconds(difficulty);
        break;
      default:
        baseSeconds = 15;
    }

    final finalMilliseconds = (baseSeconds * 1000 * accessibilityMultiplier)
        .toInt();
    return Duration(milliseconds: finalMilliseconds);
  }

  int _getPracticeSeconds(QuestionDifficulty difficulty) {
    switch (difficulty) {
      case QuestionDifficulty.easy:
        return 20;
      case QuestionDifficulty.medium:
        return 18;
      case QuestionDifficulty.hard:
        return 15;
      case QuestionDifficulty.expert:
        return 12;
      case QuestionDifficulty.adaptive:
        return 20;
    }
  }

  int _getProSeconds(QuestionDifficulty difficulty) {
    switch (difficulty) {
      case QuestionDifficulty.easy:
        return 15;
      case QuestionDifficulty.medium:
        return 12;
      case QuestionDifficulty.hard:
        return 10;
      case QuestionDifficulty.expert:
        return 8;
      case QuestionDifficulty.adaptive:
        return 15;
    }
  }
}
