import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_change.freezed.dart';
part 'rank_change.g.dart';

enum RankChangeType {
  increase,
  decrease,
  promotion,
  demotion,
  divisionPromotion,
  divisionDemotion,
  placement,
  seasonReset,
  protection,
}

@freezed
abstract class RankChange with _$RankChange {
  const factory RankChange({
    required String changeId,
    required String userId,
    required String seasonId,
    required String previousRank,
    required String newRank,
    required int previousRankPoints,
    required int newRankPoints,
    required int changeAmount,
    required RankChangeType type,
    String? referenceResultId,
    required DateTime createdAt,
    @Default(1) int schemaVersion,
    @Default(false) bool acknowledged,
    @Default(false) bool isTierChange,
    @Default(false) bool isDivisionChange,
  }) = _RankChange;

  factory RankChange.fromJson(Map<String, dynamic> json) =>
      _$RankChangeFromJson(json);
}
