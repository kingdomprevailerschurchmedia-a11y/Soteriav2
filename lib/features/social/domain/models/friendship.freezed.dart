// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendship.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Friendship {

 String get id; List<String> get userIds; DateTime get createdAt; Map<String, dynamic> get metadata;
/// Create a copy of Friendship
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendshipCopyWith<Friendship> get copyWith => _$FriendshipCopyWithImpl<Friendship>(this as Friendship, _$identity);

  /// Serializes this Friendship to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Friendship&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.userIds, userIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(userIds),createdAt,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Friendship(id: $id, userIds: $userIds, createdAt: $createdAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $FriendshipCopyWith<$Res>  {
  factory $FriendshipCopyWith(Friendship value, $Res Function(Friendship) _then) = _$FriendshipCopyWithImpl;
@useResult
$Res call({
 String id, List<String> userIds, DateTime createdAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$FriendshipCopyWithImpl<$Res>
    implements $FriendshipCopyWith<$Res> {
  _$FriendshipCopyWithImpl(this._self, this._then);

  final Friendship _self;
  final $Res Function(Friendship) _then;

/// Create a copy of Friendship
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userIds = null,Object? createdAt = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userIds: null == userIds ? _self.userIds : userIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Friendship].
extension FriendshipPatterns on Friendship {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Friendship value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Friendship() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Friendship value)  $default,){
final _that = this;
switch (_that) {
case _Friendship():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Friendship value)?  $default,){
final _that = this;
switch (_that) {
case _Friendship() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<String> userIds,  DateTime createdAt,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Friendship() when $default != null:
return $default(_that.id,_that.userIds,_that.createdAt,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<String> userIds,  DateTime createdAt,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _Friendship():
return $default(_that.id,_that.userIds,_that.createdAt,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<String> userIds,  DateTime createdAt,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _Friendship() when $default != null:
return $default(_that.id,_that.userIds,_that.createdAt,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Friendship implements Friendship {
  const _Friendship({required this.id, required final  List<String> userIds, required this.createdAt, final  Map<String, dynamic> metadata = const {}}): _userIds = userIds,_metadata = metadata;
  factory _Friendship.fromJson(Map<String, dynamic> json) => _$FriendshipFromJson(json);

@override final  String id;
 final  List<String> _userIds;
@override List<String> get userIds {
  if (_userIds is EqualUnmodifiableListView) return _userIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userIds);
}

@override final  DateTime createdAt;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of Friendship
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendshipCopyWith<_Friendship> get copyWith => __$FriendshipCopyWithImpl<_Friendship>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendshipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Friendship&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._userIds, _userIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_userIds),createdAt,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Friendship(id: $id, userIds: $userIds, createdAt: $createdAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$FriendshipCopyWith<$Res> implements $FriendshipCopyWith<$Res> {
  factory _$FriendshipCopyWith(_Friendship value, $Res Function(_Friendship) _then) = __$FriendshipCopyWithImpl;
@override @useResult
$Res call({
 String id, List<String> userIds, DateTime createdAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$FriendshipCopyWithImpl<$Res>
    implements _$FriendshipCopyWith<$Res> {
  __$FriendshipCopyWithImpl(this._self, this._then);

  final _Friendship _self;
  final $Res Function(_Friendship) _then;

/// Create a copy of Friendship
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userIds = null,Object? createdAt = null,Object? metadata = null,}) {
  return _then(_Friendship(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userIds: null == userIds ? _self._userIds : userIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
