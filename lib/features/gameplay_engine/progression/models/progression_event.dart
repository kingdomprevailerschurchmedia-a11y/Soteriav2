sealed class ProgressionEvent {}

class LevelUpEvent extends ProgressionEvent {
  final int previousLevel;
  final int newLevel;
  final int levelsGained;
  final int xpOverflow;
  LevelUpEvent({
    required this.previousLevel,
    required this.newLevel,
    required this.levelsGained,
    required this.xpOverflow,
  });
}

class AchievementUnlockedEvent extends ProgressionEvent {
  final String achievementId;
  AchievementUnlockedEvent(this.achievementId);
}

class RewardEarnedEvent extends ProgressionEvent {
  final String rewardType;
  final int amount;
  RewardEarnedEvent(this.rewardType, this.amount);
}

class StreakMilestoneEvent extends ProgressionEvent {
  final int streakCount;
  StreakMilestoneEvent(this.streakCount);
}

class ScoreMilestoneEvent extends ProgressionEvent {
  final int score;
  ScoreMilestoneEvent(this.score);
}

class XPThresholdEvent extends ProgressionEvent {
  final int threshold;
  XPThresholdEvent(this.threshold);
}

class SpeedBonusEvent extends ProgressionEvent {
  final int bonusPoints;
  final int responseTimeMs;
  SpeedBonusEvent(this.bonusPoints, this.responseTimeMs);
}
