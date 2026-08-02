import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/progression/services/score_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';

void main() {
  group('ScoreEngine Tests', () {
    final policy = ProProgressionPolicy();

    test('correct answer gives base points', () {
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
      );

      final score = ScoreEngine.calculateDelta(
        result: result,
        policy: policy,
        currentStreak: 0,
      );

      expect(score, 100);
    });

    test('streak increases score', () {
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
      );

      final score = ScoreEngine.calculateDelta(
        result: result,
        policy: policy,
        currentStreak: 5,
      );

      // 100 base + (100 * 5 * 0.1) = 150
      expect(score, 150);
    });

    test('speed bonus adds points', () {
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
        metadata: {'responseTimeMs': 500},
      );

      final score = ScoreEngine.calculateDelta(
        result: result,
        policy: policy,
        currentStreak: 0,
      );

      // 100 base + 50 speed bonus
      expect(score, 150);
    });

    test('wrong answer returns zero or negative based on policy', () {
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.wrong,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
      );

      final score = ScoreEngine.calculateDelta(
        result: result,
        policy: policy,
        currentStreak: 0,
      );

      expect(score, 0);
    });
  });
}
