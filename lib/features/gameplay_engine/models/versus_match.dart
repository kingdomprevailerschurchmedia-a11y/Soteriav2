import 'package:freezed_annotation/freezed_annotation.dart';
import 'game_mode.dart';

part 'versus_match.freezed.dart';
part 'versus_match.g.dart';

enum MatchStatus {
  created,
  waiting,
  ready,
  countdown,
  active,
  finishing,
  processing,
  completed,
  cancelled,
  abandoned,
  failed,
  expired,
}

@freezed
abstract class VersusMatch with _$VersusMatch {
  const factory VersusMatch({
    required String matchId,
    required String playerAId,
    required String playerBId,
    required MatchStatus status,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
    String? playerASessionId,
    String? playerBSessionId,
    @Default(false) bool playerAReady,
    @Default(false) bool playerBReady,
    @Default(0) int playerAScore,
    @Default(0) int playerBScore,
    @Default(0) int playerAProgress,
    @Default(0) int playerBProgress,
    @Default(GameMode.versus) GameMode mode,
    @Default({}) Map<String, dynamic> configuration,
    @Default(1) int schemaVersion,
  }) = _VersusMatch;

  factory VersusMatch.fromJson(Map<String, dynamic> json) =>
      _$VersusMatchFromJson(json);
}
