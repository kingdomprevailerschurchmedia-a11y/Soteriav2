import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
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
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
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
    this.onClose,
  });

  final Question question;
  final int currentQuestionIndex;
  final int totalQuestions;
  final String sessionId;
  final Widget? timerChild;
  final GameConfiguration? gameConfig;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(answerSelectionProvider);
    final isRevealed = ref.watch(isResultRevealedProvider);
    final showExplanation = ref.watch(showExplanationProvider);
    final lifelineResults = ref.watch(lifelineResultsProvider);
    final lifelineState = ref.watch(lifelineControllerProvider(sessionId));

    final renderer = _getRenderer(question.type);
    final modeName = gameConfig?.mode == GameMode.pro ? 'Pro Mode' : 'Practice Mode';
    final modeSubtitle = gameConfig?.mode == GameMode.pro 
        ? 'High stakes. Professional integrity.' 
        : 'Sharpen your knowledge';

    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            child: Column(
              children: [
                SizedBox(height: SoteriaSpacing.sm),
                // Header: X button, Title, Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: onClose ?? () => Navigator.of(context).pop(),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome, color: SoteriaColors.secondary, size: 14),
                            SizedBox(width: 8.w),
                            Text(
                              modeName.toUpperCase(),
                              style: context.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            const Icon(Icons.auto_awesome, color: SoteriaColors.secondary, size: 14),
                          ],
                        ),
                        Text(
                          modeSubtitle,
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.muted,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    // Timer slot
                    if (timerChild != null) 
                      timerChild!
                    else 
                      SizedBox(width: 48.w), // Spacer to balance header
                  ],
                ),
                SizedBox(height: SoteriaSpacing.lg),
                // Progress Bar
                GameplayProgressBar(
                  current: currentQuestionIndex + 1,
                  total: totalQuestions,
                  progress: (currentQuestionIndex + 1) / totalQuestions,
                ),
                SizedBox(height: SoteriaSpacing.xl),
                // Lifelines Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: LifelineType.values.map((type) {
                    final state = lifelineState[type]!;
                    return LifelineButton(
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
                    );
                  }).toList(),
                ),
                SizedBox(height: SoteriaSpacing.lg),
                // Question Card & Answers
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (lifelineResults.audienceVotes != null) ...[
                        AudienceChart(votes: lifelineResults.audienceVotes!),
                        SizedBox(height: SoteriaSpacing.lg),
                      ],
                      AnimatedSwitcher(
                        duration: SoteriaAnimations.normal,
                        child: QuestionContentCard(
                          key: ValueKey(question.id),
                          text: question.text,
                          category: question.categoryId,
                          difficulty: question.difficulty.name,
                        ),
                      ),
                      SizedBox(height: SoteriaSpacing.lg),
                      renderer.buildAnswerArea(
                        question: question,
                        selectedAnswerId: selectedId,
                        isRevealed: isRevealed,
                        onAnswerSelected: isRevealed
                            ? (id) {}
                            : (id) async {
                                ref.read(answerSelectionProvider.notifier).select(id);
                                ref.read(isResultRevealedProvider.notifier).state =
                                    true;
                                
                                if (gameConfig != null) {
                                  ref
                                      .read(gameEngineProvider(gameConfig!).notifier)
                                      .submitAnswer([id]);
                                }

                                // Delay the explanation to allow user to see the result
                                await Future.delayed(const Duration(milliseconds: 1500));
                                if (context.mounted) {
                                  ref.read(showExplanationProvider.notifier).state = true;
                                }
                              },
                        hiddenOptionIds: lifelineResults.hiddenOptionIds,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SoteriaSpacing.lg),
              ],
            ),
          ),
          if (showExplanation)
            Align(
              alignment: Alignment.bottomCenter,
              child: QuestionExplanationView(
                question: question,
                onContinue: () {
                  ref.read(showExplanationProvider.notifier).state = false;
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
