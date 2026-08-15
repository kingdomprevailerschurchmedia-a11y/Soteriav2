import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/goal.dart';
import 'package:soteria/features/player/domain/models/milestone.dart';
import 'package:soteria/features/player/domain/models/xp_transaction.dart';
import 'package:soteria/features/player/domain/services/progression_reward_service.dart';

void main() {
  late ProgressionRewardService service;

  setUp(() {
    service = ProgressionRewardService();
  });

  group('ProgressionRewardService', () {
    const userId = 'u1';

    test('should create XP transaction for completed goal with XP reward', () {
      final goal = PlayerGoal(
        goalId: 'daily_games_3',
        userId: userId,
        status: GoalStatus.completed,
        currentProgress: 3,
        startedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 1)),
      );

      final transaction = service.processGoalReward(
        userId: userId,
        goalId: 'daily_games_3_123',
        goalState: goal,
      );

      expect(transaction, isNotNull);
      expect(transaction!.amount, 250);
      expect(transaction.source, XpSource.goal);
      expect(transaction.referenceId, 'daily_games_3_123');
    });

    test('should return null if goal reward already claimed', () {
      final goal = PlayerGoal(
        goalId: 'daily_games_3',
        userId: userId,
        status: GoalStatus.claimed,
        currentProgress: 3,
        startedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 1)),
        claimedAt: DateTime.now(),
      );

      final transaction = service.processGoalReward(
        userId: userId,
        goalId: 'daily_games_3_123',
        goalState: goal,
      );

      expect(transaction, isNull);
    });

    test('should create XP transaction for completed milestone with XP reward', () {
      final milestone = PlayerMilestone(
        userId: userId,
        milestoneId: 'level_10',
        status: MilestoneStatus.completed,
        currentProgress: 10,
      );

      final transaction = service.processMilestoneReward(
        userId: userId,
        milestoneId: 'level_10',
        milestoneState: milestone,
      );

      expect(transaction, isNotNull);
      expect(transaction!.amount, 1000);
      expect(transaction.source, XpSource.milestone);
      expect(transaction.referenceId, 'level_10');
    });

    test('should return null if milestone reward already claimed', () {
      final milestone = PlayerMilestone(
        userId: userId,
        milestoneId: 'level_10',
        status: MilestoneStatus.claimed,
        currentProgress: 10,
        claimedAt: DateTime.now(),
      );

      final transaction = service.processMilestoneReward(
        userId: userId,
        milestoneId: 'level_10',
        milestoneState: milestone,
      );

      expect(transaction, isNull);
    });
  });
}
