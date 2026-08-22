import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_processor.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import 'package:soteria/features/player/domain/services/engagement_service.dart';
import 'package:soteria/features/gameplay_engine/progression/services/progression_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';

void main() {
  group('Timer & Gameplay Integrity Remediation Tests', () {
    late AnswerProcessor processor;
    late TimerEngine timer;
    late ProgressionNotifier progression;

    final questions = [
      Question(
        id: '1',
        version: '1',
        text: 'Test Q1',
        options: const [
          Answer(id: 'a', text: 'Correct'),
          Answer(id: 'b', text: 'Wrong'),
        ],
        correctOptionIds: const ['a'],
        difficulty: Difficulty.easy,
        categoryId: 'Test',
        type: QuestionType.multipleChoice,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Test',
        schemaVersion: 1,
        contentHash: 'H1',
        estimatedTime: const Duration(seconds: 45),
      ),
    ];

    setUp(() {
      processor = AnswerProcessor(onEvent: (_) {});
      timer = TimerEngine();
      progression = ProgressionNotifier(
        engine: ProgressionEngine(levelEngine: LevelEngine()),
        engagementService: EngagementService(),
      );
    });

    test('Practice mode uses default 60s timer from factory', () async {
      final config = GameConfiguration.practice();
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
        progression: progression,
      );
      
      await engine.startSession(questions);
      
      expect(timer.debugState.total, const Duration(seconds: 60));
      expect(config.showTimer, isTrue);
    });

    test('Timer falls back to Question.estimatedTime if configuration timer is null', () async {
      const config = GameConfiguration(mode: GameMode.practice, questionTimer: null);
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
        progression: progression,
      );

      await engine.startSession(questions);

      expect(timer.debugState.total, const Duration(seconds: 45));
    });

    test('Practice mode auto-advances after answer', () async {
      final config = GameConfiguration.practice();
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
        progression: progression,
      );
      
      await engine.startSession(questions);
      engine.submitAnswer(['a']);

      expect(engine.debugState.lifecycle, GameLifecycle.answered);
      
      // Advance to end state since only 1 question
      await Future.delayed(const Duration(milliseconds: 1600));
      expect(engine.debugState.lifecycle, GameLifecycle.completed);
    });

    test('Timer pauses immediately on answer submission', () async {
      final config = GameConfiguration.pro();
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
        progression: progression,
      );

      await engine.startSession(questions);
      expect(timer.debugState.status, TimerStatus.running);

      engine.submitAnswer(['a']);
      expect(timer.debugState.status, TimerStatus.paused);
    });

    test('Late submission is rejected after timer expiration', () async {
      final config = GameConfiguration.pro();
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
        progression: progression,
      );

      await engine.startSession(questions);
      
      // Force timer expiration
      timer.start(const Duration(milliseconds: 10));
      await Future.delayed(const Duration(milliseconds: 300));
      
      expect(timer.debugState.status, TimerStatus.expired);
      expect(engine.debugState.lifecycle, GameLifecycle.timeout);

      // Attempt manual submission after timeout
      engine.submitAnswer(['a']);
      
      // Should still be timeout, not answered
      expect(engine.debugState.lifecycle, GameLifecycle.timeout);
      expect(engine.debugState.answerHistory.length, 1);
      expect(engine.debugState.answerHistory.first.metadata['timeout'], isTrue);
    });

    test('Session completion resets timer engine', () async {
      final config = GameConfiguration.practice();
      final engine = GameEngine(
        config: config,
        answerProcessor: processor,
        timerEngine: timer,
        progression: progression,
      );

      await engine.startSession(questions);
      expect(timer.debugState.status, TimerStatus.running);

      engine.submitAnswer(['a']);
      await Future.delayed(const Duration(milliseconds: 1600));

      expect(engine.debugState.lifecycle, GameLifecycle.completed);
      expect(timer.debugState.status, TimerStatus.idle);
    });
  });
}
