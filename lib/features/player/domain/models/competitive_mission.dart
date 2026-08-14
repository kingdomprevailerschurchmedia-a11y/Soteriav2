import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:soteria/features/player/domain/models/reward_grant.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';

part 'competitive_mission.freezed.dart';
part 'competitive_mission.g.dart';

enum MissionPeriod {
  daily,
  weekly,
  seasonal,
  career,
}

enum MissionType {
  playMatches,
  winMatches,
  answerQuestions,
  completeCategory,
  achieveScore,
  winStreak,
  completeEvent,
  earnXp,
  earnRp,
  improveAccuracy,
}

enum MissionStatus {
  active,
  completed,
  expired,
  locked,
  claimed,
}

enum MissionDifficulty {
  easy,
  medium,
  hard,
}

@freezed
abstract class MissionDefinition with _$MissionDefinition {
  const factory MissionDefinition({
    required String id,
    required MissionType type,
    required MissionPeriod period,
    required String title,
    required String description,
    required double target,
    required MissionDifficulty difficulty,
    required RewardType rewardType,
    required int rewardAmount,
    String? categoryId,
    String? seasonId,
    String? eventId,
    @Default({}) Map<String, dynamic> metadata,
    String? icon,
  }) = _MissionDefinition;

  factory MissionDefinition.fromJson(Map<String, dynamic> json) =>
      _$MissionDefinitionFromJson(json);
}

@freezed
abstract class UserMissionState with _$UserMissionState {
  const factory UserMissionState({
    required String userId,
    required String missionId,
    required double progress,
    required MissionStatus status,
    required DateTime startAt,
    required DateTime endAt,
    DateTime? completedAt,
    DateTime? claimedAt,
    @Default(1) int schemaVersion,
  }) = _UserMissionState;

  factory UserMissionState.fromJson(Map<String, dynamic> json) =>
      _$UserMissionStateFromJson(json);
}

@freezed
abstract class CompetitiveMission with _$CompetitiveMission {
  const factory CompetitiveMission({
    required MissionDefinition definition,
    required UserMissionState state,
  }) = _CompetitiveMission;

  const CompetitiveMission._();

  bool get isCompleted =>
      state.status == MissionStatus.completed ||
      state.status == MissionStatus.claimed;
  
  bool get isClaimed => state.status == MissionStatus.claimed;
  
  bool get isActive => state.status == MissionStatus.active;
  
  bool get isExpired => state.status == MissionStatus.expired;

  double get progressPercentage => (state.progress / definition.target).clamp(0.0, 1.0);
  
  double get remaining => (definition.target - state.progress).clamp(0.0, definition.target);
  
  Duration get timeRemaining => state.endAt.difference(DateTime.now());
  
  bool get isExpiringSoon => isActive && timeRemaining.inHours < 24;

  factory CompetitiveMission.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveMissionFromJson(json);
}
