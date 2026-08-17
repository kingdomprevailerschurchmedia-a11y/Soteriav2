import 'package:freezed_annotation/freezed_annotation.dart';
import 'season_reward_definition.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

enum GoalType { daily, weekly, seasonal, career }

enum GoalCategory {
  win,
  gameCount,
  rank,
  score,
  streak,
  achievement,
  personalBest,
  correctAnswers,
  xpEarned,
  practiceCount,
}

enum GoalStatus { locked, active, completed, expired, claimed }

@freezed
abstract class GoalDefinition with _$GoalDefinition {
  const factory GoalDefinition({
    required String id,
    required String title,
    required String description,
    required GoalType type,
    required GoalCategory category,
    required double target,
    String? icon,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> metadata,
    RewardType? rewardType,
    int? rewardAmount,
    @Default(0) int displayOrder,
  }) = _GoalDefinition;

  factory GoalDefinition.fromJson(Map<String, dynamic> json) =>
      _$GoalDefinitionFromJson(json);
}

@freezed
abstract class PlayerGoal with _$PlayerGoal {
  const factory PlayerGoal({
    required String userId,
    required String goalId,
    required GoalStatus status,
    required double currentProgress,
    required DateTime startedAt,
    required DateTime expiresAt,
    DateTime? completedAt,
    DateTime? claimedAt,
    @Default(1) int schemaVersion,
  }) = _PlayerGoal;

  const PlayerGoal._();

  bool get isCompleted =>
      status == GoalStatus.completed || status == GoalStatus.claimed;
  bool get isExpired => status == GoalStatus.expired;
  bool get isActive => status == GoalStatus.active;

  factory PlayerGoal.fromJson(Map<String, dynamic> json) =>
      _$PlayerGoalFromJson(json);
}

@freezed
abstract class GoalProgress with _$GoalProgress {
  const factory GoalProgress({
    required GoalDefinition definition,
    required PlayerGoal? playerState,
  }) = _GoalProgress;

  const GoalProgress._();

  bool get isCompleted => playerState?.isCompleted ?? false;
  bool get isExpired => playerState?.isExpired ?? false;

  double get progressPercentage =>
      ((playerState?.currentProgress ?? 0.0) / definition.target).clamp(0.0, 1.0);

  double get remaining =>
      (definition.target - (playerState?.currentProgress ?? 0.0)).clamp(
        0.0,
        definition.target,
      );
}
