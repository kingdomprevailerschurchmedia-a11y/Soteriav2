import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../models/game_configuration.dart';
import '../providers/game_engine_provider.dart';
import '../providers/competitive_gameplay_providers.dart';
import '../widgets/competitive_header_stats.dart';
import '../../question_presentation/widgets/question_presenter.dart';
import '../timer/widgets/adaptive_timer_display.dart';
import '../timer/providers/timer_engine_provider.dart';

class CompetitivePlayingView extends ConsumerWidget {
  final GameConfiguration config;

  const CompetitivePlayingView({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameEngineProvider(config));
    final rewards = ref.watch(competitiveRewardProvider(config));

    final question = gameState.currentQuestion;
    if (question == null) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.md),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: CompetitiveHeaderStats(
            coinsAtRisk: rewards['coinsAtRisk'],
            potentialReward: rewards['potentialReward'],
            streak: gameState.streak,
          ),
        ),
        Expanded(
          child: QuestionPresenter(
            question: question,
            currentQuestionIndex: gameState.currentQuestionIndex,
            totalQuestions: gameState.questions.length,
            sessionId: gameState.sessionId,
            gameConfig: config,
            timerChild: AdaptiveTimerDisplay(
              state: ref.watch(timerEngineProvider),
              size: 56,
            ),
          ),
        ),
      ],
    );
  }
}
