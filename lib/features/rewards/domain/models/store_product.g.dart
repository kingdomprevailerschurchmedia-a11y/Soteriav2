// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoreProduct _$StoreProductFromJson(Map<String, dynamic> json) =>
    _StoreProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$StoreProductCategoryEnumMap, json['category']),
      quantity: (json['quantity'] as num).toInt(),
      bonusQuantity: (json['bonusQuantity'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String? ?? 'NGN',
      displayPrice: json['displayPrice'] as String?,
      icon: json['icon'] as String,
      isPopular: json['isPopular'] as bool? ?? false,
      isBestValue: json['isBestValue'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$StoreProductToJson(_StoreProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': _$StoreProductCategoryEnumMap[instance.category]!,
      'quantity': instance.quantity,
      'bonusQuantity': instance.bonusQuantity,
      'price': instance.price,
      'currencyCode': instance.currencyCode,
      'displayPrice': instance.displayPrice,
      'icon': instance.icon,
      'isPopular': instance.isPopular,
      'isBestValue': instance.isBestValue,
      'isActive': instance.isActive,
      'metadata': instance.metadata,
    };

const _$StoreProductCategoryEnumMap = {
  StoreProductCategory.coins: 'coins',
  StoreProductCategory.tokens: 'tokens',
  StoreProductCategory.pro: 'pro',
  StoreProductCategory.bundle: 'bundle',
};
