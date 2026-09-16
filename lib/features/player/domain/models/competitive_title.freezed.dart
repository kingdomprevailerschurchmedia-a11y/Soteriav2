// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_title.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveTitle {

 String get id; String get name; String get description; bool get isSecret; int get priority;
/// Create a copy of CompetitiveTitle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveTitleCopyWith<CompetitiveTitle> get copyWith => _$CompetitiveTitleCopyWithImpl<CompetitiveTitle>(this as CompetitiveTitle, _$identity);

  /// Serializes this CompetitiveTitle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveTitle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSecret, isSecret) || other.isSecret == isSecret)&&(identical(other.priority, priority) || other.priority == priority));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isSecret,priority);

@override
String toString() {
  return 'CompetitiveTitle(id: $id, name: $name, description: $description, isSecret: $isSecret, priority: $priority)';
}


}

/// @nodoc
abstract mixin class $CompetitiveTitleCopyWith<$Res>  {
  factory $CompetitiveTitleCopyWith(CompetitiveTitle value, $Res Function(CompetitiveTitle) _then) = _$CompetitiveTitleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, bool isSecret, int priority
});




}
/// @nodoc
class _$CompetitiveTitleCopyWithImpl<$Res>
    implements $CompetitiveTitleCopyWith<$Res> {
  _$CompetitiveTitleCopyWithImpl(this._self, this._then);

  final CompetitiveTitle _self;
  final $Res Function(CompetitiveTitle) _then;

/// Create a copy of CompetitiveTitle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? isSecret = null,Object? priority = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isSecret: null == isSecret ? _self.isSecret : isSecret // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveTitle].
extension CompetitiveTitlePatterns on CompetitiveTitle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveTitle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveTitle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveTitle value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveTitle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveTitle value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveTitle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  bool isSecret,  int priority)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveTitle() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isSecret,_that.priority);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  bool isSecret,  int priority)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveTitle():
return $default(_that.id,_that.name,_that.description,_that.isSecret,_that.priority);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  bool isSecret,  int priority)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveTitle() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isSecret,_that.priority);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveTitle implements CompetitiveTitle {
  const _CompetitiveTitle({required this.id, required this.name, required this.description, this.isSecret = false, this.priority = 0});
  factory _CompetitiveTitle.fromJson(Map<String, dynamic> json) => _$CompetitiveTitleFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override@JsonKey() final  bool isSecret;
@override@JsonKey() final  int priority;

/// Create a copy of CompetitiveTitle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveTitleCopyWith<_CompetitiveTitle> get copyWith => __$CompetitiveTitleCopyWithImpl<_CompetitiveTitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveTitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveTitle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSecret, isSecret) || other.isSecret == isSecret)&&(identical(other.priority, priority) || other.priority == priority));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isSecret,priority);

@override
String toString() {
  return 'CompetitiveTitle(id: $id, name: $name, description: $description, isSecret: $isSecret, priority: $priority)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveTitleCopyWith<$Res> implements $CompetitiveTitleCopyWith<$Res> {
  factory _$CompetitiveTitleCopyWith(_CompetitiveTitle value, $Res Function(_CompetitiveTitle) _then) = __$CompetitiveTitleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, bool isSecret, int priority
});




}
/// @nodoc
class __$CompetitiveTitleCopyWithImpl<$Res>
    implements _$CompetitiveTitleCopyWith<$Res> {
  __$CompetitiveTitleCopyWithImpl(this._self, this._then);

  final _CompetitiveTitle _self;
  final $Res Function(_CompetitiveTitle) _then;

/// Create a copy of CompetitiveTitle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? isSecret = null,Object? priority = null,}) {
  return _then(_CompetitiveTitle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isSecret: null == isSecret ? _self.isSecret : isSecret // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
