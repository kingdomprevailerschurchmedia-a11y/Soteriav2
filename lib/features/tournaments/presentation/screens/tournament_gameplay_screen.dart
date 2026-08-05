import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/question_presentation/widgets/question_presenter.dart';
import 'package:soteria/features/gameplay_engine/timer/widgets/adaptive_timer_display.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import '../providers/tournament_gameplay_provider.dart';

class TournamentGameplayScreen extends ConsumerWidget {
  final String tournamentId;

  const TournamentGameplayScreen({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameplayState = ref.watch(tournamentGameplayProvider(tournamentId));

    if (gameplayState == TournamentGameplayState.completed) {
      return const SafeGradientScaffold(
        body: Center(child: Text('Tournament Completed! See Leaderboard.')),
      );
    }

    if (gameplayState == TournamentGameplayState.starting) {
      return const SafeGradientScaffold(
        body: Center(child: Text('Get Ready... Tournament Starting!')),
      );
    }

    final config = GameConfiguration(
      mode: GameMode.tournament,
      // The actual values don't matter as much here for selection,
      // but must match the one used in the provider
    );

    final gameState = ref.watch(gameEngineProvider(config));
    final question = gameState.currentQuestion;

    if (question == null)
      return const Center(child: CircularProgressIndicator());

    return SafeGradientScaffold(
      body: Column(
        children: [
          _TournamentGameplayHeader(
            score: gameState.score,
            streak: gameState.streak,
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
  }
}

class _TournamentGameplayHeader extends StatelessWidget {
  final int score;
  final int streak;
  final int questionIndex;
  final int totalQuestions;

  const _TournamentGameplayHeader({
    required this.score,
    required this.streak,
    required this.questionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.lg,
        48.h,
        SoteriaSpacing.lg,
        SoteriaSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'QUESTION $questionIndex / $totalQuestions',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                'Score: $score',
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.md,
              vertical: SoteriaSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: SoteriaColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: SoteriaColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  color: SoteriaColors.primary,
                  size: 16,
                ),
                SizedBox(width: 4.w),
                Text(
                  'STREAK: $streak',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
