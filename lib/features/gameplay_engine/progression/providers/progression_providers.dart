import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_event.dart';
import 'package:soteria/features/gameplay_engine/progression/services/progression_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';

/// Notifier for managing the global progression state.
class ProgressionNotifier extends StateNotifier<ProgressSnapshot> {
  final ProgressionEngine _engine;
  final Function(ProgressionEvent)? _onEvent;

  ProgressionNotifier({
    required ProgressionEngine engine,
    Function(ProgressionEvent)? onEvent,
  }) : _engine = engine,
       _onEvent = onEvent,
       super(ProgressSnapshot.initial());

  /// Updates progression based on a question result.
  void handleAnswer(AnswerResult result, ProgressionPolicy policy) {
    final outcome = _engine.processAnswer(
      current: state,
      answer: result,
      policy: policy,
    );

    state = outcome.after;

    for (final event in outcome.events) {
      _onEvent?.call(event);
    }
  }

  /// Updates progression based on round completion.
  void handleRoundEnd(
    int totalQuestions,
    int correctAnswers,
    ProgressionPolicy policy,
  ) {
    final outcome = _engine.processRoundEnd(
      current: state,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      policy: policy,
    );

    state = outcome.after;

    for (final event in outcome.events) {
      _onEvent?.call(event);
    }
  }

  /// Manual reset for testing or session start if needed.
  void resetSession() {
    state = state.copyWith(sessionScore: 0, sessionStreak: 0);
  }
}

/// Provider for the Level Engine logic.
final levelEngineProvider = Provider<LevelEngine>((ref) => LevelEngine());

/// Provider for the Progression Engine orchestrator.
final progressionEngineProvider = Provider<ProgressionEngine>((ref) {
  final levelEngine = ref.watch(levelEngineProvider);
  return ProgressionEngine(levelEngine: levelEngine);
});

/// Central provider for player progression state.
final progressionProvider =
    StateNotifierProvider<ProgressionNotifier, ProgressSnapshot>((ref) {
      final engine = ref.watch(progressionEngineProvider);
      return ProgressionNotifier(
        engine: engine,
        onEvent: (event) {
          // Future: Hook into Analytics or Global UI Feedback (Snackbars/Toasts)
        },
      );
    });

/// Computed provider for current score.
final scoreProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).score,
);

/// Computed provider for current XP.
final xpProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).totalXP,
);

/// Computed provider for current level.
final levelProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).level,
);

/// Computed provider for current streak.
final streakProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).currentStreak,
);

/// Computed provider for level progress percentage.
final levelProgressProvider = Provider<double>((ref) {
  final snapshot = ref.watch(progressionProvider);
  final engine = ref.watch(levelEngineProvider);
  return engine.calculateLevelProgress(snapshot.totalXP);
});
