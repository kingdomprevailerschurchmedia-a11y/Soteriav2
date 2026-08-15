import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/quiz/domain/models/question_result.dart';

void main() {
  group('QuestionResult Version Tests', () {
    test('QuestionResult preserves questionVersion', () {
      final result = QuestionResult(
        questionId: 'q1',
        questionNumber: 1,
        questionText: 'Test?',
        outcome: QuestionOutcome.correct,
        correctOptionIds: ['o1'],
        correctOptionText: 'Ans1',
        responseTime: const Duration(seconds: 1),
        scoreEarned: 100,
        questionVersion: '2.1.0',
      );

      expect(result.questionVersion, '2.1.0');
    });

    test('Serialization preserves questionVersion', () {
      final result = QuestionResult(
        questionId: 'q1',
        questionNumber: 1,
        questionText: 'Test?',
        outcome: QuestionOutcome.correct,
        correctOptionIds: ['o1'],
        correctOptionText: 'Ans1',
        responseTime: const Duration(seconds: 1),
        scoreEarned: 100,
        questionVersion: '2.1.0',
      );

      final json = result.toJson();
      expect(json['questionVersion'], '2.1.0');

      final fromJson = QuestionResult.fromJson(json);
      expect(fromJson.questionVersion, '2.1.0');
    });

    test('Legacy JSON without questionVersion is handled safely (null)', () {
      final json = {
        'questionId': 'q1',
        'questionNumber': 1,
        'questionText': 'Test?',
        'outcome': 'correct',
        'correctOptionIds': ['o1'],
        'correctOptionText': 'Ans1',
        'responseTime': 1000000,
        'scoreEarned': 100,
      };

      final result = QuestionResult.fromJson(json);
      expect(result.questionVersion, isNull);
    });
  });
}
