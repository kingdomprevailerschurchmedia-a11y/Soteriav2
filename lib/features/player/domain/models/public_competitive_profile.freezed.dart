// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_competitive_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PublicCompetitiveProfile {

 String get userId; String get displayName; String get username; String get avatarId; String? get photoUrl;// Identity
 String get currentRank; String get rankTier; int get rankPoints; int get division; CompetitiveTitle? get equippedTitle; List<CompetitiveBadge> get featuredBadges; bool get isSearchable;// Career Highlights
 CareerStatistics get careerHighlights;// Metadata
 DateTime get updatedAt; int get schemaVersion;
/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicCompetitiveProfileCopyWith<PublicCompetitiveProfile> get copyWith => _$PublicCompetitiveProfileCopyWithImpl<PublicCompetitiveProfile>(this as PublicCompetitiveProfile, _$identity);

  /// Serializes this PublicCompetitiveProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicCompetitiveProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.rankTier, rankTier) || other.rankTier == rankTier)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.division, division) || other.division == division)&&(identical(other.equippedTitle, equippedTitle) || other.equippedTitle == equippedTitle)&&const DeepCollectionEquality().equals(other.featuredBadges, featuredBadges)&&(identical(other.isSearchable, isSearchable) || other.isSearchable == isSearchable)&&(identical(other.careerHighlights, careerHighlights) || other.careerHighlights == careerHighlights)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,avatarId,photoUrl,currentRank,rankTier,rankPoints,division,equippedTitle,const DeepCollectionEquality().hash(featuredBadges),isSearchable,careerHighlights,updatedAt,schemaVersion);

@override
String toString() {
  return 'PublicCompetitiveProfile(userId: $userId, displayName: $displayName, username: $username, avatarId: $avatarId, photoUrl: $photoUrl, currentRank: $currentRank, rankTier: $rankTier, rankPoints: $rankPoints, division: $division, equippedTitle: $equippedTitle, featuredBadges: $featuredBadges, isSearchable: $isSearchable, careerHighlights: $careerHighlights, updatedAt: $updatedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $PublicCompetitiveProfileCopyWith<$Res>  {
  factory $PublicCompetitiveProfileCopyWith(PublicCompetitiveProfile value, $Res Function(PublicCompetitiveProfile) _then) = _$PublicCompetitiveProfileCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String username, String avatarId, String? photoUrl, String currentRank, String rankTier, int rankPoints, int division, CompetitiveTitle? equippedTitle, List<CompetitiveBadge> featuredBadges, bool isSearchable, CareerStatistics careerHighlights, DateTime updatedAt, int schemaVersion
});


$CompetitiveTitleCopyWith<$Res>? get equippedTitle;$CareerStatisticsCopyWith<$Res> get careerHighlights;

}
/// @nodoc
class _$PublicCompetitiveProfileCopyWithImpl<$Res>
    implements $PublicCompetitiveProfileCopyWith<$Res> {
  _$PublicCompetitiveProfileCopyWithImpl(this._self, this._then);

  final PublicCompetitiveProfile _self;
  final $Res Function(PublicCompetitiveProfile) _then;

/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? username = null,Object? avatarId = null,Object? photoUrl = freezed,Object? currentRank = null,Object? rankTier = null,Object? rankPoints = null,Object? division = null,Object? equippedTitle = freezed,Object? featuredBadges = null,Object? isSearchable = null,Object? careerHighlights = null,Object? updatedAt = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,rankTier: null == rankTier ? _self.rankTier : rankTier // ignore: cast_nullable_to_non_nullable
as String,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as int,equippedTitle: freezed == equippedTitle ? _self.equippedTitle : equippedTitle // ignore: cast_nullable_to_non_nullable
as CompetitiveTitle?,featuredBadges: null == featuredBadges ? _self.featuredBadges : featuredBadges // ignore: cast_nullable_to_non_nullable
as List<CompetitiveBadge>,isSearchable: null == isSearchable ? _self.isSearchable : isSearchable // ignore: cast_nullable_to_non_nullable
as bool,careerHighlights: null == careerHighlights ? _self.careerHighlights : careerHighlights // ignore: cast_nullable_to_non_nullable
as CareerStatistics,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitiveTitleCopyWith<$Res>? get equippedTitle {
    if (_self.equippedTitle == null) {
    return null;
  }

  return $CompetitiveTitleCopyWith<$Res>(_self.equippedTitle!, (value) {
    return _then(_self.copyWith(equippedTitle: value));
  });
}/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CareerStatisticsCopyWith<$Res> get careerHighlights {
  
  return $CareerStatisticsCopyWith<$Res>(_self.careerHighlights, (value) {
    return _then(_self.copyWith(careerHighlights: value));
  });
}
}


/// Adds pattern-matching-related methods to [PublicCompetitiveProfile].
extension PublicCompetitiveProfilePatterns on PublicCompetitiveProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicCompetitiveProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicCompetitiveProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicCompetitiveProfile value)  $default,){
final _that = this;
switch (_that) {
case _PublicCompetitiveProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicCompetitiveProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PublicCompetitiveProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String username,  String avatarId,  String? photoUrl,  String currentRank,  String rankTier,  int rankPoints,  int division,  CompetitiveTitle? equippedTitle,  List<CompetitiveBadge> featuredBadges,  bool isSearchable,  CareerStatistics careerHighlights,  DateTime updatedAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicCompetitiveProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarId,_that.photoUrl,_that.currentRank,_that.rankTier,_that.rankPoints,_that.division,_that.equippedTitle,_that.featuredBadges,_that.isSearchable,_that.careerHighlights,_that.updatedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String username,  String avatarId,  String? photoUrl,  String currentRank,  String rankTier,  int rankPoints,  int division,  CompetitiveTitle? equippedTitle,  List<CompetitiveBadge> featuredBadges,  bool isSearchable,  CareerStatistics careerHighlights,  DateTime updatedAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _PublicCompetitiveProfile():
return $default(_that.userId,_that.displayName,_that.username,_that.avatarId,_that.photoUrl,_that.currentRank,_that.rankTier,_that.rankPoints,_that.division,_that.equippedTitle,_that.featuredBadges,_that.isSearchable,_that.careerHighlights,_that.updatedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String username,  String avatarId,  String? photoUrl,  String currentRank,  String rankTier,  int rankPoints,  int division,  CompetitiveTitle? equippedTitle,  List<CompetitiveBadge> featuredBadges,  bool isSearchable,  CareerStatistics careerHighlights,  DateTime updatedAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _PublicCompetitiveProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarId,_that.photoUrl,_that.currentRank,_that.rankTier,_that.rankPoints,_that.division,_that.equippedTitle,_that.featuredBadges,_that.isSearchable,_that.careerHighlights,_that.updatedAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicCompetitiveProfile implements PublicCompetitiveProfile {
  const _PublicCompetitiveProfile({required this.userId, required this.displayName, this.username = '', required this.avatarId, this.photoUrl, required this.currentRank, required this.rankTier, required this.rankPoints, required this.division, this.equippedTitle, final  List<CompetitiveBadge> featuredBadges = const [], this.isSearchable = true, required this.careerHighlights, required this.updatedAt, this.schemaVersion = 1}): _featuredBadges = featuredBadges;
  factory _PublicCompetitiveProfile.fromJson(Map<String, dynamic> json) => _$PublicCompetitiveProfileFromJson(json);

@override final  String userId;
@override final  String displayName;
@override@JsonKey() final  String username;
@override final  String avatarId;
@override final  String? photoUrl;
// Identity
@override final  String currentRank;
@override final  String rankTier;
@override final  int rankPoints;
@override final  int division;
@override final  CompetitiveTitle? equippedTitle;
 final  List<CompetitiveBadge> _featuredBadges;
@override@JsonKey() List<CompetitiveBadge> get featuredBadges {
  if (_featuredBadges is EqualUnmodifiableListView) return _featuredBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredBadges);
}

@override@JsonKey() final  bool isSearchable;
// Career Highlights
@override final  CareerStatistics careerHighlights;
// Metadata
@override final  DateTime updatedAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicCompetitiveProfileCopyWith<_PublicCompetitiveProfile> get copyWith => __$PublicCompetitiveProfileCopyWithImpl<_PublicCompetitiveProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicCompetitiveProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicCompetitiveProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.rankTier, rankTier) || other.rankTier == rankTier)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.division, division) || other.division == division)&&(identical(other.equippedTitle, equippedTitle) || other.equippedTitle == equippedTitle)&&const DeepCollectionEquality().equals(other._featuredBadges, _featuredBadges)&&(identical(other.isSearchable, isSearchable) || other.isSearchable == isSearchable)&&(identical(other.careerHighlights, careerHighlights) || other.careerHighlights == careerHighlights)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,avatarId,photoUrl,currentRank,rankTier,rankPoints,division,equippedTitle,const DeepCollectionEquality().hash(_featuredBadges),isSearchable,careerHighlights,updatedAt,schemaVersion);

@override
String toString() {
  return 'PublicCompetitiveProfile(userId: $userId, displayName: $displayName, username: $username, avatarId: $avatarId, photoUrl: $photoUrl, currentRank: $currentRank, rankTier: $rankTier, rankPoints: $rankPoints, division: $division, equippedTitle: $equippedTitle, featuredBadges: $featuredBadges, isSearchable: $isSearchable, careerHighlights: $careerHighlights, updatedAt: $updatedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$PublicCompetitiveProfileCopyWith<$Res> implements $PublicCompetitiveProfileCopyWith<$Res> {
  factory _$PublicCompetitiveProfileCopyWith(_PublicCompetitiveProfile value, $Res Function(_PublicCompetitiveProfile) _then) = __$PublicCompetitiveProfileCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String username, String avatarId, String? photoUrl, String currentRank, String rankTier, int rankPoints, int division, CompetitiveTitle? equippedTitle, List<CompetitiveBadge> featuredBadges, bool isSearchable, CareerStatistics careerHighlights, DateTime updatedAt, int schemaVersion
});


@override $CompetitiveTitleCopyWith<$Res>? get equippedTitle;@override $CareerStatisticsCopyWith<$Res> get careerHighlights;

}
/// @nodoc
class __$PublicCompetitiveProfileCopyWithImpl<$Res>
    implements _$PublicCompetitiveProfileCopyWith<$Res> {
  __$PublicCompetitiveProfileCopyWithImpl(this._self, this._then);

  final _PublicCompetitiveProfile _self;
  final $Res Function(_PublicCompetitiveProfile) _then;

/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? username = null,Object? avatarId = null,Object? photoUrl = freezed,Object? currentRank = null,Object? rankTier = null,Object? rankPoints = null,Object? division = null,Object? equippedTitle = freezed,Object? featuredBadges = null,Object? isSearchable = null,Object? careerHighlights = null,Object? updatedAt = null,Object? schemaVersion = null,}) {
  return _then(_PublicCompetitiveProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,rankTier: null == rankTier ? _self.rankTier : rankTier // ignore: cast_nullable_to_non_nullable
as String,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as int,equippedTitle: freezed == equippedTitle ? _self.equippedTitle : equippedTitle // ignore: cast_nullable_to_non_nullable
as CompetitiveTitle?,featuredBadges: null == featuredBadges ? _self._featuredBadges : featuredBadges // ignore: cast_nullable_to_non_nullable
as List<CompetitiveBadge>,isSearchable: null == isSearchable ? _self.isSearchable : isSearchable // ignore: cast_nullable_to_non_nullable
as bool,careerHighlights: null == careerHighlights ? _self.careerHighlights : careerHighlights // ignore: cast_nullable_to_non_nullable
as CareerStatistics,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitiveTitleCopyWith<$Res>? get equippedTitle {
    if (_self.equippedTitle == null) {
    return null;
  }

  return $CompetitiveTitleCopyWith<$Res>(_self.equippedTitle!, (value) {
    return _then(_self.copyWith(equippedTitle: value));
  });
}/// Create a copy of PublicCompetitiveProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CareerStatisticsCopyWith<$Res> get careerHighlights {
  
  return $CareerStatisticsCopyWith<$Res>(_self.careerHighlights, (value) {
    return _then(_self.copyWith(careerHighlights: value));
  });
}
}

// dart format on
