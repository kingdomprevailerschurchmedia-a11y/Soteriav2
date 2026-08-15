import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_submission.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_decision_engine.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  test('AnswerDecisionEngine.evaluate copies question version', () {
    final question = Question(
      id: 'q1',
      text: 'Test?',
      difficulty: Difficulty.easy,
      categoryId: 'cat1',
      type: QuestionType.multipleChoice,
      options: [
        const Answer(id: 'o1', text: 'Ans1'),
      ],
      correctOptionIds: ['o1'],
      version: '3.4.5',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Test',
    );

    final submission = AnswerSubmission(
      questionId: 'q1',
      selectedOptionIds: ['o1'],
      timestamp: DateTime.now(),
      responseTime: const Duration(seconds: 2),
    );

    final result = AnswerDecisionEngine.evaluate(
      submission: submission,
      question: question,
    );

    expect(result.questionVersion, '3.4.5');
  });
}
