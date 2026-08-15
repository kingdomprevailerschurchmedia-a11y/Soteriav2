import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';

void main() {
  group('AnswerResult Version Tests', () {
    test('AnswerResult preserves questionVersion', () {
      final result = AnswerResult(
        submissionId: 's1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['o1'],
        timestamp: DateTime.now(),
        questionVersion: '1.2.3',
      );

      expect(result.questionVersion, '1.2.3');
    });

    test('Serialization preserves questionVersion', () {
      final result = AnswerResult(
        submissionId: 's1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['o1'],
        timestamp: DateTime.parse('2026-08-14T12:00:00Z'),
        questionVersion: '1.2.3',
      );

      final json = result.toJson();
      expect(json['questionVersion'], '1.2.3');

      final fromJson = AnswerResult.fromJson(json);
      expect(fromJson.questionVersion, '1.2.3');
    });

    test('Legacy JSON without questionVersion is handled safely (null)', () {
      final json = {
        'submissionId': 's1',
        'questionId': 'q1',
        'decision': 'correct',
        'selectedOptionIds': ['o1'],
        'correctOptionIds': ['o1'],
        'xpEarned': 10,
        'timestamp': '2026-08-14T12:00:00Z',
        'responseTime': 1500,
        'metadata': {},
      };

      final result = AnswerResult.fromJson(json);
      expect(result.questionVersion, isNull);
    });
  });
}
