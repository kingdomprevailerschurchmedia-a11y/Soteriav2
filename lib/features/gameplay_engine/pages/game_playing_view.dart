import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/timer/widgets/adaptive_timer_display.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import 'package:soteria/features/question_presentation/widgets/question_presenter.dart';

import 'package:soteria/features/gameplay_engine/widgets/gameplay_header_stats.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';

class GamePlayingView extends ConsumerWidget {
  final GameConfiguration config;

  const GamePlayingView({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = ref.watch(
      gameEngineProvider(config).select((s) => s.currentQuestion),
    );
    final score = ref.watch(gameEngineProvider(config).select((s) => s.score));
    final sessionId = ref.watch(
      gameEngineProvider(config).select((s) => s.sessionId),
    );
    final currentIndex = ref.watch(
      gameEngineProvider(config).select((s) => s.currentQuestionIndex),
    );
    final totalQuestions = ref.watch(
      gameEngineProvider(config).select((s) => s.questions.length),
    );

    final progressionXP = ref.watch(
      progressionProvider.select((s) => s.totalXP),
    );
    final sessionScore = ref.watch(
      progressionProvider.select((s) => s.sessionScore),
    );

    if (question == null) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GameplayHeaderStats(
            score: score,
            xp: progressionXP,
            coins: sessionScore ~/ 10,
          ),
        ),
        Expanded(
          child: QuestionPresenter(
            question: question,
            currentQuestionIndex: currentIndex,
            totalQuestions: totalQuestions,
            sessionId: sessionId,
            gameConfig: config,
            timerChild: config.showTimer
                ? AdaptiveTimerDisplay(state: ref.watch(timerEngineProvider))
                : null,
          ),
        ),
      ],
    );
  }
}
