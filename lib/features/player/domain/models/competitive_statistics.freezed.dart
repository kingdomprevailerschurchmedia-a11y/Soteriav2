// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CareerStatistics {

 int get gamesPlayed; int get gamesWon; int get gamesLost; double get winRate; int get totalQuestionsAnswered; int get correctAnswers; double get accuracy; int get currentStreak; int get highestStreak; String get bestRank; int get peakPosition; int get seasonsPlayed;
/// Create a copy of CareerStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CareerStatisticsCopyWith<CareerStatistics> get copyWith => _$CareerStatisticsCopyWithImpl<CareerStatistics>(this as CareerStatistics, _$identity);

  /// Serializes this CareerStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CareerStatistics&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.totalQuestionsAnswered, totalQuestionsAnswered) || other.totalQuestionsAnswered == totalQuestionsAnswered)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.highestStreak, highestStreak) || other.highestStreak == highestStreak)&&(identical(other.bestRank, bestRank) || other.bestRank == bestRank)&&(identical(other.peakPosition, peakPosition) || other.peakPosition == peakPosition)&&(identical(other.seasonsPlayed, seasonsPlayed) || other.seasonsPlayed == seasonsPlayed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesPlayed,gamesWon,gamesLost,winRate,totalQuestionsAnswered,correctAnswers,accuracy,currentStreak,highestStreak,bestRank,peakPosition,seasonsPlayed);

@override
String toString() {
  return 'CareerStatistics(gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, winRate: $winRate, totalQuestionsAnswered: $totalQuestionsAnswered, correctAnswers: $correctAnswers, accuracy: $accuracy, currentStreak: $currentStreak, highestStreak: $highestStreak, bestRank: $bestRank, peakPosition: $peakPosition, seasonsPlayed: $seasonsPlayed)';
}


}

/// @nodoc
abstract mixin class $CareerStatisticsCopyWith<$Res>  {
  factory $CareerStatisticsCopyWith(CareerStatistics value, $Res Function(CareerStatistics) _then) = _$CareerStatisticsCopyWithImpl;
@useResult
$Res call({
 int gamesPlayed, int gamesWon, int gamesLost, double winRate, int totalQuestionsAnswered, int correctAnswers, double accuracy, int currentStreak, int highestStreak, String bestRank, int peakPosition, int seasonsPlayed
});




}
/// @nodoc
class _$CareerStatisticsCopyWithImpl<$Res>
    implements $CareerStatisticsCopyWith<$Res> {
  _$CareerStatisticsCopyWithImpl(this._self, this._then);

  final CareerStatistics _self;
  final $Res Function(CareerStatistics) _then;

/// Create a copy of CareerStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? winRate = null,Object? totalQuestionsAnswered = null,Object? correctAnswers = null,Object? accuracy = null,Object? currentStreak = null,Object? highestStreak = null,Object? bestRank = null,Object? peakPosition = null,Object? seasonsPlayed = null,}) {
  return _then(_self.copyWith(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,totalQuestionsAnswered: null == totalQuestionsAnswered ? _self.totalQuestionsAnswered : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,highestStreak: null == highestStreak ? _self.highestStreak : highestStreak // ignore: cast_nullable_to_non_nullable
as int,bestRank: null == bestRank ? _self.bestRank : bestRank // ignore: cast_nullable_to_non_nullable
as String,peakPosition: null == peakPosition ? _self.peakPosition : peakPosition // ignore: cast_nullable_to_non_nullable
as int,seasonsPlayed: null == seasonsPlayed ? _self.seasonsPlayed : seasonsPlayed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CareerStatistics].
extension CareerStatisticsPatterns on CareerStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CareerStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CareerStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CareerStatistics value)  $default,){
final _that = this;
switch (_that) {
case _CareerStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CareerStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _CareerStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  int totalQuestionsAnswered,  int correctAnswers,  double accuracy,  int currentStreak,  int highestStreak,  String bestRank,  int peakPosition,  int seasonsPlayed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CareerStatistics() when $default != null:
return $default(_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.totalQuestionsAnswered,_that.correctAnswers,_that.accuracy,_that.currentStreak,_that.highestStreak,_that.bestRank,_that.peakPosition,_that.seasonsPlayed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  int totalQuestionsAnswered,  int correctAnswers,  double accuracy,  int currentStreak,  int highestStreak,  String bestRank,  int peakPosition,  int seasonsPlayed)  $default,) {final _that = this;
switch (_that) {
case _CareerStatistics():
return $default(_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.totalQuestionsAnswered,_that.correctAnswers,_that.accuracy,_that.currentStreak,_that.highestStreak,_that.bestRank,_that.peakPosition,_that.seasonsPlayed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  int totalQuestionsAnswered,  int correctAnswers,  double accuracy,  int currentStreak,  int highestStreak,  String bestRank,  int peakPosition,  int seasonsPlayed)?  $default,) {final _that = this;
switch (_that) {
case _CareerStatistics() when $default != null:
return $default(_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.totalQuestionsAnswered,_that.correctAnswers,_that.accuracy,_that.currentStreak,_that.highestStreak,_that.bestRank,_that.peakPosition,_that.seasonsPlayed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CareerStatistics implements CareerStatistics {
  const _CareerStatistics({required this.gamesPlayed, required this.gamesWon, required this.gamesLost, required this.winRate, required this.totalQuestionsAnswered, required this.correctAnswers, required this.accuracy, required this.currentStreak, required this.highestStreak, required this.bestRank, required this.peakPosition, required this.seasonsPlayed});
  factory _CareerStatistics.fromJson(Map<String, dynamic> json) => _$CareerStatisticsFromJson(json);

@override final  int gamesPlayed;
@override final  int gamesWon;
@override final  int gamesLost;
@override final  double winRate;
@override final  int totalQuestionsAnswered;
@override final  int correctAnswers;
@override final  double accuracy;
@override final  int currentStreak;
@override final  int highestStreak;
@override final  String bestRank;
@override final  int peakPosition;
@override final  int seasonsPlayed;

/// Create a copy of CareerStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CareerStatisticsCopyWith<_CareerStatistics> get copyWith => __$CareerStatisticsCopyWithImpl<_CareerStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CareerStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CareerStatistics&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.totalQuestionsAnswered, totalQuestionsAnswered) || other.totalQuestionsAnswered == totalQuestionsAnswered)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.highestStreak, highestStreak) || other.highestStreak == highestStreak)&&(identical(other.bestRank, bestRank) || other.bestRank == bestRank)&&(identical(other.peakPosition, peakPosition) || other.peakPosition == peakPosition)&&(identical(other.seasonsPlayed, seasonsPlayed) || other.seasonsPlayed == seasonsPlayed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesPlayed,gamesWon,gamesLost,winRate,totalQuestionsAnswered,correctAnswers,accuracy,currentStreak,highestStreak,bestRank,peakPosition,seasonsPlayed);

@override
String toString() {
  return 'CareerStatistics(gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, winRate: $winRate, totalQuestionsAnswered: $totalQuestionsAnswered, correctAnswers: $correctAnswers, accuracy: $accuracy, currentStreak: $currentStreak, highestStreak: $highestStreak, bestRank: $bestRank, peakPosition: $peakPosition, seasonsPlayed: $seasonsPlayed)';
}


}

/// @nodoc
abstract mixin class _$CareerStatisticsCopyWith<$Res> implements $CareerStatisticsCopyWith<$Res> {
  factory _$CareerStatisticsCopyWith(_CareerStatistics value, $Res Function(_CareerStatistics) _then) = __$CareerStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int gamesPlayed, int gamesWon, int gamesLost, double winRate, int totalQuestionsAnswered, int correctAnswers, double accuracy, int currentStreak, int highestStreak, String bestRank, int peakPosition, int seasonsPlayed
});




}
/// @nodoc
class __$CareerStatisticsCopyWithImpl<$Res>
    implements _$CareerStatisticsCopyWith<$Res> {
  __$CareerStatisticsCopyWithImpl(this._self, this._then);

  final _CareerStatistics _self;
  final $Res Function(_CareerStatistics) _then;

/// Create a copy of CareerStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? winRate = null,Object? totalQuestionsAnswered = null,Object? correctAnswers = null,Object? accuracy = null,Object? currentStreak = null,Object? highestStreak = null,Object? bestRank = null,Object? peakPosition = null,Object? seasonsPlayed = null,}) {
  return _then(_CareerStatistics(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,totalQuestionsAnswered: null == totalQuestionsAnswered ? _self.totalQuestionsAnswered : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,highestStreak: null == highestStreak ? _self.highestStreak : highestStreak // ignore: cast_nullable_to_non_nullable
as int,bestRank: null == bestRank ? _self.bestRank : bestRank // ignore: cast_nullable_to_non_nullable
as String,peakPosition: null == peakPosition ? _self.peakPosition : peakPosition // ignore: cast_nullable_to_non_nullable
as int,seasonsPlayed: null == seasonsPlayed ? _self.seasonsPlayed : seasonsPlayed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SeasonStatistics {

 String get seasonId; String get seasonName; int get gamesPlayed; int get gamesWon; int get gamesLost; double get winRate; int get totalPoints; double get averagePoints; int get bestScore; double get accuracy; int? get currentPosition; int get currentWinStreak; int get highestWinStreak;
/// Create a copy of SeasonStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonStatisticsCopyWith<SeasonStatistics> get copyWith => _$SeasonStatisticsCopyWithImpl<SeasonStatistics>(this as SeasonStatistics, _$identity);

  /// Serializes this SeasonStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonStatistics&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.seasonName, seasonName) || other.seasonName == seasonName)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.averagePoints, averagePoints) || other.averagePoints == averagePoints)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.currentWinStreak, currentWinStreak) || other.currentWinStreak == currentWinStreak)&&(identical(other.highestWinStreak, highestWinStreak) || other.highestWinStreak == highestWinStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,seasonName,gamesPlayed,gamesWon,gamesLost,winRate,totalPoints,averagePoints,bestScore,accuracy,currentPosition,currentWinStreak,highestWinStreak);

@override
String toString() {
  return 'SeasonStatistics(seasonId: $seasonId, seasonName: $seasonName, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, winRate: $winRate, totalPoints: $totalPoints, averagePoints: $averagePoints, bestScore: $bestScore, accuracy: $accuracy, currentPosition: $currentPosition, currentWinStreak: $currentWinStreak, highestWinStreak: $highestWinStreak)';
}


}

/// @nodoc
abstract mixin class $SeasonStatisticsCopyWith<$Res>  {
  factory $SeasonStatisticsCopyWith(SeasonStatistics value, $Res Function(SeasonStatistics) _then) = _$SeasonStatisticsCopyWithImpl;
@useResult
$Res call({
 String seasonId, String seasonName, int gamesPlayed, int gamesWon, int gamesLost, double winRate, int totalPoints, double averagePoints, int bestScore, double accuracy, int? currentPosition, int currentWinStreak, int highestWinStreak
});




}
/// @nodoc
class _$SeasonStatisticsCopyWithImpl<$Res>
    implements $SeasonStatisticsCopyWith<$Res> {
  _$SeasonStatisticsCopyWithImpl(this._self, this._then);

  final SeasonStatistics _self;
  final $Res Function(SeasonStatistics) _then;

/// Create a copy of SeasonStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seasonId = null,Object? seasonName = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? winRate = null,Object? totalPoints = null,Object? averagePoints = null,Object? bestScore = null,Object? accuracy = null,Object? currentPosition = freezed,Object? currentWinStreak = null,Object? highestWinStreak = null,}) {
  return _then(_self.copyWith(
seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,seasonName: null == seasonName ? _self.seasonName : seasonName // ignore: cast_nullable_to_non_nullable
as String,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,averagePoints: null == averagePoints ? _self.averagePoints : averagePoints // ignore: cast_nullable_to_non_nullable
as double,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,currentPosition: freezed == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as int?,currentWinStreak: null == currentWinStreak ? _self.currentWinStreak : currentWinStreak // ignore: cast_nullable_to_non_nullable
as int,highestWinStreak: null == highestWinStreak ? _self.highestWinStreak : highestWinStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonStatistics].
extension SeasonStatisticsPatterns on SeasonStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonStatistics value)  $default,){
final _that = this;
switch (_that) {
case _SeasonStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String seasonId,  String seasonName,  int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  int totalPoints,  double averagePoints,  int bestScore,  double accuracy,  int? currentPosition,  int currentWinStreak,  int highestWinStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonStatistics() when $default != null:
return $default(_that.seasonId,_that.seasonName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.totalPoints,_that.averagePoints,_that.bestScore,_that.accuracy,_that.currentPosition,_that.currentWinStreak,_that.highestWinStreak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String seasonId,  String seasonName,  int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  int totalPoints,  double averagePoints,  int bestScore,  double accuracy,  int? currentPosition,  int currentWinStreak,  int highestWinStreak)  $default,) {final _that = this;
switch (_that) {
case _SeasonStatistics():
return $default(_that.seasonId,_that.seasonName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.totalPoints,_that.averagePoints,_that.bestScore,_that.accuracy,_that.currentPosition,_that.currentWinStreak,_that.highestWinStreak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String seasonId,  String seasonName,  int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  int totalPoints,  double averagePoints,  int bestScore,  double accuracy,  int? currentPosition,  int currentWinStreak,  int highestWinStreak)?  $default,) {final _that = this;
switch (_that) {
case _SeasonStatistics() when $default != null:
return $default(_that.seasonId,_that.seasonName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.totalPoints,_that.averagePoints,_that.bestScore,_that.accuracy,_that.currentPosition,_that.currentWinStreak,_that.highestWinStreak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonStatistics implements SeasonStatistics {
  const _SeasonStatistics({required this.seasonId, required this.seasonName, required this.gamesPlayed, required this.gamesWon, required this.gamesLost, required this.winRate, required this.totalPoints, required this.averagePoints, required this.bestScore, required this.accuracy, this.currentPosition, this.currentWinStreak = 0, this.highestWinStreak = 0});
  factory _SeasonStatistics.fromJson(Map<String, dynamic> json) => _$SeasonStatisticsFromJson(json);

@override final  String seasonId;
@override final  String seasonName;
@override final  int gamesPlayed;
@override final  int gamesWon;
@override final  int gamesLost;
@override final  double winRate;
@override final  int totalPoints;
@override final  double averagePoints;
@override final  int bestScore;
@override final  double accuracy;
@override final  int? currentPosition;
@override@JsonKey() final  int currentWinStreak;
@override@JsonKey() final  int highestWinStreak;

/// Create a copy of SeasonStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonStatisticsCopyWith<_SeasonStatistics> get copyWith => __$SeasonStatisticsCopyWithImpl<_SeasonStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonStatistics&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.seasonName, seasonName) || other.seasonName == seasonName)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.averagePoints, averagePoints) || other.averagePoints == averagePoints)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.currentWinStreak, currentWinStreak) || other.currentWinStreak == currentWinStreak)&&(identical(other.highestWinStreak, highestWinStreak) || other.highestWinStreak == highestWinStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,seasonName,gamesPlayed,gamesWon,gamesLost,winRate,totalPoints,averagePoints,bestScore,accuracy,currentPosition,currentWinStreak,highestWinStreak);

@override
String toString() {
  return 'SeasonStatistics(seasonId: $seasonId, seasonName: $seasonName, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, winRate: $winRate, totalPoints: $totalPoints, averagePoints: $averagePoints, bestScore: $bestScore, accuracy: $accuracy, currentPosition: $currentPosition, currentWinStreak: $currentWinStreak, highestWinStreak: $highestWinStreak)';
}


}

/// @nodoc
abstract mixin class _$SeasonStatisticsCopyWith<$Res> implements $SeasonStatisticsCopyWith<$Res> {
  factory _$SeasonStatisticsCopyWith(_SeasonStatistics value, $Res Function(_SeasonStatistics) _then) = __$SeasonStatisticsCopyWithImpl;
@override @useResult
$Res call({
 String seasonId, String seasonName, int gamesPlayed, int gamesWon, int gamesLost, double winRate, int totalPoints, double averagePoints, int bestScore, double accuracy, int? currentPosition, int currentWinStreak, int highestWinStreak
});




}
/// @nodoc
class __$SeasonStatisticsCopyWithImpl<$Res>
    implements _$SeasonStatisticsCopyWith<$Res> {
  __$SeasonStatisticsCopyWithImpl(this._self, this._then);

  final _SeasonStatistics _self;
  final $Res Function(_SeasonStatistics) _then;

/// Create a copy of SeasonStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seasonId = null,Object? seasonName = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? winRate = null,Object? totalPoints = null,Object? averagePoints = null,Object? bestScore = null,Object? accuracy = null,Object? currentPosition = freezed,Object? currentWinStreak = null,Object? highestWinStreak = null,}) {
  return _then(_SeasonStatistics(
seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,seasonName: null == seasonName ? _self.seasonName : seasonName // ignore: cast_nullable_to_non_nullable
as String,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,averagePoints: null == averagePoints ? _self.averagePoints : averagePoints // ignore: cast_nullable_to_non_nullable
as double,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,currentPosition: freezed == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as int?,currentWinStreak: null == currentWinStreak ? _self.currentWinStreak : currentWinStreak // ignore: cast_nullable_to_non_nullable
as int,highestWinStreak: null == highestWinStreak ? _self.highestWinStreak : highestWinStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PerformanceTrend {

 TrendState get state; double get changePercentage; String get metricName; List<double> get dataPoints;
/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<PerformanceTrend> get copyWith => _$PerformanceTrendCopyWithImpl<PerformanceTrend>(this as PerformanceTrend, _$identity);

  /// Serializes this PerformanceTrend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceTrend&&(identical(other.state, state) || other.state == state)&&(identical(other.changePercentage, changePercentage) || other.changePercentage == changePercentage)&&(identical(other.metricName, metricName) || other.metricName == metricName)&&const DeepCollectionEquality().equals(other.dataPoints, dataPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,changePercentage,metricName,const DeepCollectionEquality().hash(dataPoints));

@override
String toString() {
  return 'PerformanceTrend(state: $state, changePercentage: $changePercentage, metricName: $metricName, dataPoints: $dataPoints)';
}


}

/// @nodoc
abstract mixin class $PerformanceTrendCopyWith<$Res>  {
  factory $PerformanceTrendCopyWith(PerformanceTrend value, $Res Function(PerformanceTrend) _then) = _$PerformanceTrendCopyWithImpl;
@useResult
$Res call({
 TrendState state, double changePercentage, String metricName, List<double> dataPoints
});




}
/// @nodoc
class _$PerformanceTrendCopyWithImpl<$Res>
    implements $PerformanceTrendCopyWith<$Res> {
  _$PerformanceTrendCopyWithImpl(this._self, this._then);

  final PerformanceTrend _self;
  final $Res Function(PerformanceTrend) _then;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? changePercentage = null,Object? metricName = null,Object? dataPoints = null,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as TrendState,changePercentage: null == changePercentage ? _self.changePercentage : changePercentage // ignore: cast_nullable_to_non_nullable
as double,metricName: null == metricName ? _self.metricName : metricName // ignore: cast_nullable_to_non_nullable
as String,dataPoints: null == dataPoints ? _self.dataPoints : dataPoints // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceTrend].
extension PerformanceTrendPatterns on PerformanceTrend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceTrend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceTrend value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceTrend value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrendState state,  double changePercentage,  String metricName,  List<double> dataPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
return $default(_that.state,_that.changePercentage,_that.metricName,_that.dataPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrendState state,  double changePercentage,  String metricName,  List<double> dataPoints)  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrend():
return $default(_that.state,_that.changePercentage,_that.metricName,_that.dataPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrendState state,  double changePercentage,  String metricName,  List<double> dataPoints)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
return $default(_that.state,_that.changePercentage,_that.metricName,_that.dataPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceTrend implements PerformanceTrend {
  const _PerformanceTrend({required this.state, required this.changePercentage, required this.metricName, final  List<double> dataPoints = const []}): _dataPoints = dataPoints;
  factory _PerformanceTrend.fromJson(Map<String, dynamic> json) => _$PerformanceTrendFromJson(json);

@override final  TrendState state;
@override final  double changePercentage;
@override final  String metricName;
 final  List<double> _dataPoints;
@override@JsonKey() List<double> get dataPoints {
  if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dataPoints);
}


/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceTrendCopyWith<_PerformanceTrend> get copyWith => __$PerformanceTrendCopyWithImpl<_PerformanceTrend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceTrendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceTrend&&(identical(other.state, state) || other.state == state)&&(identical(other.changePercentage, changePercentage) || other.changePercentage == changePercentage)&&(identical(other.metricName, metricName) || other.metricName == metricName)&&const DeepCollectionEquality().equals(other._dataPoints, _dataPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,changePercentage,metricName,const DeepCollectionEquality().hash(_dataPoints));

@override
String toString() {
  return 'PerformanceTrend(state: $state, changePercentage: $changePercentage, metricName: $metricName, dataPoints: $dataPoints)';
}


}

/// @nodoc
abstract mixin class _$PerformanceTrendCopyWith<$Res> implements $PerformanceTrendCopyWith<$Res> {
  factory _$PerformanceTrendCopyWith(_PerformanceTrend value, $Res Function(_PerformanceTrend) _then) = __$PerformanceTrendCopyWithImpl;
@override @useResult
$Res call({
 TrendState state, double changePercentage, String metricName, List<double> dataPoints
});




}
/// @nodoc
class __$PerformanceTrendCopyWithImpl<$Res>
    implements _$PerformanceTrendCopyWith<$Res> {
  __$PerformanceTrendCopyWithImpl(this._self, this._then);

  final _PerformanceTrend _self;
  final $Res Function(_PerformanceTrend) _then;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? changePercentage = null,Object? metricName = null,Object? dataPoints = null,}) {
  return _then(_PerformanceTrend(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as TrendState,changePercentage: null == changePercentage ? _self.changePercentage : changePercentage // ignore: cast_nullable_to_non_nullable
as double,metricName: null == metricName ? _self.metricName : metricName // ignore: cast_nullable_to_non_nullable
as String,dataPoints: null == dataPoints ? _self._dataPoints : dataPoints // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}


/// @nodoc
mixin _$PerformanceInsight {

 String get title; String get description; bool get isPositive; String? get recommendation;
/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceInsightCopyWith<PerformanceInsight> get copyWith => _$PerformanceInsightCopyWithImpl<PerformanceInsight>(this as PerformanceInsight, _$identity);

  /// Serializes this PerformanceInsight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceInsight&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,isPositive,recommendation);

@override
String toString() {
  return 'PerformanceInsight(title: $title, description: $description, isPositive: $isPositive, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class $PerformanceInsightCopyWith<$Res>  {
  factory $PerformanceInsightCopyWith(PerformanceInsight value, $Res Function(PerformanceInsight) _then) = _$PerformanceInsightCopyWithImpl;
@useResult
$Res call({
 String title, String description, bool isPositive, String? recommendation
});




}
/// @nodoc
class _$PerformanceInsightCopyWithImpl<$Res>
    implements $PerformanceInsightCopyWith<$Res> {
  _$PerformanceInsightCopyWithImpl(this._self, this._then);

  final PerformanceInsight _self;
  final $Res Function(PerformanceInsight) _then;

/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? isPositive = null,Object? recommendation = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceInsight].
extension PerformanceInsightPatterns on PerformanceInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceInsight value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceInsight value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  bool isPositive,  String? recommendation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
return $default(_that.title,_that.description,_that.isPositive,_that.recommendation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  bool isPositive,  String? recommendation)  $default,) {final _that = this;
switch (_that) {
case _PerformanceInsight():
return $default(_that.title,_that.description,_that.isPositive,_that.recommendation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  bool isPositive,  String? recommendation)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
return $default(_that.title,_that.description,_that.isPositive,_that.recommendation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceInsight implements PerformanceInsight {
  const _PerformanceInsight({required this.title, required this.description, required this.isPositive, this.recommendation});
  factory _PerformanceInsight.fromJson(Map<String, dynamic> json) => _$PerformanceInsightFromJson(json);

@override final  String title;
@override final  String description;
@override final  bool isPositive;
@override final  String? recommendation;

/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceInsightCopyWith<_PerformanceInsight> get copyWith => __$PerformanceInsightCopyWithImpl<_PerformanceInsight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceInsightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceInsight&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,isPositive,recommendation);

@override
String toString() {
  return 'PerformanceInsight(title: $title, description: $description, isPositive: $isPositive, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class _$PerformanceInsightCopyWith<$Res> implements $PerformanceInsightCopyWith<$Res> {
  factory _$PerformanceInsightCopyWith(_PerformanceInsight value, $Res Function(_PerformanceInsight) _then) = __$PerformanceInsightCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, bool isPositive, String? recommendation
});




}
/// @nodoc
class __$PerformanceInsightCopyWithImpl<$Res>
    implements _$PerformanceInsightCopyWith<$Res> {
  __$PerformanceInsightCopyWithImpl(this._self, this._then);

  final _PerformanceInsight _self;
  final $Res Function(_PerformanceInsight) _then;

/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? isPositive = null,Object? recommendation = freezed,}) {
  return _then(_PerformanceInsight(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CompetitiveStatistics {

 String get userId; CareerStatistics get career; SeasonStatistics? get currentSeason; List<PerformanceTrend> get trends; List<PerformanceInsight> get insights; List<String> get recentForm;
/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveStatisticsCopyWith<CompetitiveStatistics> get copyWith => _$CompetitiveStatisticsCopyWithImpl<CompetitiveStatistics>(this as CompetitiveStatistics, _$identity);

  /// Serializes this CompetitiveStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveStatistics&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.career, career) || other.career == career)&&(identical(other.currentSeason, currentSeason) || other.currentSeason == currentSeason)&&const DeepCollectionEquality().equals(other.trends, trends)&&const DeepCollectionEquality().equals(other.insights, insights)&&const DeepCollectionEquality().equals(other.recentForm, recentForm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,career,currentSeason,const DeepCollectionEquality().hash(trends),const DeepCollectionEquality().hash(insights),const DeepCollectionEquality().hash(recentForm));

@override
String toString() {
  return 'CompetitiveStatistics(userId: $userId, career: $career, currentSeason: $currentSeason, trends: $trends, insights: $insights, recentForm: $recentForm)';
}


}

/// @nodoc
abstract mixin class $CompetitiveStatisticsCopyWith<$Res>  {
  factory $CompetitiveStatisticsCopyWith(CompetitiveStatistics value, $Res Function(CompetitiveStatistics) _then) = _$CompetitiveStatisticsCopyWithImpl;
@useResult
$Res call({
 String userId, CareerStatistics career, SeasonStatistics? currentSeason, List<PerformanceTrend> trends, List<PerformanceInsight> insights, List<String> recentForm
});


$CareerStatisticsCopyWith<$Res> get career;$SeasonStatisticsCopyWith<$Res>? get currentSeason;

}
/// @nodoc
class _$CompetitiveStatisticsCopyWithImpl<$Res>
    implements $CompetitiveStatisticsCopyWith<$Res> {
  _$CompetitiveStatisticsCopyWithImpl(this._self, this._then);

  final CompetitiveStatistics _self;
  final $Res Function(CompetitiveStatistics) _then;

/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? career = null,Object? currentSeason = freezed,Object? trends = null,Object? insights = null,Object? recentForm = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,career: null == career ? _self.career : career // ignore: cast_nullable_to_non_nullable
as CareerStatistics,currentSeason: freezed == currentSeason ? _self.currentSeason : currentSeason // ignore: cast_nullable_to_non_nullable
as SeasonStatistics?,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrend>,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<PerformanceInsight>,recentForm: null == recentForm ? _self.recentForm : recentForm // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CareerStatisticsCopyWith<$Res> get career {
  
  return $CareerStatisticsCopyWith<$Res>(_self.career, (value) {
    return _then(_self.copyWith(career: value));
  });
}/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonStatisticsCopyWith<$Res>? get currentSeason {
    if (_self.currentSeason == null) {
    return null;
  }

  return $SeasonStatisticsCopyWith<$Res>(_self.currentSeason!, (value) {
    return _then(_self.copyWith(currentSeason: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetitiveStatistics].
extension CompetitiveStatisticsPatterns on CompetitiveStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveStatistics value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  CareerStatistics career,  SeasonStatistics? currentSeason,  List<PerformanceTrend> trends,  List<PerformanceInsight> insights,  List<String> recentForm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveStatistics() when $default != null:
return $default(_that.userId,_that.career,_that.currentSeason,_that.trends,_that.insights,_that.recentForm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  CareerStatistics career,  SeasonStatistics? currentSeason,  List<PerformanceTrend> trends,  List<PerformanceInsight> insights,  List<String> recentForm)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveStatistics():
return $default(_that.userId,_that.career,_that.currentSeason,_that.trends,_that.insights,_that.recentForm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  CareerStatistics career,  SeasonStatistics? currentSeason,  List<PerformanceTrend> trends,  List<PerformanceInsight> insights,  List<String> recentForm)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveStatistics() when $default != null:
return $default(_that.userId,_that.career,_that.currentSeason,_that.trends,_that.insights,_that.recentForm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveStatistics implements CompetitiveStatistics {
  const _CompetitiveStatistics({required this.userId, required this.career, required this.currentSeason, required final  List<PerformanceTrend> trends, required final  List<PerformanceInsight> insights, final  List<String> recentForm = const []}): _trends = trends,_insights = insights,_recentForm = recentForm;
  factory _CompetitiveStatistics.fromJson(Map<String, dynamic> json) => _$CompetitiveStatisticsFromJson(json);

@override final  String userId;
@override final  CareerStatistics career;
@override final  SeasonStatistics? currentSeason;
 final  List<PerformanceTrend> _trends;
@override List<PerformanceTrend> get trends {
  if (_trends is EqualUnmodifiableListView) return _trends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trends);
}

 final  List<PerformanceInsight> _insights;
@override List<PerformanceInsight> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}

 final  List<String> _recentForm;
@override@JsonKey() List<String> get recentForm {
  if (_recentForm is EqualUnmodifiableListView) return _recentForm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentForm);
}


/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveStatisticsCopyWith<_CompetitiveStatistics> get copyWith => __$CompetitiveStatisticsCopyWithImpl<_CompetitiveStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveStatistics&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.career, career) || other.career == career)&&(identical(other.currentSeason, currentSeason) || other.currentSeason == currentSeason)&&const DeepCollectionEquality().equals(other._trends, _trends)&&const DeepCollectionEquality().equals(other._insights, _insights)&&const DeepCollectionEquality().equals(other._recentForm, _recentForm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,career,currentSeason,const DeepCollectionEquality().hash(_trends),const DeepCollectionEquality().hash(_insights),const DeepCollectionEquality().hash(_recentForm));

@override
String toString() {
  return 'CompetitiveStatistics(userId: $userId, career: $career, currentSeason: $currentSeason, trends: $trends, insights: $insights, recentForm: $recentForm)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveStatisticsCopyWith<$Res> implements $CompetitiveStatisticsCopyWith<$Res> {
  factory _$CompetitiveStatisticsCopyWith(_CompetitiveStatistics value, $Res Function(_CompetitiveStatistics) _then) = __$CompetitiveStatisticsCopyWithImpl;
@override @useResult
$Res call({
 String userId, CareerStatistics career, SeasonStatistics? currentSeason, List<PerformanceTrend> trends, List<PerformanceInsight> insights, List<String> recentForm
});


@override $CareerStatisticsCopyWith<$Res> get career;@override $SeasonStatisticsCopyWith<$Res>? get currentSeason;

}
/// @nodoc
class __$CompetitiveStatisticsCopyWithImpl<$Res>
    implements _$CompetitiveStatisticsCopyWith<$Res> {
  __$CompetitiveStatisticsCopyWithImpl(this._self, this._then);

  final _CompetitiveStatistics _self;
  final $Res Function(_CompetitiveStatistics) _then;

/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? career = null,Object? currentSeason = freezed,Object? trends = null,Object? insights = null,Object? recentForm = null,}) {
  return _then(_CompetitiveStatistics(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,career: null == career ? _self.career : career // ignore: cast_nullable_to_non_nullable
as CareerStatistics,currentSeason: freezed == currentSeason ? _self.currentSeason : currentSeason // ignore: cast_nullable_to_non_nullable
as SeasonStatistics?,trends: null == trends ? _self._trends : trends // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrend>,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<PerformanceInsight>,recentForm: null == recentForm ? _self._recentForm : recentForm // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CareerStatisticsCopyWith<$Res> get career {
  
  return $CareerStatisticsCopyWith<$Res>(_self.career, (value) {
    return _then(_self.copyWith(career: value));
  });
}/// Create a copy of CompetitiveStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonStatisticsCopyWith<$Res>? get currentSeason {
    if (_self.currentSeason == null) {
    return null;
  }

  return $SeasonStatisticsCopyWith<$Res>(_self.currentSeason!, (value) {
    return _then(_self.copyWith(currentSeason: value));
  });
}
}

// dart format on
