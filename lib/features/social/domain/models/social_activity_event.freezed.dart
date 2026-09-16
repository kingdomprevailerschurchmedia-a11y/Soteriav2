// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_activity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialActivityEvent {

 String get id; String get userId; String get otherUserId; String get otherDisplayName; SocialActivityType get type; String get message; DateTime get createdAt; Map<String, dynamic>? get metadata;
/// Create a copy of SocialActivityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialActivityEventCopyWith<SocialActivityEvent> get copyWith => _$SocialActivityEventCopyWithImpl<SocialActivityEvent>(this as SocialActivityEvent, _$identity);

  /// Serializes this SocialActivityEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialActivityEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.otherUserId, otherUserId) || other.otherUserId == otherUserId)&&(identical(other.otherDisplayName, otherDisplayName) || other.otherDisplayName == otherDisplayName)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,otherUserId,otherDisplayName,type,message,createdAt,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'SocialActivityEvent(id: $id, userId: $userId, otherUserId: $otherUserId, otherDisplayName: $otherDisplayName, type: $type, message: $message, createdAt: $createdAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $SocialActivityEventCopyWith<$Res>  {
  factory $SocialActivityEventCopyWith(SocialActivityEvent value, $Res Function(SocialActivityEvent) _then) = _$SocialActivityEventCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String otherUserId, String otherDisplayName, SocialActivityType type, String message, DateTime createdAt, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$SocialActivityEventCopyWithImpl<$Res>
    implements $SocialActivityEventCopyWith<$Res> {
  _$SocialActivityEventCopyWithImpl(this._self, this._then);

  final SocialActivityEvent _self;
  final $Res Function(SocialActivityEvent) _then;

/// Create a copy of SocialActivityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? otherUserId = null,Object? otherDisplayName = null,Object? type = null,Object? message = null,Object? createdAt = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,otherUserId: null == otherUserId ? _self.otherUserId : otherUserId // ignore: cast_nullable_to_non_nullable
as String,otherDisplayName: null == otherDisplayName ? _self.otherDisplayName : otherDisplayName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialActivityType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialActivityEvent].
extension SocialActivityEventPatterns on SocialActivityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialActivityEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialActivityEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialActivityEvent value)  $default,){
final _that = this;
switch (_that) {
case _SocialActivityEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialActivityEvent value)?  $default,){
final _that = this;
switch (_that) {
case _SocialActivityEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String otherUserId,  String otherDisplayName,  SocialActivityType type,  String message,  DateTime createdAt,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialActivityEvent() when $default != null:
return $default(_that.id,_that.userId,_that.otherUserId,_that.otherDisplayName,_that.type,_that.message,_that.createdAt,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String otherUserId,  String otherDisplayName,  SocialActivityType type,  String message,  DateTime createdAt,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _SocialActivityEvent():
return $default(_that.id,_that.userId,_that.otherUserId,_that.otherDisplayName,_that.type,_that.message,_that.createdAt,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String otherUserId,  String otherDisplayName,  SocialActivityType type,  String message,  DateTime createdAt,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _SocialActivityEvent() when $default != null:
return $default(_that.id,_that.userId,_that.otherUserId,_that.otherDisplayName,_that.type,_that.message,_that.createdAt,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialActivityEvent implements SocialActivityEvent {
  const _SocialActivityEvent({required this.id, required this.userId, required this.otherUserId, required this.otherDisplayName, required this.type, required this.message, required this.createdAt, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _SocialActivityEvent.fromJson(Map<String, dynamic> json) => _$SocialActivityEventFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String otherUserId;
@override final  String otherDisplayName;
@override final  SocialActivityType type;
@override final  String message;
@override final  DateTime createdAt;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SocialActivityEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialActivityEventCopyWith<_SocialActivityEvent> get copyWith => __$SocialActivityEventCopyWithImpl<_SocialActivityEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialActivityEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialActivityEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.otherUserId, otherUserId) || other.otherUserId == otherUserId)&&(identical(other.otherDisplayName, otherDisplayName) || other.otherDisplayName == otherDisplayName)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,otherUserId,otherDisplayName,type,message,createdAt,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'SocialActivityEvent(id: $id, userId: $userId, otherUserId: $otherUserId, otherDisplayName: $otherDisplayName, type: $type, message: $message, createdAt: $createdAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$SocialActivityEventCopyWith<$Res> implements $SocialActivityEventCopyWith<$Res> {
  factory _$SocialActivityEventCopyWith(_SocialActivityEvent value, $Res Function(_SocialActivityEvent) _then) = __$SocialActivityEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String otherUserId, String otherDisplayName, SocialActivityType type, String message, DateTime createdAt, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$SocialActivityEventCopyWithImpl<$Res>
    implements _$SocialActivityEventCopyWith<$Res> {
  __$SocialActivityEventCopyWithImpl(this._self, this._then);

  final _SocialActivityEvent _self;
  final $Res Function(_SocialActivityEvent) _then;

/// Create a copy of SocialActivityEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? otherUserId = null,Object? otherDisplayName = null,Object? type = null,Object? message = null,Object? createdAt = null,Object? metadata = freezed,}) {
  return _then(_SocialActivityEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,otherUserId: null == otherUserId ? _self.otherUserId : otherUserId // ignore: cast_nullable_to_non_nullable
as String,otherDisplayName: null == otherDisplayName ? _self.otherDisplayName : otherDisplayName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialActivityType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
