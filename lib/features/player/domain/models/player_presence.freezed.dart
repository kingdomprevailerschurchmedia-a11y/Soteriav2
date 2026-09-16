// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_presence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerPresence {

 String get userId; PresenceStatus get status; DateTime get lastSeenAt; DateTime get lastHeartbeatAt; bool get showOnlineStatus; bool get showActivity; bool get showMatchStatus; String? get currentMatchId; int get schemaVersion;
/// Create a copy of PlayerPresence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerPresenceCopyWith<PlayerPresence> get copyWith => _$PlayerPresenceCopyWithImpl<PlayerPresence>(this as PlayerPresence, _$identity);

  /// Serializes this PlayerPresence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerPresence&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.lastHeartbeatAt, lastHeartbeatAt) || other.lastHeartbeatAt == lastHeartbeatAt)&&(identical(other.showOnlineStatus, showOnlineStatus) || other.showOnlineStatus == showOnlineStatus)&&(identical(other.showActivity, showActivity) || other.showActivity == showActivity)&&(identical(other.showMatchStatus, showMatchStatus) || other.showMatchStatus == showMatchStatus)&&(identical(other.currentMatchId, currentMatchId) || other.currentMatchId == currentMatchId)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,status,lastSeenAt,lastHeartbeatAt,showOnlineStatus,showActivity,showMatchStatus,currentMatchId,schemaVersion);

@override
String toString() {
  return 'PlayerPresence(userId: $userId, status: $status, lastSeenAt: $lastSeenAt, lastHeartbeatAt: $lastHeartbeatAt, showOnlineStatus: $showOnlineStatus, showActivity: $showActivity, showMatchStatus: $showMatchStatus, currentMatchId: $currentMatchId, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $PlayerPresenceCopyWith<$Res>  {
  factory $PlayerPresenceCopyWith(PlayerPresence value, $Res Function(PlayerPresence) _then) = _$PlayerPresenceCopyWithImpl;
@useResult
$Res call({
 String userId, PresenceStatus status, DateTime lastSeenAt, DateTime lastHeartbeatAt, bool showOnlineStatus, bool showActivity, bool showMatchStatus, String? currentMatchId, int schemaVersion
});




}
/// @nodoc
class _$PlayerPresenceCopyWithImpl<$Res>
    implements $PlayerPresenceCopyWith<$Res> {
  _$PlayerPresenceCopyWithImpl(this._self, this._then);

  final PlayerPresence _self;
  final $Res Function(PlayerPresence) _then;

/// Create a copy of PlayerPresence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? status = null,Object? lastSeenAt = null,Object? lastHeartbeatAt = null,Object? showOnlineStatus = null,Object? showActivity = null,Object? showMatchStatus = null,Object? currentMatchId = freezed,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PresenceStatus,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastHeartbeatAt: null == lastHeartbeatAt ? _self.lastHeartbeatAt : lastHeartbeatAt // ignore: cast_nullable_to_non_nullable
as DateTime,showOnlineStatus: null == showOnlineStatus ? _self.showOnlineStatus : showOnlineStatus // ignore: cast_nullable_to_non_nullable
as bool,showActivity: null == showActivity ? _self.showActivity : showActivity // ignore: cast_nullable_to_non_nullable
as bool,showMatchStatus: null == showMatchStatus ? _self.showMatchStatus : showMatchStatus // ignore: cast_nullable_to_non_nullable
as bool,currentMatchId: freezed == currentMatchId ? _self.currentMatchId : currentMatchId // ignore: cast_nullable_to_non_nullable
as String?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerPresence].
extension PlayerPresencePatterns on PlayerPresence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerPresence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerPresence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerPresence value)  $default,){
final _that = this;
switch (_that) {
case _PlayerPresence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerPresence value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerPresence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  PresenceStatus status,  DateTime lastSeenAt,  DateTime lastHeartbeatAt,  bool showOnlineStatus,  bool showActivity,  bool showMatchStatus,  String? currentMatchId,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerPresence() when $default != null:
return $default(_that.userId,_that.status,_that.lastSeenAt,_that.lastHeartbeatAt,_that.showOnlineStatus,_that.showActivity,_that.showMatchStatus,_that.currentMatchId,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  PresenceStatus status,  DateTime lastSeenAt,  DateTime lastHeartbeatAt,  bool showOnlineStatus,  bool showActivity,  bool showMatchStatus,  String? currentMatchId,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _PlayerPresence():
return $default(_that.userId,_that.status,_that.lastSeenAt,_that.lastHeartbeatAt,_that.showOnlineStatus,_that.showActivity,_that.showMatchStatus,_that.currentMatchId,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  PresenceStatus status,  DateTime lastSeenAt,  DateTime lastHeartbeatAt,  bool showOnlineStatus,  bool showActivity,  bool showMatchStatus,  String? currentMatchId,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _PlayerPresence() when $default != null:
return $default(_that.userId,_that.status,_that.lastSeenAt,_that.lastHeartbeatAt,_that.showOnlineStatus,_that.showActivity,_that.showMatchStatus,_that.currentMatchId,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerPresence extends PlayerPresence {
  const _PlayerPresence({required this.userId, required this.status, required this.lastSeenAt, required this.lastHeartbeatAt, this.showOnlineStatus = true, this.showActivity = true, this.showMatchStatus = true, this.currentMatchId, this.schemaVersion = 1}): super._();
  factory _PlayerPresence.fromJson(Map<String, dynamic> json) => _$PlayerPresenceFromJson(json);

@override final  String userId;
@override final  PresenceStatus status;
@override final  DateTime lastSeenAt;
@override final  DateTime lastHeartbeatAt;
@override@JsonKey() final  bool showOnlineStatus;
@override@JsonKey() final  bool showActivity;
@override@JsonKey() final  bool showMatchStatus;
@override final  String? currentMatchId;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of PlayerPresence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerPresenceCopyWith<_PlayerPresence> get copyWith => __$PlayerPresenceCopyWithImpl<_PlayerPresence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerPresenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerPresence&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.lastHeartbeatAt, lastHeartbeatAt) || other.lastHeartbeatAt == lastHeartbeatAt)&&(identical(other.showOnlineStatus, showOnlineStatus) || other.showOnlineStatus == showOnlineStatus)&&(identical(other.showActivity, showActivity) || other.showActivity == showActivity)&&(identical(other.showMatchStatus, showMatchStatus) || other.showMatchStatus == showMatchStatus)&&(identical(other.currentMatchId, currentMatchId) || other.currentMatchId == currentMatchId)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,status,lastSeenAt,lastHeartbeatAt,showOnlineStatus,showActivity,showMatchStatus,currentMatchId,schemaVersion);

@override
String toString() {
  return 'PlayerPresence(userId: $userId, status: $status, lastSeenAt: $lastSeenAt, lastHeartbeatAt: $lastHeartbeatAt, showOnlineStatus: $showOnlineStatus, showActivity: $showActivity, showMatchStatus: $showMatchStatus, currentMatchId: $currentMatchId, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$PlayerPresenceCopyWith<$Res> implements $PlayerPresenceCopyWith<$Res> {
  factory _$PlayerPresenceCopyWith(_PlayerPresence value, $Res Function(_PlayerPresence) _then) = __$PlayerPresenceCopyWithImpl;
@override @useResult
$Res call({
 String userId, PresenceStatus status, DateTime lastSeenAt, DateTime lastHeartbeatAt, bool showOnlineStatus, bool showActivity, bool showMatchStatus, String? currentMatchId, int schemaVersion
});




}
/// @nodoc
class __$PlayerPresenceCopyWithImpl<$Res>
    implements _$PlayerPresenceCopyWith<$Res> {
  __$PlayerPresenceCopyWithImpl(this._self, this._then);

  final _PlayerPresence _self;
  final $Res Function(_PlayerPresence) _then;

/// Create a copy of PlayerPresence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? status = null,Object? lastSeenAt = null,Object? lastHeartbeatAt = null,Object? showOnlineStatus = null,Object? showActivity = null,Object? showMatchStatus = null,Object? currentMatchId = freezed,Object? schemaVersion = null,}) {
  return _then(_PlayerPresence(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PresenceStatus,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastHeartbeatAt: null == lastHeartbeatAt ? _self.lastHeartbeatAt : lastHeartbeatAt // ignore: cast_nullable_to_non_nullable
as DateTime,showOnlineStatus: null == showOnlineStatus ? _self.showOnlineStatus : showOnlineStatus // ignore: cast_nullable_to_non_nullable
as bool,showActivity: null == showActivity ? _self.showActivity : showActivity // ignore: cast_nullable_to_non_nullable
as bool,showMatchStatus: null == showMatchStatus ? _self.showMatchStatus : showMatchStatus // ignore: cast_nullable_to_non_nullable
as bool,currentMatchId: freezed == currentMatchId ? _self.currentMatchId : currentMatchId // ignore: cast_nullable_to_non_nullable
as String?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
