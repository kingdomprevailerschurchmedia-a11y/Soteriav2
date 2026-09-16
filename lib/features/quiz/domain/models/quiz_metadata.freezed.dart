// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizMetadata {

 String get title; String? get description; String get authorId; int get playCount; double get rating; List<String> get tags; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of QuizMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizMetadataCopyWith<QuizMetadata> get copyWith => _$QuizMetadataCopyWithImpl<QuizMetadata>(this as QuizMetadata, _$identity);

  /// Serializes this QuizMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.playCount, playCount) || other.playCount == playCount)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,authorId,playCount,rating,const DeepCollectionEquality().hash(tags),createdAt,updatedAt);

@override
String toString() {
  return 'QuizMetadata(title: $title, description: $description, authorId: $authorId, playCount: $playCount, rating: $rating, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $QuizMetadataCopyWith<$Res>  {
  factory $QuizMetadataCopyWith(QuizMetadata value, $Res Function(QuizMetadata) _then) = _$QuizMetadataCopyWithImpl;
@useResult
$Res call({
 String title, String? description, String authorId, int playCount, double rating, List<String> tags, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$QuizMetadataCopyWithImpl<$Res>
    implements $QuizMetadataCopyWith<$Res> {
  _$QuizMetadataCopyWithImpl(this._self, this._then);

  final QuizMetadata _self;
  final $Res Function(QuizMetadata) _then;

/// Create a copy of QuizMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? authorId = null,Object? playCount = null,Object? rating = null,Object? tags = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,playCount: null == playCount ? _self.playCount : playCount // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizMetadata].
extension QuizMetadataPatterns on QuizMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizMetadata value)  $default,){
final _that = this;
switch (_that) {
case _QuizMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _QuizMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? description,  String authorId,  int playCount,  double rating,  List<String> tags,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizMetadata() when $default != null:
return $default(_that.title,_that.description,_that.authorId,_that.playCount,_that.rating,_that.tags,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? description,  String authorId,  int playCount,  double rating,  List<String> tags,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _QuizMetadata():
return $default(_that.title,_that.description,_that.authorId,_that.playCount,_that.rating,_that.tags,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? description,  String authorId,  int playCount,  double rating,  List<String> tags,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _QuizMetadata() when $default != null:
return $default(_that.title,_that.description,_that.authorId,_that.playCount,_that.rating,_that.tags,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizMetadata implements QuizMetadata {
  const _QuizMetadata({required this.title, this.description, required this.authorId, this.playCount = 0, this.rating = 0.0, final  List<String> tags = const [], required this.createdAt, required this.updatedAt}): _tags = tags;
  factory _QuizMetadata.fromJson(Map<String, dynamic> json) => _$QuizMetadataFromJson(json);

@override final  String title;
@override final  String? description;
@override final  String authorId;
@override@JsonKey() final  int playCount;
@override@JsonKey() final  double rating;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of QuizMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizMetadataCopyWith<_QuizMetadata> get copyWith => __$QuizMetadataCopyWithImpl<_QuizMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.playCount, playCount) || other.playCount == playCount)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,authorId,playCount,rating,const DeepCollectionEquality().hash(_tags),createdAt,updatedAt);

@override
String toString() {
  return 'QuizMetadata(title: $title, description: $description, authorId: $authorId, playCount: $playCount, rating: $rating, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$QuizMetadataCopyWith<$Res> implements $QuizMetadataCopyWith<$Res> {
  factory _$QuizMetadataCopyWith(_QuizMetadata value, $Res Function(_QuizMetadata) _then) = __$QuizMetadataCopyWithImpl;
@override @useResult
$Res call({
 String title, String? description, String authorId, int playCount, double rating, List<String> tags, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$QuizMetadataCopyWithImpl<$Res>
    implements _$QuizMetadataCopyWith<$Res> {
  __$QuizMetadataCopyWithImpl(this._self, this._then);

  final _QuizMetadata _self;
  final $Res Function(_QuizMetadata) _then;

/// Create a copy of QuizMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? authorId = null,Object? playCount = null,Object? rating = null,Object? tags = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_QuizMetadata(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,playCount: null == playCount ? _self.playCount : playCount // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
