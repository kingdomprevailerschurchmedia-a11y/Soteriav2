// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionCategory {

 String get id; String get name; String get icon; String? get description; List<String> get tags;
/// Create a copy of QuestionCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCategoryCopyWith<QuestionCategory> get copyWith => _$QuestionCategoryCopyWithImpl<QuestionCategory>(this as QuestionCategory, _$identity);

  /// Serializes this QuestionCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,description,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'QuestionCategory(id: $id, name: $name, icon: $icon, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $QuestionCategoryCopyWith<$Res>  {
  factory $QuestionCategoryCopyWith(QuestionCategory value, $Res Function(QuestionCategory) _then) = _$QuestionCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String icon, String? description, List<String> tags
});




}
/// @nodoc
class _$QuestionCategoryCopyWithImpl<$Res>
    implements $QuestionCategoryCopyWith<$Res> {
  _$QuestionCategoryCopyWithImpl(this._self, this._then);

  final QuestionCategory _self;
  final $Res Function(QuestionCategory) _then;

/// Create a copy of QuestionCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = null,Object? description = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionCategory].
extension QuestionCategoryPatterns on QuestionCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionCategory value)  $default,){
final _that = this;
switch (_that) {
case _QuestionCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionCategory value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String icon,  String? description,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionCategory() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.description,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String icon,  String? description,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _QuestionCategory():
return $default(_that.id,_that.name,_that.icon,_that.description,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String icon,  String? description,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _QuestionCategory() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.description,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionCategory implements QuestionCategory {
  const _QuestionCategory({required this.id, required this.name, required this.icon, this.description, final  List<String> tags = const []}): _tags = tags;
  factory _QuestionCategory.fromJson(Map<String, dynamic> json) => _$QuestionCategoryFromJson(json);

@override final  String id;
@override final  String name;
@override final  String icon;
@override final  String? description;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of QuestionCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCategoryCopyWith<_QuestionCategory> get copyWith => __$QuestionCategoryCopyWithImpl<_QuestionCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,description,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'QuestionCategory(id: $id, name: $name, icon: $icon, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$QuestionCategoryCopyWith<$Res> implements $QuestionCategoryCopyWith<$Res> {
  factory _$QuestionCategoryCopyWith(_QuestionCategory value, $Res Function(_QuestionCategory) _then) = __$QuestionCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String icon, String? description, List<String> tags
});




}
/// @nodoc
class __$QuestionCategoryCopyWithImpl<$Res>
    implements _$QuestionCategoryCopyWith<$Res> {
  __$QuestionCategoryCopyWithImpl(this._self, this._then);

  final _QuestionCategory _self;
  final $Res Function(_QuestionCategory) _then;

/// Create a copy of QuestionCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = null,Object? description = freezed,Object? tags = null,}) {
  return _then(_QuestionCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
