// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'head_to_head_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeadToHeadSummary {

 String get playerAId; String get playerBId; int get totalMatches; int get playerAWins; int get playerBWins; int get draws; double get playerAWinRate; double get playerBWinRate; List<CompetitiveOutcome> get recentResults; int get playerACurrentStreak; int get playerBCurrentStreak; int get playerABestStreak; int get playerBBestStreak; DateTime? get lastMatchAt;
/// Create a copy of HeadToHeadSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadToHeadSummaryCopyWith<HeadToHeadSummary> get copyWith => _$HeadToHeadSummaryCopyWithImpl<HeadToHeadSummary>(this as HeadToHeadSummary, _$identity);

  /// Serializes this HeadToHeadSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadSummary&&(identical(other.playerAId, playerAId) || other.playerAId == playerAId)&&(identical(other.playerBId, playerBId) || other.playerBId == playerBId)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.playerAWins, playerAWins) || other.playerAWins == playerAWins)&&(identical(other.playerBWins, playerBWins) || other.playerBWins == playerBWins)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.playerAWinRate, playerAWinRate) || other.playerAWinRate == playerAWinRate)&&(identical(other.playerBWinRate, playerBWinRate) || other.playerBWinRate == playerBWinRate)&&const DeepCollectionEquality().equals(other.recentResults, recentResults)&&(identical(other.playerACurrentStreak, playerACurrentStreak) || other.playerACurrentStreak == playerACurrentStreak)&&(identical(other.playerBCurrentStreak, playerBCurrentStreak) || other.playerBCurrentStreak == playerBCurrentStreak)&&(identical(other.playerABestStreak, playerABestStreak) || other.playerABestStreak == playerABestStreak)&&(identical(other.playerBBestStreak, playerBBestStreak) || other.playerBBestStreak == playerBBestStreak)&&(identical(other.lastMatchAt, lastMatchAt) || other.lastMatchAt == lastMatchAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerAId,playerBId,totalMatches,playerAWins,playerBWins,draws,playerAWinRate,playerBWinRate,const DeepCollectionEquality().hash(recentResults),playerACurrentStreak,playerBCurrentStreak,playerABestStreak,playerBBestStreak,lastMatchAt);

@override
String toString() {
  return 'HeadToHeadSummary(playerAId: $playerAId, playerBId: $playerBId, totalMatches: $totalMatches, playerAWins: $playerAWins, playerBWins: $playerBWins, draws: $draws, playerAWinRate: $playerAWinRate, playerBWinRate: $playerBWinRate, recentResults: $recentResults, playerACurrentStreak: $playerACurrentStreak, playerBCurrentStreak: $playerBCurrentStreak, playerABestStreak: $playerABestStreak, playerBBestStreak: $playerBBestStreak, lastMatchAt: $lastMatchAt)';
}


}

/// @nodoc
abstract mixin class $HeadToHeadSummaryCopyWith<$Res>  {
  factory $HeadToHeadSummaryCopyWith(HeadToHeadSummary value, $Res Function(HeadToHeadSummary) _then) = _$HeadToHeadSummaryCopyWithImpl;
@useResult
$Res call({
 String playerAId, String playerBId, int totalMatches, int playerAWins, int playerBWins, int draws, double playerAWinRate, double playerBWinRate, List<CompetitiveOutcome> recentResults, int playerACurrentStreak, int playerBCurrentStreak, int playerABestStreak, int playerBBestStreak, DateTime? lastMatchAt
});




}
/// @nodoc
class _$HeadToHeadSummaryCopyWithImpl<$Res>
    implements $HeadToHeadSummaryCopyWith<$Res> {
  _$HeadToHeadSummaryCopyWithImpl(this._self, this._then);

  final HeadToHeadSummary _self;
  final $Res Function(HeadToHeadSummary) _then;

/// Create a copy of HeadToHeadSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerAId = null,Object? playerBId = null,Object? totalMatches = null,Object? playerAWins = null,Object? playerBWins = null,Object? draws = null,Object? playerAWinRate = null,Object? playerBWinRate = null,Object? recentResults = null,Object? playerACurrentStreak = null,Object? playerBCurrentStreak = null,Object? playerABestStreak = null,Object? playerBBestStreak = null,Object? lastMatchAt = freezed,}) {
  return _then(_self.copyWith(
playerAId: null == playerAId ? _self.playerAId : playerAId // ignore: cast_nullable_to_non_nullable
as String,playerBId: null == playerBId ? _self.playerBId : playerBId // ignore: cast_nullable_to_non_nullable
as String,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,playerAWins: null == playerAWins ? _self.playerAWins : playerAWins // ignore: cast_nullable_to_non_nullable
as int,playerBWins: null == playerBWins ? _self.playerBWins : playerBWins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,playerAWinRate: null == playerAWinRate ? _self.playerAWinRate : playerAWinRate // ignore: cast_nullable_to_non_nullable
as double,playerBWinRate: null == playerBWinRate ? _self.playerBWinRate : playerBWinRate // ignore: cast_nullable_to_non_nullable
as double,recentResults: null == recentResults ? _self.recentResults : recentResults // ignore: cast_nullable_to_non_nullable
as List<CompetitiveOutcome>,playerACurrentStreak: null == playerACurrentStreak ? _self.playerACurrentStreak : playerACurrentStreak // ignore: cast_nullable_to_non_nullable
as int,playerBCurrentStreak: null == playerBCurrentStreak ? _self.playerBCurrentStreak : playerBCurrentStreak // ignore: cast_nullable_to_non_nullable
as int,playerABestStreak: null == playerABestStreak ? _self.playerABestStreak : playerABestStreak // ignore: cast_nullable_to_non_nullable
as int,playerBBestStreak: null == playerBBestStreak ? _self.playerBBestStreak : playerBBestStreak // ignore: cast_nullable_to_non_nullable
as int,lastMatchAt: freezed == lastMatchAt ? _self.lastMatchAt : lastMatchAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadToHeadSummary].
extension HeadToHeadSummaryPatterns on HeadToHeadSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadToHeadSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadToHeadSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadToHeadSummary value)  $default,){
final _that = this;
switch (_that) {
case _HeadToHeadSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadToHeadSummary value)?  $default,){
final _that = this;
switch (_that) {
case _HeadToHeadSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerAId,  String playerBId,  int totalMatches,  int playerAWins,  int playerBWins,  int draws,  double playerAWinRate,  double playerBWinRate,  List<CompetitiveOutcome> recentResults,  int playerACurrentStreak,  int playerBCurrentStreak,  int playerABestStreak,  int playerBBestStreak,  DateTime? lastMatchAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadToHeadSummary() when $default != null:
return $default(_that.playerAId,_that.playerBId,_that.totalMatches,_that.playerAWins,_that.playerBWins,_that.draws,_that.playerAWinRate,_that.playerBWinRate,_that.recentResults,_that.playerACurrentStreak,_that.playerBCurrentStreak,_that.playerABestStreak,_that.playerBBestStreak,_that.lastMatchAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerAId,  String playerBId,  int totalMatches,  int playerAWins,  int playerBWins,  int draws,  double playerAWinRate,  double playerBWinRate,  List<CompetitiveOutcome> recentResults,  int playerACurrentStreak,  int playerBCurrentStreak,  int playerABestStreak,  int playerBBestStreak,  DateTime? lastMatchAt)  $default,) {final _that = this;
switch (_that) {
case _HeadToHeadSummary():
return $default(_that.playerAId,_that.playerBId,_that.totalMatches,_that.playerAWins,_that.playerBWins,_that.draws,_that.playerAWinRate,_that.playerBWinRate,_that.recentResults,_that.playerACurrentStreak,_that.playerBCurrentStreak,_that.playerABestStreak,_that.playerBBestStreak,_that.lastMatchAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerAId,  String playerBId,  int totalMatches,  int playerAWins,  int playerBWins,  int draws,  double playerAWinRate,  double playerBWinRate,  List<CompetitiveOutcome> recentResults,  int playerACurrentStreak,  int playerBCurrentStreak,  int playerABestStreak,  int playerBBestStreak,  DateTime? lastMatchAt)?  $default,) {final _that = this;
switch (_that) {
case _HeadToHeadSummary() when $default != null:
return $default(_that.playerAId,_that.playerBId,_that.totalMatches,_that.playerAWins,_that.playerBWins,_that.draws,_that.playerAWinRate,_that.playerBWinRate,_that.recentResults,_that.playerACurrentStreak,_that.playerBCurrentStreak,_that.playerABestStreak,_that.playerBBestStreak,_that.lastMatchAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadToHeadSummary implements HeadToHeadSummary {
  const _HeadToHeadSummary({required this.playerAId, required this.playerBId, required this.totalMatches, required this.playerAWins, required this.playerBWins, required this.draws, required this.playerAWinRate, required this.playerBWinRate, final  List<CompetitiveOutcome> recentResults = const [], required this.playerACurrentStreak, required this.playerBCurrentStreak, required this.playerABestStreak, required this.playerBBestStreak, this.lastMatchAt}): _recentResults = recentResults;
  factory _HeadToHeadSummary.fromJson(Map<String, dynamic> json) => _$HeadToHeadSummaryFromJson(json);

@override final  String playerAId;
@override final  String playerBId;
@override final  int totalMatches;
@override final  int playerAWins;
@override final  int playerBWins;
@override final  int draws;
@override final  double playerAWinRate;
@override final  double playerBWinRate;
 final  List<CompetitiveOutcome> _recentResults;
@override@JsonKey() List<CompetitiveOutcome> get recentResults {
  if (_recentResults is EqualUnmodifiableListView) return _recentResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentResults);
}

@override final  int playerACurrentStreak;
@override final  int playerBCurrentStreak;
@override final  int playerABestStreak;
@override final  int playerBBestStreak;
@override final  DateTime? lastMatchAt;

/// Create a copy of HeadToHeadSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadToHeadSummaryCopyWith<_HeadToHeadSummary> get copyWith => __$HeadToHeadSummaryCopyWithImpl<_HeadToHeadSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadToHeadSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadToHeadSummary&&(identical(other.playerAId, playerAId) || other.playerAId == playerAId)&&(identical(other.playerBId, playerBId) || other.playerBId == playerBId)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.playerAWins, playerAWins) || other.playerAWins == playerAWins)&&(identical(other.playerBWins, playerBWins) || other.playerBWins == playerBWins)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.playerAWinRate, playerAWinRate) || other.playerAWinRate == playerAWinRate)&&(identical(other.playerBWinRate, playerBWinRate) || other.playerBWinRate == playerBWinRate)&&const DeepCollectionEquality().equals(other._recentResults, _recentResults)&&(identical(other.playerACurrentStreak, playerACurrentStreak) || other.playerACurrentStreak == playerACurrentStreak)&&(identical(other.playerBCurrentStreak, playerBCurrentStreak) || other.playerBCurrentStreak == playerBCurrentStreak)&&(identical(other.playerABestStreak, playerABestStreak) || other.playerABestStreak == playerABestStreak)&&(identical(other.playerBBestStreak, playerBBestStreak) || other.playerBBestStreak == playerBBestStreak)&&(identical(other.lastMatchAt, lastMatchAt) || other.lastMatchAt == lastMatchAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerAId,playerBId,totalMatches,playerAWins,playerBWins,draws,playerAWinRate,playerBWinRate,const DeepCollectionEquality().hash(_recentResults),playerACurrentStreak,playerBCurrentStreak,playerABestStreak,playerBBestStreak,lastMatchAt);

@override
String toString() {
  return 'HeadToHeadSummary(playerAId: $playerAId, playerBId: $playerBId, totalMatches: $totalMatches, playerAWins: $playerAWins, playerBWins: $playerBWins, draws: $draws, playerAWinRate: $playerAWinRate, playerBWinRate: $playerBWinRate, recentResults: $recentResults, playerACurrentStreak: $playerACurrentStreak, playerBCurrentStreak: $playerBCurrentStreak, playerABestStreak: $playerABestStreak, playerBBestStreak: $playerBBestStreak, lastMatchAt: $lastMatchAt)';
}


}

/// @nodoc
abstract mixin class _$HeadToHeadSummaryCopyWith<$Res> implements $HeadToHeadSummaryCopyWith<$Res> {
  factory _$HeadToHeadSummaryCopyWith(_HeadToHeadSummary value, $Res Function(_HeadToHeadSummary) _then) = __$HeadToHeadSummaryCopyWithImpl;
@override @useResult
$Res call({
 String playerAId, String playerBId, int totalMatches, int playerAWins, int playerBWins, int draws, double playerAWinRate, double playerBWinRate, List<CompetitiveOutcome> recentResults, int playerACurrentStreak, int playerBCurrentStreak, int playerABestStreak, int playerBBestStreak, DateTime? lastMatchAt
});




}
/// @nodoc
class __$HeadToHeadSummaryCopyWithImpl<$Res>
    implements _$HeadToHeadSummaryCopyWith<$Res> {
  __$HeadToHeadSummaryCopyWithImpl(this._self, this._then);

  final _HeadToHeadSummary _self;
  final $Res Function(_HeadToHeadSummary) _then;

/// Create a copy of HeadToHeadSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerAId = null,Object? playerBId = null,Object? totalMatches = null,Object? playerAWins = null,Object? playerBWins = null,Object? draws = null,Object? playerAWinRate = null,Object? playerBWinRate = null,Object? recentResults = null,Object? playerACurrentStreak = null,Object? playerBCurrentStreak = null,Object? playerABestStreak = null,Object? playerBBestStreak = null,Object? lastMatchAt = freezed,}) {
  return _then(_HeadToHeadSummary(
playerAId: null == playerAId ? _self.playerAId : playerAId // ignore: cast_nullable_to_non_nullable
as String,playerBId: null == playerBId ? _self.playerBId : playerBId // ignore: cast_nullable_to_non_nullable
as String,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,playerAWins: null == playerAWins ? _self.playerAWins : playerAWins // ignore: cast_nullable_to_non_nullable
as int,playerBWins: null == playerBWins ? _self.playerBWins : playerBWins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,playerAWinRate: null == playerAWinRate ? _self.playerAWinRate : playerAWinRate // ignore: cast_nullable_to_non_nullable
as double,playerBWinRate: null == playerBWinRate ? _self.playerBWinRate : playerBWinRate // ignore: cast_nullable_to_non_nullable
as double,recentResults: null == recentResults ? _self._recentResults : recentResults // ignore: cast_nullable_to_non_nullable
as List<CompetitiveOutcome>,playerACurrentStreak: null == playerACurrentStreak ? _self.playerACurrentStreak : playerACurrentStreak // ignore: cast_nullable_to_non_nullable
as int,playerBCurrentStreak: null == playerBCurrentStreak ? _self.playerBCurrentStreak : playerBCurrentStreak // ignore: cast_nullable_to_non_nullable
as int,playerABestStreak: null == playerABestStreak ? _self.playerABestStreak : playerABestStreak // ignore: cast_nullable_to_non_nullable
as int,playerBBestStreak: null == playerBBestStreak ? _self.playerBBestStreak : playerBBestStreak // ignore: cast_nullable_to_non_nullable
as int,lastMatchAt: freezed == lastMatchAt ? _self.lastMatchAt : lastMatchAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
