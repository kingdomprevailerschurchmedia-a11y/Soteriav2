import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_bundle.freezed.dart';
part 'coin_bundle.g.dart';

@freezed
abstract class CoinBundle with _$CoinBundle {
  const factory CoinBundle({
    required String id,
    required String name,
    required int coins,
    @Default(0) int bonusCoins,
    required double price,
    @Default('USD') String currency,
    String? displayPrice,
    required String icon,
    @Default(false) bool featured,
    @Default(true) bool active,
    @Default({}) Map<String, dynamic> metadata,
  }) = _CoinBundle;

  factory CoinBundle.fromJson(Map<String, dynamic> json) => _$CoinBundleFromJson(json);
}
