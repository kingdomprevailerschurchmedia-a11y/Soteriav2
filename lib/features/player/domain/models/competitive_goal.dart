import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_goal.freezed.dart';
part 'competitive_goal.g.dart';

enum GoalType { daily, weekly, seasonal, career }

enum GoalCategory {
  win,
  gameCount,
  rank,
  score,
  streak,
  achievement,
  personalBest,
}

enum GoalStatus { locked, active, completed, expired, claimed }

@freezed
abstract class CompetitiveGoal with _$CompetitiveGoal {
  const factory CompetitiveGoal({
    required String id,
    required String userId,
    required GoalType type,
    required GoalCategory category,
    required String title,
    required String description,
    required double target,
    required double currentProgress,
    required GoalStatus status,
    required DateTime startAt,
    required DateTime endAt,
    DateTime? completedAt,
    String? seasonId,
    String? rewardId,
    @Default({}) Map<String, dynamic> metadata,
  }) = _CompetitiveGoal;

  const CompetitiveGoal._();

  bool get isCompleted =>
      status == GoalStatus.completed || status == GoalStatus.claimed;
  bool get isExpired => status == GoalStatus.expired;
  bool get isActive => status == GoalStatus.active;

  double get progressPercentage => (currentProgress / target).clamp(0.0, 1.0);
  double get remaining => (target - currentProgress).clamp(0.0, target);

  factory CompetitiveGoal.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveGoalFromJson(json);
}

@freezed
abstract class GoalSummary with _$GoalSummary {
  const factory GoalSummary({
    required int activeCount,
    required int completedTodayCount,
    required double totalProgress,
  }) = _GoalSummary;
}
