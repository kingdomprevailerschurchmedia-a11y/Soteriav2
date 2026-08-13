import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

part 'competitive_challenge.freezed.dart';
part 'competitive_challenge.g.dart';

enum ChallengeStatus {
  pending,
  accepted,
  declined,
  expired,
  cancelled,
  matched,
  completed,
  invalid,
}

@freezed
abstract class CompetitiveChallenge with _$CompetitiveChallenge {
  const factory CompetitiveChallenge({
    required String challengeId,
    required String challengerId,
    required String challengedPlayerId,
    required ChallengeStatus status,
    required DateTime createdAt,
    required DateTime expiresAt,
    String? matchId,
    @Default(GameMode.versus) GameMode mode,
    @Default({}) Map<String, dynamic> configuration,
    @Default(1) int schemaVersion,
  }) = _CompetitiveChallenge;

  factory CompetitiveChallenge.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveChallengeFromJson(json);
}
