import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

@freezed
abstract class Wallet with _$Wallet {
  const factory Wallet({
    required int coins,
    @Default(0) int lifetimeCoinsEarned,
    @Default(0) int lifetimeCoinsSpent,
    DateTime? updatedAt,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  
  const Wallet._();
  
  factory Wallet.empty() => const Wallet(coins: 0);
}
