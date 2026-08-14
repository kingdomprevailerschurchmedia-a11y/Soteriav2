import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_presentation/providers/presentation_providers.dart';
import 'package:soteria/features/question_presentation/strategies/rendering_strategy.dart';
import 'package:soteria/features/gameplay_engine/lifelines/providers/lifeline_results_provider.dart';
import 'package:soteria/features/gameplay_engine/lifelines/widgets/audience_chart.dart';
import 'package:soteria/features/gameplay_engine/lifelines/widgets/lifeline_button.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/providers/lifeline_controller.dart';
import 'package:soteria/features/question_presentation/widgets/question_explanation_view.dart';
import 'package:soteria/features/question_presentation/widgets/question_card.dart';
import 'package:soteria/features/gameplay_engine/widgets/gameplay_progress_bar.dart';

import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';

class QuestionPresenter extends ConsumerWidget {
  const QuestionPresenter({
    super.key,
    required this.question,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.sessionId,
    this.timerChild,
    this.gameConfig,
  });

  final Question question;
  final int currentQuestionIndex;
  final int totalQuestions;
  final String sessionId;
  final Widget? timerChild;
  final GameConfiguration? gameConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(answerSelectionProvider);
    final isRevealed = ref.watch(isResultRevealedProvider);
    final lifelineResults = ref.watch(lifelineResultsProvider);
    final lifelineState = ref.watch(lifelineControllerProvider(sessionId));

    final renderer = _getRenderer(question.type);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: GameplayProgressBar(
            current: currentQuestionIndex + 1,
            total: totalQuestions,
            progress: (currentQuestionIndex + 1) / totalQuestions,
          ),
        ),
        SizedBox(height: SoteriaSpacing.lg),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (timerChild != null) timerChild!,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: LifelineType.values.map((type) {
                  final state = lifelineState[type]!;
                  return Padding(
                    padding: EdgeInsets.only(left: SoteriaSpacing.sm),
                    child: LifelineButton(
                      type: type,
                      status: state.status,
                      onTap: () {
                        if (!isRevealed) {
                          ref
                              .read(
                                lifelineControllerProvider(sessionId).notifier,
                              )
                              .activate(type, question);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(SoteriaSpacing.lg),
                child: Column(
                  children: [
                    SizedBox(height: SoteriaSpacing.lg),
                    if (lifelineResults.audienceVotes != null) ...[
                      AudienceChart(votes: lifelineResults.audienceVotes!),
                      SizedBox(height: SoteriaSpacing.xl),
                    ],
                    AnimatedSwitcher(
                      duration: SoteriaAnimations.normal,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(0.05, 0),
                                end: Offset.zero,
                              ),
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: QuestionContentCard(
                        key: ValueKey(question.id),
                        text: question.text,
                        category: question.categoryId,
                        difficulty: question.difficulty.name,
                      ),
                    ),
                    SizedBox(height: SoteriaSpacing.xxl),
                    renderer.buildAnswerArea(
                      question: question,
                      selectedAnswerId: selectedId,
                      isRevealed: isRevealed,
                      onAnswerSelected: isRevealed
                          ? (id) {}
                          : (id) => ref
                                .read(answerSelectionProvider.notifier)
                                .select(id),
                      hiddenOptionIds: lifelineResults.hiddenOptionIds,
                    ),
                    const SizedBox(height: 32),
                    if (!isRevealed && selectedId != null)
                      SoteriaButton.primary(
                        label: 'CONFIRM ANSWER',
                        onPressed: () {
                          ref.read(isResultRevealedProvider.notifier).state =
                              true;
                          if (gameConfig != null) {
                            ref
                                .read(gameEngineProvider(gameConfig!).notifier)
                                .submitAnswer([selectedId]);
                          }
                        },
                      ),
                    SizedBox(height: 120.h), // Space for explanation view
                  ],
                ),
              ),
              if (isRevealed)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: QuestionExplanationView(
                    question: question,
                    onContinue: () {
                      if (gameConfig != null) {
                        ref
                            .read(gameEngineProvider(gameConfig!).notifier)
                            .moveToNextQuestion();
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  QuestionRenderingStrategy _getRenderer(QuestionType type) {
    switch (type) {
      case QuestionType.multipleChoice:
        return MultipleChoiceRenderer();
      case QuestionType.trueFalse:
        return TrueFalseRenderer();
      // Add other types as implemented
      default:
        return MultipleChoiceRenderer();
    }
  }
}
