import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/progression/services/xp_manager.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';

void main() {
  group('XPManager Tests', () {
    final policy = ProProgressionPolicy();

    test('correct answer gives XP with multiplier', () {
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
      );

      final xp = XPManager.calculateXPDelta(result: result, policy: policy);

      // xpPerCorrect(20) * xpMultiplier(1.5) = 30
      expect(xp, 30);
    });

    test('wrong answer gives no XP', () {
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.wrong,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
      );

      final xp = XPManager.calculateXPDelta(result: result, policy: policy);

      expect(xp, 0);
    });

    test('perfect round bonus is applied', () {
      final bonus = XPManager.calculateRoundBonus(
        totalQuestions: 10,
        correctAnswers: 10,
        policy: policy,
      );

      // completion(50) + perfect(100) = 150
      expect(bonus, 150);
    });
  });
}
