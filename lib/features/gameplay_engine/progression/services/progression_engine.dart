import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_event.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_result.dart';
import 'package:soteria/features/gameplay_engine/progression/services/achievement_engine.dart';
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
    Map<String, dynamic> careerContext = const {},
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

    // 4. Update Level & Mastery
    final newTotalXP = current.totalXP + xpDelta;
    final newLevel = _levelEngine.calculateLevel(newTotalXP);

    final newSessionCorrectAnswers = answer.isCorrect 
        ? current.sessionCorrectAnswers + 1 
        : current.sessionCorrectAnswers;
    
    final Map<String, int> newCategoryMastery = Map.from(current.sessionCategoryMastery);
    if (answer.isCorrect) {
      final category = answer.metadata['categoryId'] as String? ?? 'unknown';
      newCategoryMastery[category] = (newCategoryMastery[category] ?? 0) + 1;
    }

    if (newLevel > current.level) {
      events.add(
        LevelUpEvent(
          previousLevel: current.level,
          newLevel: newLevel,
          levelsGained: newLevel - current.level,
          xpOverflow: _levelEngine.xpIntoCurrentLevel(newTotalXP),
        ),
      );
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
      sessionCorrectAnswers: newSessionCorrectAnswers,
      sessionCategoryMastery: newCategoryMastery,
      lives: answer.isCorrect ? current.lives : current.lives - 1,
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

    // 7. Check for Achievements
    final newAchievements = AchievementEngine.checkAchievements(
      result: result,
      careerContext: careerContext,
    );
    for (final achId in newAchievements) {
      events.add(AchievementUnlockedEvent(achId));
    }

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
    required String currentEngagementDate,
    required bool Function(String, String) isConsecutive,
    required bool Function(String, String) isSameDay,
    Map<String, dynamic> careerContext = const {},
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
      events.add(
        LevelUpEvent(
          previousLevel: current.level,
          newLevel: newLevel,
          levelsGained: newLevel - current.level,
          xpOverflow: _levelEngine.xpIntoCurrentLevel(newTotalXP),
        ),
      );
    }

    // Daily Streak Logic
    final newDailyStreak = StreakEngine.calculateDailyStreak(
      currentDailyStreak: current.dailyStreak,
      lastEngagementDate: current.lastEngagementDate,
      currentEngagementDate: currentEngagementDate,
      isConsecutive: isConsecutive,
      isSameDay: isSameDay,
    );

    if (newDailyStreak > current.dailyStreak &&
        StreakEngine.isMilestone(newDailyStreak)) {
      events.add(StreakMilestoneEvent(newDailyStreak));
    }

    final updatedSnapshot = current.copyWith(
      totalXP: newTotalXP,
      level: newLevel,
      dailyStreak: newDailyStreak,
      lastEngagementDate: currentEngagementDate,
      timestamp: DateTime.now(),
    );

    final result = ProgressionResult(
      before: current,
      after: updatedSnapshot,
      scoreDelta: 0,
      xpDelta: xpBonus,
      events: events,
    );

    // Check for Achievements at Round End
    final newAchievements = AchievementEngine.checkAchievements(
      result: result,
      careerContext: careerContext,
      isRoundEnd: true,
    );
    for (final achId in newAchievements) {
      events.add(AchievementUnlockedEvent(achId));
    }

    return result;
  }
}
