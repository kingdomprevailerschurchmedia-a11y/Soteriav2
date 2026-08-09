import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_status.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_state.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_usage.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_event.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/lifeline_engine.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/fifty_fifty_engine.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/pause_timer_engine.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/ask_audience_engine.dart';
import 'package:soteria/features/gameplay_engine/lifelines/providers/lifeline_results_provider.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

class LifelineController
    extends StateNotifier<Map<LifelineType, LifelineState>> {
  final Map<LifelineType, LifelineEngine> _engines;
  final String sessionId;
  final void Function(LifelineEvent)? onEvent;
  final LifelineResultsNotifier? _resultsNotifier;

  LifelineController({
    required this.sessionId,
    required TimerEngine timerEngine,
    this.onEvent,
    LifelineResultsNotifier? resultsNotifier,
  }) : _resultsNotifier = resultsNotifier,
       _engines = {
         LifelineType.fiftyFifty: FiftyFiftyEngine(),
         LifelineType.pauseTimer: PauseTimerEngine(timerEngine),
         LifelineType.askAudience: AskAudienceEngine(),
       },
       super({
         LifelineType.fiftyFifty: const LifelineState(),
         LifelineType.pauseTimer: const LifelineState(),
         LifelineType.askAudience: const LifelineState(),
       });

  Future<void> activate(LifelineType type, Question question) async {
    final currentState = state[type];
    if (currentState == null ||
        currentState.status != LifelineStatus.available ||
        currentState.remainingUses <= 0) {
      onEvent?.call(
        LifelineRejected(type, 'Lifeline not available or already used.'),
      );
      return;
    }

    onEvent?.call(LifelineActivated(type, question.id));

    try {
      final result = await _engines[type]!.activate(question: question);

      // Update results UI
      if (type == LifelineType.fiftyFifty && result is List<String>) {
        _resultsNotifier?.setHiddenOptions(result);
      } else if (type == LifelineType.askAudience &&
          result is Map<String, double>) {
        _resultsNotifier?.setAudienceVotes(result);
      }

      final newRemaining = currentState.remainingUses - 1;
      state = {
        ...state,
        type: currentState.copyWith(
          remainingUses: newRemaining,
          status: newRemaining > 0
              ? LifelineStatus.available
              : LifelineStatus.used,
        ),
      };

      onEvent?.call(
        LifelineUsageConsumed(
          LifelineUsage(
            sessionId: sessionId,
            type: type,
            timestamp: DateTime.now(),
            questionId: question.id,
            remainingUses: newRemaining,
          ),
        ),
      );

      onEvent?.call(LifelineCompleted(type, result));
    } catch (e) {
      onEvent?.call(LifelineRejected(type, e.toString()));
    }
  }

  void reset() {
    state = {
      LifelineType.fiftyFifty: const LifelineState(),
      LifelineType.pauseTimer: const LifelineState(),
      LifelineType.askAudience: const LifelineState(),
    };
    _resultsNotifier?.reset();
  }
}

final lifelineControllerProvider =
    StateNotifierProvider.family<
      LifelineController,
      Map<LifelineType, LifelineState>,
      String
    >((ref, sessionId) {
      final timer = ref.watch(timerEngineProvider.notifier);
      final results = ref.watch(lifelineResultsProvider.notifier);

      return LifelineController(
        sessionId: sessionId,
        timerEngine: timer,
        resultsNotifier: results,
        onEvent: (event) {
          // Future: Analytics / Logging
        },
      );
    });
