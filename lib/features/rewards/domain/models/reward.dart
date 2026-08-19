import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward.freezed.dart';
part 'reward.g.dart';

enum RewardStatus {
  locked,
  available,
  claimable,
  claimed,
  expired,
}

enum RewardType {
  coins,
  tokens,
  xp,
  ticket,
  premiumCurrency,
  cosmetic,
  item,
  boost,
  mysteryChest,
}

enum RewardSource {
  dailyLogin,
  dailyChallenge,
  achievement,
  milestone,
  streak,
  tournament,
  tournamentReward,
  proModeEntry,
  proModeReward,
  practice,
  goalCompletion,
  competitiveReward,
  itemRedemption,
  season,
  rank,
  event,
  promotion,
  purchase,
  purchaseBonus,
  gameEntry,
  tournamentEntry,
  refund,
  adminGrant,
  unknown,
}

@freezed
abstract class Reward with _$Reward {
  const factory Reward({
    required String id,
    required String title,
    required String description,
    required RewardType type,
    required int amount,
    required RewardSource source,
    @Default(RewardStatus.available) RewardStatus status,
    DateTime? expiresAt,
    DateTime? claimedAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Reward;

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
}
