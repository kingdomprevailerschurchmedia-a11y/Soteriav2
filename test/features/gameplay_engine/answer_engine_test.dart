import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_submission.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_validator.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_decision_engine.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  group('AnswerValidator Tests', () {
    final mockSubmission = AnswerSubmission(
      questionId: 'q1',
      selectedOptionIds: ['a'],
      timestamp: DateTime.now(),
      responseTime: const Duration(seconds: 2),
    );

    test('validates correctly in normal conditions', () {
      final error = AnswerValidator.validate(
        submission: mockSubmission,
        lifecycle: GameLifecycle.playing,
        timerStatus: TimerStatus.running,
        alreadySubmitted: false,
        allowMultipleSubmissions: false,
      );
      expect(error, isNull);
    });

    test('rejects when timer expired', () {
      final error = AnswerValidator.validate(
        submission: mockSubmission,
        lifecycle: GameLifecycle.playing,
        timerStatus: TimerStatus.expired,
        alreadySubmitted: false,
        allowMultipleSubmissions: false,
      );
      expect(error, contains('Timer has already expired'));
    });

    test('rejects duplicate when not allowed', () {
      final error = AnswerValidator.validate(
        submission: mockSubmission,
        lifecycle: GameLifecycle.playing,
        timerStatus: TimerStatus.running,
        alreadySubmitted: true,
        allowMultipleSubmissions: false,
      );
      expect(error, contains('Duplicate submission not allowed'));
    });
  });

  group('AnswerDecisionEngine Tests', () {
    final question = Question(
      id: 'q1',
      version: '1',
      text: 'Test?',
      difficulty: Difficulty.easy,
      categoryId: 'C',
      type: QuestionType.multipleChoice,
      options: [
        const Answer(id: 'a', text: 'Ans1'),
        const Answer(id: 'b', text: 'Ans2'),
      ],
      correctOptionIds: ['a'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'S',
      schemaVersion: 1,
      contentHash: 'H',
    );

    test('evaluates correct answer correctly', () {
      final submission = AnswerSubmission(
        questionId: 'q1',
        selectedOptionIds: ['a'],
        timestamp: DateTime.now(),
        responseTime: const Duration(seconds: 2),
      );

      final result = AnswerDecisionEngine.evaluate(
        submission: submission,
        question: question,
      );

      expect(result.decision, AnswerDecision.correct);
      expect(result.xpEarned, greaterThan(0));
    });

    test('evaluates wrong answer correctly', () {
      final submission = AnswerSubmission(
        questionId: 'q1',
        selectedOptionIds: ['b'],
        timestamp: DateTime.now(),
        responseTime: const Duration(seconds: 2),
      );

      final result = AnswerDecisionEngine.evaluate(
        submission: submission,
        question: question,
      );

      expect(result.decision, AnswerDecision.wrong);
      expect(result.xpEarned, 0);
    });
  });
}
