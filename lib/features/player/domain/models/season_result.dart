import 'package:freezed_annotation/freezed_annotation.dart';

part 'season_result.freezed.dart';
part 'season_result.g.dart';

@freezed
abstract class SeasonResult with _$SeasonResult {
  const factory SeasonResult({
    required String seasonId,
    required String userId,
    required String seasonName,
    required int seasonNumber,
    required int finalPosition,
    required int finalRankPoints,
    required String finalTier,
    required int finalDivision,
    required String previousTier,
    required int previousDivision,
    required int rankChange,
    required DateTime completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default('finalized') String status,
    Map<String, dynamic>? statistics,
  }) = _SeasonResult;

  factory SeasonResult.fromJson(Map<String, dynamic> json) =>
      _$SeasonResultFromJson(json);
}

@freezed
abstract class CompetitiveHistory with _$CompetitiveHistory {
  const factory CompetitiveHistory({
    required String userId,
    @Default([]) List<SeasonResult> results,
    SeasonResult? bestResult,
    SeasonResult? latestResult,
  }) = _CompetitiveHistory;

  factory CompetitiveHistory.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveHistoryFromJson(json);
}
