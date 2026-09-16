// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSession {

 String? get sessionId; String? get uid; SessionStatus get status; DateTime? get expiresAt; bool get isOffline; bool get hasPendingSync;
/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSessionCopyWith<UserSession> get copyWith => _$UserSessionCopyWithImpl<UserSession>(this as UserSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.hasPendingSync, hasPendingSync) || other.hasPendingSync == hasPendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,uid,status,expiresAt,isOffline,hasPendingSync);

@override
String toString() {
  return 'UserSession(sessionId: $sessionId, uid: $uid, status: $status, expiresAt: $expiresAt, isOffline: $isOffline, hasPendingSync: $hasPendingSync)';
}


}

/// @nodoc
abstract mixin class $UserSessionCopyWith<$Res>  {
  factory $UserSessionCopyWith(UserSession value, $Res Function(UserSession) _then) = _$UserSessionCopyWithImpl;
@useResult
$Res call({
 String? sessionId, String? uid, SessionStatus status, DateTime? expiresAt, bool isOffline, bool hasPendingSync
});




}
/// @nodoc
class _$UserSessionCopyWithImpl<$Res>
    implements $UserSessionCopyWith<$Res> {
  _$UserSessionCopyWithImpl(this._self, this._then);

  final UserSession _self;
  final $Res Function(UserSession) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = freezed,Object? uid = freezed,Object? status = null,Object? expiresAt = freezed,Object? isOffline = null,Object? hasPendingSync = null,}) {
  return _then(_self.copyWith(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,hasPendingSync: null == hasPendingSync ? _self.hasPendingSync : hasPendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSession].
extension UserSessionPatterns on UserSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSession value)  $default,){
final _that = this;
switch (_that) {
case _UserSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSession value)?  $default,){
final _that = this;
switch (_that) {
case _UserSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sessionId,  String? uid,  SessionStatus status,  DateTime? expiresAt,  bool isOffline,  bool hasPendingSync)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that.sessionId,_that.uid,_that.status,_that.expiresAt,_that.isOffline,_that.hasPendingSync);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sessionId,  String? uid,  SessionStatus status,  DateTime? expiresAt,  bool isOffline,  bool hasPendingSync)  $default,) {final _that = this;
switch (_that) {
case _UserSession():
return $default(_that.sessionId,_that.uid,_that.status,_that.expiresAt,_that.isOffline,_that.hasPendingSync);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sessionId,  String? uid,  SessionStatus status,  DateTime? expiresAt,  bool isOffline,  bool hasPendingSync)?  $default,) {final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that.sessionId,_that.uid,_that.status,_that.expiresAt,_that.isOffline,_that.hasPendingSync);case _:
  return null;

}
}

}

/// @nodoc


class _UserSession extends UserSession {
  const _UserSession({this.sessionId, this.uid, this.status = SessionStatus.guest, this.expiresAt, this.isOffline = false, this.hasPendingSync = false}): super._();
  

@override final  String? sessionId;
@override final  String? uid;
@override@JsonKey() final  SessionStatus status;
@override final  DateTime? expiresAt;
@override@JsonKey() final  bool isOffline;
@override@JsonKey() final  bool hasPendingSync;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSessionCopyWith<_UserSession> get copyWith => __$UserSessionCopyWithImpl<_UserSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.hasPendingSync, hasPendingSync) || other.hasPendingSync == hasPendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,uid,status,expiresAt,isOffline,hasPendingSync);

@override
String toString() {
  return 'UserSession(sessionId: $sessionId, uid: $uid, status: $status, expiresAt: $expiresAt, isOffline: $isOffline, hasPendingSync: $hasPendingSync)';
}


}

/// @nodoc
abstract mixin class _$UserSessionCopyWith<$Res> implements $UserSessionCopyWith<$Res> {
  factory _$UserSessionCopyWith(_UserSession value, $Res Function(_UserSession) _then) = __$UserSessionCopyWithImpl;
@override @useResult
$Res call({
 String? sessionId, String? uid, SessionStatus status, DateTime? expiresAt, bool isOffline, bool hasPendingSync
});




}
/// @nodoc
class __$UserSessionCopyWithImpl<$Res>
    implements _$UserSessionCopyWith<$Res> {
  __$UserSessionCopyWithImpl(this._self, this._then);

  final _UserSession _self;
  final $Res Function(_UserSession) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = freezed,Object? uid = freezed,Object? status = null,Object? expiresAt = freezed,Object? isOffline = null,Object? hasPendingSync = null,}) {
  return _then(_UserSession(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,hasPendingSync: null == hasPendingSync ? _self.hasPendingSync : hasPendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
