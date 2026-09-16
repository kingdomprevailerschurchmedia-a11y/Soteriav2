// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeasonResult {

 String get seasonId; String get userId; String get seasonName; int get seasonNumber; int get finalPosition; int get finalRankPoints; String get finalTier; int get finalDivision; String get previousTier; int get previousDivision; int get rankChange; DateTime get completedAt; DateTime get createdAt; DateTime get updatedAt; String get status; Map<String, dynamic>? get statistics;
/// Create a copy of SeasonResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonResultCopyWith<SeasonResult> get copyWith => _$SeasonResultCopyWithImpl<SeasonResult>(this as SeasonResult, _$identity);

  /// Serializes this SeasonResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonResult&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonName, seasonName) || other.seasonName == seasonName)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.finalPosition, finalPosition) || other.finalPosition == finalPosition)&&(identical(other.finalRankPoints, finalRankPoints) || other.finalRankPoints == finalRankPoints)&&(identical(other.finalTier, finalTier) || other.finalTier == finalTier)&&(identical(other.finalDivision, finalDivision) || other.finalDivision == finalDivision)&&(identical(other.previousTier, previousTier) || other.previousTier == previousTier)&&(identical(other.previousDivision, previousDivision) || other.previousDivision == previousDivision)&&(identical(other.rankChange, rankChange) || other.rankChange == rankChange)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.statistics, statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,userId,seasonName,seasonNumber,finalPosition,finalRankPoints,finalTier,finalDivision,previousTier,previousDivision,rankChange,completedAt,createdAt,updatedAt,status,const DeepCollectionEquality().hash(statistics));

@override
String toString() {
  return 'SeasonResult(seasonId: $seasonId, userId: $userId, seasonName: $seasonName, seasonNumber: $seasonNumber, finalPosition: $finalPosition, finalRankPoints: $finalRankPoints, finalTier: $finalTier, finalDivision: $finalDivision, previousTier: $previousTier, previousDivision: $previousDivision, rankChange: $rankChange, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class $SeasonResultCopyWith<$Res>  {
  factory $SeasonResultCopyWith(SeasonResult value, $Res Function(SeasonResult) _then) = _$SeasonResultCopyWithImpl;
@useResult
$Res call({
 String seasonId, String userId, String seasonName, int seasonNumber, int finalPosition, int finalRankPoints, String finalTier, int finalDivision, String previousTier, int previousDivision, int rankChange, DateTime completedAt, DateTime createdAt, DateTime updatedAt, String status, Map<String, dynamic>? statistics
});




}
/// @nodoc
class _$SeasonResultCopyWithImpl<$Res>
    implements $SeasonResultCopyWith<$Res> {
  _$SeasonResultCopyWithImpl(this._self, this._then);

  final SeasonResult _self;
  final $Res Function(SeasonResult) _then;

/// Create a copy of SeasonResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seasonId = null,Object? userId = null,Object? seasonName = null,Object? seasonNumber = null,Object? finalPosition = null,Object? finalRankPoints = null,Object? finalTier = null,Object? finalDivision = null,Object? previousTier = null,Object? previousDivision = null,Object? rankChange = null,Object? completedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? statistics = freezed,}) {
  return _then(_self.copyWith(
seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonName: null == seasonName ? _self.seasonName : seasonName // ignore: cast_nullable_to_non_nullable
as String,seasonNumber: null == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int,finalPosition: null == finalPosition ? _self.finalPosition : finalPosition // ignore: cast_nullable_to_non_nullable
as int,finalRankPoints: null == finalRankPoints ? _self.finalRankPoints : finalRankPoints // ignore: cast_nullable_to_non_nullable
as int,finalTier: null == finalTier ? _self.finalTier : finalTier // ignore: cast_nullable_to_non_nullable
as String,finalDivision: null == finalDivision ? _self.finalDivision : finalDivision // ignore: cast_nullable_to_non_nullable
as int,previousTier: null == previousTier ? _self.previousTier : previousTier // ignore: cast_nullable_to_non_nullable
as String,previousDivision: null == previousDivision ? _self.previousDivision : previousDivision // ignore: cast_nullable_to_non_nullable
as int,rankChange: null == rankChange ? _self.rankChange : rankChange // ignore: cast_nullable_to_non_nullable
as int,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statistics: freezed == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonResult].
extension SeasonResultPatterns on SeasonResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonResult value)  $default,){
final _that = this;
switch (_that) {
case _SeasonResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonResult value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String seasonId,  String userId,  String seasonName,  int seasonNumber,  int finalPosition,  int finalRankPoints,  String finalTier,  int finalDivision,  String previousTier,  int previousDivision,  int rankChange,  DateTime completedAt,  DateTime createdAt,  DateTime updatedAt,  String status,  Map<String, dynamic>? statistics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonResult() when $default != null:
return $default(_that.seasonId,_that.userId,_that.seasonName,_that.seasonNumber,_that.finalPosition,_that.finalRankPoints,_that.finalTier,_that.finalDivision,_that.previousTier,_that.previousDivision,_that.rankChange,_that.completedAt,_that.createdAt,_that.updatedAt,_that.status,_that.statistics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String seasonId,  String userId,  String seasonName,  int seasonNumber,  int finalPosition,  int finalRankPoints,  String finalTier,  int finalDivision,  String previousTier,  int previousDivision,  int rankChange,  DateTime completedAt,  DateTime createdAt,  DateTime updatedAt,  String status,  Map<String, dynamic>? statistics)  $default,) {final _that = this;
switch (_that) {
case _SeasonResult():
return $default(_that.seasonId,_that.userId,_that.seasonName,_that.seasonNumber,_that.finalPosition,_that.finalRankPoints,_that.finalTier,_that.finalDivision,_that.previousTier,_that.previousDivision,_that.rankChange,_that.completedAt,_that.createdAt,_that.updatedAt,_that.status,_that.statistics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String seasonId,  String userId,  String seasonName,  int seasonNumber,  int finalPosition,  int finalRankPoints,  String finalTier,  int finalDivision,  String previousTier,  int previousDivision,  int rankChange,  DateTime completedAt,  DateTime createdAt,  DateTime updatedAt,  String status,  Map<String, dynamic>? statistics)?  $default,) {final _that = this;
switch (_that) {
case _SeasonResult() when $default != null:
return $default(_that.seasonId,_that.userId,_that.seasonName,_that.seasonNumber,_that.finalPosition,_that.finalRankPoints,_that.finalTier,_that.finalDivision,_that.previousTier,_that.previousDivision,_that.rankChange,_that.completedAt,_that.createdAt,_that.updatedAt,_that.status,_that.statistics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonResult implements SeasonResult {
  const _SeasonResult({required this.seasonId, required this.userId, required this.seasonName, required this.seasonNumber, required this.finalPosition, required this.finalRankPoints, required this.finalTier, required this.finalDivision, required this.previousTier, required this.previousDivision, required this.rankChange, required this.completedAt, required this.createdAt, required this.updatedAt, this.status = 'finalized', final  Map<String, dynamic>? statistics}): _statistics = statistics;
  factory _SeasonResult.fromJson(Map<String, dynamic> json) => _$SeasonResultFromJson(json);

@override final  String seasonId;
@override final  String userId;
@override final  String seasonName;
@override final  int seasonNumber;
@override final  int finalPosition;
@override final  int finalRankPoints;
@override final  String finalTier;
@override final  int finalDivision;
@override final  String previousTier;
@override final  int previousDivision;
@override final  int rankChange;
@override final  DateTime completedAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  String status;
 final  Map<String, dynamic>? _statistics;
@override Map<String, dynamic>? get statistics {
  final value = _statistics;
  if (value == null) return null;
  if (_statistics is EqualUnmodifiableMapView) return _statistics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SeasonResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonResultCopyWith<_SeasonResult> get copyWith => __$SeasonResultCopyWithImpl<_SeasonResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonResult&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonName, seasonName) || other.seasonName == seasonName)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.finalPosition, finalPosition) || other.finalPosition == finalPosition)&&(identical(other.finalRankPoints, finalRankPoints) || other.finalRankPoints == finalRankPoints)&&(identical(other.finalTier, finalTier) || other.finalTier == finalTier)&&(identical(other.finalDivision, finalDivision) || other.finalDivision == finalDivision)&&(identical(other.previousTier, previousTier) || other.previousTier == previousTier)&&(identical(other.previousDivision, previousDivision) || other.previousDivision == previousDivision)&&(identical(other.rankChange, rankChange) || other.rankChange == rankChange)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._statistics, _statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,userId,seasonName,seasonNumber,finalPosition,finalRankPoints,finalTier,finalDivision,previousTier,previousDivision,rankChange,completedAt,createdAt,updatedAt,status,const DeepCollectionEquality().hash(_statistics));

@override
String toString() {
  return 'SeasonResult(seasonId: $seasonId, userId: $userId, seasonName: $seasonName, seasonNumber: $seasonNumber, finalPosition: $finalPosition, finalRankPoints: $finalRankPoints, finalTier: $finalTier, finalDivision: $finalDivision, previousTier: $previousTier, previousDivision: $previousDivision, rankChange: $rankChange, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class _$SeasonResultCopyWith<$Res> implements $SeasonResultCopyWith<$Res> {
  factory _$SeasonResultCopyWith(_SeasonResult value, $Res Function(_SeasonResult) _then) = __$SeasonResultCopyWithImpl;
@override @useResult
$Res call({
 String seasonId, String userId, String seasonName, int seasonNumber, int finalPosition, int finalRankPoints, String finalTier, int finalDivision, String previousTier, int previousDivision, int rankChange, DateTime completedAt, DateTime createdAt, DateTime updatedAt, String status, Map<String, dynamic>? statistics
});




}
/// @nodoc
class __$SeasonResultCopyWithImpl<$Res>
    implements _$SeasonResultCopyWith<$Res> {
  __$SeasonResultCopyWithImpl(this._self, this._then);

  final _SeasonResult _self;
  final $Res Function(_SeasonResult) _then;

/// Create a copy of SeasonResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seasonId = null,Object? userId = null,Object? seasonName = null,Object? seasonNumber = null,Object? finalPosition = null,Object? finalRankPoints = null,Object? finalTier = null,Object? finalDivision = null,Object? previousTier = null,Object? previousDivision = null,Object? rankChange = null,Object? completedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? statistics = freezed,}) {
  return _then(_SeasonResult(
seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonName: null == seasonName ? _self.seasonName : seasonName // ignore: cast_nullable_to_non_nullable
as String,seasonNumber: null == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int,finalPosition: null == finalPosition ? _self.finalPosition : finalPosition // ignore: cast_nullable_to_non_nullable
as int,finalRankPoints: null == finalRankPoints ? _self.finalRankPoints : finalRankPoints // ignore: cast_nullable_to_non_nullable
as int,finalTier: null == finalTier ? _self.finalTier : finalTier // ignore: cast_nullable_to_non_nullable
as String,finalDivision: null == finalDivision ? _self.finalDivision : finalDivision // ignore: cast_nullable_to_non_nullable
as int,previousTier: null == previousTier ? _self.previousTier : previousTier // ignore: cast_nullable_to_non_nullable
as String,previousDivision: null == previousDivision ? _self.previousDivision : previousDivision // ignore: cast_nullable_to_non_nullable
as int,rankChange: null == rankChange ? _self.rankChange : rankChange // ignore: cast_nullable_to_non_nullable
as int,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statistics: freezed == statistics ? _self._statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$CompetitiveHistory {

 String get userId; List<SeasonResult> get results; SeasonResult? get bestResult; SeasonResult? get latestResult;
/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveHistoryCopyWith<CompetitiveHistory> get copyWith => _$CompetitiveHistoryCopyWithImpl<CompetitiveHistory>(this as CompetitiveHistory, _$identity);

  /// Serializes this CompetitiveHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveHistory&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.bestResult, bestResult) || other.bestResult == bestResult)&&(identical(other.latestResult, latestResult) || other.latestResult == latestResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(results),bestResult,latestResult);

@override
String toString() {
  return 'CompetitiveHistory(userId: $userId, results: $results, bestResult: $bestResult, latestResult: $latestResult)';
}


}

/// @nodoc
abstract mixin class $CompetitiveHistoryCopyWith<$Res>  {
  factory $CompetitiveHistoryCopyWith(CompetitiveHistory value, $Res Function(CompetitiveHistory) _then) = _$CompetitiveHistoryCopyWithImpl;
@useResult
$Res call({
 String userId, List<SeasonResult> results, SeasonResult? bestResult, SeasonResult? latestResult
});


$SeasonResultCopyWith<$Res>? get bestResult;$SeasonResultCopyWith<$Res>? get latestResult;

}
/// @nodoc
class _$CompetitiveHistoryCopyWithImpl<$Res>
    implements $CompetitiveHistoryCopyWith<$Res> {
  _$CompetitiveHistoryCopyWithImpl(this._self, this._then);

  final CompetitiveHistory _self;
  final $Res Function(CompetitiveHistory) _then;

/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? results = null,Object? bestResult = freezed,Object? latestResult = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<SeasonResult>,bestResult: freezed == bestResult ? _self.bestResult : bestResult // ignore: cast_nullable_to_non_nullable
as SeasonResult?,latestResult: freezed == latestResult ? _self.latestResult : latestResult // ignore: cast_nullable_to_non_nullable
as SeasonResult?,
  ));
}
/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonResultCopyWith<$Res>? get bestResult {
    if (_self.bestResult == null) {
    return null;
  }

  return $SeasonResultCopyWith<$Res>(_self.bestResult!, (value) {
    return _then(_self.copyWith(bestResult: value));
  });
}/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonResultCopyWith<$Res>? get latestResult {
    if (_self.latestResult == null) {
    return null;
  }

  return $SeasonResultCopyWith<$Res>(_self.latestResult!, (value) {
    return _then(_self.copyWith(latestResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetitiveHistory].
extension CompetitiveHistoryPatterns on CompetitiveHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveHistory value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveHistory value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  List<SeasonResult> results,  SeasonResult? bestResult,  SeasonResult? latestResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveHistory() when $default != null:
return $default(_that.userId,_that.results,_that.bestResult,_that.latestResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  List<SeasonResult> results,  SeasonResult? bestResult,  SeasonResult? latestResult)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveHistory():
return $default(_that.userId,_that.results,_that.bestResult,_that.latestResult);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  List<SeasonResult> results,  SeasonResult? bestResult,  SeasonResult? latestResult)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveHistory() when $default != null:
return $default(_that.userId,_that.results,_that.bestResult,_that.latestResult);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveHistory implements CompetitiveHistory {
  const _CompetitiveHistory({required this.userId, final  List<SeasonResult> results = const [], this.bestResult, this.latestResult}): _results = results;
  factory _CompetitiveHistory.fromJson(Map<String, dynamic> json) => _$CompetitiveHistoryFromJson(json);

@override final  String userId;
 final  List<SeasonResult> _results;
@override@JsonKey() List<SeasonResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  SeasonResult? bestResult;
@override final  SeasonResult? latestResult;

/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveHistoryCopyWith<_CompetitiveHistory> get copyWith => __$CompetitiveHistoryCopyWithImpl<_CompetitiveHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveHistory&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.bestResult, bestResult) || other.bestResult == bestResult)&&(identical(other.latestResult, latestResult) || other.latestResult == latestResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_results),bestResult,latestResult);

@override
String toString() {
  return 'CompetitiveHistory(userId: $userId, results: $results, bestResult: $bestResult, latestResult: $latestResult)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveHistoryCopyWith<$Res> implements $CompetitiveHistoryCopyWith<$Res> {
  factory _$CompetitiveHistoryCopyWith(_CompetitiveHistory value, $Res Function(_CompetitiveHistory) _then) = __$CompetitiveHistoryCopyWithImpl;
@override @useResult
$Res call({
 String userId, List<SeasonResult> results, SeasonResult? bestResult, SeasonResult? latestResult
});


@override $SeasonResultCopyWith<$Res>? get bestResult;@override $SeasonResultCopyWith<$Res>? get latestResult;

}
/// @nodoc
class __$CompetitiveHistoryCopyWithImpl<$Res>
    implements _$CompetitiveHistoryCopyWith<$Res> {
  __$CompetitiveHistoryCopyWithImpl(this._self, this._then);

  final _CompetitiveHistory _self;
  final $Res Function(_CompetitiveHistory) _then;

/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? results = null,Object? bestResult = freezed,Object? latestResult = freezed,}) {
  return _then(_CompetitiveHistory(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<SeasonResult>,bestResult: freezed == bestResult ? _self.bestResult : bestResult // ignore: cast_nullable_to_non_nullable
as SeasonResult?,latestResult: freezed == latestResult ? _self.latestResult : latestResult // ignore: cast_nullable_to_non_nullable
as SeasonResult?,
  ));
}

/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonResultCopyWith<$Res>? get bestResult {
    if (_self.bestResult == null) {
    return null;
  }

  return $SeasonResultCopyWith<$Res>(_self.bestResult!, (value) {
    return _then(_self.copyWith(bestResult: value));
  });
}/// Create a copy of CompetitiveHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonResultCopyWith<$Res>? get latestResult {
    if (_self.latestResult == null) {
    return null;
  }

  return $SeasonResultCopyWith<$Res>(_self.latestResult!, (value) {
    return _then(_self.copyWith(latestResult: value));
  });
}
}

// dart format on
