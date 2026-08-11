import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_season.freezed.dart';
part 'competitive_season.g.dart';

enum SeasonStatus { upcoming, active, ending, completed, archived }

@freezed
abstract class CompetitiveSeason with _$CompetitiveSeason {
  const factory CompetitiveSeason({
    required String seasonId,
    required String name,
    String? displayName,
    required SeasonStatus status,
    required DateTime startAt,
    required DateTime endAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? rankConfigId,
    String? leaderboardId,
    String? description,
    int? seasonNumber,
    @Default(false) bool isCurrent,
    @Default(true) bool isVisible,
    DateTime? archiveAt,
    @Default(1) int version,
  }) = _CompetitiveSeason;

  factory CompetitiveSeason.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveSeasonFromJson(json);
}

extension CompetitiveSeasonX on CompetitiveSeason {
  /// Derives the current lifecycle status based on authoritative [now].
  SeasonStatus calculateStatus(DateTime now) {
    if (now.isBefore(startAt)) return SeasonStatus.upcoming;
    if (now.isAfter(endAt)) return SeasonStatus.completed;

    // Check for "Ending Soon" (24h threshold)
    if (endAt.difference(now) < const Duration(hours: 24)) {
      return SeasonStatus.ending;
    }

    return SeasonStatus.active;
  }
}
