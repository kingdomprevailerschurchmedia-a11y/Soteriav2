// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_tier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankTier {

 String get id; String get name; int get minPoints; int get maxPoints; int get displayOrder; int get promotionThreshold; int get demotionThreshold; String get visualToken;
/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankTierCopyWith<RankTier> get copyWith => _$RankTierCopyWithImpl<RankTier>(this as RankTier, _$identity);

  /// Serializes this RankTier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankTier&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.minPoints, minPoints) || other.minPoints == minPoints)&&(identical(other.maxPoints, maxPoints) || other.maxPoints == maxPoints)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.promotionThreshold, promotionThreshold) || other.promotionThreshold == promotionThreshold)&&(identical(other.demotionThreshold, demotionThreshold) || other.demotionThreshold == demotionThreshold)&&(identical(other.visualToken, visualToken) || other.visualToken == visualToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,minPoints,maxPoints,displayOrder,promotionThreshold,demotionThreshold,visualToken);

@override
String toString() {
  return 'RankTier(id: $id, name: $name, minPoints: $minPoints, maxPoints: $maxPoints, displayOrder: $displayOrder, promotionThreshold: $promotionThreshold, demotionThreshold: $demotionThreshold, visualToken: $visualToken)';
}


}

/// @nodoc
abstract mixin class $RankTierCopyWith<$Res>  {
  factory $RankTierCopyWith(RankTier value, $Res Function(RankTier) _then) = _$RankTierCopyWithImpl;
@useResult
$Res call({
 String id, String name, int minPoints, int maxPoints, int displayOrder, int promotionThreshold, int demotionThreshold, String visualToken
});




}
/// @nodoc
class _$RankTierCopyWithImpl<$Res>
    implements $RankTierCopyWith<$Res> {
  _$RankTierCopyWithImpl(this._self, this._then);

  final RankTier _self;
  final $Res Function(RankTier) _then;

/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? minPoints = null,Object? maxPoints = null,Object? displayOrder = null,Object? promotionThreshold = null,Object? demotionThreshold = null,Object? visualToken = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,maxPoints: null == maxPoints ? _self.maxPoints : maxPoints // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,promotionThreshold: null == promotionThreshold ? _self.promotionThreshold : promotionThreshold // ignore: cast_nullable_to_non_nullable
as int,demotionThreshold: null == demotionThreshold ? _self.demotionThreshold : demotionThreshold // ignore: cast_nullable_to_non_nullable
as int,visualToken: null == visualToken ? _self.visualToken : visualToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RankTier].
extension RankTierPatterns on RankTier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankTier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankTier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankTier value)  $default,){
final _that = this;
switch (_that) {
case _RankTier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankTier value)?  $default,){
final _that = this;
switch (_that) {
case _RankTier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int minPoints,  int maxPoints,  int displayOrder,  int promotionThreshold,  int demotionThreshold,  String visualToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankTier() when $default != null:
return $default(_that.id,_that.name,_that.minPoints,_that.maxPoints,_that.displayOrder,_that.promotionThreshold,_that.demotionThreshold,_that.visualToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int minPoints,  int maxPoints,  int displayOrder,  int promotionThreshold,  int demotionThreshold,  String visualToken)  $default,) {final _that = this;
switch (_that) {
case _RankTier():
return $default(_that.id,_that.name,_that.minPoints,_that.maxPoints,_that.displayOrder,_that.promotionThreshold,_that.demotionThreshold,_that.visualToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int minPoints,  int maxPoints,  int displayOrder,  int promotionThreshold,  int demotionThreshold,  String visualToken)?  $default,) {final _that = this;
switch (_that) {
case _RankTier() when $default != null:
return $default(_that.id,_that.name,_that.minPoints,_that.maxPoints,_that.displayOrder,_that.promotionThreshold,_that.demotionThreshold,_that.visualToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankTier implements RankTier {
  const _RankTier({required this.id, required this.name, required this.minPoints, required this.maxPoints, required this.displayOrder, required this.promotionThreshold, required this.demotionThreshold, required this.visualToken});
  factory _RankTier.fromJson(Map<String, dynamic> json) => _$RankTierFromJson(json);

@override final  String id;
@override final  String name;
@override final  int minPoints;
@override final  int maxPoints;
@override final  int displayOrder;
@override final  int promotionThreshold;
@override final  int demotionThreshold;
@override final  String visualToken;

/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankTierCopyWith<_RankTier> get copyWith => __$RankTierCopyWithImpl<_RankTier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankTierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankTier&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.minPoints, minPoints) || other.minPoints == minPoints)&&(identical(other.maxPoints, maxPoints) || other.maxPoints == maxPoints)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.promotionThreshold, promotionThreshold) || other.promotionThreshold == promotionThreshold)&&(identical(other.demotionThreshold, demotionThreshold) || other.demotionThreshold == demotionThreshold)&&(identical(other.visualToken, visualToken) || other.visualToken == visualToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,minPoints,maxPoints,displayOrder,promotionThreshold,demotionThreshold,visualToken);

@override
String toString() {
  return 'RankTier(id: $id, name: $name, minPoints: $minPoints, maxPoints: $maxPoints, displayOrder: $displayOrder, promotionThreshold: $promotionThreshold, demotionThreshold: $demotionThreshold, visualToken: $visualToken)';
}


}

/// @nodoc
abstract mixin class _$RankTierCopyWith<$Res> implements $RankTierCopyWith<$Res> {
  factory _$RankTierCopyWith(_RankTier value, $Res Function(_RankTier) _then) = __$RankTierCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int minPoints, int maxPoints, int displayOrder, int promotionThreshold, int demotionThreshold, String visualToken
});




}
/// @nodoc
class __$RankTierCopyWithImpl<$Res>
    implements _$RankTierCopyWith<$Res> {
  __$RankTierCopyWithImpl(this._self, this._then);

  final _RankTier _self;
  final $Res Function(_RankTier) _then;

/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? minPoints = null,Object? maxPoints = null,Object? displayOrder = null,Object? promotionThreshold = null,Object? demotionThreshold = null,Object? visualToken = null,}) {
  return _then(_RankTier(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,maxPoints: null == maxPoints ? _self.maxPoints : maxPoints // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,promotionThreshold: null == promotionThreshold ? _self.promotionThreshold : promotionThreshold // ignore: cast_nullable_to_non_nullable
as int,demotionThreshold: null == demotionThreshold ? _self.demotionThreshold : demotionThreshold // ignore: cast_nullable_to_non_nullable
as int,visualToken: null == visualToken ? _self.visualToken : visualToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
