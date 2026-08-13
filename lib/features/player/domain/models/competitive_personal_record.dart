import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_personal_record.freezed.dart';
part 'competitive_personal_record.g.dart';

enum CompetitiveRecordType {
  highestScore,
  bestAccuracy,
  longestWinStreak,
  mostRankPointsGained,
  bestRankReached,
  bestLeaderboardPosition,
  bestSeasonPosition,
  mostWinsInSeason,
  bestModeScore,
}

@freezed
abstract class CompetitivePersonalRecord with _$CompetitivePersonalRecord {
  const factory CompetitivePersonalRecord({
    required String id,
    required String userId,
    required CompetitiveRecordType type,
    required double value,
    required String displayValue,
    String? matchId,
    String? seasonId,
    String? mode,
    required DateTime achievedAt,
    double? previousValue,
    @Default(false) bool isCareerRecord,
  }) = _CompetitivePersonalRecord;

  factory CompetitivePersonalRecord.fromJson(Map<String, dynamic> json) =>
      _$CompetitivePersonalRecordFromJson(json);
}
