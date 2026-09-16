import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/json_converters.dart';
import 'wallet_transaction_type.dart';

part 'wallet_transaction.freezed.dart';
part 'wallet_transaction.g.dart';

@freezed
abstract class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required String uid,
    required String direction, // 'credit' or 'debit'
    required int amount,
    required int balanceBefore,
    required int balanceAfter,
    required WalletTransactionType type,
    
    /// External reference (e.g., Paystack reference, Tournament ID, etc.)
    String? referenceId,
    
    /// Unique key to prevent duplicate processing (Rule #5)
    required String idempotencyKey,
    
    @Default('completed') String status, // pending, completed, failed, reversed
    
    @Default({}) Map<String, dynamic> metadata,
    
    @RequiredTimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? processedAt,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}
