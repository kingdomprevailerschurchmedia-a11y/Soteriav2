// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveResult {

 String get resultId; String get userId; String get seasonId; CompetitiveOutcome get outcome; String get mode; int get score;@RequiredTimestampConverter() DateTime get completedAt; int get maxStreak; String? get opponentId; Map<String, dynamic>? get performanceModifiers; int get version;
/// Create a copy of CompetitiveResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveResultCopyWith<CompetitiveResult> get copyWith => _$CompetitiveResultCopyWithImpl<CompetitiveResult>(this as CompetitiveResult, _$identity);

  /// Serializes this CompetitiveResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveResult&&(identical(other.resultId, resultId) || other.resultId == resultId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.score, score) || other.score == score)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.maxStreak, maxStreak) || other.maxStreak == maxStreak)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&const DeepCollectionEquality().equals(other.performanceModifiers, performanceModifiers)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resultId,userId,seasonId,outcome,mode,score,completedAt,maxStreak,opponentId,const DeepCollectionEquality().hash(performanceModifiers),version);

@override
String toString() {
  return 'CompetitiveResult(resultId: $resultId, userId: $userId, seasonId: $seasonId, outcome: $outcome, mode: $mode, score: $score, completedAt: $completedAt, maxStreak: $maxStreak, opponentId: $opponentId, performanceModifiers: $performanceModifiers, version: $version)';
}


}

/// @nodoc
abstract mixin class $CompetitiveResultCopyWith<$Res>  {
  factory $CompetitiveResultCopyWith(CompetitiveResult value, $Res Function(CompetitiveResult) _then) = _$CompetitiveResultCopyWithImpl;
@useResult
$Res call({
 String resultId, String userId, String seasonId, CompetitiveOutcome outcome, String mode, int score,@RequiredTimestampConverter() DateTime completedAt, int maxStreak, String? opponentId, Map<String, dynamic>? performanceModifiers, int version
});




}
/// @nodoc
class _$CompetitiveResultCopyWithImpl<$Res>
    implements $CompetitiveResultCopyWith<$Res> {
  _$CompetitiveResultCopyWithImpl(this._self, this._then);

  final CompetitiveResult _self;
  final $Res Function(CompetitiveResult) _then;

/// Create a copy of CompetitiveResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultId = null,Object? userId = null,Object? seasonId = null,Object? outcome = null,Object? mode = null,Object? score = null,Object? completedAt = null,Object? maxStreak = null,Object? opponentId = freezed,Object? performanceModifiers = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
resultId: null == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as CompetitiveOutcome,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxStreak: null == maxStreak ? _self.maxStreak : maxStreak // ignore: cast_nullable_to_non_nullable
as int,opponentId: freezed == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String?,performanceModifiers: freezed == performanceModifiers ? _self.performanceModifiers : performanceModifiers // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveResult].
extension CompetitiveResultPatterns on CompetitiveResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveResult value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveResult value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String resultId,  String userId,  String seasonId,  CompetitiveOutcome outcome,  String mode,  int score, @RequiredTimestampConverter()  DateTime completedAt,  int maxStreak,  String? opponentId,  Map<String, dynamic>? performanceModifiers,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveResult() when $default != null:
return $default(_that.resultId,_that.userId,_that.seasonId,_that.outcome,_that.mode,_that.score,_that.completedAt,_that.maxStreak,_that.opponentId,_that.performanceModifiers,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String resultId,  String userId,  String seasonId,  CompetitiveOutcome outcome,  String mode,  int score, @RequiredTimestampConverter()  DateTime completedAt,  int maxStreak,  String? opponentId,  Map<String, dynamic>? performanceModifiers,  int version)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveResult():
return $default(_that.resultId,_that.userId,_that.seasonId,_that.outcome,_that.mode,_that.score,_that.completedAt,_that.maxStreak,_that.opponentId,_that.performanceModifiers,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String resultId,  String userId,  String seasonId,  CompetitiveOutcome outcome,  String mode,  int score, @RequiredTimestampConverter()  DateTime completedAt,  int maxStreak,  String? opponentId,  Map<String, dynamic>? performanceModifiers,  int version)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveResult() when $default != null:
return $default(_that.resultId,_that.userId,_that.seasonId,_that.outcome,_that.mode,_that.score,_that.completedAt,_that.maxStreak,_that.opponentId,_that.performanceModifiers,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveResult implements CompetitiveResult {
  const _CompetitiveResult({required this.resultId, required this.userId, required this.seasonId, required this.outcome, required this.mode, required this.score, @RequiredTimestampConverter() required this.completedAt, this.maxStreak = 0, this.opponentId, final  Map<String, dynamic>? performanceModifiers, this.version = 1}): _performanceModifiers = performanceModifiers;
  factory _CompetitiveResult.fromJson(Map<String, dynamic> json) => _$CompetitiveResultFromJson(json);

@override final  String resultId;
@override final  String userId;
@override final  String seasonId;
@override final  CompetitiveOutcome outcome;
@override final  String mode;
@override final  int score;
@override@RequiredTimestampConverter() final  DateTime completedAt;
@override@JsonKey() final  int maxStreak;
@override final  String? opponentId;
 final  Map<String, dynamic>? _performanceModifiers;
@override Map<String, dynamic>? get performanceModifiers {
  final value = _performanceModifiers;
  if (value == null) return null;
  if (_performanceModifiers is EqualUnmodifiableMapView) return _performanceModifiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  int version;

/// Create a copy of CompetitiveResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveResultCopyWith<_CompetitiveResult> get copyWith => __$CompetitiveResultCopyWithImpl<_CompetitiveResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveResult&&(identical(other.resultId, resultId) || other.resultId == resultId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.score, score) || other.score == score)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.maxStreak, maxStreak) || other.maxStreak == maxStreak)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&const DeepCollectionEquality().equals(other._performanceModifiers, _performanceModifiers)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resultId,userId,seasonId,outcome,mode,score,completedAt,maxStreak,opponentId,const DeepCollectionEquality().hash(_performanceModifiers),version);

@override
String toString() {
  return 'CompetitiveResult(resultId: $resultId, userId: $userId, seasonId: $seasonId, outcome: $outcome, mode: $mode, score: $score, completedAt: $completedAt, maxStreak: $maxStreak, opponentId: $opponentId, performanceModifiers: $performanceModifiers, version: $version)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveResultCopyWith<$Res> implements $CompetitiveResultCopyWith<$Res> {
  factory _$CompetitiveResultCopyWith(_CompetitiveResult value, $Res Function(_CompetitiveResult) _then) = __$CompetitiveResultCopyWithImpl;
@override @useResult
$Res call({
 String resultId, String userId, String seasonId, CompetitiveOutcome outcome, String mode, int score,@RequiredTimestampConverter() DateTime completedAt, int maxStreak, String? opponentId, Map<String, dynamic>? performanceModifiers, int version
});




}
/// @nodoc
class __$CompetitiveResultCopyWithImpl<$Res>
    implements _$CompetitiveResultCopyWith<$Res> {
  __$CompetitiveResultCopyWithImpl(this._self, this._then);

  final _CompetitiveResult _self;
  final $Res Function(_CompetitiveResult) _then;

/// Create a copy of CompetitiveResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultId = null,Object? userId = null,Object? seasonId = null,Object? outcome = null,Object? mode = null,Object? score = null,Object? completedAt = null,Object? maxStreak = null,Object? opponentId = freezed,Object? performanceModifiers = freezed,Object? version = null,}) {
  return _then(_CompetitiveResult(
resultId: null == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as CompetitiveOutcome,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxStreak: null == maxStreak ? _self.maxStreak : maxStreak // ignore: cast_nullable_to_non_nullable
as int,opponentId: freezed == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String?,performanceModifiers: freezed == performanceModifiers ? _self._performanceModifiers : performanceModifiers // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
