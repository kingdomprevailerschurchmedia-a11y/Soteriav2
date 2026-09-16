// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subcategory_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubcategoryDto {

 String get id; String get categoryId; String get name; String get description; String get slug; int get displayOrder; bool get active; Map<String, dynamic> get metadata; String? get createdAt; String? get updatedAt;
/// Create a copy of SubcategoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubcategoryDtoCopyWith<SubcategoryDto> get copyWith => _$SubcategoryDtoCopyWithImpl<SubcategoryDto>(this as SubcategoryDto, _$identity);

  /// Serializes this SubcategoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubcategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,description,slug,displayOrder,active,const DeepCollectionEquality().hash(metadata),createdAt,updatedAt);

@override
String toString() {
  return 'SubcategoryDto(id: $id, categoryId: $categoryId, name: $name, description: $description, slug: $slug, displayOrder: $displayOrder, active: $active, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SubcategoryDtoCopyWith<$Res>  {
  factory $SubcategoryDtoCopyWith(SubcategoryDto value, $Res Function(SubcategoryDto) _then) = _$SubcategoryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String categoryId, String name, String description, String slug, int displayOrder, bool active, Map<String, dynamic> metadata, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$SubcategoryDtoCopyWithImpl<$Res>
    implements $SubcategoryDtoCopyWith<$Res> {
  _$SubcategoryDtoCopyWithImpl(this._self, this._then);

  final SubcategoryDto _self;
  final $Res Function(SubcategoryDto) _then;

/// Create a copy of SubcategoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? description = null,Object? slug = null,Object? displayOrder = null,Object? active = null,Object? metadata = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubcategoryDto].
extension SubcategoryDtoPatterns on SubcategoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubcategoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubcategoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubcategoryDto value)  $default,){
final _that = this;
switch (_that) {
case _SubcategoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubcategoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubcategoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String categoryId,  String name,  String description,  String slug,  int displayOrder,  bool active,  Map<String, dynamic> metadata,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubcategoryDto() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.slug,_that.displayOrder,_that.active,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String categoryId,  String name,  String description,  String slug,  int displayOrder,  bool active,  Map<String, dynamic> metadata,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SubcategoryDto():
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.slug,_that.displayOrder,_that.active,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String categoryId,  String name,  String description,  String slug,  int displayOrder,  bool active,  Map<String, dynamic> metadata,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SubcategoryDto() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.slug,_that.displayOrder,_that.active,_that.metadata,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubcategoryDto implements SubcategoryDto {
  const _SubcategoryDto({required this.id, required this.categoryId, required this.name, required this.description, required this.slug, this.displayOrder = 0, this.active = true, final  Map<String, dynamic> metadata = const {}, this.createdAt, this.updatedAt}): _metadata = metadata;
  factory _SubcategoryDto.fromJson(Map<String, dynamic> json) => _$SubcategoryDtoFromJson(json);

@override final  String id;
@override final  String categoryId;
@override final  String name;
@override final  String description;
@override final  String slug;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool active;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of SubcategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubcategoryDtoCopyWith<_SubcategoryDto> get copyWith => __$SubcategoryDtoCopyWithImpl<_SubcategoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubcategoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubcategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,description,slug,displayOrder,active,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt);

@override
String toString() {
  return 'SubcategoryDto(id: $id, categoryId: $categoryId, name: $name, description: $description, slug: $slug, displayOrder: $displayOrder, active: $active, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SubcategoryDtoCopyWith<$Res> implements $SubcategoryDtoCopyWith<$Res> {
  factory _$SubcategoryDtoCopyWith(_SubcategoryDto value, $Res Function(_SubcategoryDto) _then) = __$SubcategoryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String categoryId, String name, String description, String slug, int displayOrder, bool active, Map<String, dynamic> metadata, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$SubcategoryDtoCopyWithImpl<$Res>
    implements _$SubcategoryDtoCopyWith<$Res> {
  __$SubcategoryDtoCopyWithImpl(this._self, this._then);

  final _SubcategoryDto _self;
  final $Res Function(_SubcategoryDto) _then;

/// Create a copy of SubcategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? description = null,Object? slug = null,Object? displayOrder = null,Object? active = null,Object? metadata = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SubcategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
