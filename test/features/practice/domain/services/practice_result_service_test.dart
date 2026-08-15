import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/practice/domain/services/practice_result_service.dart';

void main() {
  group('PracticeResultService', () {
    final mockQuestions = [
      Question(
        id: 'q1',
        text: 'Q1',
        difficulty: Difficulty.easy,
        categoryId: 'science',
        type: QuestionType.multipleChoice,
        options: [],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Test',
      ),
      Question(
        id: 'q2',
        text: 'Q2',
        difficulty: Difficulty.medium,
        categoryId: 'science',
        type: QuestionType.multipleChoice,
        options: [],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Test',
      ),
      Question(
        id: 'q3',
        text: 'Q3',
        difficulty: Difficulty.hard,
        categoryId: 'technology',
        type: QuestionType.multipleChoice,
        options: [],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Test',
      ),
    ];

    test('should calculate accuracy and counts correctly', () {
      final state = GameState(
        sessionId: 'test',
        questions: mockQuestions,
        lifecycle: GameLifecycle.completed,
        answerHistory: [
          AnswerResult(
            submissionId: 's1',
            questionId: 'q1',
            decision: AnswerDecision.correct,
            selectedOptionIds: ['o1'],
            correctOptionIds: ['o1'],
            timestamp: DateTime.now(),
            responseTime: const Duration(seconds: 2),
          ),
          AnswerResult(
            submissionId: 's2',
            questionId: 'q2',
            decision: AnswerDecision.wrong,
            selectedOptionIds: ['o2'],
            correctOptionIds: ['o1'],
            timestamp: DateTime.now(),
            responseTime: const Duration(seconds: 4),
          ),
        ],
        startTime: DateTime.now().subtract(const Duration(minutes: 1)),
      );

      final result = PracticeResultService.calculateResult(state, 'test_user');

      expect(result.totalQuestions, 3);
      expect(result.answeredQuestions, 2);
      expect(result.correctAnswers, 1);
      expect(result.incorrectAnswers, 1);
      expect(result.skippedQuestions, 1);
      expect(result.accuracy, 0.5);
    });

    test('should detect strengths and weaknesses', () {
      final manyScienceQuestions = List.generate(5, (i) => Question(
        id: 'sci_$i',
        text: 'Sci $i',
        difficulty: Difficulty.easy,
        categoryId: 'science',
        type: QuestionType.multipleChoice,
        options: [],
        correctOptionIds: ['o1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Test',
      ));

      final state = GameState(
        sessionId: 'test',
        questions: manyScienceQuestions,
        answerHistory: manyScienceQuestions.map((q) => AnswerResult(
          submissionId: 's_${q.id}',
          questionId: q.id,
          decision: AnswerDecision.correct,
          selectedOptionIds: ['o1'],
          correctOptionIds: ['o1'],
          timestamp: DateTime.now(),
        )).toList(),
      );

      final result = PracticeResultService.calculateResult(state, 'test_user');

      expect(result.metadata['strengths'], contains('science'));
    });
  });
}
