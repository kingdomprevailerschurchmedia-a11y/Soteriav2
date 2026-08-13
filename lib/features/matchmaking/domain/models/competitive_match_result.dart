import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../gameplay_engine/models/game_result.dart';

part 'competitive_match_result.freezed.dart';
part 'competitive_match_result.g.dart';

enum MatchOutcome {
  victory,
  defeat,
  draw,
  abandoned,
  cancelled,
}

@freezed
class CompetitiveMatchResult with _$CompetitiveMatchResult {
  const factory CompetitiveMatchResult({
    required String matchId,
    required String playerId,
    required String opponentId,
    required MatchOutcome outcome,
    required int playerScore,
    required int opponentScore,
    required GameResult playerPerformance,
    required GameResult opponentPerformance,
    required Map<String, dynamic> rankChange,
    required Map<String, dynamic> rewards,
    required DateTime completedAt,
    @Default(1) int schemaVersion,
  }) = _CompetitiveMatchResult;

  factory CompetitiveMatchResult.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveMatchResultFromJson(json);
}
