import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/domain/services/reward_settlement_service.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/gameplay_engine/domain/config/competitive_reward_config.dart';

void main() {
  late RewardSettlementService service;

  setUp(() {
    service = RewardSettlementService();
  });

  group('Pro Mode Rewards', () {
    test('Example 1: Foundation, 10 questions, 100% accuracy', () {
      final result = GameResult(
        sessionId: 'test_session',
        playerId: 'test_user',
        mode: GameMode.pro,
        finalScore: 1000,
        totalXP: 0,
        totalQuestions: 10,
        correctAnswers: 10,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 2),
        accuracy: 1.0,
        maxStreak: 10,
        timestamp: DateTime.now(),
      );

      final settlement = service.calculateProSettlement(
        settlementId: 'test_settlement',
        result: result,
        difficulty: Difficulty.easy,
        questionCount: 10,
      );

      expect(settlement.coinsWon, 1250);
      expect(settlement.xpEarned, 225);
    });

    test('Example 2: Intermediate, 20 questions, 90% accuracy', () {
      final result = GameResult(
        sessionId: 'test_session',
        playerId: 'test_user',
        mode: GameMode.pro,
        finalScore: 1800,
        totalXP: 0,
        totalQuestions: 20,
        correctAnswers: 18,
        wrongAnswers: 2,
        totalDuration: const Duration(minutes: 4),
        accuracy: 0.9,
        maxStreak: 12,
        timestamp: DateTime.now(),
      );

      final settlement = service.calculateProSettlement(
        settlementId: 'test_settlement',
        result: result,
        difficulty: Difficulty.medium,
        questionCount: 20,
      );

      expect(settlement.coinsWon, 3400);
      expect(settlement.xpEarned, 414);
    });

    test('Example 3: Expert, 50 questions, 100% accuracy', () {
      final result = GameResult(
        sessionId: 'test_session',
        playerId: 'test_user',
        mode: GameMode.pro,
        finalScore: 5000,
        totalXP: 0,
        totalQuestions: 50,
        correctAnswers: 50,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 10),
        accuracy: 1.0,
        maxStreak: 50,
        timestamp: DateTime.now(),
      );

      final settlement = service.calculateProSettlement(
        settlementId: 'test_settlement',
        result: result,
        difficulty: Difficulty.expert,
        questionCount: 50,
      );

      expect(settlement.coinsWon, 125000);
      expect(settlement.xpEarned, 2625);
    });
  });

  group('Versus Mode Rewards', () {
    test('Versus Win: 500 wager, 10 correct, 100% accuracy', () {
      final result = GameResult(
        sessionId: 'vs_session',
        playerId: 'user_a',
        mode: GameMode.versus,
        finalScore: 1000,
        totalXP: 0,
        totalQuestions: 10,
        correctAnswers: 10,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 2),
        accuracy: 1.0,
        maxStreak: 10,
        timestamp: DateTime.now(),
      );

      final settlement = service.calculateVersusSettlement(
        settlementId: 'vs_settlement',
        result: result,
        wagerPerPlayer: 500,
        outcome: VersusOutcome.win,
      );

      // Pot = 1000, Fee = 100, Winner = 900
      expect(settlement.coinsWon, 900);
      expect(settlement.platformFee, 100);
      
      // XP: Win (30) * 10 correct * (1 + 0.35 accuracy bonus) = 300 * 1.35 = 405
      expect(settlement.xpEarned, 405);
    });

    test('Versus Loss: 1000 wager, 5 correct, 50% accuracy', () {
      final result = GameResult(
        sessionId: 'vs_session',
        playerId: 'user_a',
        mode: GameMode.versus,
        finalScore: 500,
        totalXP: 0,
        totalQuestions: 10,
        correctAnswers: 5,
        wrongAnswers: 5,
        totalDuration: const Duration(minutes: 2),
        accuracy: 0.5,
        maxStreak: 3,
        timestamp: DateTime.now(),
      );

      final settlement = service.calculateVersusSettlement(
        settlementId: 'vs_settlement',
        result: result,
        wagerPerPlayer: 1000,
        outcome: VersusOutcome.loss,
      );

      expect(settlement.coinsWon, 0);
      
      // XP: Loss (20) * 5 correct * (1 + 0.0 bonus) = 100
      expect(settlement.xpEarned, 100);
    });
  });

  group('Tournament Rewards', () {
    test('Tournament placement reward settlement', () {
      final result = GameResult(
        sessionId: 'tour_session',
        playerId: 'user_t',
        mode: GameMode.tournament,
        finalScore: 2500,
        totalXP: 0,
        totalQuestions: 20,
        correctAnswers: 20,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 5),
        accuracy: 1.0,
        maxStreak: 20,
        timestamp: DateTime.now(),
      );

      final settlement = service.calculateTournamentSettlement(
        settlementId: 'tour_settlement',
        result: result,
        tournamentId: 'daily_tour_001',
        placement: 1,
        coinsReward: 100000,
        xpReward: 5000,
      );

      expect(settlement.coinsWon, 100000);
      expect(settlement.xpEarned, 5000);
      expect(settlement.tournamentId, 'daily_tour_001');
      expect(settlement.placement, 1);
    });
  });
}
