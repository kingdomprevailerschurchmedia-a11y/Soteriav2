import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart' as qc;
import 'package:soteria/features/question_content/domain/entities/difficulty.dart' as qc_difficulty;
import 'package:soteria/features/quiz/domain/models/player_answer.dart';
import 'package:soteria/features/quiz/domain/models/scoring_configuration.dart';
import 'package:soteria/features/quiz/domain/services/quiz_scoring_engine.dart';
import 'package:soteria/features/quiz/domain/models/answer_option.dart';

void main() {
  group('QuizScoringEngine Tests', () {
    final config = ScoringConfiguration.standard();
    final engine = QuizScoringEngine(config: config);

    final mockQuestion = qc.Question(
      id: 'q1',
      type: qc.QuestionType.multipleChoice,
      categoryId: 'Science',
      difficulty: qc_difficulty.Difficulty.medium,
      text: 'Test?',
      options: [
        const qc.Answer(id: 'o1', text: 'Ans1'),
        const qc.Answer(id: 'o2', text: 'Ans2'),
      ],
      correctOptionIds: ['o1'],
      estimatedTime: const Duration(seconds: 30),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Internal',
    );

    test('Correct answer awards base score + difficulty bonus', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o1'],
        isCorrect: true,
        responseTime: const Duration(
          seconds: 20,
        ), // > 50% of 30s, no speed bonus
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 0);

      expect(result.baseScore, equals(200)); // Medium base
      expect(result.difficultyBonus, equals(40)); // 200 * 1.2 - 200
      expect(result.speedBonus, equals(0));
      expect(result.totalScore, equals(240));
    });

    test('Fast correct answer awards speed bonus', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o1'],
        isCorrect: true,
        responseTime: const Duration(seconds: 5), // < 15s (50% of 30s)
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 0);

      expect(result.speedBonus, greaterThan(0));
      expect(result.totalScore, greaterThan(240));
    });

    test('Correct answer with streak awards streak bonus', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o1'],
        isCorrect: true,
        responseTime: const Duration(seconds: 20),
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 5); // 5 streak

      expect(result.streakBonus, equals(100)); // 200 * (5 * 0.1)
      expect(result.totalScore, equals(340)); // 200 + 40 + 0 + 100
    });

    test('Incorrect answer awards zero points', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o2'],
        isCorrect: false,
        responseTime: const Duration(seconds: 5),
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 10);

      expect(result.totalScore, equals(0));
      expect(result.xpEarned, equals(0));
    });

    test('Timed out answer awards zero points', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: [],
        isCorrect: false,
        isTimedOut: true,
        responseTime: const Duration(seconds: 30),
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 10);

      expect(result.totalScore, equals(0));
    });

    test('Streak updates correctly', () {
      final correct = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o1'],
        isCorrect: true,
        responseTime: const Duration(seconds: 5),
        timestamp: DateTime.now(),
      );

      final incorrect = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o2'],
        isCorrect: false,
        responseTime: const Duration(seconds: 5),
        timestamp: DateTime.now(),
      );

      expect(engine.calculateNewStreak(5, correct), equals(6));
      expect(engine.calculateNewStreak(5, incorrect), equals(0));
    });
  });
}
