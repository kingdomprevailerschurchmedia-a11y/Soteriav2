// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_bundle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoinBundle {

 String get id; String get name; int get coins; int get bonusCoins; double get price; String get currency; String? get displayPrice; String get icon; bool get featured; bool get active; Map<String, dynamic> get metadata;
/// Create a copy of CoinBundle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinBundleCopyWith<CoinBundle> get copyWith => _$CoinBundleCopyWithImpl<CoinBundle>(this as CoinBundle, _$identity);

  /// Serializes this CoinBundle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinBundle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.bonusCoins, bonusCoins) || other.bonusCoins == bonusCoins)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.displayPrice, displayPrice) || other.displayPrice == displayPrice)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,coins,bonusCoins,price,currency,displayPrice,icon,featured,active,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'CoinBundle(id: $id, name: $name, coins: $coins, bonusCoins: $bonusCoins, price: $price, currency: $currency, displayPrice: $displayPrice, icon: $icon, featured: $featured, active: $active, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $CoinBundleCopyWith<$Res>  {
  factory $CoinBundleCopyWith(CoinBundle value, $Res Function(CoinBundle) _then) = _$CoinBundleCopyWithImpl;
@useResult
$Res call({
 String id, String name, int coins, int bonusCoins, double price, String currency, String? displayPrice, String icon, bool featured, bool active, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$CoinBundleCopyWithImpl<$Res>
    implements $CoinBundleCopyWith<$Res> {
  _$CoinBundleCopyWithImpl(this._self, this._then);

  final CoinBundle _self;
  final $Res Function(CoinBundle) _then;

/// Create a copy of CoinBundle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coins = null,Object? bonusCoins = null,Object? price = null,Object? currency = null,Object? displayPrice = freezed,Object? icon = null,Object? featured = null,Object? active = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,bonusCoins: null == bonusCoins ? _self.bonusCoins : bonusCoins // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,displayPrice: freezed == displayPrice ? _self.displayPrice : displayPrice // ignore: cast_nullable_to_non_nullable
as String?,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinBundle].
extension CoinBundlePatterns on CoinBundle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinBundle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinBundle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinBundle value)  $default,){
final _that = this;
switch (_that) {
case _CoinBundle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinBundle value)?  $default,){
final _that = this;
switch (_that) {
case _CoinBundle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int coins,  int bonusCoins,  double price,  String currency,  String? displayPrice,  String icon,  bool featured,  bool active,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinBundle() when $default != null:
return $default(_that.id,_that.name,_that.coins,_that.bonusCoins,_that.price,_that.currency,_that.displayPrice,_that.icon,_that.featured,_that.active,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int coins,  int bonusCoins,  double price,  String currency,  String? displayPrice,  String icon,  bool featured,  bool active,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _CoinBundle():
return $default(_that.id,_that.name,_that.coins,_that.bonusCoins,_that.price,_that.currency,_that.displayPrice,_that.icon,_that.featured,_that.active,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int coins,  int bonusCoins,  double price,  String currency,  String? displayPrice,  String icon,  bool featured,  bool active,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _CoinBundle() when $default != null:
return $default(_that.id,_that.name,_that.coins,_that.bonusCoins,_that.price,_that.currency,_that.displayPrice,_that.icon,_that.featured,_that.active,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinBundle implements CoinBundle {
  const _CoinBundle({required this.id, required this.name, required this.coins, this.bonusCoins = 0, required this.price, this.currency = 'NGN', this.displayPrice, required this.icon, this.featured = false, this.active = true, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _CoinBundle.fromJson(Map<String, dynamic> json) => _$CoinBundleFromJson(json);

@override final  String id;
@override final  String name;
@override final  int coins;
@override@JsonKey() final  int bonusCoins;
@override final  double price;
@override@JsonKey() final  String currency;
@override final  String? displayPrice;
@override final  String icon;
@override@JsonKey() final  bool featured;
@override@JsonKey() final  bool active;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of CoinBundle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinBundleCopyWith<_CoinBundle> get copyWith => __$CoinBundleCopyWithImpl<_CoinBundle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinBundleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinBundle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.bonusCoins, bonusCoins) || other.bonusCoins == bonusCoins)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.displayPrice, displayPrice) || other.displayPrice == displayPrice)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,coins,bonusCoins,price,currency,displayPrice,icon,featured,active,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'CoinBundle(id: $id, name: $name, coins: $coins, bonusCoins: $bonusCoins, price: $price, currency: $currency, displayPrice: $displayPrice, icon: $icon, featured: $featured, active: $active, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$CoinBundleCopyWith<$Res> implements $CoinBundleCopyWith<$Res> {
  factory _$CoinBundleCopyWith(_CoinBundle value, $Res Function(_CoinBundle) _then) = __$CoinBundleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int coins, int bonusCoins, double price, String currency, String? displayPrice, String icon, bool featured, bool active, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$CoinBundleCopyWithImpl<$Res>
    implements _$CoinBundleCopyWith<$Res> {
  __$CoinBundleCopyWithImpl(this._self, this._then);

  final _CoinBundle _self;
  final $Res Function(_CoinBundle) _then;

/// Create a copy of CoinBundle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coins = null,Object? bonusCoins = null,Object? price = null,Object? currency = null,Object? displayPrice = freezed,Object? icon = null,Object? featured = null,Object? active = null,Object? metadata = null,}) {
  return _then(_CoinBundle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,bonusCoins: null == bonusCoins ? _self.bonusCoins : bonusCoins // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,displayPrice: freezed == displayPrice ? _self.displayPrice : displayPrice // ignore: cast_nullable_to_non_nullable
as String?,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
