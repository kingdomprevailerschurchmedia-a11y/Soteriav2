import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';
import 'package:soteria/features/player/domain/services/reward_eligibility_service.dart';

void main() {
  late RewardEligibilityService service;

  setUp(() {
    service = RewardEligibilityService();
  });

  group('RewardEligibilityService', () {
    final result = SeasonResult(
      seasonId: 'season_5',
      userId: 'user_1',
      seasonName: 'Season 5',
      seasonNumber: 5,
      finalPosition: 10,
      finalRankPoints: 3000,
      finalTier: 'Diamond',
      finalDivision: 1,
      previousTier: 'Platinum',
      previousDivision: 1,
      rankChange: 500,
      completedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('should be eligible for top 10 reward', () {
      final definition = SeasonRewardDefinition(
        rewardId: 'top_10',
        seasonId: 'season_5',
        name: 'Top 10',
        description: 'Top 10 players',
        type: RewardType.coins,
        amount: 1000,
        minimumPosition: 10,
      );

      final eligible = service.determineEligibility(
        result: result,
        definitions: [definition],
      );

      expect(eligible, contains(definition));
    });

    test('should NOT be eligible for top 5 reward if position is 10', () {
      final definition = SeasonRewardDefinition(
        rewardId: 'top_5',
        seasonId: 'season_5',
        name: 'Top 5',
        description: 'Top 5 players',
        type: RewardType.coins,
        amount: 2000,
        minimumPosition: 5,
      );

      final eligible = service.determineEligibility(
        result: result,
        definitions: [definition],
      );

      expect(eligible, isEmpty);
    });

    test('should be eligible for rank-based reward', () {
      final definition = SeasonRewardDefinition(
        rewardId: 'diamond_reward',
        seasonId: 'season_5',
        name: 'Diamond Tier',
        description: 'Diamond tier players',
        type: RewardType.badge,
        amount: 1,
        minimumRank: 'Diamond',
      );

      final eligible = service.determineEligibility(
        result: result,
        definitions: [definition],
      );

      expect(eligible, contains(definition));
    });

    test('should be eligible for participation reward', () {
      final definition = SeasonRewardDefinition(
        rewardId: 'participation',
        seasonId: 'season_5',
        name: 'Participation',
        description: 'Participated in season',
        type: RewardType.xp,
        amount: 500,
        participationRequired: true,
      );

      final eligible = service.determineEligibility(
        result: result,
        definitions: [definition],
      );

      expect(eligible, contains(definition));
    });
  });
}
