import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/logic/competitive_settlement_engine.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_session.dart';
import 'package:soteria/features/gameplay_engine/models/pro_session_config.dart';
import 'package:soteria/features/gameplay_engine/progression/models/reward_summary.dart';

void main() {
  group('CompetitiveSettlementEngine', () {
    late CompetitiveSession mockSession;

    setUp(() {
      mockSession = CompetitiveSession(
        sessionId: 'test_session',
        uid: 'user_123',
        config: const ProSessionConfig(
          difficulty: ProDifficulty.intermediate,
          questionCount: 10,
          entryFee: 100,
          timerEnabled: true,
        ),
        startTime: DateTime.now(),
        reservedFee: 100,
      );
    });

    test('validateResult returns true for consistent data', () {
      final result = GameResult(
        sessionId: 'test_session',
        mode: GameMode.pro,
        finalScore: 1000,
        totalXP: 500,
        totalQuestions: 10,
        correctAnswers: 10,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 2),
        accuracy: 1.0,
        maxStreak: 10,
        timestamp: DateTime.now(),
      );

      expect(
        CompetitiveSettlementEngine.validateResult(mockSession, result),
        isTrue,
      );
    });

    test('validateResult returns false if question count mismatch', () {
      final result = GameResult(
        sessionId: 'test_session',
        mode: GameMode.pro,
        finalScore: 1000,
        totalXP: 500,
        totalQuestions: 5, // Mismatch
        correctAnswers: 5,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 2),
        accuracy: 1.0,
        maxStreak: 5,
        timestamp: DateTime.now(),
      );

      expect(
        CompetitiveSettlementEngine.validateResult(mockSession, result),
        isFalse,
      );
    });

    test('calculateRewards grants 1.5x coins for 90%+ accuracy', () {
      final result = GameResult(
        sessionId: 'test_session',
        mode: GameMode.pro,
        finalScore: 900,
        totalXP: 450,
        totalQuestions: 10,
        correctAnswers: 9,
        wrongAnswers: 1,
        totalDuration: const Duration(minutes: 2),
        accuracy: 0.9,
        maxStreak: 9,
        timestamp: DateTime.now(),
      );

      final rewards = CompetitiveSettlementEngine.calculateRewards(
        session: mockSession,
        result: result,
      );

      expect(rewards.baseCoins, 150); // 100 * 1.5
    });

    test('calculateRewards grants money back for 70%-89% accuracy', () {
      final result = GameResult(
        sessionId: 'test_session',
        mode: GameMode.pro,
        finalScore: 700,
        totalXP: 350,
        totalQuestions: 10,
        correctAnswers: 7,
        wrongAnswers: 3,
        totalDuration: const Duration(minutes: 2),
        accuracy: 0.7,
        maxStreak: 7,
        timestamp: DateTime.now(),
      );

      final rewards = CompetitiveSettlementEngine.calculateRewards(
        session: mockSession,
        result: result,
      );

      expect(rewards.baseCoins, 100);
    });

    test('calculateRewards grants 0 coins for < 70% accuracy', () {
      final result = GameResult(
        sessionId: 'test_session',
        mode: GameMode.pro,
        finalScore: 500,
        totalXP: 250,
        totalQuestions: 10,
        correctAnswers: 5,
        wrongAnswers: 5,
        totalDuration: const Duration(minutes: 2),
        accuracy: 0.5,
        maxStreak: 5,
        timestamp: DateTime.now(),
      );

      final rewards = CompetitiveSettlementEngine.calculateRewards(
        session: mockSession,
        result: result,
      );

      expect(rewards.baseCoins, 0);
    });
  });
}
