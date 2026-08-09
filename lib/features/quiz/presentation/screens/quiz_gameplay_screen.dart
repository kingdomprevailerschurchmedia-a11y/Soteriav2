import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/overlays/soteria_dialog.dart';
import '../../../../core/widgets/feedback/soteria_error_widget.dart';
import '../../../../core/design_system/components/soteria_state_views.dart';
import '../../domain/models/quiz_enums.dart';
import '../providers/quiz_providers.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_stats_bar.dart';
import '../widgets/quiz_question_card.dart';
import '../widgets/quiz_answer_option.dart';
import '../widgets/quiz_power_up_bar.dart';

class QuizGameplayScreen extends ConsumerWidget {
  const QuizGameplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizControllerProvider);
    final notifier = ref.read(quizControllerProvider.notifier);

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
        body: _buildBody(context, ref, state, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, state, notifier) {
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

    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.lg),
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
        SizedBox(height: SoteriaSpacing.xl),
        QuizStatsBar(streak: state.streak, timerState: state.timer),
        SizedBox(height: SoteriaSpacing.lg),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                QuizQuestionCard(
                  text: question.text,
                  category: question.category,
                  difficulty: question.difficulty,
                  imageUrl: question.imageUrl,
                ),
                SizedBox(height: SoteriaSpacing.xl),
                ...question.options.map((option) {
                  final letter = _getLetterForIndex(
                    question.options.indexOf(option),
                  );
                  final isSelected = state.selectedOptionId == option.id;
                  final isCorrect = question.correctOptionIds.contains(
                    option.id,
                  );

                  QuizAnswerState answerState = QuizAnswerState.defaultState;

                  if (state.isAnswerLocked) {
                    if (isSelected) {
                      answerState = isCorrect
                          ? QuizAnswerState.correct
                          : QuizAnswerState.incorrect;
                    } else if (isCorrect) {
                      // Reveal correct answer if player was wrong
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
                  );
                }),
                SizedBox(height: SoteriaSpacing.xxl),
              ],
            ),
          ),
        ),
        QuizPowerUpBar(
          powerUps: state.powerUps,
          onPowerUpTap: (type) {
            // Power-up logic in Story 8.7
          },
        ),
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
