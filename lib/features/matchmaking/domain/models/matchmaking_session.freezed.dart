// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matchmaking_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchmakingSession {

 String get sessionId; String get userId; MatchmakingStatus get status; DateTime get queuedAt; DateTime? get matchedAt; String? get opponentId; String? get matchId; Map<String, dynamic> get configuration; Map<String, dynamic> get rankSnapshot; bool get isReady; bool get opponentReady; int get schemaVersion;
/// Create a copy of MatchmakingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingSessionCopyWith<MatchmakingSession> get copyWith => _$MatchmakingSessionCopyWithImpl<MatchmakingSession>(this as MatchmakingSession, _$identity);

  /// Serializes this MatchmakingSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.queuedAt, queuedAt) || other.queuedAt == queuedAt)&&(identical(other.matchedAt, matchedAt) || other.matchedAt == matchedAt)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&const DeepCollectionEquality().equals(other.configuration, configuration)&&const DeepCollectionEquality().equals(other.rankSnapshot, rankSnapshot)&&(identical(other.isReady, isReady) || other.isReady == isReady)&&(identical(other.opponentReady, opponentReady) || other.opponentReady == opponentReady)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,userId,status,queuedAt,matchedAt,opponentId,matchId,const DeepCollectionEquality().hash(configuration),const DeepCollectionEquality().hash(rankSnapshot),isReady,opponentReady,schemaVersion);

@override
String toString() {
  return 'MatchmakingSession(sessionId: $sessionId, userId: $userId, status: $status, queuedAt: $queuedAt, matchedAt: $matchedAt, opponentId: $opponentId, matchId: $matchId, configuration: $configuration, rankSnapshot: $rankSnapshot, isReady: $isReady, opponentReady: $opponentReady, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $MatchmakingSessionCopyWith<$Res>  {
  factory $MatchmakingSessionCopyWith(MatchmakingSession value, $Res Function(MatchmakingSession) _then) = _$MatchmakingSessionCopyWithImpl;
@useResult
$Res call({
 String sessionId, String userId, MatchmakingStatus status, DateTime queuedAt, DateTime? matchedAt, String? opponentId, String? matchId, Map<String, dynamic> configuration, Map<String, dynamic> rankSnapshot, bool isReady, bool opponentReady, int schemaVersion
});




}
/// @nodoc
class _$MatchmakingSessionCopyWithImpl<$Res>
    implements $MatchmakingSessionCopyWith<$Res> {
  _$MatchmakingSessionCopyWithImpl(this._self, this._then);

  final MatchmakingSession _self;
  final $Res Function(MatchmakingSession) _then;

/// Create a copy of MatchmakingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? userId = null,Object? status = null,Object? queuedAt = null,Object? matchedAt = freezed,Object? opponentId = freezed,Object? matchId = freezed,Object? configuration = null,Object? rankSnapshot = null,Object? isReady = null,Object? opponentReady = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchmakingStatus,queuedAt: null == queuedAt ? _self.queuedAt : queuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,matchedAt: freezed == matchedAt ? _self.matchedAt : matchedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,opponentId: freezed == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String?,matchId: freezed == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String?,configuration: null == configuration ? _self.configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rankSnapshot: null == rankSnapshot ? _self.rankSnapshot : rankSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,opponentReady: null == opponentReady ? _self.opponentReady : opponentReady // ignore: cast_nullable_to_non_nullable
as bool,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchmakingSession].
extension MatchmakingSessionPatterns on MatchmakingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchmakingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchmakingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchmakingSession value)  $default,){
final _that = this;
switch (_that) {
case _MatchmakingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchmakingSession value)?  $default,){
final _that = this;
switch (_that) {
case _MatchmakingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String userId,  MatchmakingStatus status,  DateTime queuedAt,  DateTime? matchedAt,  String? opponentId,  String? matchId,  Map<String, dynamic> configuration,  Map<String, dynamic> rankSnapshot,  bool isReady,  bool opponentReady,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchmakingSession() when $default != null:
return $default(_that.sessionId,_that.userId,_that.status,_that.queuedAt,_that.matchedAt,_that.opponentId,_that.matchId,_that.configuration,_that.rankSnapshot,_that.isReady,_that.opponentReady,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String userId,  MatchmakingStatus status,  DateTime queuedAt,  DateTime? matchedAt,  String? opponentId,  String? matchId,  Map<String, dynamic> configuration,  Map<String, dynamic> rankSnapshot,  bool isReady,  bool opponentReady,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _MatchmakingSession():
return $default(_that.sessionId,_that.userId,_that.status,_that.queuedAt,_that.matchedAt,_that.opponentId,_that.matchId,_that.configuration,_that.rankSnapshot,_that.isReady,_that.opponentReady,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String userId,  MatchmakingStatus status,  DateTime queuedAt,  DateTime? matchedAt,  String? opponentId,  String? matchId,  Map<String, dynamic> configuration,  Map<String, dynamic> rankSnapshot,  bool isReady,  bool opponentReady,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _MatchmakingSession() when $default != null:
return $default(_that.sessionId,_that.userId,_that.status,_that.queuedAt,_that.matchedAt,_that.opponentId,_that.matchId,_that.configuration,_that.rankSnapshot,_that.isReady,_that.opponentReady,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchmakingSession implements MatchmakingSession {
  const _MatchmakingSession({required this.sessionId, required this.userId, required this.status, required this.queuedAt, this.matchedAt, this.opponentId, this.matchId, final  Map<String, dynamic> configuration = const {}, final  Map<String, dynamic> rankSnapshot = const {}, this.isReady = false, this.opponentReady = false, this.schemaVersion = 1}): _configuration = configuration,_rankSnapshot = rankSnapshot;
  factory _MatchmakingSession.fromJson(Map<String, dynamic> json) => _$MatchmakingSessionFromJson(json);

@override final  String sessionId;
@override final  String userId;
@override final  MatchmakingStatus status;
@override final  DateTime queuedAt;
@override final  DateTime? matchedAt;
@override final  String? opponentId;
@override final  String? matchId;
 final  Map<String, dynamic> _configuration;
@override@JsonKey() Map<String, dynamic> get configuration {
  if (_configuration is EqualUnmodifiableMapView) return _configuration;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_configuration);
}

 final  Map<String, dynamic> _rankSnapshot;
@override@JsonKey() Map<String, dynamic> get rankSnapshot {
  if (_rankSnapshot is EqualUnmodifiableMapView) return _rankSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rankSnapshot);
}

@override@JsonKey() final  bool isReady;
@override@JsonKey() final  bool opponentReady;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of MatchmakingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchmakingSessionCopyWith<_MatchmakingSession> get copyWith => __$MatchmakingSessionCopyWithImpl<_MatchmakingSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchmakingSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchmakingSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.queuedAt, queuedAt) || other.queuedAt == queuedAt)&&(identical(other.matchedAt, matchedAt) || other.matchedAt == matchedAt)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&const DeepCollectionEquality().equals(other._configuration, _configuration)&&const DeepCollectionEquality().equals(other._rankSnapshot, _rankSnapshot)&&(identical(other.isReady, isReady) || other.isReady == isReady)&&(identical(other.opponentReady, opponentReady) || other.opponentReady == opponentReady)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,userId,status,queuedAt,matchedAt,opponentId,matchId,const DeepCollectionEquality().hash(_configuration),const DeepCollectionEquality().hash(_rankSnapshot),isReady,opponentReady,schemaVersion);

@override
String toString() {
  return 'MatchmakingSession(sessionId: $sessionId, userId: $userId, status: $status, queuedAt: $queuedAt, matchedAt: $matchedAt, opponentId: $opponentId, matchId: $matchId, configuration: $configuration, rankSnapshot: $rankSnapshot, isReady: $isReady, opponentReady: $opponentReady, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$MatchmakingSessionCopyWith<$Res> implements $MatchmakingSessionCopyWith<$Res> {
  factory _$MatchmakingSessionCopyWith(_MatchmakingSession value, $Res Function(_MatchmakingSession) _then) = __$MatchmakingSessionCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String userId, MatchmakingStatus status, DateTime queuedAt, DateTime? matchedAt, String? opponentId, String? matchId, Map<String, dynamic> configuration, Map<String, dynamic> rankSnapshot, bool isReady, bool opponentReady, int schemaVersion
});




}
/// @nodoc
class __$MatchmakingSessionCopyWithImpl<$Res>
    implements _$MatchmakingSessionCopyWith<$Res> {
  __$MatchmakingSessionCopyWithImpl(this._self, this._then);

  final _MatchmakingSession _self;
  final $Res Function(_MatchmakingSession) _then;

/// Create a copy of MatchmakingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? userId = null,Object? status = null,Object? queuedAt = null,Object? matchedAt = freezed,Object? opponentId = freezed,Object? matchId = freezed,Object? configuration = null,Object? rankSnapshot = null,Object? isReady = null,Object? opponentReady = null,Object? schemaVersion = null,}) {
  return _then(_MatchmakingSession(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchmakingStatus,queuedAt: null == queuedAt ? _self.queuedAt : queuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,matchedAt: freezed == matchedAt ? _self.matchedAt : matchedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,opponentId: freezed == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String?,matchId: freezed == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String?,configuration: null == configuration ? _self._configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rankSnapshot: null == rankSnapshot ? _self._rankSnapshot : rankSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,opponentReady: null == opponentReady ? _self.opponentReady : opponentReady // ignore: cast_nullable_to_non_nullable
as bool,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
