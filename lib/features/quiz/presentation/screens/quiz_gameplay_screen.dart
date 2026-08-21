import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/overlays/soteria_dialog.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../../../../core/widgets/feedback/soteria_error_widget.dart';
import '../../../../core/design_system/components/soteria_state_views.dart';
import '../../domain/models/quiz_enums.dart';
import '../providers/quiz_providers.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_stats_bar.dart';
import '../widgets/quiz_question_card.dart';
import '../widgets/quiz_answer_option.dart';
import '../widgets/quiz_power_up_bar.dart';
import '../widgets/audience_distribution_overlay.dart';
import '../widgets/score_gain_animation.dart';
import '../../../matchmaking/presentation/widgets/versus_live_scoreboard.dart';
import '../../../matchmaking/presentation/providers/match_lifecycle_providers.dart';

import '../../../../core/utils/soteria_responsive.dart';

class QuizGameplayScreen extends ConsumerWidget {
  const QuizGameplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizControllerProvider);
    final notifier = ref.read(quizControllerProvider.notifier);
    final isShort = SoteriaResponsive.isShortScreen(context);

    ref.listen(quizControllerProvider.select((s) => s.status), (prev, next) {
      if (next == QuizStatus.completed) {
        if (ref.read(activeMatchIdProvider) != null) {
          // Versus Match Orchestrator will handle the transition
          return;
        }
        context.go(SoteriaRoutes.quizResults);
      }
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final bool? shouldExit = await _showExitConfirmation(context);
        if (shouldExit == true && context.mounted) {
          context.pop();
        }
      },
      child: SafeGradientScaffold(
        body: _buildBody(context, ref, state, notifier, isShort),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    state,
    notifier,
    bool isShort,
  ) {
    if (state.isLoading) {
      return const SoteriaLoadingView(message: 'Initializing session...');
    }

    if (state.error != null) {
      return SoteriaErrorWidget(
        message: state.error!,
        onRetry: () => notifier.resetQuiz(),
      );
    }

    if (state.status == QuizStatus.idle) {
      return const SoteriaEmptyView(
        title: 'QUIZ NOT STARTED',
        message: 'Please select a category to begin.',
        icon: Icons.rocket_launch_rounded,
      );
    }

    if (state.questions.isEmpty) {
      return const SoteriaEmptyView(
        title: 'NO QUESTIONS',
        message: 'No questions found for the selected criteria.',
        icon: Icons.help_outline_rounded,
      );
    }

    final question = state.currentQuestion;
    if (question == null) return const SizedBox.shrink();

    final isVersus = ref.watch(activeMatchIdProvider) != null;

    return Stack(
      children: [
        Column(
          children: [
            if (isVersus) const VersusLiveScoreboard(),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
            ),
            QuizHeader(
              currentQuestion: state.currentIndex + 1,
              totalQuestions: state.questions.length,
              score: state.score,
              onExit: () async {
                final bool? shouldExit = await _showExitConfirmation(context);
                if (shouldExit == true && context.mounted) {
                  context.pop();
                }
              },
            ),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
            ),
            QuizStatsBar(
              streak: state.streak,
              xp: state.xp,
              timerState: state.timer,
              powerUpTimerState: state.powerUpTimer,
            ),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: SoteriaSpacing.containerPadding(context),
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    QuizQuestionCard(
                      text: question.text,
                      category: question.category,
                      difficulty: question.difficulty,
                      imageUrl: question.imageUrl,
                    ),
                    if (state.audienceDistribution.isNotEmpty) ...[
                      SizedBox(
                        height: SoteriaSpacing.adaptive(
                          context,
                          SoteriaSpacing.mdStatic,
                        ),
                      ),
                      AudienceDistributionOverlay(
                        distribution: state.audienceDistribution,
                        optionLetters: {
                          for (var i = 0; i < question.options.length; i++)
                            question.options[i].id: _getLetterForIndex(i),
                        },
                      ),
                    ],
                    SizedBox(
                      height: SoteriaSpacing.adaptive(
                        context,
                        SoteriaSpacing.lgStatic,
                      ),
                    ),
                    ...question.options.map((option) {
                      final index = question.options.indexOf(option);
                      final letter = _getLetterForIndex(index);
                      final isSelected = state.selectedOptionId == option.id;
                      final isCorrect = question.correctOptionIds.contains(
                        option.id,
                      );
                      final isHidden = state.hiddenOptionIds.contains(
                        option.id,
                      );

                      QuizAnswerState answerState =
                          QuizAnswerState.defaultState;

                      if (state.isAnswerLocked) {
                        if (isSelected) {
                          answerState = isCorrect
                              ? QuizAnswerState.correct
                              : QuizAnswerState.incorrect;
                        } else if (isCorrect) {
                          answerState = QuizAnswerState.correct;
                        } else {
                          answerState = QuizAnswerState.disabled;
                        }
                      }

                      return QuizAnswerOption(
                        letter: letter,
                        text: option.text,
                        state: answerState,
                        onTap: () => notifier.selectAnswer(option.id),
                        isHidden: isHidden,
                      );
                    }),
                    SizedBox(
                      height: SoteriaSpacing.adaptive(
                        context,
                        SoteriaSpacing.xlStatic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            QuizPowerUpBar(
              powerUps: state.powerUps,
              onPowerUpTap: (type) => notifier.activatePowerUp(type),
              isLocked:
                  state.isAnswerLocked || state.status != QuizStatus.active,
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
        const Align(alignment: Alignment(0, -0.2), child: ScoreGainAnimation()),
      ],
    );
  }

  String _getLetterForIndex(int index) {
    return String.fromCharCode(65 + index); // A, B, C, D...
  }

  Future<bool?> _showExitConfirmation(BuildContext context) {
    return SoteriaDialog.show(
      context,
      title: 'EXIT QUIZ?',
      message: 'Your current progress and score will be lost.',
      confirmLabel: 'EXIT QUIZ',
      cancelLabel: 'CANCEL',
      isDestructive: true,
      icon: Icons.warning_amber_rounded,
      iconColor: SoteriaColors.error,
    );
  }
}
