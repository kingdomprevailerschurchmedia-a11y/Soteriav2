import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/models/versus_match.dart';
import '../domain/models/competitive_match_result.dart';
import '../presentation/providers/match_lifecycle_providers.dart';
import '../presentation/providers/match_result_providers.dart';
import '../presentation/screens/versus_match_orchestrator.dart';
import '../presentation/screens/competitive_match_result_screen.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

class MatchLifecyclePreviews {
  static Widget ready() => ProviderScope(
    overrides: [
      activeMatchIdProvider.overrideWith((ref) => 'm1'),
      activeMatchProvider.overrideWith((ref) => Stream.value(
        VersusMatch(
          matchId: 'm1',
          playerAId: 'me',
          playerBId: 'rival',
          status: MatchStatus.ready,
          createdAt: DateTime.now(),
          configuration: {'categoryName': 'Network Security', 'questionCount': 10, 'difficulty': 'Hard'},
          playerAReady: true,
        ),
      )),
    ],
    child: const VersusMatchOrchestrator(matchId: 'm1'),
  );

  static Widget countdown() => ProviderScope(
    overrides: [
      activeMatchIdProvider.overrideWith((ref) => 'm1'),
      activeMatchProvider.overrideWith((ref) => Stream.value(
        VersusMatch(
          matchId: 'm1',
          playerAId: 'me',
          playerBId: 'rival',
          status: MatchStatus.countdown,
          createdAt: DateTime.now(),
          configuration: {'categoryName': 'Network Security', 'questionCount': 10},
        ),
      )),
      matchCountdownProvider.overrideWith((ref) => Stream.value(2)),
    ],
    child: const VersusMatchOrchestrator(matchId: 'm1'),
  );

  static Widget victory() => ProviderScope(
    overrides: [
      currentMatchResultProvider('m1').overrideWith((ref) => Stream.value(
        CompetitiveMatchResult(
          matchId: 'm1',
          playerId: 'me',
          opponentId: 'rival',
          outcome: MatchOutcome.victory,
          playerScore: 1250,
          opponentScore: 840,
          playerPerformance: GameResult(
            sessionId: 's1',
            playerId: 'me',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 1250,
            totalXP: 250,
            totalQuestions: 10,
            correctAnswers: 9,
            wrongAnswers: 1,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.9,
            maxStreak: 7,
            avgResponseTime: const Duration(milliseconds: 1200),
          ),
          opponentPerformance: GameResult(
            sessionId: 's2',
            playerId: 'rival',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 840,
            totalXP: 100,
            totalQuestions: 10,
            correctAnswers: 6,
            wrongAnswers: 4,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.6,
            maxStreak: 3,
          ),
          rankChange: const {'rankBefore': 'Gold II', 'rankAfter': 'Gold I', 'pointsChange': 125},
          rewards: const {'xp': 250, 'coins': 50},
          completedAt: DateTime.now(),
        ),
      )),
    ],
    child: const CompetitiveMatchResultScreen(matchId: 'm1'),
  );

  static Widget defeat() => ProviderScope(
    overrides: [
      currentMatchResultProvider('m1').overrideWith((ref) => Stream.value(
        CompetitiveMatchResult(
          matchId: 'm1',
          playerId: 'me',
          opponentId: 'rival',
          outcome: MatchOutcome.defeat,
          playerScore: 720,
          opponentScore: 1100,
          playerPerformance: GameResult(
            sessionId: 's1',
            playerId: 'me',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 720,
            totalXP: 50,
            totalQuestions: 10,
            correctAnswers: 5,
            wrongAnswers: 5,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.5,
            maxStreak: 2,
            avgResponseTime: const Duration(milliseconds: 2500),
          ),
          opponentPerformance: GameResult(
            sessionId: 's2',
            playerId: 'rival',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 1100,
            totalXP: 200,
            totalQuestions: 10,
            correctAnswers: 8,
            wrongAnswers: 2,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.8,
            maxStreak: 5,
          ),
          rankChange: const {'rankBefore': 'Gold I', 'rankAfter': 'Gold II', 'pointsChange': -80},
          rewards: const {'xp': 50, 'coins': 10},
          completedAt: DateTime.now(),
        ),
      )),
    ],
    child: const CompetitiveMatchResultScreen(matchId: 'm1'),
  );

  static Widget draw() => ProviderScope(
    overrides: [
      currentMatchResultProvider('m1').overrideWith((ref) => Stream.value(
        CompetitiveMatchResult(
          matchId: 'm1',
          playerId: 'me',
          opponentId: 'rival',
          outcome: MatchOutcome.draw,
          playerScore: 950,
          opponentScore: 950,
          playerPerformance: GameResult(
            sessionId: 's1',
            playerId: 'me',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 950,
            totalXP: 100,
            totalQuestions: 10,
            correctAnswers: 7,
            wrongAnswers: 3,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.7,
            maxStreak: 4,
          ),
          opponentPerformance: GameResult(
            sessionId: 's2',
            playerId: 'rival',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 950,
            totalXP: 100,
            totalQuestions: 10,
            correctAnswers: 7,
            wrongAnswers: 3,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.7,
            maxStreak: 4,
          ),
          rankChange: const {'rankBefore': 'Gold II', 'rankAfter': 'Gold II', 'pointsChange': 0},
          rewards: const {'xp': 100, 'coins': 20},
          completedAt: DateTime.now(),
        ),
      )),
    ],
    child: const CompetitiveMatchResultScreen(matchId: 'm1'),
  );

  static Widget rankUp() => ProviderScope(
    overrides: [
      currentMatchResultProvider('m1').overrideWith((ref) => Stream.value(
        CompetitiveMatchResult(
          matchId: 'm1',
          playerId: 'me',
          opponentId: 'rival',
          outcome: MatchOutcome.victory,
          playerScore: 1500,
          opponentScore: 600,
          playerPerformance: GameResult(
            sessionId: 's1',
            playerId: 'me',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 1500,
            totalXP: 300,
            totalQuestions: 10,
            correctAnswers: 10,
            wrongAnswers: 0,
            totalDuration: const Duration(minutes: 2),
            accuracy: 1.0,
            maxStreak: 10,
          ),
          opponentPerformance: GameResult(
            sessionId: 's2',
            playerId: 'rival',
            mode: GameMode.versus,
            timestamp: DateTime.now(),
            finalScore: 600,
            totalXP: 50,
            totalQuestions: 10,
            correctAnswers: 4,
            wrongAnswers: 6,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.4,
            maxStreak: 2,
          ),
          rankChange: const {'rankBefore': 'Silver I', 'rankAfter': 'Gold III', 'pointsChange': 150},
          rewards: const {'xp': 300, 'coins': 100},
          completedAt: DateTime.now(),
        ),
      )),
    ],
    child: const CompetitiveMatchResultScreen(matchId: 'm1'),
  );
}
