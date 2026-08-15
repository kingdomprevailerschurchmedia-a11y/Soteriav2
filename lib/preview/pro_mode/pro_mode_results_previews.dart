import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/gameplay_engine/pages/pro_mode_results_screen.dart';
import 'package:soteria/features/gameplay_engine/providers/pro_mode_results_provider.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/progression/models/reward_summary.dart';

class ProModeResultsPreviews {
  static Widget perfectScore() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 1500,
        totalXP: 250,
        totalQuestions: 10,
        correctAnswers: 10,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 2),
        accuracy: 1.0,
        maxStreak: 10,
        rewards: const RewardSummary(
          baseXP: 100,
          bonusXP: 50,
          baseCoins: 50,
          bonusCoins: 50,
        ),
        avgResponseTime: const Duration(seconds: 12),
        fastestAnswerTime: const Duration(seconds: 4),
        slowestAnswerTime: const Duration(seconds: 18),
        timestamp: DateTime.now(),
        rating: 'S',
      ),
    );
  }

  static Widget excellentResult() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 1250,
        totalXP: 210,
        totalQuestions: 10,
        correctAnswers: 9,
        wrongAnswers: 1,
        totalDuration: const Duration(minutes: 2, seconds: 45),
        accuracy: 0.9,
        maxStreak: 8,
        rewards: const RewardSummary(
          baseXP: 90,
          bonusXP: 45,
          baseCoins: 45,
          bonusCoins: 50,
        ),
        avgResponseTime: const Duration(seconds: 15),
        fastestAnswerTime: const Duration(seconds: 5),
        slowestAnswerTime: const Duration(seconds: 22),
        timestamp: DateTime.now(),
        rating: 'A',
      ),
    );
  }

  static Widget averageResult() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 850,
        totalXP: 120,
        totalQuestions: 10,
        correctAnswers: 7,
        wrongAnswers: 3,
        totalDuration: const Duration(minutes: 3, seconds: 45),
        accuracy: 0.7,
        maxStreak: 4,
        rewards: const RewardSummary(baseXP: 70, bonusXP: 20, baseCoins: 35),
        avgResponseTime: const Duration(seconds: 22),
        fastestAnswerTime: const Duration(seconds: 8),
        slowestAnswerTime: const Duration(seconds: 45),
        timestamp: DateTime.now(),
        rating: 'C',
      ),
    );
  }

  static Widget lowResult() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 300,
        totalXP: 40,
        totalQuestions: 10,
        correctAnswers: 3,
        wrongAnswers: 7,
        totalDuration: const Duration(minutes: 5),
        accuracy: 0.3,
        maxStreak: 1,
        rewards: const RewardSummary(baseXP: 30, bonusXP: 5, baseCoins: 15),
        timestamp: DateTime.now(),
        rating: 'D',
      ),
    );
  }

  static Widget loading() {
    return ProviderScope(
      overrides: [
        proModeResultsProvider.overrideWith(
          (ref) => _FakeResultsNotifier(
            const ProModeResultsState(result: AsyncValue.loading(), isCompleting: true),
          ),
        ),
      ],
      child: const ProModeResultsScreen(),
    );
  }

  static Widget completing() {
    return ProviderScope(
      overrides: [
        proModeResultsProvider.overrideWith(
          (ref) => _FakeResultsNotifier(
            const ProModeResultsState(result: AsyncValue.loading(), isCompleting: true),
          ),
        ),
      ],
      child: const ProModeResultsScreen(),
    );
  }

  static Widget error() {
    return ProviderScope(
      overrides: [
        proModeResultsProvider.overrideWith(
          (ref) => _FakeResultsNotifier(
            ProModeResultsState(
              result: AsyncValue.error(
                'Authoritative validation failed. Please check your connection.',
                StackTrace.current,
              ),
            ),
          ),
        ),
      ],
      child: const ProModeResultsScreen(),
    );
  }

  static Widget unansweredQuestions() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 400,
        totalXP: 50,
        totalQuestions: 10,
        correctAnswers: 4,
        wrongAnswers: 2,
        skippedQuestions: 4,
        totalDuration: const Duration(minutes: 4),
        accuracy: 0.4,
        maxStreak: 2,
        rewards: const RewardSummary(baseXP: 40, baseCoins: 20),
        timestamp: DateTime.now(),
        rating: 'D',
      ),
    );
  }

  static Widget timeoutResult() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 0,
        totalXP: 0,
        totalQuestions: 10,
        correctAnswers: 0,
        wrongAnswers: 0,
        skippedQuestions: 10,
        totalDuration: const Duration(minutes: 10),
        accuracy: 0.0,
        maxStreak: 0,
        rewards: const RewardSummary(),
        timestamp: DateTime.now(),
        rating: 'D',
      ),
    );
  }

  static Widget offlineSyncPending() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 900,
        totalXP: 150,
        totalQuestions: 10,
        correctAnswers: 8,
        wrongAnswers: 2,
        totalDuration: const Duration(minutes: 3),
        accuracy: 0.8,
        maxStreak: 5,
        rewards: const RewardSummary(baseXP: 80, bonusXP: 20, baseCoins: 40),
        timestamp: DateTime.now(),
        rating: 'B',
        isSynced: false,
      ),
    );
  }

  static Widget rewardEarned() {
    return _withResult(
      ProModeResult(
        sessionId: 'fake-id',
        mode: GameMode.pro,
        finalScore: 2000,
        totalXP: 500,
        totalQuestions: 20,
        correctAnswers: 20,
        wrongAnswers: 0,
        totalDuration: const Duration(minutes: 5),
        accuracy: 1.0,
        maxStreak: 20,
        rewards: const RewardSummary(
          baseXP: 300,
          bonusXP: 200,
          baseCoins: 100,
          bonusCoins: 100,
        ),
        timestamp: DateTime.now(),
        rating: 'S',
      ),
    );
  }

  static Widget longExplanationReview() {
    // This would be for the review screen
    return Container(); // Placeholder or implement a specific review preview
  }

  static Widget _withResult(ProModeResult result) {
    return ProviderScope(
      overrides: [
        proModeResultsProvider.overrideWith(
          (ref) => _FakeResultsNotifier(
            ProModeResultsState(result: AsyncValue.data(result)),
          ),
        ),
      ],
      child: const ProModeResultsScreen(),
    );
  }
}

class _FakeResultsNotifier extends ProModeResultsNotifier {
  final ProModeResultsState _mockState;

  _FakeResultsNotifier(this._mockState)
    : super(null as dynamic) {
      Future.microtask(() => state = _mockState);
    }

  @override
  Future<void> loadResult(String sessionId) async {}

  @override
  Future<void> completeSession(dynamic s) async {}
}
