import 'package:freezed_annotation/freezed_annotation.dart';
import 'matchmaking_status.dart';

part 'matchmaking_session.freezed.dart';
part 'matchmaking_session.g.dart';

@freezed
class MatchmakingSession with _$MatchmakingSession {
  const factory MatchmakingSession({
    required String sessionId,
    required String userId,
    required MatchmakingStatus status,
    required DateTime queuedAt,
    DateTime? matchedAt,
    String? opponentId,
    String? matchId,
    @Default({}) Map<String, dynamic> configuration,
    @Default({}) Map<String, dynamic> rankSnapshot,
    @Default(false) bool isReady,
    @Default(false) bool opponentReady,
    @Default(1) int schemaVersion,
  }) = _MatchmakingSession;

  factory MatchmakingSession.fromJson(Map<String, dynamic> json) =>
      _$MatchmakingSessionFromJson(json);
}
