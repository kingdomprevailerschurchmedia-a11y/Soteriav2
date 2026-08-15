import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/question_presentation/widgets/question_presenter.dart';
import 'package:soteria/features/gameplay_engine/timer/widgets/adaptive_timer_display.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import '../providers/event_providers.dart';
import '../../domain/models/live_event.dart';
import '../../domain/models/event_participation.dart';
import '../widgets/event/event_status_badge.dart';
import '../widgets/event/event_countdown.dart';
import '../widgets/event/event_reward_card.dart';

class EventGameplayScreen extends ConsumerWidget {
  final String eventId;

  const EventGameplayScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailsProvider(eventId));

    return eventAsync.when(
      data: (event) {
        if (event == null) return const Center(child: Text('Event not found'));

        final config = GameConfiguration(
          mode: GameMode.event,
          categoryId: event.category,
        );

        final gameState = ref.watch(gameEngineProvider(config));
        
        // Listen for game completion
        ref.listen<GameState>(gameEngineProvider(config), (prev, next) {
          if (next.lifecycle == GameLifecycle.completed) {
            ref.read(eventControllerProvider.notifier).submitScore(eventId, next.score);
            context.go('/app/events/result/$eventId?score=${next.score}');
          }
        });

        final question = gameState.currentQuestion;

        if (question == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeGradientScaffold(
          body: Column(
            children: [
              _EventGameplayHeader(
                title: event.title,
                score: gameState.score,
                questionIndex: gameState.currentQuestionIndex + 1,
                totalQuestions: gameState.questions.length,
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
          ),
        );
      },
      loading: () => const SafeGradientScaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, __) => Center(child: Text('Error: $e')),
    );
  }
}

class _EventGameplayHeader extends StatelessWidget {
  final String title;
  final int score;
  final int questionIndex;
  final int totalQuestions;

  const _EventGameplayHeader({
    required this.title,
    required this.score,
    required this.questionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: const BoxDecoration(
        color: SoteriaColors.surface,
        border: Border(bottom: BorderSide(color: SoteriaColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'QUESTION $questionIndex / $totalQuestions',
                style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'SCORE',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                score.toString(),
                style: context.headlineSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
