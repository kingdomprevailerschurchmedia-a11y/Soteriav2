import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/widgets/game_score_board.dart';
import 'package:soteria/features/gameplay_engine/timer/widgets/adaptive_timer_display.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import 'package:soteria/features/question_presentation/widgets/question_presenter.dart';

class GamePlayingView extends ConsumerWidget {
  final GameConfiguration config;

  const GamePlayingView({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameEngineProvider(config));
    final question = state.currentQuestion;

    if (question == null) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.lg),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: GameScoreBoard(),
        ),
        Expanded(
          child: QuestionPresenter(
            question: question,
            currentQuestionIndex: state.currentQuestionIndex,
            totalQuestions: state.questions.length,
            sessionId: state.sessionId,
            gameConfig: config,
            timerChild: config.questionTimer != null
                ? AdaptiveTimerDisplay(state: ref.watch(timerEngineProvider))
                : null,
          ),
        ),
      ],
    );
  }
}
