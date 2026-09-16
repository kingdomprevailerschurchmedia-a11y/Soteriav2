// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoreResult {

 int get baseScore; int get speedBonus; int get difficultyBonus; int get streakBonus; int get totalScore; int get xpEarned; int get coinsEarned; DateTime get timestamp;
/// Create a copy of ScoreResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreResultCopyWith<ScoreResult> get copyWith => _$ScoreResultCopyWithImpl<ScoreResult>(this as ScoreResult, _$identity);

  /// Serializes this ScoreResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreResult&&(identical(other.baseScore, baseScore) || other.baseScore == baseScore)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.difficultyBonus, difficultyBonus) || other.difficultyBonus == difficultyBonus)&&(identical(other.streakBonus, streakBonus) || other.streakBonus == streakBonus)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseScore,speedBonus,difficultyBonus,streakBonus,totalScore,xpEarned,coinsEarned,timestamp);

@override
String toString() {
  return 'ScoreResult(baseScore: $baseScore, speedBonus: $speedBonus, difficultyBonus: $difficultyBonus, streakBonus: $streakBonus, totalScore: $totalScore, xpEarned: $xpEarned, coinsEarned: $coinsEarned, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ScoreResultCopyWith<$Res>  {
  factory $ScoreResultCopyWith(ScoreResult value, $Res Function(ScoreResult) _then) = _$ScoreResultCopyWithImpl;
@useResult
$Res call({
 int baseScore, int speedBonus, int difficultyBonus, int streakBonus, int totalScore, int xpEarned, int coinsEarned, DateTime timestamp
});




}
/// @nodoc
class _$ScoreResultCopyWithImpl<$Res>
    implements $ScoreResultCopyWith<$Res> {
  _$ScoreResultCopyWithImpl(this._self, this._then);

  final ScoreResult _self;
  final $Res Function(ScoreResult) _then;

/// Create a copy of ScoreResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseScore = null,Object? speedBonus = null,Object? difficultyBonus = null,Object? streakBonus = null,Object? totalScore = null,Object? xpEarned = null,Object? coinsEarned = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
baseScore: null == baseScore ? _self.baseScore : baseScore // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,difficultyBonus: null == difficultyBonus ? _self.difficultyBonus : difficultyBonus // ignore: cast_nullable_to_non_nullable
as int,streakBonus: null == streakBonus ? _self.streakBonus : streakBonus // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreResult].
extension ScoreResultPatterns on ScoreResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreResult value)  $default,){
final _that = this;
switch (_that) {
case _ScoreResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreResult value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int baseScore,  int speedBonus,  int difficultyBonus,  int streakBonus,  int totalScore,  int xpEarned,  int coinsEarned,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreResult() when $default != null:
return $default(_that.baseScore,_that.speedBonus,_that.difficultyBonus,_that.streakBonus,_that.totalScore,_that.xpEarned,_that.coinsEarned,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int baseScore,  int speedBonus,  int difficultyBonus,  int streakBonus,  int totalScore,  int xpEarned,  int coinsEarned,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ScoreResult():
return $default(_that.baseScore,_that.speedBonus,_that.difficultyBonus,_that.streakBonus,_that.totalScore,_that.xpEarned,_that.coinsEarned,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int baseScore,  int speedBonus,  int difficultyBonus,  int streakBonus,  int totalScore,  int xpEarned,  int coinsEarned,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ScoreResult() when $default != null:
return $default(_that.baseScore,_that.speedBonus,_that.difficultyBonus,_that.streakBonus,_that.totalScore,_that.xpEarned,_that.coinsEarned,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreResult implements ScoreResult {
  const _ScoreResult({this.baseScore = 0, this.speedBonus = 0, this.difficultyBonus = 0, this.streakBonus = 0, this.totalScore = 0, this.xpEarned = 0, this.coinsEarned = 0, required this.timestamp});
  factory _ScoreResult.fromJson(Map<String, dynamic> json) => _$ScoreResultFromJson(json);

@override@JsonKey() final  int baseScore;
@override@JsonKey() final  int speedBonus;
@override@JsonKey() final  int difficultyBonus;
@override@JsonKey() final  int streakBonus;
@override@JsonKey() final  int totalScore;
@override@JsonKey() final  int xpEarned;
@override@JsonKey() final  int coinsEarned;
@override final  DateTime timestamp;

/// Create a copy of ScoreResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreResultCopyWith<_ScoreResult> get copyWith => __$ScoreResultCopyWithImpl<_ScoreResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreResult&&(identical(other.baseScore, baseScore) || other.baseScore == baseScore)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.difficultyBonus, difficultyBonus) || other.difficultyBonus == difficultyBonus)&&(identical(other.streakBonus, streakBonus) || other.streakBonus == streakBonus)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseScore,speedBonus,difficultyBonus,streakBonus,totalScore,xpEarned,coinsEarned,timestamp);

@override
String toString() {
  return 'ScoreResult(baseScore: $baseScore, speedBonus: $speedBonus, difficultyBonus: $difficultyBonus, streakBonus: $streakBonus, totalScore: $totalScore, xpEarned: $xpEarned, coinsEarned: $coinsEarned, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ScoreResultCopyWith<$Res> implements $ScoreResultCopyWith<$Res> {
  factory _$ScoreResultCopyWith(_ScoreResult value, $Res Function(_ScoreResult) _then) = __$ScoreResultCopyWithImpl;
@override @useResult
$Res call({
 int baseScore, int speedBonus, int difficultyBonus, int streakBonus, int totalScore, int xpEarned, int coinsEarned, DateTime timestamp
});




}
/// @nodoc
class __$ScoreResultCopyWithImpl<$Res>
    implements _$ScoreResultCopyWith<$Res> {
  __$ScoreResultCopyWithImpl(this._self, this._then);

  final _ScoreResult _self;
  final $Res Function(_ScoreResult) _then;

/// Create a copy of ScoreResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseScore = null,Object? speedBonus = null,Object? difficultyBonus = null,Object? streakBonus = null,Object? totalScore = null,Object? xpEarned = null,Object? coinsEarned = null,Object? timestamp = null,}) {
  return _then(_ScoreResult(
baseScore: null == baseScore ? _self.baseScore : baseScore // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,difficultyBonus: null == difficultyBonus ? _self.difficultyBonus : difficultyBonus // ignore: cast_nullable_to_non_nullable
as int,streakBonus: null == streakBonus ? _self.streakBonus : streakBonus // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
