import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entry.freezed.dart';
part 'leaderboard_entry.g.dart';

@freezed
abstract class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String userId,
    required String displayName,
    String? avatarUrl,
    String? avatarId,
    required int rankPoints,
    @Default(0) int xp,
    required String rankTier,
    required int division,
    required int position,
    @Default(0) int registrationOrder,
    String? titleId,
    required DateTime lastUpdated,
    DateTime? createdAt,
    @Default(1) int schemaVersion,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}
