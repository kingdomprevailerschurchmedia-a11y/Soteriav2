import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';

part 'competitive_challenge.freezed.dart';
part 'competitive_challenge.g.dart';

enum ChallengeStatus {
  pending,
  accepted,
  declined,
  expired,
  cancelled,
  active,
  completed,
  invalid,
}

enum ChallengeType {
  matchWins,
  matchScore,
  winStreak,
  totalPoints,
  accuracy,
  categoryPerformance,
  headToHeadWins,
}

@freezed
abstract class CompetitiveChallenge with _$CompetitiveChallenge {
  const factory CompetitiveChallenge({
    required String challengeId,
    required String challengerId,
    required String challengedPlayerId,
    required ChallengeType type,
    required double target,
    required ChallengeStatus status,
    required DateTime createdAt,
    required DateTime expiresAt,
    DateTime? startAt,
    DateTime? completedAt,
    @Default(0.0) double challengerProgress,
    @Default(0.0) double opponentProgress,
    String? seasonId,
    RewardType? rewardType,
    int? rewardAmount,
    @Default(GameMode.versus) GameMode mode,
    @Default({}) Map<String, dynamic> configuration,
    @Default(1) int schemaVersion,
  }) = _CompetitiveChallenge;

  const CompetitiveChallenge._();

  bool get isPending => status == ChallengeStatus.pending;
  bool get isActive => status == ChallengeStatus.active;
  bool get isCompleted => status == ChallengeStatus.completed;
  bool get isExpired => status == ChallengeStatus.expired;

  double get challengerProgressPercentage => (challengerProgress / target).clamp(0.0, 1.0);
  double get opponentProgressPercentage => (opponentProgress / target).clamp(0.0, 1.0);

  bool get challengerLeading => challengerProgress > opponentProgress;
  bool get opponentLeading => opponentProgress > challengerProgress;
  bool get isTie => challengerProgress == opponentProgress;

  factory CompetitiveChallenge.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveChallengeFromJson(json);
}
