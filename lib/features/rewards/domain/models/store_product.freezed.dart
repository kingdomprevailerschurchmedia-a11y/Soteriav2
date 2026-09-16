// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoreProduct {

 String get id; String get name; String get description; StoreProductCategory get category; int get quantity; int get bonusQuantity; double get price; String get currencyCode; String? get displayPrice; String get icon; bool get isPopular; bool get isBestValue; bool get isActive; Map<String, dynamic> get metadata;
/// Create a copy of StoreProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreProductCopyWith<StoreProduct> get copyWith => _$StoreProductCopyWithImpl<StoreProduct>(this as StoreProduct, _$identity);

  /// Serializes this StoreProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.bonusQuantity, bonusQuantity) || other.bonusQuantity == bonusQuantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.displayPrice, displayPrice) || other.displayPrice == displayPrice)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.isBestValue, isBestValue) || other.isBestValue == isBestValue)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,quantity,bonusQuantity,price,currencyCode,displayPrice,icon,isPopular,isBestValue,isActive,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'StoreProduct(id: $id, name: $name, description: $description, category: $category, quantity: $quantity, bonusQuantity: $bonusQuantity, price: $price, currencyCode: $currencyCode, displayPrice: $displayPrice, icon: $icon, isPopular: $isPopular, isBestValue: $isBestValue, isActive: $isActive, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $StoreProductCopyWith<$Res>  {
  factory $StoreProductCopyWith(StoreProduct value, $Res Function(StoreProduct) _then) = _$StoreProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, StoreProductCategory category, int quantity, int bonusQuantity, double price, String currencyCode, String? displayPrice, String icon, bool isPopular, bool isBestValue, bool isActive, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$StoreProductCopyWithImpl<$Res>
    implements $StoreProductCopyWith<$Res> {
  _$StoreProductCopyWithImpl(this._self, this._then);

  final StoreProduct _self;
  final $Res Function(StoreProduct) _then;

/// Create a copy of StoreProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? quantity = null,Object? bonusQuantity = null,Object? price = null,Object? currencyCode = null,Object? displayPrice = freezed,Object? icon = null,Object? isPopular = null,Object? isBestValue = null,Object? isActive = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as StoreProductCategory,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,bonusQuantity: null == bonusQuantity ? _self.bonusQuantity : bonusQuantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,displayPrice: freezed == displayPrice ? _self.displayPrice : displayPrice // ignore: cast_nullable_to_non_nullable
as String?,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,isBestValue: null == isBestValue ? _self.isBestValue : isBestValue // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreProduct].
extension StoreProductPatterns on StoreProduct {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreProduct() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreProduct value)  $default,){
final _that = this;
switch (_that) {
case _StoreProduct():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreProduct value)?  $default,){
final _that = this;
switch (_that) {
case _StoreProduct() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  StoreProductCategory category,  int quantity,  int bonusQuantity,  double price,  String currencyCode,  String? displayPrice,  String icon,  bool isPopular,  bool isBestValue,  bool isActive,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreProduct() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.quantity,_that.bonusQuantity,_that.price,_that.currencyCode,_that.displayPrice,_that.icon,_that.isPopular,_that.isBestValue,_that.isActive,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  StoreProductCategory category,  int quantity,  int bonusQuantity,  double price,  String currencyCode,  String? displayPrice,  String icon,  bool isPopular,  bool isBestValue,  bool isActive,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _StoreProduct():
return $default(_that.id,_that.name,_that.description,_that.category,_that.quantity,_that.bonusQuantity,_that.price,_that.currencyCode,_that.displayPrice,_that.icon,_that.isPopular,_that.isBestValue,_that.isActive,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  StoreProductCategory category,  int quantity,  int bonusQuantity,  double price,  String currencyCode,  String? displayPrice,  String icon,  bool isPopular,  bool isBestValue,  bool isActive,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _StoreProduct() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.quantity,_that.bonusQuantity,_that.price,_that.currencyCode,_that.displayPrice,_that.icon,_that.isPopular,_that.isBestValue,_that.isActive,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoreProduct implements StoreProduct {
  const _StoreProduct({required this.id, required this.name, required this.description, required this.category, required this.quantity, this.bonusQuantity = 0, required this.price, this.currencyCode = 'NGN', this.displayPrice, required this.icon, this.isPopular = false, this.isBestValue = false, this.isActive = true, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _StoreProduct.fromJson(Map<String, dynamic> json) => _$StoreProductFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  StoreProductCategory category;
@override final  int quantity;
@override@JsonKey() final  int bonusQuantity;
@override final  double price;
@override@JsonKey() final  String currencyCode;
@override final  String? displayPrice;
@override final  String icon;
@override@JsonKey() final  bool isPopular;
@override@JsonKey() final  bool isBestValue;
@override@JsonKey() final  bool isActive;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of StoreProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreProductCopyWith<_StoreProduct> get copyWith => __$StoreProductCopyWithImpl<_StoreProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.bonusQuantity, bonusQuantity) || other.bonusQuantity == bonusQuantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.displayPrice, displayPrice) || other.displayPrice == displayPrice)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.isBestValue, isBestValue) || other.isBestValue == isBestValue)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,quantity,bonusQuantity,price,currencyCode,displayPrice,icon,isPopular,isBestValue,isActive,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'StoreProduct(id: $id, name: $name, description: $description, category: $category, quantity: $quantity, bonusQuantity: $bonusQuantity, price: $price, currencyCode: $currencyCode, displayPrice: $displayPrice, icon: $icon, isPopular: $isPopular, isBestValue: $isBestValue, isActive: $isActive, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$StoreProductCopyWith<$Res> implements $StoreProductCopyWith<$Res> {
  factory _$StoreProductCopyWith(_StoreProduct value, $Res Function(_StoreProduct) _then) = __$StoreProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, StoreProductCategory category, int quantity, int bonusQuantity, double price, String currencyCode, String? displayPrice, String icon, bool isPopular, bool isBestValue, bool isActive, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$StoreProductCopyWithImpl<$Res>
    implements _$StoreProductCopyWith<$Res> {
  __$StoreProductCopyWithImpl(this._self, this._then);

  final _StoreProduct _self;
  final $Res Function(_StoreProduct) _then;

/// Create a copy of StoreProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? quantity = null,Object? bonusQuantity = null,Object? price = null,Object? currencyCode = null,Object? displayPrice = freezed,Object? icon = null,Object? isPopular = null,Object? isBestValue = null,Object? isActive = null,Object? metadata = null,}) {
  return _then(_StoreProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as StoreProductCategory,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,bonusQuantity: null == bonusQuantity ? _self.bonusQuantity : bonusQuantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,displayPrice: freezed == displayPrice ? _self.displayPrice : displayPrice // ignore: cast_nullable_to_non_nullable
as String?,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,isBestValue: null == isBestValue ? _self.isBestValue : isBestValue // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
