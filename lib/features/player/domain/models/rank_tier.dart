import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_tier.freezed.dart';
part 'rank_tier.g.dart';

@freezed
abstract class RankTier with _$RankTier {
  const factory RankTier({
    required String id,
    required String name,
    required int minPoints,
    required int maxPoints,
    required int displayOrder,
    required int promotionThreshold,
    required int demotionThreshold,
    required String visualToken,
  }) = _RankTier;

  factory RankTier.fromJson(Map<String, dynamic> json) =>
      _$RankTierFromJson(json);
}
