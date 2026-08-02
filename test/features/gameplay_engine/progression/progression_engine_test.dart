import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/progression/services/progression_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_event.dart';

void main() {
  group('ProgressionEngine Integration Tests', () {
    final engine = ProgressionEngine();
    final policy = ProProgressionPolicy();

    test('full answer pipeline updates state correctly', () {
      final initial = ProgressSnapshot.initial();
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
      );

      final outcome = engine.processAnswer(
        current: initial,
        answer: result,
        policy: policy,
      );

      expect(outcome.after.score, 100);
      expect(outcome.after.totalXP, 30);
      expect(outcome.after.currentStreak, 1);
      expect(outcome.after.sessionScore, 100);
    });

    test('consecutive answers trigger streak milestones', () {
      var current = ProgressSnapshot.initial();

      // Answer 5 times
      for (int i = 0; i < 5; i++) {
        final result = AnswerResult(
          submissionId: i.toString(),
          questionId: 'q',
          decision: AnswerDecision.correct,
          correctOptionIds: ['a'],
          timestamp: DateTime.now(),
        );
        final outcome = engine.processAnswer(
          current: current,
          answer: result,
          policy: policy,
        );
        current = outcome.after;

        if (i == 4) {
          expect(
            outcome.events.any(
              (e) => e is StreakMilestoneEvent && e.streakCount == 5,
            ),
            true,
          );
        }
      }
    });

    test('level up event is emitted', () {
      final initial = ProgressSnapshot.initial().copyWith(totalXP: 130);
      final result = AnswerResult(
        submissionId: '1',
        questionId: 'q1',
        decision: AnswerDecision.correct,
        correctOptionIds: ['a'],
        timestamp: DateTime.now(),
      );

      final outcome = engine.processAnswer(
        current: initial,
        answer: result,
        policy: policy,
      );

      // totalXP becomes 130 + 30 = 160. Threshold for Level 2 is 150.
      expect(outcome.after.level, greaterThan(1));
      expect(outcome.events.any((e) => e is LevelUpEvent), true);
    });
  });
}
