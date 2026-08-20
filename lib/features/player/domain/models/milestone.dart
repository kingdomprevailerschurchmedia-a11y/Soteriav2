import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/json_converters.dart';
import 'season_reward_definition.dart';

part 'milestone.freezed.dart';
part 'milestone.g.dart';

enum MilestoneType {
  count,
  win,
  streak,
  rank,
  position,
  season,
  statistic,
  careerBest,
  promotion,
  welcome,
}

enum MilestoneCategory { general, participation, victory, ranking, social }

enum MilestoneStatus { locked, inProgress, completed, claimed }

@freezed
abstract class MilestoneDefinition with _$MilestoneDefinition {
  const factory MilestoneDefinition({
    required String id,
    required String name,
    required String description,
    required MilestoneType type,
    required MilestoneCategory category,
    required double threshold,
    String? icon,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> metadata,
    RewardType? rewardType,
    int? rewardAmount,
    String? achievementId,
    @Default(0) int displayOrder,
  }) = _MilestoneDefinition;

  factory MilestoneDefinition.fromJson(Map<String, dynamic> json) =>
      _$MilestoneDefinitionFromJson(json);
}

@freezed
abstract class PlayerMilestone with _$PlayerMilestone {
  const factory PlayerMilestone({
    required String userId,
    required String milestoneId,
    required MilestoneStatus status,
    required double currentProgress,
    @TimestampConverter() DateTime? unlockedAt,
    @TimestampConverter() DateTime? claimedAt,
    @Default(1) int schemaVersion,
  }) = _PlayerMilestone;

  factory PlayerMilestone.fromJson(Map<String, dynamic> json) =>
      _$PlayerMilestoneFromJson(json);
}

@freezed
abstract class MilestoneProgress with _$MilestoneProgress {
  const factory MilestoneProgress({
    required MilestoneDefinition definition,
    required PlayerMilestone? playerState,
  }) = _MilestoneProgress;

  const MilestoneProgress._();

  bool get isCompleted =>
      playerState?.status == MilestoneStatus.completed ||
      playerState?.status == MilestoneStatus.claimed;

  double get progressPercentage =>
      (playerState?.currentProgress ?? 0.0) / definition.threshold;

  double get remaining =>
      (definition.threshold - (playerState?.currentProgress ?? 0.0)).clamp(
        0.0,
        definition.threshold,
      );
}
