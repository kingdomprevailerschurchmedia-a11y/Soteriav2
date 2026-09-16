// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'versus_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VersusMatch {

 String get matchId; String get playerAId; String get playerBId; MatchStatus get status; DateTime get createdAt; DateTime? get startedAt; DateTime? get endedAt; String? get playerASessionId; String? get playerBSessionId; bool get playerAReady; bool get playerBReady; int get playerAScore; int get playerBScore; int get playerAProgress; int get playerBProgress; GameMode get mode; Map<String, dynamic> get configuration; int get schemaVersion;
/// Create a copy of VersusMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersusMatchCopyWith<VersusMatch> get copyWith => _$VersusMatchCopyWithImpl<VersusMatch>(this as VersusMatch, _$identity);

  /// Serializes this VersusMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VersusMatch&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.playerAId, playerAId) || other.playerAId == playerAId)&&(identical(other.playerBId, playerBId) || other.playerBId == playerBId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.playerASessionId, playerASessionId) || other.playerASessionId == playerASessionId)&&(identical(other.playerBSessionId, playerBSessionId) || other.playerBSessionId == playerBSessionId)&&(identical(other.playerAReady, playerAReady) || other.playerAReady == playerAReady)&&(identical(other.playerBReady, playerBReady) || other.playerBReady == playerBReady)&&(identical(other.playerAScore, playerAScore) || other.playerAScore == playerAScore)&&(identical(other.playerBScore, playerBScore) || other.playerBScore == playerBScore)&&(identical(other.playerAProgress, playerAProgress) || other.playerAProgress == playerAProgress)&&(identical(other.playerBProgress, playerBProgress) || other.playerBProgress == playerBProgress)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.configuration, configuration)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,playerAId,playerBId,status,createdAt,startedAt,endedAt,playerASessionId,playerBSessionId,playerAReady,playerBReady,playerAScore,playerBScore,playerAProgress,playerBProgress,mode,const DeepCollectionEquality().hash(configuration),schemaVersion);

@override
String toString() {
  return 'VersusMatch(matchId: $matchId, playerAId: $playerAId, playerBId: $playerBId, status: $status, createdAt: $createdAt, startedAt: $startedAt, endedAt: $endedAt, playerASessionId: $playerASessionId, playerBSessionId: $playerBSessionId, playerAReady: $playerAReady, playerBReady: $playerBReady, playerAScore: $playerAScore, playerBScore: $playerBScore, playerAProgress: $playerAProgress, playerBProgress: $playerBProgress, mode: $mode, configuration: $configuration, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $VersusMatchCopyWith<$Res>  {
  factory $VersusMatchCopyWith(VersusMatch value, $Res Function(VersusMatch) _then) = _$VersusMatchCopyWithImpl;
@useResult
$Res call({
 String matchId, String playerAId, String playerBId, MatchStatus status, DateTime createdAt, DateTime? startedAt, DateTime? endedAt, String? playerASessionId, String? playerBSessionId, bool playerAReady, bool playerBReady, int playerAScore, int playerBScore, int playerAProgress, int playerBProgress, GameMode mode, Map<String, dynamic> configuration, int schemaVersion
});




}
/// @nodoc
class _$VersusMatchCopyWithImpl<$Res>
    implements $VersusMatchCopyWith<$Res> {
  _$VersusMatchCopyWithImpl(this._self, this._then);

  final VersusMatch _self;
  final $Res Function(VersusMatch) _then;

/// Create a copy of VersusMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? playerAId = null,Object? playerBId = null,Object? status = null,Object? createdAt = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? playerASessionId = freezed,Object? playerBSessionId = freezed,Object? playerAReady = null,Object? playerBReady = null,Object? playerAScore = null,Object? playerBScore = null,Object? playerAProgress = null,Object? playerBProgress = null,Object? mode = null,Object? configuration = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,playerAId: null == playerAId ? _self.playerAId : playerAId // ignore: cast_nullable_to_non_nullable
as String,playerBId: null == playerBId ? _self.playerBId : playerBId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,playerASessionId: freezed == playerASessionId ? _self.playerASessionId : playerASessionId // ignore: cast_nullable_to_non_nullable
as String?,playerBSessionId: freezed == playerBSessionId ? _self.playerBSessionId : playerBSessionId // ignore: cast_nullable_to_non_nullable
as String?,playerAReady: null == playerAReady ? _self.playerAReady : playerAReady // ignore: cast_nullable_to_non_nullable
as bool,playerBReady: null == playerBReady ? _self.playerBReady : playerBReady // ignore: cast_nullable_to_non_nullable
as bool,playerAScore: null == playerAScore ? _self.playerAScore : playerAScore // ignore: cast_nullable_to_non_nullable
as int,playerBScore: null == playerBScore ? _self.playerBScore : playerBScore // ignore: cast_nullable_to_non_nullable
as int,playerAProgress: null == playerAProgress ? _self.playerAProgress : playerAProgress // ignore: cast_nullable_to_non_nullable
as int,playerBProgress: null == playerBProgress ? _self.playerBProgress : playerBProgress // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,configuration: null == configuration ? _self.configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VersusMatch].
extension VersusMatchPatterns on VersusMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VersusMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VersusMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VersusMatch value)  $default,){
final _that = this;
switch (_that) {
case _VersusMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VersusMatch value)?  $default,){
final _that = this;
switch (_that) {
case _VersusMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  String playerAId,  String playerBId,  MatchStatus status,  DateTime createdAt,  DateTime? startedAt,  DateTime? endedAt,  String? playerASessionId,  String? playerBSessionId,  bool playerAReady,  bool playerBReady,  int playerAScore,  int playerBScore,  int playerAProgress,  int playerBProgress,  GameMode mode,  Map<String, dynamic> configuration,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VersusMatch() when $default != null:
return $default(_that.matchId,_that.playerAId,_that.playerBId,_that.status,_that.createdAt,_that.startedAt,_that.endedAt,_that.playerASessionId,_that.playerBSessionId,_that.playerAReady,_that.playerBReady,_that.playerAScore,_that.playerBScore,_that.playerAProgress,_that.playerBProgress,_that.mode,_that.configuration,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  String playerAId,  String playerBId,  MatchStatus status,  DateTime createdAt,  DateTime? startedAt,  DateTime? endedAt,  String? playerASessionId,  String? playerBSessionId,  bool playerAReady,  bool playerBReady,  int playerAScore,  int playerBScore,  int playerAProgress,  int playerBProgress,  GameMode mode,  Map<String, dynamic> configuration,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _VersusMatch():
return $default(_that.matchId,_that.playerAId,_that.playerBId,_that.status,_that.createdAt,_that.startedAt,_that.endedAt,_that.playerASessionId,_that.playerBSessionId,_that.playerAReady,_that.playerBReady,_that.playerAScore,_that.playerBScore,_that.playerAProgress,_that.playerBProgress,_that.mode,_that.configuration,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  String playerAId,  String playerBId,  MatchStatus status,  DateTime createdAt,  DateTime? startedAt,  DateTime? endedAt,  String? playerASessionId,  String? playerBSessionId,  bool playerAReady,  bool playerBReady,  int playerAScore,  int playerBScore,  int playerAProgress,  int playerBProgress,  GameMode mode,  Map<String, dynamic> configuration,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _VersusMatch() when $default != null:
return $default(_that.matchId,_that.playerAId,_that.playerBId,_that.status,_that.createdAt,_that.startedAt,_that.endedAt,_that.playerASessionId,_that.playerBSessionId,_that.playerAReady,_that.playerBReady,_that.playerAScore,_that.playerBScore,_that.playerAProgress,_that.playerBProgress,_that.mode,_that.configuration,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VersusMatch implements VersusMatch {
  const _VersusMatch({required this.matchId, required this.playerAId, required this.playerBId, required this.status, required this.createdAt, this.startedAt, this.endedAt, this.playerASessionId, this.playerBSessionId, this.playerAReady = false, this.playerBReady = false, this.playerAScore = 0, this.playerBScore = 0, this.playerAProgress = 0, this.playerBProgress = 0, this.mode = GameMode.versus, final  Map<String, dynamic> configuration = const {}, this.schemaVersion = 1}): _configuration = configuration;
  factory _VersusMatch.fromJson(Map<String, dynamic> json) => _$VersusMatchFromJson(json);

@override final  String matchId;
@override final  String playerAId;
@override final  String playerBId;
@override final  MatchStatus status;
@override final  DateTime createdAt;
@override final  DateTime? startedAt;
@override final  DateTime? endedAt;
@override final  String? playerASessionId;
@override final  String? playerBSessionId;
@override@JsonKey() final  bool playerAReady;
@override@JsonKey() final  bool playerBReady;
@override@JsonKey() final  int playerAScore;
@override@JsonKey() final  int playerBScore;
@override@JsonKey() final  int playerAProgress;
@override@JsonKey() final  int playerBProgress;
@override@JsonKey() final  GameMode mode;
 final  Map<String, dynamic> _configuration;
@override@JsonKey() Map<String, dynamic> get configuration {
  if (_configuration is EqualUnmodifiableMapView) return _configuration;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_configuration);
}

@override@JsonKey() final  int schemaVersion;

/// Create a copy of VersusMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VersusMatchCopyWith<_VersusMatch> get copyWith => __$VersusMatchCopyWithImpl<_VersusMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersusMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VersusMatch&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.playerAId, playerAId) || other.playerAId == playerAId)&&(identical(other.playerBId, playerBId) || other.playerBId == playerBId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.playerASessionId, playerASessionId) || other.playerASessionId == playerASessionId)&&(identical(other.playerBSessionId, playerBSessionId) || other.playerBSessionId == playerBSessionId)&&(identical(other.playerAReady, playerAReady) || other.playerAReady == playerAReady)&&(identical(other.playerBReady, playerBReady) || other.playerBReady == playerBReady)&&(identical(other.playerAScore, playerAScore) || other.playerAScore == playerAScore)&&(identical(other.playerBScore, playerBScore) || other.playerBScore == playerBScore)&&(identical(other.playerAProgress, playerAProgress) || other.playerAProgress == playerAProgress)&&(identical(other.playerBProgress, playerBProgress) || other.playerBProgress == playerBProgress)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._configuration, _configuration)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,playerAId,playerBId,status,createdAt,startedAt,endedAt,playerASessionId,playerBSessionId,playerAReady,playerBReady,playerAScore,playerBScore,playerAProgress,playerBProgress,mode,const DeepCollectionEquality().hash(_configuration),schemaVersion);

@override
String toString() {
  return 'VersusMatch(matchId: $matchId, playerAId: $playerAId, playerBId: $playerBId, status: $status, createdAt: $createdAt, startedAt: $startedAt, endedAt: $endedAt, playerASessionId: $playerASessionId, playerBSessionId: $playerBSessionId, playerAReady: $playerAReady, playerBReady: $playerBReady, playerAScore: $playerAScore, playerBScore: $playerBScore, playerAProgress: $playerAProgress, playerBProgress: $playerBProgress, mode: $mode, configuration: $configuration, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$VersusMatchCopyWith<$Res> implements $VersusMatchCopyWith<$Res> {
  factory _$VersusMatchCopyWith(_VersusMatch value, $Res Function(_VersusMatch) _then) = __$VersusMatchCopyWithImpl;
@override @useResult
$Res call({
 String matchId, String playerAId, String playerBId, MatchStatus status, DateTime createdAt, DateTime? startedAt, DateTime? endedAt, String? playerASessionId, String? playerBSessionId, bool playerAReady, bool playerBReady, int playerAScore, int playerBScore, int playerAProgress, int playerBProgress, GameMode mode, Map<String, dynamic> configuration, int schemaVersion
});




}
/// @nodoc
class __$VersusMatchCopyWithImpl<$Res>
    implements _$VersusMatchCopyWith<$Res> {
  __$VersusMatchCopyWithImpl(this._self, this._then);

  final _VersusMatch _self;
  final $Res Function(_VersusMatch) _then;

/// Create a copy of VersusMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? playerAId = null,Object? playerBId = null,Object? status = null,Object? createdAt = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? playerASessionId = freezed,Object? playerBSessionId = freezed,Object? playerAReady = null,Object? playerBReady = null,Object? playerAScore = null,Object? playerBScore = null,Object? playerAProgress = null,Object? playerBProgress = null,Object? mode = null,Object? configuration = null,Object? schemaVersion = null,}) {
  return _then(_VersusMatch(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,playerAId: null == playerAId ? _self.playerAId : playerAId // ignore: cast_nullable_to_non_nullable
as String,playerBId: null == playerBId ? _self.playerBId : playerBId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,playerASessionId: freezed == playerASessionId ? _self.playerASessionId : playerASessionId // ignore: cast_nullable_to_non_nullable
as String?,playerBSessionId: freezed == playerBSessionId ? _self.playerBSessionId : playerBSessionId // ignore: cast_nullable_to_non_nullable
as String?,playerAReady: null == playerAReady ? _self.playerAReady : playerAReady // ignore: cast_nullable_to_non_nullable
as bool,playerBReady: null == playerBReady ? _self.playerBReady : playerBReady // ignore: cast_nullable_to_non_nullable
as bool,playerAScore: null == playerAScore ? _self.playerAScore : playerAScore // ignore: cast_nullable_to_non_nullable
as int,playerBScore: null == playerBScore ? _self.playerBScore : playerBScore // ignore: cast_nullable_to_non_nullable
as int,playerAProgress: null == playerAProgress ? _self.playerAProgress : playerAProgress // ignore: cast_nullable_to_non_nullable
as int,playerBProgress: null == playerBProgress ? _self.playerBProgress : playerBProgress // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,configuration: null == configuration ? _self._configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
