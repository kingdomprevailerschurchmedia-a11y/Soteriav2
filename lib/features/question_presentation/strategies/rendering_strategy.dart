import 'package:flutter/material.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_presentation/widgets/answer_card.dart';
import 'package:soteria/features/question_presentation/providers/presentation_providers.dart';

/// Strategy for rendering different question types.
abstract class QuestionRenderingStrategy {
  Widget buildAnswerArea({
    required Question question,
    required String? selectedAnswerId,
    required bool isRevealed,
    required Function(String) onAnswerSelected,
    List<String> hiddenOptionIds = const [],
  });
}

class MultipleChoiceRenderer extends QuestionRenderingStrategy {
  @override
  Widget buildAnswerArea({
    required Question question,
    required String? selectedAnswerId,
    required bool isRevealed,
    required Function(String) onAnswerSelected,
    List<String> hiddenOptionIds = const [],
  }) {
    return Column(
      children: List.generate(question.options.length, (index) {
        final answer = question.options[index];

        if (hiddenOptionIds.contains(answer.id)) {
          return const SizedBox.shrink();
        }

        final isSelected = selectedAnswerId == answer.id;
        final isCorrect =
            isRevealed && question.correctOptionIds.contains(answer.id);
        final isWrong =
            isRevealed &&
            isSelected &&
            !question.correctOptionIds.contains(answer.id);

        AnswerVisualState visualState = AnswerVisualState.normal;
        if (isCorrect) {
          visualState = AnswerVisualState.correct;
        } else if (isWrong) {
          visualState = AnswerVisualState.wrong;
        } else if (isSelected) {
          visualState = isRevealed
              ? AnswerVisualState.locked
              : AnswerVisualState.selected;
        } else if (isRevealed) {
          visualState = AnswerVisualState.locked;
        }

        return AnswerCard(
          prefix: String.fromCharCode(65 + index), // A, B, C, D...
          text: answer.text,
          visualState: visualState,
          onTap: () => onAnswerSelected(answer.id),
        );
      }),
    );
  }
}

class TrueFalseRenderer extends QuestionRenderingStrategy {
  @override
  Widget buildAnswerArea({
    required Question question,
    required String? selectedAnswerId,
    required bool isRevealed,
    required Function(String) onAnswerSelected,
    List<String> hiddenOptionIds = const [],
  }) {
    // Similar to Multiple Choice but usually just 2 options
    return MultipleChoiceRenderer().buildAnswerArea(
      question: question,
      selectedAnswerId: selectedAnswerId,
      isRevealed: isRevealed,
      onAnswerSelected: onAnswerSelected,
      hiddenOptionIds: hiddenOptionIds,
    );
  }
}
