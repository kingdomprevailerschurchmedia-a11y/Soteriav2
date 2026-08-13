import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_match_result.dart';
import '../domain/models/competitive_match_replay.dart';
import '../presentation/providers/match_result_providers.dart';
import '../presentation/screens/competitive_match_replay_screen.dart';
import '../../../gameplay_engine/models/game_result.dart';
import '../../../gameplay_engine/answer/models/answer_result.dart';
import '../../../gameplay_engine/answer/models/answer_decision.dart';
import '../../../question_content/domain/entities/question.dart';

class MatchReplayPreviews {
  static Widget standard() => ProviderScope(
    overrides: [
      matchReplayProvider('m1').overrideWith((ref) => Future.value(
        CompetitiveMatchReplay(
          result: CompetitiveMatchResult(
            matchId: 'm1',
            playerId: 'me',
            opponentId: 'rival',
            outcome: MatchOutcome.victory,
            playerScore: 820,
            opponentScore: 760,
            playerPerformance: GameResult(
              sessionId: 's1',
              finalScore: 820,
              totalXP: 100,
              totalQuestions: 2,
              correctAnswers: 1,
              wrongAnswers: 1,
              totalDuration: const Duration(minutes: 1),
              accuracy: 0.5,
              maxStreak: 1,
              answers: [
                AnswerResult(
                  submissionId: 'opt_1',
                  questionId: 'q1',
                  decision: AnswerDecision.correct,
                  correctOptionIds: ['opt_1'],
                  xpEarned: 50,
                  timestamp: DateTime.now(),
                  metadata: {'responseTime': 3200},
                ),
                AnswerResult(
                  submissionId: 'opt_3',
                  questionId: 'q2',
                  decision: AnswerDecision.wrong,
                  correctOptionIds: ['opt_4'],
                  xpEarned: 0,
                  timestamp: DateTime.now(),
                  metadata: {'responseTime': 4500},
                ),
              ],
            ),
            opponentPerformance: const GameResult(
              sessionId: 's2',
              finalScore: 760,
              totalXP: 80,
              totalQuestions: 2,
              correctAnswers: 1,
              wrongAnswers: 1,
              totalDuration: Duration(minutes: 1),
              accuracy: 0.5,
              maxStreak: 1,
            ),
            rankChange: const {'rankBefore': 'Gold II', 'rankAfter': 'Gold II', 'pointsChange': 15},
            rewards: const {'xp': 100, 'coins': 20},
            completedAt: DateTime.now(),
          ),
          questions: [
            Question(
              version: '1',
              text: 'What is the primary purpose of a firewall?',
              difficulty: QuestionDifficulty.medium,
              category: 'Security',
              type: QuestionType.multipleChoice,
              options: [
                const Answer(id: 'opt_1', text: 'Filter traffic'),
                const Answer(id: 'opt_2', text: 'Increase speed'),
              ],
              correctAnswers: ['opt_1'],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              source: 'internal',
              schemaVersion: 1,
              contentHash: 'h1',
            ),
            Question(
              version: '1',
              text: 'Which protocol is used for secure shell access?',
              difficulty: QuestionDifficulty.easy,
              category: 'Networking',
              type: QuestionType.multipleChoice,
              options: [
                const Answer(id: 'opt_3', text: 'HTTP'),
                const Answer(id: 'opt_4', text: 'SSH'),
              ],
              correctAnswers: ['opt_4'],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              source: 'internal',
              schemaVersion: 1,
              contentHash: 'h2',
            ),
          ],
        ),
      )),
    ],
    child: const CompetitiveMatchReplayScreen(matchId: 'm1'),
  );
}
