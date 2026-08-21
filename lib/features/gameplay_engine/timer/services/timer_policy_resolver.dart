import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_policy.dart';

class TimerPolicyResolver implements TimerPolicy {
  @override
  Duration getDuration({
    required GameMode mode,
    required Difficulty difficulty,
    double accessibilityMultiplier = 1.0,
  }) {
    int baseSeconds = 15;

    switch (mode) {
      case GameMode.practice:
        baseSeconds = 60;
        break;
      case GameMode.pro:
      case GameMode.versus:
      case GameMode.tournament:
        baseSeconds = 15;
        break;
      default:
        baseSeconds = 15;
    }

    final finalMilliseconds = (baseSeconds * 1000 * accessibilityMultiplier)
        .toInt();
    return Duration(milliseconds: finalMilliseconds);
  }
}
