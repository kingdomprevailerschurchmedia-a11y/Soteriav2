// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_change.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankChange {

 String get changeId; String get userId; String get seasonId; String get previousRank; String get newRank; int get previousRankPoints; int get newRankPoints; int get changeAmount; RankChangeType get type; String? get referenceResultId; DateTime get createdAt; int get schemaVersion; bool get acknowledged; bool get isTierChange; bool get isDivisionChange;
/// Create a copy of RankChange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankChangeCopyWith<RankChange> get copyWith => _$RankChangeCopyWithImpl<RankChange>(this as RankChange, _$identity);

  /// Serializes this RankChange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankChange&&(identical(other.changeId, changeId) || other.changeId == changeId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.newRank, newRank) || other.newRank == newRank)&&(identical(other.previousRankPoints, previousRankPoints) || other.previousRankPoints == previousRankPoints)&&(identical(other.newRankPoints, newRankPoints) || other.newRankPoints == newRankPoints)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.type, type) || other.type == type)&&(identical(other.referenceResultId, referenceResultId) || other.referenceResultId == referenceResultId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.isTierChange, isTierChange) || other.isTierChange == isTierChange)&&(identical(other.isDivisionChange, isDivisionChange) || other.isDivisionChange == isDivisionChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,changeId,userId,seasonId,previousRank,newRank,previousRankPoints,newRankPoints,changeAmount,type,referenceResultId,createdAt,schemaVersion,acknowledged,isTierChange,isDivisionChange);

@override
String toString() {
  return 'RankChange(changeId: $changeId, userId: $userId, seasonId: $seasonId, previousRank: $previousRank, newRank: $newRank, previousRankPoints: $previousRankPoints, newRankPoints: $newRankPoints, changeAmount: $changeAmount, type: $type, referenceResultId: $referenceResultId, createdAt: $createdAt, schemaVersion: $schemaVersion, acknowledged: $acknowledged, isTierChange: $isTierChange, isDivisionChange: $isDivisionChange)';
}


}

/// @nodoc
abstract mixin class $RankChangeCopyWith<$Res>  {
  factory $RankChangeCopyWith(RankChange value, $Res Function(RankChange) _then) = _$RankChangeCopyWithImpl;
@useResult
$Res call({
 String changeId, String userId, String seasonId, String previousRank, String newRank, int previousRankPoints, int newRankPoints, int changeAmount, RankChangeType type, String? referenceResultId, DateTime createdAt, int schemaVersion, bool acknowledged, bool isTierChange, bool isDivisionChange
});




}
/// @nodoc
class _$RankChangeCopyWithImpl<$Res>
    implements $RankChangeCopyWith<$Res> {
  _$RankChangeCopyWithImpl(this._self, this._then);

  final RankChange _self;
  final $Res Function(RankChange) _then;

/// Create a copy of RankChange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? changeId = null,Object? userId = null,Object? seasonId = null,Object? previousRank = null,Object? newRank = null,Object? previousRankPoints = null,Object? newRankPoints = null,Object? changeAmount = null,Object? type = null,Object? referenceResultId = freezed,Object? createdAt = null,Object? schemaVersion = null,Object? acknowledged = null,Object? isTierChange = null,Object? isDivisionChange = null,}) {
  return _then(_self.copyWith(
changeId: null == changeId ? _self.changeId : changeId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,previousRank: null == previousRank ? _self.previousRank : previousRank // ignore: cast_nullable_to_non_nullable
as String,newRank: null == newRank ? _self.newRank : newRank // ignore: cast_nullable_to_non_nullable
as String,previousRankPoints: null == previousRankPoints ? _self.previousRankPoints : previousRankPoints // ignore: cast_nullable_to_non_nullable
as int,newRankPoints: null == newRankPoints ? _self.newRankPoints : newRankPoints // ignore: cast_nullable_to_non_nullable
as int,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RankChangeType,referenceResultId: freezed == referenceResultId ? _self.referenceResultId : referenceResultId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,isTierChange: null == isTierChange ? _self.isTierChange : isTierChange // ignore: cast_nullable_to_non_nullable
as bool,isDivisionChange: null == isDivisionChange ? _self.isDivisionChange : isDivisionChange // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RankChange].
extension RankChangePatterns on RankChange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankChange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankChange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankChange value)  $default,){
final _that = this;
switch (_that) {
case _RankChange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankChange value)?  $default,){
final _that = this;
switch (_that) {
case _RankChange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String changeId,  String userId,  String seasonId,  String previousRank,  String newRank,  int previousRankPoints,  int newRankPoints,  int changeAmount,  RankChangeType type,  String? referenceResultId,  DateTime createdAt,  int schemaVersion,  bool acknowledged,  bool isTierChange,  bool isDivisionChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankChange() when $default != null:
return $default(_that.changeId,_that.userId,_that.seasonId,_that.previousRank,_that.newRank,_that.previousRankPoints,_that.newRankPoints,_that.changeAmount,_that.type,_that.referenceResultId,_that.createdAt,_that.schemaVersion,_that.acknowledged,_that.isTierChange,_that.isDivisionChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String changeId,  String userId,  String seasonId,  String previousRank,  String newRank,  int previousRankPoints,  int newRankPoints,  int changeAmount,  RankChangeType type,  String? referenceResultId,  DateTime createdAt,  int schemaVersion,  bool acknowledged,  bool isTierChange,  bool isDivisionChange)  $default,) {final _that = this;
switch (_that) {
case _RankChange():
return $default(_that.changeId,_that.userId,_that.seasonId,_that.previousRank,_that.newRank,_that.previousRankPoints,_that.newRankPoints,_that.changeAmount,_that.type,_that.referenceResultId,_that.createdAt,_that.schemaVersion,_that.acknowledged,_that.isTierChange,_that.isDivisionChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String changeId,  String userId,  String seasonId,  String previousRank,  String newRank,  int previousRankPoints,  int newRankPoints,  int changeAmount,  RankChangeType type,  String? referenceResultId,  DateTime createdAt,  int schemaVersion,  bool acknowledged,  bool isTierChange,  bool isDivisionChange)?  $default,) {final _that = this;
switch (_that) {
case _RankChange() when $default != null:
return $default(_that.changeId,_that.userId,_that.seasonId,_that.previousRank,_that.newRank,_that.previousRankPoints,_that.newRankPoints,_that.changeAmount,_that.type,_that.referenceResultId,_that.createdAt,_that.schemaVersion,_that.acknowledged,_that.isTierChange,_that.isDivisionChange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankChange implements RankChange {
  const _RankChange({required this.changeId, required this.userId, required this.seasonId, required this.previousRank, required this.newRank, required this.previousRankPoints, required this.newRankPoints, required this.changeAmount, required this.type, this.referenceResultId, required this.createdAt, this.schemaVersion = 1, this.acknowledged = false, this.isTierChange = false, this.isDivisionChange = false});
  factory _RankChange.fromJson(Map<String, dynamic> json) => _$RankChangeFromJson(json);

@override final  String changeId;
@override final  String userId;
@override final  String seasonId;
@override final  String previousRank;
@override final  String newRank;
@override final  int previousRankPoints;
@override final  int newRankPoints;
@override final  int changeAmount;
@override final  RankChangeType type;
@override final  String? referenceResultId;
@override final  DateTime createdAt;
@override@JsonKey() final  int schemaVersion;
@override@JsonKey() final  bool acknowledged;
@override@JsonKey() final  bool isTierChange;
@override@JsonKey() final  bool isDivisionChange;

/// Create a copy of RankChange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankChangeCopyWith<_RankChange> get copyWith => __$RankChangeCopyWithImpl<_RankChange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankChangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankChange&&(identical(other.changeId, changeId) || other.changeId == changeId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.newRank, newRank) || other.newRank == newRank)&&(identical(other.previousRankPoints, previousRankPoints) || other.previousRankPoints == previousRankPoints)&&(identical(other.newRankPoints, newRankPoints) || other.newRankPoints == newRankPoints)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.type, type) || other.type == type)&&(identical(other.referenceResultId, referenceResultId) || other.referenceResultId == referenceResultId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.isTierChange, isTierChange) || other.isTierChange == isTierChange)&&(identical(other.isDivisionChange, isDivisionChange) || other.isDivisionChange == isDivisionChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,changeId,userId,seasonId,previousRank,newRank,previousRankPoints,newRankPoints,changeAmount,type,referenceResultId,createdAt,schemaVersion,acknowledged,isTierChange,isDivisionChange);

@override
String toString() {
  return 'RankChange(changeId: $changeId, userId: $userId, seasonId: $seasonId, previousRank: $previousRank, newRank: $newRank, previousRankPoints: $previousRankPoints, newRankPoints: $newRankPoints, changeAmount: $changeAmount, type: $type, referenceResultId: $referenceResultId, createdAt: $createdAt, schemaVersion: $schemaVersion, acknowledged: $acknowledged, isTierChange: $isTierChange, isDivisionChange: $isDivisionChange)';
}


}

/// @nodoc
abstract mixin class _$RankChangeCopyWith<$Res> implements $RankChangeCopyWith<$Res> {
  factory _$RankChangeCopyWith(_RankChange value, $Res Function(_RankChange) _then) = __$RankChangeCopyWithImpl;
@override @useResult
$Res call({
 String changeId, String userId, String seasonId, String previousRank, String newRank, int previousRankPoints, int newRankPoints, int changeAmount, RankChangeType type, String? referenceResultId, DateTime createdAt, int schemaVersion, bool acknowledged, bool isTierChange, bool isDivisionChange
});




}
/// @nodoc
class __$RankChangeCopyWithImpl<$Res>
    implements _$RankChangeCopyWith<$Res> {
  __$RankChangeCopyWithImpl(this._self, this._then);

  final _RankChange _self;
  final $Res Function(_RankChange) _then;

/// Create a copy of RankChange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? changeId = null,Object? userId = null,Object? seasonId = null,Object? previousRank = null,Object? newRank = null,Object? previousRankPoints = null,Object? newRankPoints = null,Object? changeAmount = null,Object? type = null,Object? referenceResultId = freezed,Object? createdAt = null,Object? schemaVersion = null,Object? acknowledged = null,Object? isTierChange = null,Object? isDivisionChange = null,}) {
  return _then(_RankChange(
changeId: null == changeId ? _self.changeId : changeId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,previousRank: null == previousRank ? _self.previousRank : previousRank // ignore: cast_nullable_to_non_nullable
as String,newRank: null == newRank ? _self.newRank : newRank // ignore: cast_nullable_to_non_nullable
as String,previousRankPoints: null == previousRankPoints ? _self.previousRankPoints : previousRankPoints // ignore: cast_nullable_to_non_nullable
as int,newRankPoints: null == newRankPoints ? _self.newRankPoints : newRankPoints // ignore: cast_nullable_to_non_nullable
as int,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RankChangeType,referenceResultId: freezed == referenceResultId ? _self.referenceResultId : referenceResultId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,isTierChange: null == isTierChange ? _self.isTierChange : isTierChange // ignore: cast_nullable_to_non_nullable
as bool,isDivisionChange: null == isDivisionChange ? _self.isDivisionChange : isDivisionChange // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
