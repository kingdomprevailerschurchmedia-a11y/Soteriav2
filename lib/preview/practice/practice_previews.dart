import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/screens/practice_lobby_screen.dart';
import 'package:soteria/features/practice/presentation/screens/practice_results_screen.dart';
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
    return ProviderScope(
      overrides: [
        practiceHistoryProvider.overrideWith((ref) => Future.value([
          GameResult(
            sessionId: 'prev',
            mode: GameMode.practice,
            finalScore: 100,
            totalXP: 20,
            totalQuestions: 5,
            correctAnswers: 2,
            wrongAnswers: 3,
            totalDuration: const Duration(minutes: 2),
            accuracy: 0.4,
            maxStreak: 2,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ])),
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
