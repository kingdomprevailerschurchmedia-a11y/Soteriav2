import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/progression/models/reward_summary.dart';

void main() {
  group('RewardSummary Tests', () {
    test('calculates total XP correctly', () {
      const rewards = RewardSummary(
        baseXP: 100,
        bonusXP: 50,
        streakBonus: 20,
        perfectScoreBonus: 100,
        dailyChallengeBonus: 30,
      );

      expect(rewards.totalXP, 300);
    });

    test('calculates total Coins correctly', () {
      const rewards = RewardSummary(
        baseCoins: 20,
        bonusCoins: 10,
        streakBonus: 20, // (20 ~/ 2) = 10
        perfectScoreBonus: 100, // (100 ~/ 2) = 50
      );

      expect(rewards.totalCoins, 90);
    });
  });
}
