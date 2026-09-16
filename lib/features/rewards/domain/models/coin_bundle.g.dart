// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoinBundle _$CoinBundleFromJson(Map<String, dynamic> json) => _CoinBundle(
  id: json['id'] as String,
  name: json['name'] as String,
  coins: (json['coins'] as num).toInt(),
  bonusCoins: (json['bonusCoins'] as num?)?.toInt() ?? 0,
  price: (json['price'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'NGN',
  displayPrice: json['displayPrice'] as String?,
  icon: json['icon'] as String,
  featured: json['featured'] as bool? ?? false,
  active: json['active'] as bool? ?? true,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$CoinBundleToJson(_CoinBundle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coins': instance.coins,
      'bonusCoins': instance.bonusCoins,
      'price': instance.price,
      'currency': instance.currency,
      'displayPrice': instance.displayPrice,
      'icon': instance.icon,
      'featured': instance.featured,
      'active': instance.active,
      'metadata': instance.metadata,
    };
