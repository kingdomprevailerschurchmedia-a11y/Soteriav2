import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/progression/models/reward_summary.dart';

void main() {
  group('ProModeResult Unit Tests', () {
    test('calculateRating returns correct grades based on accuracy', () {
      expect(ProModeResult.calculateRating(1.0), 'S');
      expect(ProModeResult.calculateRating(0.95), 'A');
      expect(ProModeResult.calculateRating(0.9), 'A');
      expect(ProModeResult.calculateRating(0.85), 'B');
      expect(ProModeResult.calculateRating(0.8), 'B');
      expect(ProModeResult.calculateRating(0.75), 'C');
      expect(ProModeResult.calculateRating(0.7), 'C');
      expect(ProModeResult.calculateRating(0.65), 'D');
      expect(ProModeResult.calculateRating(0.0), 'D');
    });

    test('toJson and fromJson maintain data integrity', () {
      final now = DateTime.now();
      final result = ProModeResult(
        playerId: 'test-player',
      sessionId: 'test-session',
        mode: GameMode.pro,
        finalScore: 1200,
        totalXP: 200,
        totalQuestions: 10,
        correctAnswers: 8,
        wrongAnswers: 2,
        totalDuration: const Duration(minutes: 2),
        accuracy: 0.8,
        maxStreak: 5,
        rewards: const RewardSummary(baseXP: 100, bonusXP: 50, baseCoins: 40),
        timestamp: now,
        rating: 'B',
      );

      final json = result.toJson();
      final fromJson = ProModeResult.fromJson(json);

      expect(fromJson.sessionId, result.sessionId);
      expect(fromJson.finalScore, result.finalScore);
      expect(fromJson.rating, result.rating);
      expect(fromJson.totalXP, result.totalXP);
      expect(fromJson.rewards.baseCoins, result.rewards.baseCoins);
      expect(fromJson.timestamp.isAtSameMomentAs(now), isTrue);
    });

    test('fromGameResult correctly assigns fields and calculates rating', () {
      final now = DateTime.now();
      final baseResult = GameResult(
        playerId: 'test-player',
      sessionId: 'base-id',
        mode: GameMode.pro,
        finalScore: 1000,
        totalXP: 150,
        totalQuestions: 10,
        correctAnswers: 9,
        wrongAnswers: 1,
        totalDuration: const Duration(minutes: 1),
        accuracy: 0.9,
        maxStreak: 7,
        timestamp: now,
      );

      final proResult = ProModeResult.fromGameResult(baseResult);

      expect(proResult.sessionId, 'base-id');
      expect(proResult.rating, 'A');
      expect(proResult.accuracy, 0.9);
    });
  });
}
