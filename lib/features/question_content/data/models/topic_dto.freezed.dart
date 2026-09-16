// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopicDto {

 String get id; String get subcategoryId; String get name; String get description; String get slug; int get displayOrder; bool get active; Map<String, dynamic> get metadata; String? get createdAt; String? get updatedAt;
/// Create a copy of TopicDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopicDtoCopyWith<TopicDto> get copyWith => _$TopicDtoCopyWithImpl<TopicDto>(this as TopicDto, _$identity);

  /// Serializes this TopicDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopicDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subcategoryId,name,description,slug,displayOrder,active,const DeepCollectionEquality().hash(metadata),createdAt,updatedAt);

@override
String toString() {
  return 'TopicDto(id: $id, subcategoryId: $subcategoryId, name: $name, description: $description, slug: $slug, displayOrder: $displayOrder, active: $active, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TopicDtoCopyWith<$Res>  {
  factory $TopicDtoCopyWith(TopicDto value, $Res Function(TopicDto) _then) = _$TopicDtoCopyWithImpl;
@useResult
$Res call({
 String id, String subcategoryId, String name, String description, String slug, int displayOrder, bool active, Map<String, dynamic> metadata, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$TopicDtoCopyWithImpl<$Res>
    implements $TopicDtoCopyWith<$Res> {
  _$TopicDtoCopyWithImpl(this._self, this._then);

  final TopicDto _self;
  final $Res Function(TopicDto) _then;

/// Create a copy of TopicDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subcategoryId = null,Object? name = null,Object? description = null,Object? slug = null,Object? displayOrder = null,Object? active = null,Object? metadata = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: null == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [TopicDto].
extension TopicDtoPatterns on TopicDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopicDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopicDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopicDto value)  $default,){
final _that = this;
switch (_that) {
case _TopicDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopicDto value)?  $default,){
final _that = this;
switch (_that) {
case _TopicDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subcategoryId,  String name,  String description,  String slug,  int displayOrder,  bool active,  Map<String, dynamic> metadata,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopicDto() when $default != null:
return $default(_that.id,_that.subcategoryId,_that.name,_that.description,_that.slug,_that.displayOrder,_that.active,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subcategoryId,  String name,  String description,  String slug,  int displayOrder,  bool active,  Map<String, dynamic> metadata,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TopicDto():
return $default(_that.id,_that.subcategoryId,_that.name,_that.description,_that.slug,_that.displayOrder,_that.active,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subcategoryId,  String name,  String description,  String slug,  int displayOrder,  bool active,  Map<String, dynamic> metadata,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TopicDto() when $default != null:
return $default(_that.id,_that.subcategoryId,_that.name,_that.description,_that.slug,_that.displayOrder,_that.active,_that.metadata,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopicDto implements TopicDto {
  const _TopicDto({required this.id, required this.subcategoryId, required this.name, required this.description, required this.slug, this.displayOrder = 0, this.active = true, final  Map<String, dynamic> metadata = const {}, this.createdAt, this.updatedAt}): _metadata = metadata;
  factory _TopicDto.fromJson(Map<String, dynamic> json) => _$TopicDtoFromJson(json);

@override final  String id;
@override final  String subcategoryId;
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

/// Create a copy of TopicDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopicDtoCopyWith<_TopicDto> get copyWith => __$TopicDtoCopyWithImpl<_TopicDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopicDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopicDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subcategoryId,name,description,slug,displayOrder,active,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt);

@override
String toString() {
  return 'TopicDto(id: $id, subcategoryId: $subcategoryId, name: $name, description: $description, slug: $slug, displayOrder: $displayOrder, active: $active, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TopicDtoCopyWith<$Res> implements $TopicDtoCopyWith<$Res> {
  factory _$TopicDtoCopyWith(_TopicDto value, $Res Function(_TopicDto) _then) = __$TopicDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String subcategoryId, String name, String description, String slug, int displayOrder, bool active, Map<String, dynamic> metadata, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$TopicDtoCopyWithImpl<$Res>
    implements _$TopicDtoCopyWith<$Res> {
  __$TopicDtoCopyWithImpl(this._self, this._then);

  final _TopicDto _self;
  final $Res Function(_TopicDto) _then;

/// Create a copy of TopicDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subcategoryId = null,Object? name = null,Object? description = null,Object? slug = null,Object? displayOrder = null,Object? active = null,Object? metadata = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TopicDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: null == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
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
