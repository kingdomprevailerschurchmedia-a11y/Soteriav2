import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

@freezed
abstract class Wallet with _$Wallet {
  const factory Wallet({
    required String userId,
    @Default(0) int coins,
    @Default(0) int tokens,
    @Default(0) int lifetimeCoinsEarned,
    @Default(0) int lifetimeCoinsSpent,
    @Default(0) int lifetimeTokensEarned,
    @Default(0) int lifetimeTokensSpent,
    @Default(false) bool isPro,
    DateTime? proExpiresAt,
    String? lastTransactionId,
    DateTime? updatedAt,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  
  const Wallet._();
  
  factory Wallet.empty([String userId = 'anonymous']) => Wallet(userId: userId, coins: 0, tokens: 0);
  
  // Aliases for requirements consistency
  int get coinBalance => coins;
  int get tokenBalance => tokens;
}
