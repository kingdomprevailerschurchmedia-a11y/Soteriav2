import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_product.freezed.dart';
part 'store_product.g.dart';

enum StoreProductCategory {
  coins,
  tokens,
  pro,
  bundle,
}

@freezed
abstract class StoreProduct with _$StoreProduct {
  const factory StoreProduct({
    required String id,
    required String name,
    required String description,
    required StoreProductCategory category,
    required int quantity,
    @Default(0) int bonusQuantity,
    required double price,
    @Default('NGN') String currencyCode,
    String? displayPrice,
    required String icon,
    @Default(false) bool isPopular,
    @Default(false) bool isBestValue,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> metadata,
  }) = _StoreProduct;

  factory StoreProduct.fromJson(Map<String, dynamic> json) => _$StoreProductFromJson(json);

  // Product ID Constants
  static const String coin100 = 'soteria.coins.100';
  static const String coin550 = 'soteria.coins.550';
  static const String coin1200 = 'soteria.coins.1200';
  static const String coin3000 = 'soteria.coins.3000';
  static const String coin7000 = 'soteria.coins.7000';
  static const String coin15000 = 'soteria.coins.15000';

  static const String token10 = 'soteria.tokens.10';
  static const String token25 = 'soteria.tokens.25';
  static const String token60 = 'soteria.tokens.60';
  static const String token150 = 'soteria.tokens.150';

  static const String proMonthly = 'soteria.pro.monthly';
  static const String proYearly = 'soteria.pro.yearly';

  static const String starterBundle = 'starter_bundle';
  static const String competitorBundle = 'competitor_bundle';
  static const String seasonBundle = 'season_bundle';
}
