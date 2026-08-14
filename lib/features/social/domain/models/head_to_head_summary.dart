import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../player/domain/models/competitive_result.dart';

part 'head_to_head_summary.freezed.dart';
part 'head_to_head_summary.g.dart';

@freezed
abstract class HeadToHeadSummary with _$HeadToHeadSummary {
  const factory HeadToHeadSummary({
    required String playerAId,
    required String playerBId,
    required int totalMatches,
    required int playerAWins,
    required int playerBWins,
    required int draws,
    required double playerAWinRate,
    required double playerBWinRate,
    @Default([]) List<CompetitiveOutcome> recentResults,
    required int playerACurrentStreak,
    required int playerBCurrentStreak,
    required int playerABestStreak,
    required int playerBBestStreak,
    DateTime? lastMatchAt,
  }) = _HeadToHeadSummary;

  factory HeadToHeadSummary.fromJson(Map<String, dynamic> json) =>
      _$HeadToHeadSummaryFromJson(json);
}
