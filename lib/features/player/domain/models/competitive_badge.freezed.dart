// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_badge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveBadge {

 String get id; String get name; String get description; String get iconAsset; BadgeCategory get category; bool get isHidden; int get displayOrder;
/// Create a copy of CompetitiveBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveBadgeCopyWith<CompetitiveBadge> get copyWith => _$CompetitiveBadgeCopyWithImpl<CompetitiveBadge>(this as CompetitiveBadge, _$identity);

  /// Serializes this CompetitiveBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveBadge&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset)&&(identical(other.category, category) || other.category == category)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,iconAsset,category,isHidden,displayOrder);

@override
String toString() {
  return 'CompetitiveBadge(id: $id, name: $name, description: $description, iconAsset: $iconAsset, category: $category, isHidden: $isHidden, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $CompetitiveBadgeCopyWith<$Res>  {
  factory $CompetitiveBadgeCopyWith(CompetitiveBadge value, $Res Function(CompetitiveBadge) _then) = _$CompetitiveBadgeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String iconAsset, BadgeCategory category, bool isHidden, int displayOrder
});




}
/// @nodoc
class _$CompetitiveBadgeCopyWithImpl<$Res>
    implements $CompetitiveBadgeCopyWith<$Res> {
  _$CompetitiveBadgeCopyWithImpl(this._self, this._then);

  final CompetitiveBadge _self;
  final $Res Function(CompetitiveBadge) _then;

/// Create a copy of CompetitiveBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? iconAsset = null,Object? category = null,Object? isHidden = null,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconAsset: null == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BadgeCategory,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveBadge].
extension CompetitiveBadgePatterns on CompetitiveBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveBadge value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveBadge value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveBadge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String iconAsset,  BadgeCategory category,  bool isHidden,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveBadge() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.iconAsset,_that.category,_that.isHidden,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String iconAsset,  BadgeCategory category,  bool isHidden,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveBadge():
return $default(_that.id,_that.name,_that.description,_that.iconAsset,_that.category,_that.isHidden,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String iconAsset,  BadgeCategory category,  bool isHidden,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveBadge() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.iconAsset,_that.category,_that.isHidden,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveBadge implements CompetitiveBadge {
  const _CompetitiveBadge({required this.id, required this.name, required this.description, required this.iconAsset, required this.category, this.isHidden = false, this.displayOrder = 0});
  factory _CompetitiveBadge.fromJson(Map<String, dynamic> json) => _$CompetitiveBadgeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String iconAsset;
@override final  BadgeCategory category;
@override@JsonKey() final  bool isHidden;
@override@JsonKey() final  int displayOrder;

/// Create a copy of CompetitiveBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveBadgeCopyWith<_CompetitiveBadge> get copyWith => __$CompetitiveBadgeCopyWithImpl<_CompetitiveBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveBadge&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset)&&(identical(other.category, category) || other.category == category)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,iconAsset,category,isHidden,displayOrder);

@override
String toString() {
  return 'CompetitiveBadge(id: $id, name: $name, description: $description, iconAsset: $iconAsset, category: $category, isHidden: $isHidden, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveBadgeCopyWith<$Res> implements $CompetitiveBadgeCopyWith<$Res> {
  factory _$CompetitiveBadgeCopyWith(_CompetitiveBadge value, $Res Function(_CompetitiveBadge) _then) = __$CompetitiveBadgeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String iconAsset, BadgeCategory category, bool isHidden, int displayOrder
});




}
/// @nodoc
class __$CompetitiveBadgeCopyWithImpl<$Res>
    implements _$CompetitiveBadgeCopyWith<$Res> {
  __$CompetitiveBadgeCopyWithImpl(this._self, this._then);

  final _CompetitiveBadge _self;
  final $Res Function(_CompetitiveBadge) _then;

/// Create a copy of CompetitiveBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? iconAsset = null,Object? category = null,Object? isHidden = null,Object? displayOrder = null,}) {
  return _then(_CompetitiveBadge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconAsset: null == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BadgeCategory,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
