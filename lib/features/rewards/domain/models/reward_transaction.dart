import 'package:freezed_annotation/freezed_annotation.dart';
import 'reward.dart';

part 'reward_transaction.freezed.dart';
part 'reward_transaction.g.dart';

enum TransactionDirection {
  credit,
  debit,
}

enum TransactionStatus {
  pending,
  completed,
  failed,
  cancelled,
}

enum WalletTransactionType {
  purchase,
  gameEntry,
  tournamentEntry,
  reward,
  refund,
  adminGrant,
  promotion,
  spend,
  itemRedemption,
  unknown,
}

@freezed
abstract class RewardTransaction with _$RewardTransaction {
  const factory RewardTransaction({
    required String id,
    required String userId,
    required RewardType type, // Keep for backward compatibility with existing UI
    required WalletTransactionType transactionType,
    required TransactionDirection direction,
    required int amount,
    @Default('coins') String currency, // 'coins' or 'tokens'
    required RewardSource source,
    String? referenceId,
    @Default(TransactionStatus.completed) TransactionStatus status,
    required DateTime createdAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _RewardTransaction;

  factory RewardTransaction.fromJson(Map<String, dynamic> json) => _$RewardTransactionFromJson(json);
}

typedef WalletTransaction = RewardTransaction;
