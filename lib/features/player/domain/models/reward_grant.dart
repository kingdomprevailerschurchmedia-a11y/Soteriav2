import 'package:freezed_annotation/freezed_annotation.dart';
import 'season_reward_definition.dart';

part 'reward_grant.freezed.dart';
part 'reward_grant.g.dart';

enum GrantStatus { eligible, pending, granted, claimed, failed, cancelled }

@freezed
abstract class RewardGrant with _$RewardGrant {
  const factory RewardGrant({
    required String grantId,
    required String rewardId,
    required String seasonId,
    required String userId,
    required RewardType type,
    required int amount,
    required GrantStatus status,
    String? transactionId,
    DateTime? grantedAt,
    DateTime? claimedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RewardGrant;

  factory RewardGrant.fromJson(Map<String, dynamic> json) =>
      _$RewardGrantFromJson(json);
}
