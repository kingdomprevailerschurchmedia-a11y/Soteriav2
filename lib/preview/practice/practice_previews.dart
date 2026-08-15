import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/screens/practice_lobby_screen.dart';
import 'package:soteria/features/practice/presentation/screens/practice_results_screen.dart';
import 'package:soteria/features/practice/presentation/screens/practice_history_screen.dart';
import 'package:soteria/features/practice/domain/models/practice_result.dart';
import 'package:soteria/features/practice/domain/models/practice_history.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/practice/presentation/providers/practice_history_providers.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

class PracticePreviews {
  static Widget setup() => const PracticeLobbyScreen();

  static Widget resultsPerfect() {
    final questions = _createMockQuestions(5);
    final state = GameState(
      sessionId: 'preview_perfect',
      questions: questions,
      lifecycle: GameLifecycle.completed,
      answerHistory: questions.map((q) => AnswerResult(
        submissionId: 's_${q.id}',
        questionId: q.id,
        decision: AnswerDecision.correct,
        selectedOptionIds: q.correctOptionIds,
        correctOptionIds: q.correctOptionIds,
        timestamp: DateTime.now(),
        responseTime: const Duration(seconds: 3),
      )).toList(),
      score: 500,
      xp: 120,
      startTime: DateTime.now().subtract(const Duration(minutes: 2)),
    );
    return PracticeResultsScreen(gameState: state);
  }

  static Widget resultsStrong() {
    final questions = _createMockQuestions(10);
    final state = GameState(
      sessionId: 'preview_strong',
      questions: questions,
      lifecycle: GameLifecycle.completed,
      answerHistory: List.generate(10, (i) => AnswerResult(
        submissionId: 's_$i',
        questionId: questions[i].id,
        decision: i < 9 ? AnswerDecision.correct : AnswerDecision.wrong,
        selectedOptionIds: i < 9 ? questions[i].correctOptionIds : ['o2'],
        correctOptionIds: questions[i].correctOptionIds,
        timestamp: DateTime.now(),
        responseTime: const Duration(seconds: 4),
      )),
      score: 450,
      xp: 100,
      startTime: DateTime.now().subtract(const Duration(minutes: 3)),
    );
    return PracticeResultsScreen(gameState: state);
  }

  static Widget resultsAverage() {
    final questions = _createMockQuestions(10);
    final state = GameState(
      sessionId: 'preview_average',
      questions: questions,
      lifecycle: GameLifecycle.completed,
      answerHistory: List.generate(10, (i) => AnswerResult(
        submissionId: 's_$i',
        questionId: questions[i].id,
        decision: i < 7 ? AnswerDecision.correct : AnswerDecision.wrong,
        selectedOptionIds: i < 7 ? questions[i].correctOptionIds : ['o2'],
        correctOptionIds: questions[i].correctOptionIds,
        timestamp: DateTime.now(),
        responseTime: const Duration(seconds: 5),
      )),
      score: 350,
      xp: 80,
      startTime: DateTime.now().subtract(const Duration(minutes: 4)),
    );
    return PracticeResultsScreen(gameState: state);
  }

  static Widget resultsPoor() {
    final questions = _createMockQuestions(5);
    final state = GameState(
      sessionId: 'preview_poor',
      questions: questions,
      lifecycle: GameLifecycle.completed,
      answerHistory: [
        AnswerResult(
          submissionId: 's1',
          questionId: questions[0].id,
          decision: AnswerDecision.wrong,
          selectedOptionIds: ['o2'],
          correctOptionIds: questions[0].correctOptionIds,
          timestamp: DateTime.now(),
          responseTime: const Duration(seconds: 10),
        ),
      ],
      score: 0,
      xp: 10,
      startTime: DateTime.now().subtract(const Duration(minutes: 2)),
    );
    return PracticeResultsScreen(gameState: state);
  }

  static Widget improvementInsight() {
    final questions = _createMockQuestions(5);
    final currentState = GameState(
      sessionId: 'current',
      questions: questions,
      answerHistory: questions.map((q) => AnswerResult(
        submissionId: 's_${q.id}',
        questionId: q.id,
        decision: AnswerDecision.correct,
        selectedOptionIds: q.correctOptionIds,
        correctOptionIds: q.correctOptionIds,
        timestamp: DateTime.now(),
      )).toList(),
      score: 250,
      xp: 60,
      startTime: DateTime.now().subtract(const Duration(minutes: 1)),
    );

    // Provide history with lower accuracy
    final pastResults = [
      PracticeResult(
        sessionId: 'prev',
        userId: 'u1',
        completedAt: DateTime.now().subtract(const Duration(days: 1)),
        totalQuestions: 5,
        answeredQuestions: 5,
        correctAnswers: 2,
        incorrectAnswers: 3,
        skippedQuestions: 0,
        accuracy: 0.4,
        score: 100,
        totalTime: const Duration(minutes: 2),
        categoryPerformance: {},
        difficultyPerformance: {},
        reviewItems: [],
      ),
    ];

    return ProviderScope(
      overrides: [
        practiceHistoryProvider.overrideWith((ref) => Future.value(PracticeHistory.fromResults(pastResults))),
      ],
      child: PracticeResultsScreen(gameState: currentState),
    );
  }

  static Widget weakCategoryInsight() {
    final questions = _createMockQuestions(10);
    // Force many failures in science
    final state = GameState(
      sessionId: 'weak_sci',
      questions: questions,
      lifecycle: GameLifecycle.completed,
      answerHistory: List.generate(10, (i) {
        final isScience = questions[i].categoryId == 'science';
        return AnswerResult(
          submissionId: 's_$i',
          questionId: questions[i].id,
          decision: isScience ? AnswerDecision.wrong : AnswerDecision.correct,
          selectedOptionIds: isScience ? ['o2'] : questions[i].correctOptionIds,
          correctOptionIds: questions[i].correctOptionIds,
          timestamp: DateTime.now(),
        );
      }),
      score: 250,
      xp: 50,
      startTime: DateTime.now().subtract(const Duration(minutes: 5)),
    );
    return PracticeResultsScreen(gameState: state);
  }

  static Widget difficultyInsight() {
    final questions = _createMockQuestions(10);
    // Force many failures in medium difficulty
    final state = GameState(
      sessionId: 'weak_medium',
      questions: questions,
      lifecycle: GameLifecycle.completed,
      answerHistory: List.generate(10, (i) {
        final isMedium = questions[i].difficulty == Difficulty.medium;
        return AnswerResult(
          submissionId: 's_$i',
          questionId: questions[i].id,
          decision: isMedium ? AnswerDecision.wrong : AnswerDecision.correct,
          selectedOptionIds: isMedium ? ['o2'] : questions[i].correctOptionIds,
          correctOptionIds: questions[i].correctOptionIds,
          timestamp: DateTime.now(),
        );
      }),
      score: 250,
      xp: 50,
      startTime: DateTime.now().subtract(const Duration(minutes: 5)),
    );
    return PracticeResultsScreen(gameState: state);
  }

  static Widget historyEmpty() {
    return ProviderScope(
      overrides: [
        practiceHistoryProvider.overrideWith((ref) => Future.value(PracticeHistory.empty())),
      ],
      child: const PracticeHistoryScreen(),
    );
  }

  static Widget historyFull() {
    final results = [
      PracticeResult(
        sessionId: 'h1',
        userId: 'u1',
        completedAt: DateTime.now().subtract(const Duration(hours: 1)),
        totalQuestions: 10,
        answeredQuestions: 10,
        correctAnswers: 9,
        incorrectAnswers: 1,
        skippedQuestions: 0,
        accuracy: 0.9,
        score: 900,
        totalTime: const Duration(minutes: 6),
        categoryPerformance: {
          'science': const CategoryPerformance(categoryId: 'science', total: 6, correct: 5, accuracy: 0.83),
          'history': const CategoryPerformance(categoryId: 'history', total: 4, correct: 4, accuracy: 1.0),
        },
        difficultyPerformance: {},
        reviewItems: [],
      ),
      PracticeResult(
        sessionId: 'h2',
        userId: 'u1',
        completedAt: DateTime.now().subtract(const Duration(days: 1)),
        totalQuestions: 10,
        answeredQuestions: 10,
        correctAnswers: 7,
        incorrectAnswers: 3,
        skippedQuestions: 0,
        accuracy: 0.7,
        score: 700,
        totalTime: const Duration(minutes: 8),
        categoryPerformance: {
          'science': const CategoryPerformance(categoryId: 'science', total: 10, correct: 7, accuracy: 0.7),
        },
        difficultyPerformance: {},
        reviewItems: [],
      ),
      PracticeResult(
        sessionId: 'h3',
        userId: 'u1',
        completedAt: DateTime.now().subtract(const Duration(days: 2)),
        totalQuestions: 10,
        answeredQuestions: 10,
        correctAnswers: 5,
        incorrectAnswers: 5,
        skippedQuestions: 0,
        accuracy: 0.5,
        score: 500,
        totalTime: const Duration(minutes: 10),
        categoryPerformance: {
          'math': const CategoryPerformance(categoryId: 'math', total: 10, correct: 5, accuracy: 0.5),
        },
        difficultyPerformance: {},
        reviewItems: [],
      ),
    ];

    return ProviderScope(
      overrides: [
        practiceHistoryProvider.overrideWith((ref) => Future.value(PracticeHistory.fromResults(results))),
      ],
      child: const PracticeHistoryScreen(),
    );
  }

  static List<Question> _createMockQuestions(int count) {
    return List.generate(count, (i) => Question(
      id: 'q$i',
      text: 'Mock Question $i',
      explanation: 'Explanation for question $i.',
      difficulty: i % 2 == 0 ? Difficulty.easy : Difficulty.medium,
      categoryId: i < 5 ? 'science' : 'technology',
      type: QuestionType.multipleChoice,
      options: [
        const Answer(id: 'o1', text: 'Correct Option'),
        const Answer(id: 'o2', text: 'Wrong Option'),
      ],
      correctOptionIds: ['o1'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Mock',
    ));
  }
}
