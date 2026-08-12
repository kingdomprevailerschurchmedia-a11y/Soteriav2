import 'package:freezed_annotation/freezed_annotation.dart';

part 'season_reward_definition.freezed.dart';
part 'season_reward_definition.g.dart';

enum RewardType { xp, coins, tokens, badge, achievement, cosmetic, title }

@freezed
abstract class SeasonRewardDefinition with _$SeasonRewardDefinition {
  const factory SeasonRewardDefinition({
    required String rewardId,
    required String seasonId,
    required String name,
    required String description,
    required RewardType type,
    required int amount,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,

    // Eligibility criteria
    int? minimumPosition,
    int? maximumPosition,
    String? minimumRank,
    int? minimumTier,
    int? minimumDivision,
    bool? participationRequired,
  }) = _SeasonRewardDefinition;

  factory SeasonRewardDefinition.fromJson(Map<String, dynamic> json) =>
      _$SeasonRewardDefinitionFromJson(json);
}
