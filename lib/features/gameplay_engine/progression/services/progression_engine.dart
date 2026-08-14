import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_event.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_result.dart';
import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/services/reward_calculator.dart';
import 'package:soteria/features/gameplay_engine/progression/services/score_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/services/streak_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/services/xp_manager.dart';

/// The central orchestrator for the player progression pipeline.
class ProgressionEngine {
  final LevelEngine _levelEngine;

  ProgressionEngine({LevelEngine? levelEngine})
    : _levelEngine = levelEngine ?? LevelEngine();

  /// Processes a single answer result and returns the new progression state.
  ProgressionResult processAnswer({
    required ProgressSnapshot current,
    required AnswerResult answer,
    required ProgressionPolicy policy,
  }) {
    final List<ProgressionEvent> events = [];

    // 1. Calculate Score Delta
    final scoreDelta = ScoreEngine.calculateDelta(
      result: answer,
      policy: policy,
      currentStreak: current.currentStreak,
    );

    // Check for speed bonus event
    if (policy.allowSpeedBonus && answer.isCorrect) {
      final responseTimeMs = answer.metadata['responseTimeMs'] as int? ?? 10000;
      if (responseTimeMs < 5000) {
        events.add(
          SpeedBonusEvent(scoreDelta - policy.pointsPerCorrect, responseTimeMs),
        );
      }
    }

    // 2. Calculate XP Delta
    final xpDelta = XPManager.calculateXPDelta(result: answer, policy: policy);

    // 3. Update Streak
    final newCurrentStreak = StreakEngine.updateCurrentStreak(
      currentStreak: current.currentStreak,
      result: answer,
    );
    final newMaxStreak = StreakEngine.updateMaxStreak(
      currentStreak: newCurrentStreak,
      maxStreak: current.maxStreak,
    );

    if (newCurrentStreak > current.currentStreak &&
        StreakEngine.isMilestone(newCurrentStreak)) {
      events.add(StreakMilestoneEvent(newCurrentStreak));
    }

    // 4. Update Level
    final newTotalXP = current.totalXP + xpDelta;
    final newLevel = _levelEngine.calculateLevel(newTotalXP);

    if (newLevel > current.level) {
      events.add(
        LevelUpEvent(newLevel, 0),
      ); // XP Overflow logic can be added here
    }

    // 5. Assemble Intermediate State
    final updatedSnapshot = current.copyWith(
      score: current.score + scoreDelta,
      totalXP: newTotalXP,
      level: newLevel,
      currentStreak: newCurrentStreak,
      maxStreak: newMaxStreak,
      sessionScore: current.sessionScore + scoreDelta,
      sessionStreak: newCurrentStreak,
      timestamp: DateTime.now(),
    );

    final result = ProgressionResult(
      before: current,
      after: updatedSnapshot,
      scoreDelta: scoreDelta,
      xpDelta: xpDelta,
      events: events,
    );

    // 6. Calculate Reward Hooks & Achievement Events
    final rewardEvents = RewardCalculator.calculateRewards(result);
    events.addAll(rewardEvents);

    // Final result with all events
    return ProgressionResult(
      before: current,
      after: updatedSnapshot,
      scoreDelta: scoreDelta,
      xpDelta: xpDelta,
      events: events,
    );
  }

  /// Processes end-of-round bonuses.
  ProgressionResult processRoundEnd({
    required ProgressSnapshot current,
    required int totalQuestions,
    required int correctAnswers,
    required ProgressionPolicy policy,
  }) {
    final List<ProgressionEvent> events = [];

    final xpBonus = XPManager.calculateRoundBonus(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      policy: policy,
    );

    final newTotalXP = current.totalXP + xpBonus;
    final newLevel = _levelEngine.calculateLevel(newTotalXP);

    if (newLevel > current.level) {
      events.add(LevelUpEvent(newLevel, 0));
    }

    // Daily Streak Logic
    final now = DateTime.now();
    int newDailyStreak = current.dailyStreak;
    DateTime? newLastUpdate = current.lastDailyStreakUpdate;

    if (newLastUpdate == null) {
      newDailyStreak = 1;
      newLastUpdate = now;
      events.add(StreakMilestoneEvent(newDailyStreak));
    } else {
      final difference = now.difference(newLastUpdate).inDays;
      if (difference == 1) {
        newDailyStreak++;
        newLastUpdate = now;
        events.add(StreakMilestoneEvent(newDailyStreak));
      } else if (difference > 1) {
        newDailyStreak = 1;
        newLastUpdate = now;
      }
      // If difference is 0, same day, no change to streak count
    }

    final updatedSnapshot = current.copyWith(
      totalXP: newTotalXP,
      level: newLevel,
      dailyStreak: newDailyStreak,
      lastDailyStreakUpdate: newLastUpdate,
      timestamp: now,
    );

    return ProgressionResult(
      before: current,
      after: updatedSnapshot,
      scoreDelta: 0,
      xpDelta: xpBonus,
      events: events,
    );
  }
}
