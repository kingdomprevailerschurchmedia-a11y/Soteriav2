// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_career_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveCareerSummary {

 String get userId; int get totalSeasons; String get bestRank; int get bestPosition; int get totalMatches; int get totalWins; int get totalLosses; double get winRate; int get bestStreak; int get highestScore; int get totalXp; SeasonResult? get bestSeason; List<CompetitivePersonalRecord> get careerRecords; List<String> get recentForm;
/// Create a copy of CompetitiveCareerSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveCareerSummaryCopyWith<CompetitiveCareerSummary> get copyWith => _$CompetitiveCareerSummaryCopyWithImpl<CompetitiveCareerSummary>(this as CompetitiveCareerSummary, _$identity);

  /// Serializes this CompetitiveCareerSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveCareerSummary&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.totalSeasons, totalSeasons) || other.totalSeasons == totalSeasons)&&(identical(other.bestRank, bestRank) || other.bestRank == bestRank)&&(identical(other.bestPosition, bestPosition) || other.bestPosition == bestPosition)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.totalWins, totalWins) || other.totalWins == totalWins)&&(identical(other.totalLosses, totalLosses) || other.totalLosses == totalLosses)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.highestScore, highestScore) || other.highestScore == highestScore)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.bestSeason, bestSeason) || other.bestSeason == bestSeason)&&const DeepCollectionEquality().equals(other.careerRecords, careerRecords)&&const DeepCollectionEquality().equals(other.recentForm, recentForm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,totalSeasons,bestRank,bestPosition,totalMatches,totalWins,totalLosses,winRate,bestStreak,highestScore,totalXp,bestSeason,const DeepCollectionEquality().hash(careerRecords),const DeepCollectionEquality().hash(recentForm));

@override
String toString() {
  return 'CompetitiveCareerSummary(userId: $userId, totalSeasons: $totalSeasons, bestRank: $bestRank, bestPosition: $bestPosition, totalMatches: $totalMatches, totalWins: $totalWins, totalLosses: $totalLosses, winRate: $winRate, bestStreak: $bestStreak, highestScore: $highestScore, totalXp: $totalXp, bestSeason: $bestSeason, careerRecords: $careerRecords, recentForm: $recentForm)';
}


}

/// @nodoc
abstract mixin class $CompetitiveCareerSummaryCopyWith<$Res>  {
  factory $CompetitiveCareerSummaryCopyWith(CompetitiveCareerSummary value, $Res Function(CompetitiveCareerSummary) _then) = _$CompetitiveCareerSummaryCopyWithImpl;
@useResult
$Res call({
 String userId, int totalSeasons, String bestRank, int bestPosition, int totalMatches, int totalWins, int totalLosses, double winRate, int bestStreak, int highestScore, int totalXp, SeasonResult? bestSeason, List<CompetitivePersonalRecord> careerRecords, List<String> recentForm
});


$SeasonResultCopyWith<$Res>? get bestSeason;

}
/// @nodoc
class _$CompetitiveCareerSummaryCopyWithImpl<$Res>
    implements $CompetitiveCareerSummaryCopyWith<$Res> {
  _$CompetitiveCareerSummaryCopyWithImpl(this._self, this._then);

  final CompetitiveCareerSummary _self;
  final $Res Function(CompetitiveCareerSummary) _then;

/// Create a copy of CompetitiveCareerSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? totalSeasons = null,Object? bestRank = null,Object? bestPosition = null,Object? totalMatches = null,Object? totalWins = null,Object? totalLosses = null,Object? winRate = null,Object? bestStreak = null,Object? highestScore = null,Object? totalXp = null,Object? bestSeason = freezed,Object? careerRecords = null,Object? recentForm = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,totalSeasons: null == totalSeasons ? _self.totalSeasons : totalSeasons // ignore: cast_nullable_to_non_nullable
as int,bestRank: null == bestRank ? _self.bestRank : bestRank // ignore: cast_nullable_to_non_nullable
as String,bestPosition: null == bestPosition ? _self.bestPosition : bestPosition // ignore: cast_nullable_to_non_nullable
as int,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,totalWins: null == totalWins ? _self.totalWins : totalWins // ignore: cast_nullable_to_non_nullable
as int,totalLosses: null == totalLosses ? _self.totalLosses : totalLosses // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,highestScore: null == highestScore ? _self.highestScore : highestScore // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,bestSeason: freezed == bestSeason ? _self.bestSeason : bestSeason // ignore: cast_nullable_to_non_nullable
as SeasonResult?,careerRecords: null == careerRecords ? _self.careerRecords : careerRecords // ignore: cast_nullable_to_non_nullable
as List<CompetitivePersonalRecord>,recentForm: null == recentForm ? _self.recentForm : recentForm // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of CompetitiveCareerSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonResultCopyWith<$Res>? get bestSeason {
    if (_self.bestSeason == null) {
    return null;
  }

  return $SeasonResultCopyWith<$Res>(_self.bestSeason!, (value) {
    return _then(_self.copyWith(bestSeason: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetitiveCareerSummary].
extension CompetitiveCareerSummaryPatterns on CompetitiveCareerSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveCareerSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveCareerSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveCareerSummary value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveCareerSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveCareerSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveCareerSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int totalSeasons,  String bestRank,  int bestPosition,  int totalMatches,  int totalWins,  int totalLosses,  double winRate,  int bestStreak,  int highestScore,  int totalXp,  SeasonResult? bestSeason,  List<CompetitivePersonalRecord> careerRecords,  List<String> recentForm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveCareerSummary() when $default != null:
return $default(_that.userId,_that.totalSeasons,_that.bestRank,_that.bestPosition,_that.totalMatches,_that.totalWins,_that.totalLosses,_that.winRate,_that.bestStreak,_that.highestScore,_that.totalXp,_that.bestSeason,_that.careerRecords,_that.recentForm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int totalSeasons,  String bestRank,  int bestPosition,  int totalMatches,  int totalWins,  int totalLosses,  double winRate,  int bestStreak,  int highestScore,  int totalXp,  SeasonResult? bestSeason,  List<CompetitivePersonalRecord> careerRecords,  List<String> recentForm)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveCareerSummary():
return $default(_that.userId,_that.totalSeasons,_that.bestRank,_that.bestPosition,_that.totalMatches,_that.totalWins,_that.totalLosses,_that.winRate,_that.bestStreak,_that.highestScore,_that.totalXp,_that.bestSeason,_that.careerRecords,_that.recentForm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int totalSeasons,  String bestRank,  int bestPosition,  int totalMatches,  int totalWins,  int totalLosses,  double winRate,  int bestStreak,  int highestScore,  int totalXp,  SeasonResult? bestSeason,  List<CompetitivePersonalRecord> careerRecords,  List<String> recentForm)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveCareerSummary() when $default != null:
return $default(_that.userId,_that.totalSeasons,_that.bestRank,_that.bestPosition,_that.totalMatches,_that.totalWins,_that.totalLosses,_that.winRate,_that.bestStreak,_that.highestScore,_that.totalXp,_that.bestSeason,_that.careerRecords,_that.recentForm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveCareerSummary implements CompetitiveCareerSummary {
  const _CompetitiveCareerSummary({required this.userId, required this.totalSeasons, required this.bestRank, required this.bestPosition, required this.totalMatches, required this.totalWins, required this.totalLosses, required this.winRate, required this.bestStreak, required this.highestScore, required this.totalXp, this.bestSeason, final  List<CompetitivePersonalRecord> careerRecords = const [], final  List<String> recentForm = const []}): _careerRecords = careerRecords,_recentForm = recentForm;
  factory _CompetitiveCareerSummary.fromJson(Map<String, dynamic> json) => _$CompetitiveCareerSummaryFromJson(json);

@override final  String userId;
@override final  int totalSeasons;
@override final  String bestRank;
@override final  int bestPosition;
@override final  int totalMatches;
@override final  int totalWins;
@override final  int totalLosses;
@override final  double winRate;
@override final  int bestStreak;
@override final  int highestScore;
@override final  int totalXp;
@override final  SeasonResult? bestSeason;
 final  List<CompetitivePersonalRecord> _careerRecords;
@override@JsonKey() List<CompetitivePersonalRecord> get careerRecords {
  if (_careerRecords is EqualUnmodifiableListView) return _careerRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_careerRecords);
}

 final  List<String> _recentForm;
@override@JsonKey() List<String> get recentForm {
  if (_recentForm is EqualUnmodifiableListView) return _recentForm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentForm);
}


/// Create a copy of CompetitiveCareerSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveCareerSummaryCopyWith<_CompetitiveCareerSummary> get copyWith => __$CompetitiveCareerSummaryCopyWithImpl<_CompetitiveCareerSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveCareerSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveCareerSummary&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.totalSeasons, totalSeasons) || other.totalSeasons == totalSeasons)&&(identical(other.bestRank, bestRank) || other.bestRank == bestRank)&&(identical(other.bestPosition, bestPosition) || other.bestPosition == bestPosition)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.totalWins, totalWins) || other.totalWins == totalWins)&&(identical(other.totalLosses, totalLosses) || other.totalLosses == totalLosses)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.highestScore, highestScore) || other.highestScore == highestScore)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.bestSeason, bestSeason) || other.bestSeason == bestSeason)&&const DeepCollectionEquality().equals(other._careerRecords, _careerRecords)&&const DeepCollectionEquality().equals(other._recentForm, _recentForm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,totalSeasons,bestRank,bestPosition,totalMatches,totalWins,totalLosses,winRate,bestStreak,highestScore,totalXp,bestSeason,const DeepCollectionEquality().hash(_careerRecords),const DeepCollectionEquality().hash(_recentForm));

@override
String toString() {
  return 'CompetitiveCareerSummary(userId: $userId, totalSeasons: $totalSeasons, bestRank: $bestRank, bestPosition: $bestPosition, totalMatches: $totalMatches, totalWins: $totalWins, totalLosses: $totalLosses, winRate: $winRate, bestStreak: $bestStreak, highestScore: $highestScore, totalXp: $totalXp, bestSeason: $bestSeason, careerRecords: $careerRecords, recentForm: $recentForm)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveCareerSummaryCopyWith<$Res> implements $CompetitiveCareerSummaryCopyWith<$Res> {
  factory _$CompetitiveCareerSummaryCopyWith(_CompetitiveCareerSummary value, $Res Function(_CompetitiveCareerSummary) _then) = __$CompetitiveCareerSummaryCopyWithImpl;
@override @useResult
$Res call({
 String userId, int totalSeasons, String bestRank, int bestPosition, int totalMatches, int totalWins, int totalLosses, double winRate, int bestStreak, int highestScore, int totalXp, SeasonResult? bestSeason, List<CompetitivePersonalRecord> careerRecords, List<String> recentForm
});


@override $SeasonResultCopyWith<$Res>? get bestSeason;

}
/// @nodoc
class __$CompetitiveCareerSummaryCopyWithImpl<$Res>
    implements _$CompetitiveCareerSummaryCopyWith<$Res> {
  __$CompetitiveCareerSummaryCopyWithImpl(this._self, this._then);

  final _CompetitiveCareerSummary _self;
  final $Res Function(_CompetitiveCareerSummary) _then;

/// Create a copy of CompetitiveCareerSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? totalSeasons = null,Object? bestRank = null,Object? bestPosition = null,Object? totalMatches = null,Object? totalWins = null,Object? totalLosses = null,Object? winRate = null,Object? bestStreak = null,Object? highestScore = null,Object? totalXp = null,Object? bestSeason = freezed,Object? careerRecords = null,Object? recentForm = null,}) {
  return _then(_CompetitiveCareerSummary(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,totalSeasons: null == totalSeasons ? _self.totalSeasons : totalSeasons // ignore: cast_nullable_to_non_nullable
as int,bestRank: null == bestRank ? _self.bestRank : bestRank // ignore: cast_nullable_to_non_nullable
as String,bestPosition: null == bestPosition ? _self.bestPosition : bestPosition // ignore: cast_nullable_to_non_nullable
as int,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,totalWins: null == totalWins ? _self.totalWins : totalWins // ignore: cast_nullable_to_non_nullable
as int,totalLosses: null == totalLosses ? _self.totalLosses : totalLosses // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,highestScore: null == highestScore ? _self.highestScore : highestScore // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,bestSeason: freezed == bestSeason ? _self.bestSeason : bestSeason // ignore: cast_nullable_to_non_nullable
as SeasonResult?,careerRecords: null == careerRecords ? _self._careerRecords : careerRecords // ignore: cast_nullable_to_non_nullable
as List<CompetitivePersonalRecord>,recentForm: null == recentForm ? _self._recentForm : recentForm // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of CompetitiveCareerSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonResultCopyWith<$Res>? get bestSeason {
    if (_self.bestSeason == null) {
    return null;
  }

  return $SeasonResultCopyWith<$Res>(_self.bestSeason!, (value) {
    return _then(_self.copyWith(bestSeason: value));
  });
}
}

// dart format on
