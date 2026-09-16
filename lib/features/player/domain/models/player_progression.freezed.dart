// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_progression.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerProgression {

 String get userId; int get currentLevel; int get currentXp; int get lifetimeXp; int get xpRequiredForCurrentLevel; int get xpRequiredForNextLevel; double get xpProgress; String get currentRank; String get currentRankTier; int get rankPoints; double get rankProgress; String get seasonId; int get seasonXp; int get seasonRankPoints;@RequiredTimestampConverter() DateTime get lastUpdated; int get dailyStreak; int get longestStreak;// Daily Login Record
 int get maxQuestionStreak;// Gameplay Record
@EngagementDateConverter() String? get lastEngagementDate;// YYYY-MM-DD
 String? get lastXpTransactionId; String? get lastRankTransactionId; int get schemaVersion;
/// Create a copy of PlayerProgression
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerProgressionCopyWith<PlayerProgression> get copyWith => _$PlayerProgressionCopyWithImpl<PlayerProgression>(this as PlayerProgression, _$identity);

  /// Serializes this PlayerProgression to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerProgression&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentLevel, currentLevel) || other.currentLevel == currentLevel)&&(identical(other.currentXp, currentXp) || other.currentXp == currentXp)&&(identical(other.lifetimeXp, lifetimeXp) || other.lifetimeXp == lifetimeXp)&&(identical(other.xpRequiredForCurrentLevel, xpRequiredForCurrentLevel) || other.xpRequiredForCurrentLevel == xpRequiredForCurrentLevel)&&(identical(other.xpRequiredForNextLevel, xpRequiredForNextLevel) || other.xpRequiredForNextLevel == xpRequiredForNextLevel)&&(identical(other.xpProgress, xpProgress) || other.xpProgress == xpProgress)&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.currentRankTier, currentRankTier) || other.currentRankTier == currentRankTier)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.rankProgress, rankProgress) || other.rankProgress == rankProgress)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.seasonXp, seasonXp) || other.seasonXp == seasonXp)&&(identical(other.seasonRankPoints, seasonRankPoints) || other.seasonRankPoints == seasonRankPoints)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.dailyStreak, dailyStreak) || other.dailyStreak == dailyStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.maxQuestionStreak, maxQuestionStreak) || other.maxQuestionStreak == maxQuestionStreak)&&(identical(other.lastEngagementDate, lastEngagementDate) || other.lastEngagementDate == lastEngagementDate)&&(identical(other.lastXpTransactionId, lastXpTransactionId) || other.lastXpTransactionId == lastXpTransactionId)&&(identical(other.lastRankTransactionId, lastRankTransactionId) || other.lastRankTransactionId == lastRankTransactionId)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,currentLevel,currentXp,lifetimeXp,xpRequiredForCurrentLevel,xpRequiredForNextLevel,xpProgress,currentRank,currentRankTier,rankPoints,rankProgress,seasonId,seasonXp,seasonRankPoints,lastUpdated,dailyStreak,longestStreak,maxQuestionStreak,lastEngagementDate,lastXpTransactionId,lastRankTransactionId,schemaVersion]);

@override
String toString() {
  return 'PlayerProgression(userId: $userId, currentLevel: $currentLevel, currentXp: $currentXp, lifetimeXp: $lifetimeXp, xpRequiredForCurrentLevel: $xpRequiredForCurrentLevel, xpRequiredForNextLevel: $xpRequiredForNextLevel, xpProgress: $xpProgress, currentRank: $currentRank, currentRankTier: $currentRankTier, rankPoints: $rankPoints, rankProgress: $rankProgress, seasonId: $seasonId, seasonXp: $seasonXp, seasonRankPoints: $seasonRankPoints, lastUpdated: $lastUpdated, dailyStreak: $dailyStreak, longestStreak: $longestStreak, maxQuestionStreak: $maxQuestionStreak, lastEngagementDate: $lastEngagementDate, lastXpTransactionId: $lastXpTransactionId, lastRankTransactionId: $lastRankTransactionId, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $PlayerProgressionCopyWith<$Res>  {
  factory $PlayerProgressionCopyWith(PlayerProgression value, $Res Function(PlayerProgression) _then) = _$PlayerProgressionCopyWithImpl;
@useResult
$Res call({
 String userId, int currentLevel, int currentXp, int lifetimeXp, int xpRequiredForCurrentLevel, int xpRequiredForNextLevel, double xpProgress, String currentRank, String currentRankTier, int rankPoints, double rankProgress, String seasonId, int seasonXp, int seasonRankPoints,@RequiredTimestampConverter() DateTime lastUpdated, int dailyStreak, int longestStreak, int maxQuestionStreak,@EngagementDateConverter() String? lastEngagementDate, String? lastXpTransactionId, String? lastRankTransactionId, int schemaVersion
});




}
/// @nodoc
class _$PlayerProgressionCopyWithImpl<$Res>
    implements $PlayerProgressionCopyWith<$Res> {
  _$PlayerProgressionCopyWithImpl(this._self, this._then);

  final PlayerProgression _self;
  final $Res Function(PlayerProgression) _then;

/// Create a copy of PlayerProgression
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? currentLevel = null,Object? currentXp = null,Object? lifetimeXp = null,Object? xpRequiredForCurrentLevel = null,Object? xpRequiredForNextLevel = null,Object? xpProgress = null,Object? currentRank = null,Object? currentRankTier = null,Object? rankPoints = null,Object? rankProgress = null,Object? seasonId = null,Object? seasonXp = null,Object? seasonRankPoints = null,Object? lastUpdated = null,Object? dailyStreak = null,Object? longestStreak = null,Object? maxQuestionStreak = null,Object? lastEngagementDate = freezed,Object? lastXpTransactionId = freezed,Object? lastRankTransactionId = freezed,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentLevel: null == currentLevel ? _self.currentLevel : currentLevel // ignore: cast_nullable_to_non_nullable
as int,currentXp: null == currentXp ? _self.currentXp : currentXp // ignore: cast_nullable_to_non_nullable
as int,lifetimeXp: null == lifetimeXp ? _self.lifetimeXp : lifetimeXp // ignore: cast_nullable_to_non_nullable
as int,xpRequiredForCurrentLevel: null == xpRequiredForCurrentLevel ? _self.xpRequiredForCurrentLevel : xpRequiredForCurrentLevel // ignore: cast_nullable_to_non_nullable
as int,xpRequiredForNextLevel: null == xpRequiredForNextLevel ? _self.xpRequiredForNextLevel : xpRequiredForNextLevel // ignore: cast_nullable_to_non_nullable
as int,xpProgress: null == xpProgress ? _self.xpProgress : xpProgress // ignore: cast_nullable_to_non_nullable
as double,currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,currentRankTier: null == currentRankTier ? _self.currentRankTier : currentRankTier // ignore: cast_nullable_to_non_nullable
as String,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,rankProgress: null == rankProgress ? _self.rankProgress : rankProgress // ignore: cast_nullable_to_non_nullable
as double,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,seasonXp: null == seasonXp ? _self.seasonXp : seasonXp // ignore: cast_nullable_to_non_nullable
as int,seasonRankPoints: null == seasonRankPoints ? _self.seasonRankPoints : seasonRankPoints // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,dailyStreak: null == dailyStreak ? _self.dailyStreak : dailyStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,maxQuestionStreak: null == maxQuestionStreak ? _self.maxQuestionStreak : maxQuestionStreak // ignore: cast_nullable_to_non_nullable
as int,lastEngagementDate: freezed == lastEngagementDate ? _self.lastEngagementDate : lastEngagementDate // ignore: cast_nullable_to_non_nullable
as String?,lastXpTransactionId: freezed == lastXpTransactionId ? _self.lastXpTransactionId : lastXpTransactionId // ignore: cast_nullable_to_non_nullable
as String?,lastRankTransactionId: freezed == lastRankTransactionId ? _self.lastRankTransactionId : lastRankTransactionId // ignore: cast_nullable_to_non_nullable
as String?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerProgression].
extension PlayerProgressionPatterns on PlayerProgression {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerProgression value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerProgression() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerProgression value)  $default,){
final _that = this;
switch (_that) {
case _PlayerProgression():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerProgression value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerProgression() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int currentLevel,  int currentXp,  int lifetimeXp,  int xpRequiredForCurrentLevel,  int xpRequiredForNextLevel,  double xpProgress,  String currentRank,  String currentRankTier,  int rankPoints,  double rankProgress,  String seasonId,  int seasonXp,  int seasonRankPoints, @RequiredTimestampConverter()  DateTime lastUpdated,  int dailyStreak,  int longestStreak,  int maxQuestionStreak, @EngagementDateConverter()  String? lastEngagementDate,  String? lastXpTransactionId,  String? lastRankTransactionId,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerProgression() when $default != null:
return $default(_that.userId,_that.currentLevel,_that.currentXp,_that.lifetimeXp,_that.xpRequiredForCurrentLevel,_that.xpRequiredForNextLevel,_that.xpProgress,_that.currentRank,_that.currentRankTier,_that.rankPoints,_that.rankProgress,_that.seasonId,_that.seasonXp,_that.seasonRankPoints,_that.lastUpdated,_that.dailyStreak,_that.longestStreak,_that.maxQuestionStreak,_that.lastEngagementDate,_that.lastXpTransactionId,_that.lastRankTransactionId,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int currentLevel,  int currentXp,  int lifetimeXp,  int xpRequiredForCurrentLevel,  int xpRequiredForNextLevel,  double xpProgress,  String currentRank,  String currentRankTier,  int rankPoints,  double rankProgress,  String seasonId,  int seasonXp,  int seasonRankPoints, @RequiredTimestampConverter()  DateTime lastUpdated,  int dailyStreak,  int longestStreak,  int maxQuestionStreak, @EngagementDateConverter()  String? lastEngagementDate,  String? lastXpTransactionId,  String? lastRankTransactionId,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _PlayerProgression():
return $default(_that.userId,_that.currentLevel,_that.currentXp,_that.lifetimeXp,_that.xpRequiredForCurrentLevel,_that.xpRequiredForNextLevel,_that.xpProgress,_that.currentRank,_that.currentRankTier,_that.rankPoints,_that.rankProgress,_that.seasonId,_that.seasonXp,_that.seasonRankPoints,_that.lastUpdated,_that.dailyStreak,_that.longestStreak,_that.maxQuestionStreak,_that.lastEngagementDate,_that.lastXpTransactionId,_that.lastRankTransactionId,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int currentLevel,  int currentXp,  int lifetimeXp,  int xpRequiredForCurrentLevel,  int xpRequiredForNextLevel,  double xpProgress,  String currentRank,  String currentRankTier,  int rankPoints,  double rankProgress,  String seasonId,  int seasonXp,  int seasonRankPoints, @RequiredTimestampConverter()  DateTime lastUpdated,  int dailyStreak,  int longestStreak,  int maxQuestionStreak, @EngagementDateConverter()  String? lastEngagementDate,  String? lastXpTransactionId,  String? lastRankTransactionId,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _PlayerProgression() when $default != null:
return $default(_that.userId,_that.currentLevel,_that.currentXp,_that.lifetimeXp,_that.xpRequiredForCurrentLevel,_that.xpRequiredForNextLevel,_that.xpProgress,_that.currentRank,_that.currentRankTier,_that.rankPoints,_that.rankProgress,_that.seasonId,_that.seasonXp,_that.seasonRankPoints,_that.lastUpdated,_that.dailyStreak,_that.longestStreak,_that.maxQuestionStreak,_that.lastEngagementDate,_that.lastXpTransactionId,_that.lastRankTransactionId,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerProgression implements PlayerProgression {
  const _PlayerProgression({required this.userId, required this.currentLevel, required this.currentXp, required this.lifetimeXp, required this.xpRequiredForCurrentLevel, required this.xpRequiredForNextLevel, required this.xpProgress, required this.currentRank, required this.currentRankTier, required this.rankPoints, required this.rankProgress, required this.seasonId, required this.seasonXp, required this.seasonRankPoints, @RequiredTimestampConverter() required this.lastUpdated, this.dailyStreak = 0, this.longestStreak = 0, this.maxQuestionStreak = 0, @EngagementDateConverter() this.lastEngagementDate, this.lastXpTransactionId, this.lastRankTransactionId, this.schemaVersion = 1});
  factory _PlayerProgression.fromJson(Map<String, dynamic> json) => _$PlayerProgressionFromJson(json);

@override final  String userId;
@override final  int currentLevel;
@override final  int currentXp;
@override final  int lifetimeXp;
@override final  int xpRequiredForCurrentLevel;
@override final  int xpRequiredForNextLevel;
@override final  double xpProgress;
@override final  String currentRank;
@override final  String currentRankTier;
@override final  int rankPoints;
@override final  double rankProgress;
@override final  String seasonId;
@override final  int seasonXp;
@override final  int seasonRankPoints;
@override@RequiredTimestampConverter() final  DateTime lastUpdated;
@override@JsonKey() final  int dailyStreak;
@override@JsonKey() final  int longestStreak;
// Daily Login Record
@override@JsonKey() final  int maxQuestionStreak;
// Gameplay Record
@override@EngagementDateConverter() final  String? lastEngagementDate;
// YYYY-MM-DD
@override final  String? lastXpTransactionId;
@override final  String? lastRankTransactionId;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of PlayerProgression
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerProgressionCopyWith<_PlayerProgression> get copyWith => __$PlayerProgressionCopyWithImpl<_PlayerProgression>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerProgressionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerProgression&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentLevel, currentLevel) || other.currentLevel == currentLevel)&&(identical(other.currentXp, currentXp) || other.currentXp == currentXp)&&(identical(other.lifetimeXp, lifetimeXp) || other.lifetimeXp == lifetimeXp)&&(identical(other.xpRequiredForCurrentLevel, xpRequiredForCurrentLevel) || other.xpRequiredForCurrentLevel == xpRequiredForCurrentLevel)&&(identical(other.xpRequiredForNextLevel, xpRequiredForNextLevel) || other.xpRequiredForNextLevel == xpRequiredForNextLevel)&&(identical(other.xpProgress, xpProgress) || other.xpProgress == xpProgress)&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.currentRankTier, currentRankTier) || other.currentRankTier == currentRankTier)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.rankProgress, rankProgress) || other.rankProgress == rankProgress)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.seasonXp, seasonXp) || other.seasonXp == seasonXp)&&(identical(other.seasonRankPoints, seasonRankPoints) || other.seasonRankPoints == seasonRankPoints)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.dailyStreak, dailyStreak) || other.dailyStreak == dailyStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.maxQuestionStreak, maxQuestionStreak) || other.maxQuestionStreak == maxQuestionStreak)&&(identical(other.lastEngagementDate, lastEngagementDate) || other.lastEngagementDate == lastEngagementDate)&&(identical(other.lastXpTransactionId, lastXpTransactionId) || other.lastXpTransactionId == lastXpTransactionId)&&(identical(other.lastRankTransactionId, lastRankTransactionId) || other.lastRankTransactionId == lastRankTransactionId)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,currentLevel,currentXp,lifetimeXp,xpRequiredForCurrentLevel,xpRequiredForNextLevel,xpProgress,currentRank,currentRankTier,rankPoints,rankProgress,seasonId,seasonXp,seasonRankPoints,lastUpdated,dailyStreak,longestStreak,maxQuestionStreak,lastEngagementDate,lastXpTransactionId,lastRankTransactionId,schemaVersion]);

@override
String toString() {
  return 'PlayerProgression(userId: $userId, currentLevel: $currentLevel, currentXp: $currentXp, lifetimeXp: $lifetimeXp, xpRequiredForCurrentLevel: $xpRequiredForCurrentLevel, xpRequiredForNextLevel: $xpRequiredForNextLevel, xpProgress: $xpProgress, currentRank: $currentRank, currentRankTier: $currentRankTier, rankPoints: $rankPoints, rankProgress: $rankProgress, seasonId: $seasonId, seasonXp: $seasonXp, seasonRankPoints: $seasonRankPoints, lastUpdated: $lastUpdated, dailyStreak: $dailyStreak, longestStreak: $longestStreak, maxQuestionStreak: $maxQuestionStreak, lastEngagementDate: $lastEngagementDate, lastXpTransactionId: $lastXpTransactionId, lastRankTransactionId: $lastRankTransactionId, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$PlayerProgressionCopyWith<$Res> implements $PlayerProgressionCopyWith<$Res> {
  factory _$PlayerProgressionCopyWith(_PlayerProgression value, $Res Function(_PlayerProgression) _then) = __$PlayerProgressionCopyWithImpl;
@override @useResult
$Res call({
 String userId, int currentLevel, int currentXp, int lifetimeXp, int xpRequiredForCurrentLevel, int xpRequiredForNextLevel, double xpProgress, String currentRank, String currentRankTier, int rankPoints, double rankProgress, String seasonId, int seasonXp, int seasonRankPoints,@RequiredTimestampConverter() DateTime lastUpdated, int dailyStreak, int longestStreak, int maxQuestionStreak,@EngagementDateConverter() String? lastEngagementDate, String? lastXpTransactionId, String? lastRankTransactionId, int schemaVersion
});




}
/// @nodoc
class __$PlayerProgressionCopyWithImpl<$Res>
    implements _$PlayerProgressionCopyWith<$Res> {
  __$PlayerProgressionCopyWithImpl(this._self, this._then);

  final _PlayerProgression _self;
  final $Res Function(_PlayerProgression) _then;

/// Create a copy of PlayerProgression
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? currentLevel = null,Object? currentXp = null,Object? lifetimeXp = null,Object? xpRequiredForCurrentLevel = null,Object? xpRequiredForNextLevel = null,Object? xpProgress = null,Object? currentRank = null,Object? currentRankTier = null,Object? rankPoints = null,Object? rankProgress = null,Object? seasonId = null,Object? seasonXp = null,Object? seasonRankPoints = null,Object? lastUpdated = null,Object? dailyStreak = null,Object? longestStreak = null,Object? maxQuestionStreak = null,Object? lastEngagementDate = freezed,Object? lastXpTransactionId = freezed,Object? lastRankTransactionId = freezed,Object? schemaVersion = null,}) {
  return _then(_PlayerProgression(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentLevel: null == currentLevel ? _self.currentLevel : currentLevel // ignore: cast_nullable_to_non_nullable
as int,currentXp: null == currentXp ? _self.currentXp : currentXp // ignore: cast_nullable_to_non_nullable
as int,lifetimeXp: null == lifetimeXp ? _self.lifetimeXp : lifetimeXp // ignore: cast_nullable_to_non_nullable
as int,xpRequiredForCurrentLevel: null == xpRequiredForCurrentLevel ? _self.xpRequiredForCurrentLevel : xpRequiredForCurrentLevel // ignore: cast_nullable_to_non_nullable
as int,xpRequiredForNextLevel: null == xpRequiredForNextLevel ? _self.xpRequiredForNextLevel : xpRequiredForNextLevel // ignore: cast_nullable_to_non_nullable
as int,xpProgress: null == xpProgress ? _self.xpProgress : xpProgress // ignore: cast_nullable_to_non_nullable
as double,currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,currentRankTier: null == currentRankTier ? _self.currentRankTier : currentRankTier // ignore: cast_nullable_to_non_nullable
as String,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,rankProgress: null == rankProgress ? _self.rankProgress : rankProgress // ignore: cast_nullable_to_non_nullable
as double,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,seasonXp: null == seasonXp ? _self.seasonXp : seasonXp // ignore: cast_nullable_to_non_nullable
as int,seasonRankPoints: null == seasonRankPoints ? _self.seasonRankPoints : seasonRankPoints // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,dailyStreak: null == dailyStreak ? _self.dailyStreak : dailyStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,maxQuestionStreak: null == maxQuestionStreak ? _self.maxQuestionStreak : maxQuestionStreak // ignore: cast_nullable_to_non_nullable
as int,lastEngagementDate: freezed == lastEngagementDate ? _self.lastEngagementDate : lastEngagementDate // ignore: cast_nullable_to_non_nullable
as String?,lastXpTransactionId: freezed == lastXpTransactionId ? _self.lastXpTransactionId : lastXpTransactionId // ignore: cast_nullable_to_non_nullable
as String?,lastRankTransactionId: freezed == lastRankTransactionId ? _self.lastRankTransactionId : lastRankTransactionId // ignore: cast_nullable_to_non_nullable
as String?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
