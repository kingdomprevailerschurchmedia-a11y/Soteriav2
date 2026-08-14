import 'package:freezed_annotation/freezed_annotation.dart';
import 'season_result.dart';
import 'competitive_personal_record.dart';

part 'competitive_career_summary.freezed.dart';
part 'competitive_career_summary.g.dart';

@freezed
abstract class CompetitiveCareerSummary with _$CompetitiveCareerSummary {
  const factory CompetitiveCareerSummary({
    required String userId,
    required int totalSeasons,
    required String bestRank,
    required int bestPosition,
    required int totalMatches,
    required int totalWins,
    required int totalLosses,
    required double winRate,
    required int bestStreak,
    required int highestScore,
    required int totalXp,
    SeasonResult? bestSeason,
    @Default([]) List<CompetitivePersonalRecord> careerRecords,
    @Default([]) List<String> recentForm,
  }) = _CompetitiveCareerSummary;

  factory CompetitiveCareerSummary.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveCareerSummaryFromJson(json);
}
