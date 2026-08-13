import 'package:freezed_annotation/freezed_annotation.dart';
import 'rank_tier.dart';

part 'rank_progress.freezed.dart';
part 'rank_progress.g.dart';

@freezed
abstract class RankProgress with _$RankProgress {
  const factory RankProgress({
    required String currentRank,
    required int currentRP,
    required int minimumRP,
    required int maximumRP,
    required double progressPercentage,
    String? nextRank,
    int? rpToNextRank,
    @Default(false) bool isMaxRank,
    @Default(false) bool isUnranked,
    required RankTier tier,
    required int division,
  }) = _RankProgress;

  factory RankProgress.fromJson(Map<String, dynamic> json) =>
      _$RankProgressFromJson(json);
}
