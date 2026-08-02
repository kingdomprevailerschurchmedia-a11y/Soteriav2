import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/lifeline_engine.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

class PauseTimerEngine implements LifelineEngine {
  final TimerEngine _timerEngine;

  PauseTimerEngine(this._timerEngine);

  @override
  LifelineType get type => LifelineType.pauseTimer;

  @override
  Future<void> activate({
    required Question question,
    Map<String, dynamic>? context,
  }) async {
    final duration = context?['duration'] as Duration?;
    await _timerEngine.triggerPauseLifeline(duration);
  }
}
