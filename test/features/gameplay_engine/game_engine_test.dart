import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_processor.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';

void main() {
  group('GameEngine Tests', () {
    late GameConfiguration config;
    late AnswerProcessor processor;
    late TimerEngine timer;

    final questions = [
      Question(
        id: '1',
        version: '1',
        text: 'Test Q1',
        options: const [
          Answer(id: 'a', text: 'Correct'),
          Answer(id: 'b', text: 'Wrong'),
        ],
        correctAnswers: const ['a'],
        difficulty: QuestionDifficulty.easy,
        category: 'Test',
        type: QuestionType.multipleChoice,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Test',
        schemaVersion: 1,
        contentHash: 'H1',
      ),
      Question(
        id: '2',
        version: '1',
        text: 'Test Q2',
        options: const [
          Answer(id: 'c', text: 'Correct'),
          Answer(id: 'd', text: 'Wrong'),
        ],
        correctAnswers: const ['c'],
        difficulty: QuestionDifficulty.easy,
        category: 'Test',
        type: QuestionType.multipleChoice,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Test',
        schemaVersion: 1,
        contentHash: 'H2',
      ),
    ];

    setUp(() {
      config = GameConfiguration.pro();
      processor = AnswerProcessor(onEvent: (_) {});
      timer = TimerEngine();
    });

    test('initial state is correct', () {
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
      );
      expect(engine.debugState.lifecycle, GameLifecycle.initializing);
      expect(engine.debugState.score, 0);
    });

    test('startSession transitions to playing', () async {
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
      );
      final future = engine.startSession(questions);

      expect(engine.debugState.lifecycle, GameLifecycle.loading);

      await future;

      expect(engine.debugState.lifecycle, GameLifecycle.playing);
      expect(engine.debugState.questions.length, 2);
    });

    test('submitting correct answer increases score and streak', () async {
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
      );
      await engine.startSession(questions);

      engine.submitAnswer(['a']); // Correct

      expect(engine.debugState.score, greaterThan(0));
      expect(engine.debugState.streak, 1);
      expect(engine.debugState.lifecycle, GameLifecycle.answered);

      // Wait for auto-advance
      await Future.delayed(const Duration(milliseconds: 1600));
      expect(engine.debugState.currentQuestionIndex, 1);
      expect(engine.debugState.lifecycle, GameLifecycle.playing);
    });

    test('submitting wrong answer resets streak and loses life', () async {
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
      );
      await engine.startSession(questions);

      engine.submitAnswer(['b']); // Wrong

      expect(engine.debugState.score, 0);
      expect(engine.debugState.streak, 0);
      expect(engine.debugState.lives, config.initialLives - 1);
      expect(engine.debugState.lifecycle, GameLifecycle.answered);
    });

    test('game ends when lives reach zero', () async {
      final engine = GameEngine(
        config: GameConfiguration(mode: GameMode.pro, initialLives: 1),
        answerProcessor: processor,
        timerEngine: timer,
      );
      await engine.startSession(questions);

      engine.submitAnswer(['b']); // Wrong

      expect(engine.debugState.lifecycle, GameLifecycle.failed);
    });

    test('game ends when all questions are answered', () async {
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
      );
      await engine.startSession(questions);

      engine.submitAnswer(['a']); // Q1 Correct
      await Future.delayed(const Duration(milliseconds: 1600));

      engine.submitAnswer(['c']); // Q2 Correct
      await Future.delayed(const Duration(milliseconds: 1600));

      expect(engine.debugState.lifecycle, GameLifecycle.completed);
    });
  });
}
