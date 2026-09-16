// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaderboardEntry {

 String get userId; String get displayName; String? get avatarUrl; String? get avatarId; int get rankPoints; int get xp; String get rankTier; int get division; int get position; int get registrationOrder; String? get titleId; DateTime get lastUpdated; DateTime? get createdAt; int get schemaVersion;
/// Create a copy of LeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardEntryCopyWith<LeaderboardEntry> get copyWith => _$LeaderboardEntryCopyWithImpl<LeaderboardEntry>(this as LeaderboardEntry, _$identity);

  /// Serializes this LeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardEntry&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.rankTier, rankTier) || other.rankTier == rankTier)&&(identical(other.division, division) || other.division == division)&&(identical(other.position, position) || other.position == position)&&(identical(other.registrationOrder, registrationOrder) || other.registrationOrder == registrationOrder)&&(identical(other.titleId, titleId) || other.titleId == titleId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,avatarUrl,avatarId,rankPoints,xp,rankTier,division,position,registrationOrder,titleId,lastUpdated,createdAt,schemaVersion);

@override
String toString() {
  return 'LeaderboardEntry(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, avatarId: $avatarId, rankPoints: $rankPoints, xp: $xp, rankTier: $rankTier, division: $division, position: $position, registrationOrder: $registrationOrder, titleId: $titleId, lastUpdated: $lastUpdated, createdAt: $createdAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $LeaderboardEntryCopyWith<$Res>  {
  factory $LeaderboardEntryCopyWith(LeaderboardEntry value, $Res Function(LeaderboardEntry) _then) = _$LeaderboardEntryCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? avatarUrl, String? avatarId, int rankPoints, int xp, String rankTier, int division, int position, int registrationOrder, String? titleId, DateTime lastUpdated, DateTime? createdAt, int schemaVersion
});




}
/// @nodoc
class _$LeaderboardEntryCopyWithImpl<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  _$LeaderboardEntryCopyWithImpl(this._self, this._then);

  final LeaderboardEntry _self;
  final $Res Function(LeaderboardEntry) _then;

/// Create a copy of LeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? avatarId = freezed,Object? rankPoints = null,Object? xp = null,Object? rankTier = null,Object? division = null,Object? position = null,Object? registrationOrder = null,Object? titleId = freezed,Object? lastUpdated = null,Object? createdAt = freezed,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,rankTier: null == rankTier ? _self.rankTier : rankTier // ignore: cast_nullable_to_non_nullable
as String,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,registrationOrder: null == registrationOrder ? _self.registrationOrder : registrationOrder // ignore: cast_nullable_to_non_nullable
as int,titleId: freezed == titleId ? _self.titleId : titleId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaderboardEntry].
extension LeaderboardEntryPatterns on LeaderboardEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaderboardEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaderboardEntry value)  $default,){
final _that = this;
switch (_that) {
case _LeaderboardEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaderboardEntry value)?  $default,){
final _that = this;
switch (_that) {
case _LeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? avatarUrl,  String? avatarId,  int rankPoints,  int xp,  String rankTier,  int division,  int position,  int registrationOrder,  String? titleId,  DateTime lastUpdated,  DateTime? createdAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaderboardEntry() when $default != null:
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.avatarId,_that.rankPoints,_that.xp,_that.rankTier,_that.division,_that.position,_that.registrationOrder,_that.titleId,_that.lastUpdated,_that.createdAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? avatarUrl,  String? avatarId,  int rankPoints,  int xp,  String rankTier,  int division,  int position,  int registrationOrder,  String? titleId,  DateTime lastUpdated,  DateTime? createdAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _LeaderboardEntry():
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.avatarId,_that.rankPoints,_that.xp,_that.rankTier,_that.division,_that.position,_that.registrationOrder,_that.titleId,_that.lastUpdated,_that.createdAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? avatarUrl,  String? avatarId,  int rankPoints,  int xp,  String rankTier,  int division,  int position,  int registrationOrder,  String? titleId,  DateTime lastUpdated,  DateTime? createdAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _LeaderboardEntry() when $default != null:
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.avatarId,_that.rankPoints,_that.xp,_that.rankTier,_that.division,_that.position,_that.registrationOrder,_that.titleId,_that.lastUpdated,_that.createdAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaderboardEntry implements LeaderboardEntry {
  const _LeaderboardEntry({required this.userId, required this.displayName, this.avatarUrl, this.avatarId, required this.rankPoints, this.xp = 0, required this.rankTier, required this.division, required this.position, this.registrationOrder = 0, this.titleId, required this.lastUpdated, this.createdAt, this.schemaVersion = 1});
  factory _LeaderboardEntry.fromJson(Map<String, dynamic> json) => _$LeaderboardEntryFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String? avatarId;
@override final  int rankPoints;
@override@JsonKey() final  int xp;
@override final  String rankTier;
@override final  int division;
@override final  int position;
@override@JsonKey() final  int registrationOrder;
@override final  String? titleId;
@override final  DateTime lastUpdated;
@override final  DateTime? createdAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of LeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderboardEntryCopyWith<_LeaderboardEntry> get copyWith => __$LeaderboardEntryCopyWithImpl<_LeaderboardEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaderboardEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderboardEntry&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.rankTier, rankTier) || other.rankTier == rankTier)&&(identical(other.division, division) || other.division == division)&&(identical(other.position, position) || other.position == position)&&(identical(other.registrationOrder, registrationOrder) || other.registrationOrder == registrationOrder)&&(identical(other.titleId, titleId) || other.titleId == titleId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,avatarUrl,avatarId,rankPoints,xp,rankTier,division,position,registrationOrder,titleId,lastUpdated,createdAt,schemaVersion);

@override
String toString() {
  return 'LeaderboardEntry(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, avatarId: $avatarId, rankPoints: $rankPoints, xp: $xp, rankTier: $rankTier, division: $division, position: $position, registrationOrder: $registrationOrder, titleId: $titleId, lastUpdated: $lastUpdated, createdAt: $createdAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$LeaderboardEntryCopyWith<$Res> implements $LeaderboardEntryCopyWith<$Res> {
  factory _$LeaderboardEntryCopyWith(_LeaderboardEntry value, $Res Function(_LeaderboardEntry) _then) = __$LeaderboardEntryCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? avatarUrl, String? avatarId, int rankPoints, int xp, String rankTier, int division, int position, int registrationOrder, String? titleId, DateTime lastUpdated, DateTime? createdAt, int schemaVersion
});




}
/// @nodoc
class __$LeaderboardEntryCopyWithImpl<$Res>
    implements _$LeaderboardEntryCopyWith<$Res> {
  __$LeaderboardEntryCopyWithImpl(this._self, this._then);

  final _LeaderboardEntry _self;
  final $Res Function(_LeaderboardEntry) _then;

/// Create a copy of LeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? avatarId = freezed,Object? rankPoints = null,Object? xp = null,Object? rankTier = null,Object? division = null,Object? position = null,Object? registrationOrder = null,Object? titleId = freezed,Object? lastUpdated = null,Object? createdAt = freezed,Object? schemaVersion = null,}) {
  return _then(_LeaderboardEntry(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,rankTier: null == rankTier ? _self.rankTier : rankTier // ignore: cast_nullable_to_non_nullable
as String,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,registrationOrder: null == registrationOrder ? _self.registrationOrder : registrationOrder // ignore: cast_nullable_to_non_nullable
as int,titleId: freezed == titleId ? _self.titleId : titleId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
