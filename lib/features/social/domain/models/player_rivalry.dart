import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../player/domain/models/competitive_result.dart';

part 'player_rivalry.freezed.dart';
part 'player_rivalry.g.dart';

@freezed
abstract class PlayerRivalry with _$PlayerRivalry {
  const factory PlayerRivalry({
    required String rivalryId,
    required String userId,
    required String rivalId,
    required int matchesPlayed,
    required int wins,
    required int losses,
    required int draws,
    required DateTime lastMatchAt,
    CompetitiveOutcome? lastOutcome,
    @Default([]) List<CompetitiveOutcome> recentForm,
  }) = _PlayerRivalry;

  factory PlayerRivalry.fromJson(Map<String, dynamic> json) =>
      _$PlayerRivalryFromJson(json);
}
