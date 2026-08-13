import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_movement_event.freezed.dart';
part 'rank_movement_event.g.dart';

enum RankMovementType {
  positionImproved,
  positionDropped,
  positionMaintained,
  rankPromoted,
  rankDemoted,
  initialPlacement,
}

@freezed
abstract class RankMovementEvent with _$RankMovementEvent {
  const factory RankMovementEvent({
    required String id,
    required String userId,
    String? seasonId,
    required int previousPosition,
    required int currentPosition,
    required int positionDelta,
    required String previousRank,
    required String currentRank,
    required int rankPoints,
    required RankMovementType type,
    required DateTime timestamp,
    String? sourceId, // e.g., matchId
  }) = _RankMovementEvent;

  factory RankMovementEvent.fromJson(Map<String, dynamic> json) =>
      _$RankMovementEventFromJson(json);
}
