import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_presence.freezed.dart';
part 'player_presence.g.dart';

enum PresenceStatus {
  online,
  recentlyActive,
  offline,
  inMatch,
  unavailable,
}

@freezed
abstract class PlayerPresence with _$PlayerPresence {
  const factory PlayerPresence({
    required String userId,
    required PresenceStatus status,
    required DateTime lastSeenAt,
    @Default(true) bool showOnlineStatus,
    @Default(true) bool showActivity,
    String? currentMatchId,
    @Default(1) int schemaVersion,
  }) = _PlayerPresence;

  const PlayerPresence._();

  bool get isEffectivelyOnline => 
      status == PresenceStatus.online || status == PresenceStatus.inMatch;

  factory PlayerPresence.fromJson(Map<String, dynamic> json) =>
      _$PlayerPresenceFromJson(json);
}
