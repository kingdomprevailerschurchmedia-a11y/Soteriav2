import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/quiz/domain/models/question_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

void main() {
  group('QuestionResult Analytics Fields', () {
    test('QuestionResult preserves categoryId and mode', () {
      final result = QuestionResult(
        questionId: 'q1',
        questionNumber: 1,
        questionText: 'Test?',
        outcome: QuestionOutcome.correct,
        correctOptionIds: ['o1'],
        correctOptionText: 'Ans1',
        responseTime: const Duration(seconds: 1),
        scoreEarned: 100,
        categoryId: 'history',
        mode: GameMode.pro,
      );

      expect(result.categoryId, 'history');
      expect(result.mode, GameMode.pro);
    });

    test('Serialization preserves categoryId and mode', () {
      final result = QuestionResult(
        questionId: 'q1',
        questionNumber: 1,
        questionText: 'Test?',
        outcome: QuestionOutcome.correct,
        correctOptionIds: ['o1'],
        correctOptionText: 'Ans1',
        responseTime: const Duration(seconds: 1),
        scoreEarned: 100,
        categoryId: 'science',
        mode: GameMode.practice,
      );

      final json = result.toJson();
      expect(json['categoryId'], 'science');
      expect(json['mode'], 'practice');

      final fromJson = QuestionResult.fromJson(json);
      expect(fromJson.categoryId, 'science');
      expect(fromJson.mode, GameMode.practice);
    });

    test('Backward compatibility: Handles missing categoryId and mode safely', () {
      final json = {
        'questionId': 'q1',
        'questionNumber': 1,
        'questionText': 'Test?',
        'outcome': 'correct',
        'correctOptionIds': ['o1'],
        'correctOptionText': 'Ans1',
        'responseTime': 1000,
        'scoreEarned': 100,
      };

      final result = QuestionResult.fromJson(json);
      expect(result.categoryId, isNull);
      expect(result.mode, isNull);
    });
  });
}
