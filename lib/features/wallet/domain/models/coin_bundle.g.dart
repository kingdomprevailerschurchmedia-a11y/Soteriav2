// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoinBundle _$CoinBundleFromJson(Map<String, dynamic> json) => _CoinBundle(
  id: json['id'] as String,
  name: json['name'] as String,
  coins: (json['coins'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  icon: json['icon'] as String,
);

Map<String, dynamic> _$CoinBundleToJson(_CoinBundle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coins': instance.coins,
      'price': instance.price,
      'icon': instance.icon,
    };
