import 'package:freezed_annotation/freezed_annotation.dart';
import 'season_reward_definition.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

enum AchievementCategory {
  general,
  participation,
  victory,
  streak,
  ranking,
  social,
  special,
}

enum AchievementRarity {
  common,
  uncommon,
  rare,
  epic,
  legendary,
  mythic,
}

enum AchievementRequirementType {
  score,
  xp,
  level,
  streak,
  gamesPlayed,
  gamesWon,
  correctAnswers,
  accuracy,
  tournamentWin,
  proWin,
  categoryMastery,
}

@freezed
abstract class AchievementDefinition with _$AchievementDefinition {
  const factory AchievementDefinition({
    required String id,
    required String title,
    required String description,
    required AchievementCategory category,
    required String icon,
    required AchievementRequirementType requirementType,
    required double threshold,
    @Default(AchievementRarity.common) AchievementRarity rarity,
    @Default(0) int xpReward,
    @Default(0) int coinReward,
    @Default(false) bool isHidden,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> metadata,
    @Default(0) int displayOrder,
  }) = _AchievementDefinition;

  factory AchievementDefinition.fromJson(Map<String, dynamic> json) =>
      _$AchievementDefinitionFromJson(json);
}

enum AchievementStatus { inProgress, unlocked, claimed }

@freezed
abstract class PlayerAchievement with _$PlayerAchievement {
  const factory PlayerAchievement({
    required String userId,
    required String achievementId,
    required AchievementStatus status,
    required double currentValue,
    required double targetValue,
    DateTime? unlockedAt,
    DateTime? claimedAt,
    @Default(1) int schemaVersion,
  }) = _PlayerAchievement;

  factory PlayerAchievement.fromJson(Map<String, dynamic> json) =>
      _$PlayerAchievementFromJson(json);
}
