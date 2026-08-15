import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart' as qc;
import 'package:soteria/features/question_content/domain/entities/difficulty.dart' as qc_difficulty;
import 'package:soteria/features/quiz/domain/models/player_answer.dart';
import 'package:soteria/features/quiz/domain/models/scoring_configuration.dart';
import 'package:soteria/features/quiz/domain/services/quiz_scoring_engine.dart';

void main() {
  group('Pro Mode Scoring Tests', () {
    final config = ScoringConfiguration.pro();
    final engine = QuizScoringEngine(config: config);

    final mockQuestion = qc.Question(
      id: 'q1',
      type: qc.QuestionType.multipleChoice,
      categoryId: 'Science',
      difficulty: qc_difficulty.Difficulty.hard,
      text: 'Pro Question?',
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

    test('Pro scoring awards higher base points and multipliers', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o1'],
        isCorrect: true,
        responseTime: const Duration(seconds: 25), // No speed bonus
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 0);

      expect(result.baseScore, equals(450)); // Hard base in Pro
      expect(result.difficultyBonus, equals(450)); // 450 * 2.0 - 450
      expect(result.totalScore, equals(900));
      expect(result.xpEarned, equals(33)); // (15 * 1.5 * 1.5) = 33.75 -> 33
    });

    test('Pro scoring has higher streak bonus', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o1'],
        isCorrect: true,
        responseTime: const Duration(seconds: 25),
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 5); // 5 streak

      expect(result.streakBonus, equals(450)); // 450 * (5 * 0.2) = 450
      expect(result.totalScore, equals(1350)); // 900 + 450
    });

    test('Pro scoring has higher speed bonus threshold and reward', () {
      final answer = PlayerAnswer(
        questionId: 'q1',
        selectedOptionIds: ['o1'],
        isCorrect: true,
        responseTime: const Duration(seconds: 9), // 30% of 30s
        timestamp: DateTime.now(),
      );

      final result = engine.calculate(mockQuestion, answer, 0);

      expect(result.speedBonus, greaterThan(50)); // Max speed bonus is 100 in Pro
      expect(result.totalScore, greaterThan(900));
    });
  });
}
