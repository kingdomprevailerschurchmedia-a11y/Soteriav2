import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/json_converters.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

@freezed
abstract class Wallet with _$Wallet {
  const factory Wallet({
    required String uid,
    @Default(0) int balance,
    
    /// Reference to the latest transaction record in the ledger
    String? lastTransactionId,
    
    @RequiredTimestampConverter() required DateTime updatedAt,
    
    @Default(1) int version,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) =>
      _$WalletFromJson(json);
      
  const Wallet._();
  
  /// Helper to check if the wallet has enough coins for a debit
  bool canAfford(int amount) => balance >= amount;
}
