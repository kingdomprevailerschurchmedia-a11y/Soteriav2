import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/quiz_result.dart';
import '../domain/models/quiz_enums.dart' hide SessionStatus;
import '../domain/models/question_result.dart';
import '../presentation/screens/quiz_history_screen.dart';
import '../presentation/screens/quiz_history_detail_screen.dart';
import '../presentation/providers/history_providers.dart';
import '../../../core/identity/providers/identity_providers.dart';
import '../../../core/identity/models/user_session.dart' as identity;

class QuizHistoryPreview extends StatelessWidget {
  const QuizHistoryPreview({super.key, this.scenario = 'many'});
  final String scenario;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authStateChangesProvider.overrideWith(
          (ref) => Stream.value(
            const identity.UserSession(
              uid: 'preview_user',
              status: identity.SessionStatus.authenticated,
            ),
          ),
        ),
        historyListProvider.overrideWith((ref) async {
          if (scenario == 'empty') return [];
          if (scenario == 'error') throw Exception('Failed to load history');
          return _generateMockResults(scenario);
        }),
      ],
      child: const QuizHistoryScreen(),
    );
  }

  List<QuizResult> _generateMockResults(String scenario) {
    final now = DateTime.now();
    return [
      QuizResult(
        sessionId: 's1',
        playerId: 'preview_user',
        gameMode: GameMode.practice,
        category: 'Science',
        difficulty: Difficulty.medium,
        totalQuestions: 10,
        answeredQuestions: 10,
        correctAnswers: 9,
        wrongAnswers: 1,
        skipped: 0,
        timedOut: 0,
        accuracy: 0.9,
        finalScore: 1850,
        xpEarned: 125,
        longestStreak: 7,
        finalStreak: 3,
        averageResponseTime: const Duration(seconds: 2),
        fastestResponseTime: const Duration(seconds: 1),
        slowestResponseTime: const Duration(seconds: 5),
        questionResults: [],
        completedAt: now,
        completionTime: const Duration(minutes: 2),
        performanceRating: 'Excellent',
      ),
      QuizResult(
        sessionId: 's2',
        playerId: 'preview_user',
        gameMode: GameMode.pro,
        category: 'History',
        difficulty: Difficulty.hard,
        totalQuestions: 20,
        answeredQuestions: 20,
        correctAnswers: 15,
        wrongAnswers: 5,
        skipped: 0,
        timedOut: 0,
        accuracy: 0.75,
        finalScore: 3200,
        xpEarned: 250,
        longestStreak: 5,
        finalStreak: 0,
        averageResponseTime: const Duration(seconds: 4),
        fastestResponseTime: const Duration(seconds: 2),
        slowestResponseTime: const Duration(seconds: 10),
        questionResults: [],
        completedAt: now.subtract(const Duration(days: 1)),
        completionTime: const Duration(minutes: 5),
        performanceRating: 'Strong',
      ),
      QuizResult(
        sessionId: 's3',
        playerId: 'preview_user',
        gameMode: GameMode.tournament,
        category: 'Geography',
        difficulty: Difficulty.easy,
        totalQuestions: 5,
        answeredQuestions: 5,
        correctAnswers: 5,
        wrongAnswers: 0,
        skipped: 0,
        timedOut: 0,
        accuracy: 1.0,
        finalScore: 1200,
        xpEarned: 100,
        longestStreak: 5,
        finalStreak: 5,
        averageResponseTime: const Duration(seconds: 1),
        fastestResponseTime: const Duration(seconds: 1),
        slowestResponseTime: const Duration(seconds: 2),
        questionResults: [],
        completedAt: now.subtract(const Duration(days: 2)),
        completionTime: const Duration(minutes: 1),
        performanceRating: 'Perfect',
      ),
    ];
  }
}

class QuizHistoryDetailPreview extends StatelessWidget {
  const QuizHistoryDetailPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final result = QuizResult(
      sessionId: 's1',
      playerId: 'preview_user',
      gameMode: GameMode.practice,
      category: 'Science',
      difficulty: Difficulty.medium,
      totalQuestions: 5,
      answeredQuestions: 5,
      correctAnswers: 4,
      wrongAnswers: 1,
      skipped: 0,
      timedOut: 0,
      accuracy: 0.8,
      finalScore: 850,
      xpEarned: 50,
      longestStreak: 3,
      finalStreak: 1,
      averageResponseTime: const Duration(seconds: 2),
      fastestResponseTime: const Duration(seconds: 1),
      slowestResponseTime: const Duration(seconds: 5),
      questionResults: [
        const QuestionResult(
          questionId: 'q1',
          questionNumber: 1,
          questionText: 'What is the atomic number of Hydrogen?',
          selectedOptionId: 'o1',
          selectedOptionText: '1',
          correctOptionIds: ['o1'],
          correctOptionText: '1',
          outcome: QuestionOutcome.correct,
          responseTime: Duration(seconds: 1),
          scoreEarned: 100,
        ),
        const QuestionResult(
          questionId: 'q2',
          questionNumber: 2,
          questionText: 'Which planet is the largest in our solar system?',
          selectedOptionId: 'o2',
          selectedOptionText: 'Earth',
          correctOptionIds: ['o1'],
          correctOptionText: 'Jupiter',
          outcome: QuestionOutcome.incorrect,
          explanation:
              'Jupiter is the largest planet, with a mass more than twice that of all the other planets in the Solar System combined.',
          responseTime: Duration(seconds: 3),
          scoreEarned: 0,
        ),
      ],
      completedAt: DateTime.now(),
      completionTime: const Duration(minutes: 1),
      performanceRating: 'Good',
    );

    return QuizHistoryDetailScreen(result: result);
  }
}
