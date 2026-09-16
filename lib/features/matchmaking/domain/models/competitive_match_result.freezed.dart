// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_match_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveMatchResult {

 String get matchId; String get playerId; String get opponentId; MatchOutcome get outcome; int get playerScore; int get opponentScore; GameResult get playerPerformance; GameResult get opponentPerformance; Map<String, dynamic> get rankChange; Map<String, dynamic> get rewards; DateTime get completedAt; int get schemaVersion;
/// Create a copy of CompetitiveMatchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveMatchResultCopyWith<CompetitiveMatchResult> get copyWith => _$CompetitiveMatchResultCopyWithImpl<CompetitiveMatchResult>(this as CompetitiveMatchResult, _$identity);

  /// Serializes this CompetitiveMatchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveMatchResult&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.playerScore, playerScore) || other.playerScore == playerScore)&&(identical(other.opponentScore, opponentScore) || other.opponentScore == opponentScore)&&(identical(other.playerPerformance, playerPerformance) || other.playerPerformance == playerPerformance)&&(identical(other.opponentPerformance, opponentPerformance) || other.opponentPerformance == opponentPerformance)&&const DeepCollectionEquality().equals(other.rankChange, rankChange)&&const DeepCollectionEquality().equals(other.rewards, rewards)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,playerId,opponentId,outcome,playerScore,opponentScore,playerPerformance,opponentPerformance,const DeepCollectionEquality().hash(rankChange),const DeepCollectionEquality().hash(rewards),completedAt,schemaVersion);

@override
String toString() {
  return 'CompetitiveMatchResult(matchId: $matchId, playerId: $playerId, opponentId: $opponentId, outcome: $outcome, playerScore: $playerScore, opponentScore: $opponentScore, playerPerformance: $playerPerformance, opponentPerformance: $opponentPerformance, rankChange: $rankChange, rewards: $rewards, completedAt: $completedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $CompetitiveMatchResultCopyWith<$Res>  {
  factory $CompetitiveMatchResultCopyWith(CompetitiveMatchResult value, $Res Function(CompetitiveMatchResult) _then) = _$CompetitiveMatchResultCopyWithImpl;
@useResult
$Res call({
 String matchId, String playerId, String opponentId, MatchOutcome outcome, int playerScore, int opponentScore, GameResult playerPerformance, GameResult opponentPerformance, Map<String, dynamic> rankChange, Map<String, dynamic> rewards, DateTime completedAt, int schemaVersion
});




}
/// @nodoc
class _$CompetitiveMatchResultCopyWithImpl<$Res>
    implements $CompetitiveMatchResultCopyWith<$Res> {
  _$CompetitiveMatchResultCopyWithImpl(this._self, this._then);

  final CompetitiveMatchResult _self;
  final $Res Function(CompetitiveMatchResult) _then;

/// Create a copy of CompetitiveMatchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? playerId = null,Object? opponentId = null,Object? outcome = null,Object? playerScore = null,Object? opponentScore = null,Object? playerPerformance = null,Object? opponentPerformance = null,Object? rankChange = null,Object? rewards = null,Object? completedAt = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as MatchOutcome,playerScore: null == playerScore ? _self.playerScore : playerScore // ignore: cast_nullable_to_non_nullable
as int,opponentScore: null == opponentScore ? _self.opponentScore : opponentScore // ignore: cast_nullable_to_non_nullable
as int,playerPerformance: null == playerPerformance ? _self.playerPerformance : playerPerformance // ignore: cast_nullable_to_non_nullable
as GameResult,opponentPerformance: null == opponentPerformance ? _self.opponentPerformance : opponentPerformance // ignore: cast_nullable_to_non_nullable
as GameResult,rankChange: null == rankChange ? _self.rankChange : rankChange // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rewards: null == rewards ? _self.rewards : rewards // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveMatchResult].
extension CompetitiveMatchResultPatterns on CompetitiveMatchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveMatchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveMatchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveMatchResult value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMatchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveMatchResult value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMatchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  String playerId,  String opponentId,  MatchOutcome outcome,  int playerScore,  int opponentScore,  GameResult playerPerformance,  GameResult opponentPerformance,  Map<String, dynamic> rankChange,  Map<String, dynamic> rewards,  DateTime completedAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveMatchResult() when $default != null:
return $default(_that.matchId,_that.playerId,_that.opponentId,_that.outcome,_that.playerScore,_that.opponentScore,_that.playerPerformance,_that.opponentPerformance,_that.rankChange,_that.rewards,_that.completedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  String playerId,  String opponentId,  MatchOutcome outcome,  int playerScore,  int opponentScore,  GameResult playerPerformance,  GameResult opponentPerformance,  Map<String, dynamic> rankChange,  Map<String, dynamic> rewards,  DateTime completedAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMatchResult():
return $default(_that.matchId,_that.playerId,_that.opponentId,_that.outcome,_that.playerScore,_that.opponentScore,_that.playerPerformance,_that.opponentPerformance,_that.rankChange,_that.rewards,_that.completedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  String playerId,  String opponentId,  MatchOutcome outcome,  int playerScore,  int opponentScore,  GameResult playerPerformance,  GameResult opponentPerformance,  Map<String, dynamic> rankChange,  Map<String, dynamic> rewards,  DateTime completedAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMatchResult() when $default != null:
return $default(_that.matchId,_that.playerId,_that.opponentId,_that.outcome,_that.playerScore,_that.opponentScore,_that.playerPerformance,_that.opponentPerformance,_that.rankChange,_that.rewards,_that.completedAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveMatchResult implements CompetitiveMatchResult {
  const _CompetitiveMatchResult({required this.matchId, required this.playerId, required this.opponentId, required this.outcome, required this.playerScore, required this.opponentScore, required this.playerPerformance, required this.opponentPerformance, required final  Map<String, dynamic> rankChange, required final  Map<String, dynamic> rewards, required this.completedAt, this.schemaVersion = 1}): _rankChange = rankChange,_rewards = rewards;
  factory _CompetitiveMatchResult.fromJson(Map<String, dynamic> json) => _$CompetitiveMatchResultFromJson(json);

@override final  String matchId;
@override final  String playerId;
@override final  String opponentId;
@override final  MatchOutcome outcome;
@override final  int playerScore;
@override final  int opponentScore;
@override final  GameResult playerPerformance;
@override final  GameResult opponentPerformance;
 final  Map<String, dynamic> _rankChange;
@override Map<String, dynamic> get rankChange {
  if (_rankChange is EqualUnmodifiableMapView) return _rankChange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rankChange);
}

 final  Map<String, dynamic> _rewards;
@override Map<String, dynamic> get rewards {
  if (_rewards is EqualUnmodifiableMapView) return _rewards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rewards);
}

@override final  DateTime completedAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of CompetitiveMatchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveMatchResultCopyWith<_CompetitiveMatchResult> get copyWith => __$CompetitiveMatchResultCopyWithImpl<_CompetitiveMatchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveMatchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveMatchResult&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.playerScore, playerScore) || other.playerScore == playerScore)&&(identical(other.opponentScore, opponentScore) || other.opponentScore == opponentScore)&&(identical(other.playerPerformance, playerPerformance) || other.playerPerformance == playerPerformance)&&(identical(other.opponentPerformance, opponentPerformance) || other.opponentPerformance == opponentPerformance)&&const DeepCollectionEquality().equals(other._rankChange, _rankChange)&&const DeepCollectionEquality().equals(other._rewards, _rewards)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,playerId,opponentId,outcome,playerScore,opponentScore,playerPerformance,opponentPerformance,const DeepCollectionEquality().hash(_rankChange),const DeepCollectionEquality().hash(_rewards),completedAt,schemaVersion);

@override
String toString() {
  return 'CompetitiveMatchResult(matchId: $matchId, playerId: $playerId, opponentId: $opponentId, outcome: $outcome, playerScore: $playerScore, opponentScore: $opponentScore, playerPerformance: $playerPerformance, opponentPerformance: $opponentPerformance, rankChange: $rankChange, rewards: $rewards, completedAt: $completedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveMatchResultCopyWith<$Res> implements $CompetitiveMatchResultCopyWith<$Res> {
  factory _$CompetitiveMatchResultCopyWith(_CompetitiveMatchResult value, $Res Function(_CompetitiveMatchResult) _then) = __$CompetitiveMatchResultCopyWithImpl;
@override @useResult
$Res call({
 String matchId, String playerId, String opponentId, MatchOutcome outcome, int playerScore, int opponentScore, GameResult playerPerformance, GameResult opponentPerformance, Map<String, dynamic> rankChange, Map<String, dynamic> rewards, DateTime completedAt, int schemaVersion
});




}
/// @nodoc
class __$CompetitiveMatchResultCopyWithImpl<$Res>
    implements _$CompetitiveMatchResultCopyWith<$Res> {
  __$CompetitiveMatchResultCopyWithImpl(this._self, this._then);

  final _CompetitiveMatchResult _self;
  final $Res Function(_CompetitiveMatchResult) _then;

/// Create a copy of CompetitiveMatchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? playerId = null,Object? opponentId = null,Object? outcome = null,Object? playerScore = null,Object? opponentScore = null,Object? playerPerformance = null,Object? opponentPerformance = null,Object? rankChange = null,Object? rewards = null,Object? completedAt = null,Object? schemaVersion = null,}) {
  return _then(_CompetitiveMatchResult(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as MatchOutcome,playerScore: null == playerScore ? _self.playerScore : playerScore // ignore: cast_nullable_to_non_nullable
as int,opponentScore: null == opponentScore ? _self.opponentScore : opponentScore // ignore: cast_nullable_to_non_nullable
as int,playerPerformance: null == playerPerformance ? _self.playerPerformance : playerPerformance // ignore: cast_nullable_to_non_nullable
as GameResult,opponentPerformance: null == opponentPerformance ? _self.opponentPerformance : opponentPerformance // ignore: cast_nullable_to_non_nullable
as GameResult,rankChange: null == rankChange ? _self._rankChange : rankChange // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rewards: null == rewards ? _self._rewards : rewards // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
