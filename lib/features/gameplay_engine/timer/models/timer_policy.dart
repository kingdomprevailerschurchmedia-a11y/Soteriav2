import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

abstract class TimerPolicy {
  Duration getDuration({
    required GameMode mode,
    required Difficulty difficulty,
    double accessibilityMultiplier = 1.0,
  });
}
