// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveIdentity {

 String get userId; PlayerProfile get profile; PlayerProgression get progression; RankProgress get rankProgress; CompetitiveTitle? get equippedTitle; List<CompetitiveBadge> get featuredBadges; List<CompetitiveBadge> get allOwnedBadges; List<CompetitiveTitle> get allOwnedTitles; int get schemaVersion;
/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveIdentityCopyWith<CompetitiveIdentity> get copyWith => _$CompetitiveIdentityCopyWithImpl<CompetitiveIdentity>(this as CompetitiveIdentity, _$identity);

  /// Serializes this CompetitiveIdentity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveIdentity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.progression, progression) || other.progression == progression)&&(identical(other.rankProgress, rankProgress) || other.rankProgress == rankProgress)&&(identical(other.equippedTitle, equippedTitle) || other.equippedTitle == equippedTitle)&&const DeepCollectionEquality().equals(other.featuredBadges, featuredBadges)&&const DeepCollectionEquality().equals(other.allOwnedBadges, allOwnedBadges)&&const DeepCollectionEquality().equals(other.allOwnedTitles, allOwnedTitles)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,profile,progression,rankProgress,equippedTitle,const DeepCollectionEquality().hash(featuredBadges),const DeepCollectionEquality().hash(allOwnedBadges),const DeepCollectionEquality().hash(allOwnedTitles),schemaVersion);

@override
String toString() {
  return 'CompetitiveIdentity(userId: $userId, profile: $profile, progression: $progression, rankProgress: $rankProgress, equippedTitle: $equippedTitle, featuredBadges: $featuredBadges, allOwnedBadges: $allOwnedBadges, allOwnedTitles: $allOwnedTitles, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $CompetitiveIdentityCopyWith<$Res>  {
  factory $CompetitiveIdentityCopyWith(CompetitiveIdentity value, $Res Function(CompetitiveIdentity) _then) = _$CompetitiveIdentityCopyWithImpl;
@useResult
$Res call({
 String userId, PlayerProfile profile, PlayerProgression progression, RankProgress rankProgress, CompetitiveTitle? equippedTitle, List<CompetitiveBadge> featuredBadges, List<CompetitiveBadge> allOwnedBadges, List<CompetitiveTitle> allOwnedTitles, int schemaVersion
});


$PlayerProfileCopyWith<$Res> get profile;$PlayerProgressionCopyWith<$Res> get progression;$RankProgressCopyWith<$Res> get rankProgress;$CompetitiveTitleCopyWith<$Res>? get equippedTitle;

}
/// @nodoc
class _$CompetitiveIdentityCopyWithImpl<$Res>
    implements $CompetitiveIdentityCopyWith<$Res> {
  _$CompetitiveIdentityCopyWithImpl(this._self, this._then);

  final CompetitiveIdentity _self;
  final $Res Function(CompetitiveIdentity) _then;

/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? profile = null,Object? progression = null,Object? rankProgress = null,Object? equippedTitle = freezed,Object? featuredBadges = null,Object? allOwnedBadges = null,Object? allOwnedTitles = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as PlayerProfile,progression: null == progression ? _self.progression : progression // ignore: cast_nullable_to_non_nullable
as PlayerProgression,rankProgress: null == rankProgress ? _self.rankProgress : rankProgress // ignore: cast_nullable_to_non_nullable
as RankProgress,equippedTitle: freezed == equippedTitle ? _self.equippedTitle : equippedTitle // ignore: cast_nullable_to_non_nullable
as CompetitiveTitle?,featuredBadges: null == featuredBadges ? _self.featuredBadges : featuredBadges // ignore: cast_nullable_to_non_nullable
as List<CompetitiveBadge>,allOwnedBadges: null == allOwnedBadges ? _self.allOwnedBadges : allOwnedBadges // ignore: cast_nullable_to_non_nullable
as List<CompetitiveBadge>,allOwnedTitles: null == allOwnedTitles ? _self.allOwnedTitles : allOwnedTitles // ignore: cast_nullable_to_non_nullable
as List<CompetitiveTitle>,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<$Res> get profile {
  
  return $PlayerProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProgressionCopyWith<$Res> get progression {
  
  return $PlayerProgressionCopyWith<$Res>(_self.progression, (value) {
    return _then(_self.copyWith(progression: value));
  });
}/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankProgressCopyWith<$Res> get rankProgress {
  
  return $RankProgressCopyWith<$Res>(_self.rankProgress, (value) {
    return _then(_self.copyWith(rankProgress: value));
  });
}/// Create a copy of CompetitiveIdentity
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
}
}


/// Adds pattern-matching-related methods to [CompetitiveIdentity].
extension CompetitiveIdentityPatterns on CompetitiveIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveIdentity value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  PlayerProfile profile,  PlayerProgression progression,  RankProgress rankProgress,  CompetitiveTitle? equippedTitle,  List<CompetitiveBadge> featuredBadges,  List<CompetitiveBadge> allOwnedBadges,  List<CompetitiveTitle> allOwnedTitles,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveIdentity() when $default != null:
return $default(_that.userId,_that.profile,_that.progression,_that.rankProgress,_that.equippedTitle,_that.featuredBadges,_that.allOwnedBadges,_that.allOwnedTitles,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  PlayerProfile profile,  PlayerProgression progression,  RankProgress rankProgress,  CompetitiveTitle? equippedTitle,  List<CompetitiveBadge> featuredBadges,  List<CompetitiveBadge> allOwnedBadges,  List<CompetitiveTitle> allOwnedTitles,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveIdentity():
return $default(_that.userId,_that.profile,_that.progression,_that.rankProgress,_that.equippedTitle,_that.featuredBadges,_that.allOwnedBadges,_that.allOwnedTitles,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  PlayerProfile profile,  PlayerProgression progression,  RankProgress rankProgress,  CompetitiveTitle? equippedTitle,  List<CompetitiveBadge> featuredBadges,  List<CompetitiveBadge> allOwnedBadges,  List<CompetitiveTitle> allOwnedTitles,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveIdentity() when $default != null:
return $default(_that.userId,_that.profile,_that.progression,_that.rankProgress,_that.equippedTitle,_that.featuredBadges,_that.allOwnedBadges,_that.allOwnedTitles,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveIdentity implements CompetitiveIdentity {
  const _CompetitiveIdentity({required this.userId, required this.profile, required this.progression, required this.rankProgress, this.equippedTitle, final  List<CompetitiveBadge> featuredBadges = const [], final  List<CompetitiveBadge> allOwnedBadges = const [], final  List<CompetitiveTitle> allOwnedTitles = const [], this.schemaVersion = 1}): _featuredBadges = featuredBadges,_allOwnedBadges = allOwnedBadges,_allOwnedTitles = allOwnedTitles;
  factory _CompetitiveIdentity.fromJson(Map<String, dynamic> json) => _$CompetitiveIdentityFromJson(json);

@override final  String userId;
@override final  PlayerProfile profile;
@override final  PlayerProgression progression;
@override final  RankProgress rankProgress;
@override final  CompetitiveTitle? equippedTitle;
 final  List<CompetitiveBadge> _featuredBadges;
@override@JsonKey() List<CompetitiveBadge> get featuredBadges {
  if (_featuredBadges is EqualUnmodifiableListView) return _featuredBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredBadges);
}

 final  List<CompetitiveBadge> _allOwnedBadges;
@override@JsonKey() List<CompetitiveBadge> get allOwnedBadges {
  if (_allOwnedBadges is EqualUnmodifiableListView) return _allOwnedBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allOwnedBadges);
}

 final  List<CompetitiveTitle> _allOwnedTitles;
@override@JsonKey() List<CompetitiveTitle> get allOwnedTitles {
  if (_allOwnedTitles is EqualUnmodifiableListView) return _allOwnedTitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allOwnedTitles);
}

@override@JsonKey() final  int schemaVersion;

/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveIdentityCopyWith<_CompetitiveIdentity> get copyWith => __$CompetitiveIdentityCopyWithImpl<_CompetitiveIdentity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveIdentityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveIdentity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.progression, progression) || other.progression == progression)&&(identical(other.rankProgress, rankProgress) || other.rankProgress == rankProgress)&&(identical(other.equippedTitle, equippedTitle) || other.equippedTitle == equippedTitle)&&const DeepCollectionEquality().equals(other._featuredBadges, _featuredBadges)&&const DeepCollectionEquality().equals(other._allOwnedBadges, _allOwnedBadges)&&const DeepCollectionEquality().equals(other._allOwnedTitles, _allOwnedTitles)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,profile,progression,rankProgress,equippedTitle,const DeepCollectionEquality().hash(_featuredBadges),const DeepCollectionEquality().hash(_allOwnedBadges),const DeepCollectionEquality().hash(_allOwnedTitles),schemaVersion);

@override
String toString() {
  return 'CompetitiveIdentity(userId: $userId, profile: $profile, progression: $progression, rankProgress: $rankProgress, equippedTitle: $equippedTitle, featuredBadges: $featuredBadges, allOwnedBadges: $allOwnedBadges, allOwnedTitles: $allOwnedTitles, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveIdentityCopyWith<$Res> implements $CompetitiveIdentityCopyWith<$Res> {
  factory _$CompetitiveIdentityCopyWith(_CompetitiveIdentity value, $Res Function(_CompetitiveIdentity) _then) = __$CompetitiveIdentityCopyWithImpl;
@override @useResult
$Res call({
 String userId, PlayerProfile profile, PlayerProgression progression, RankProgress rankProgress, CompetitiveTitle? equippedTitle, List<CompetitiveBadge> featuredBadges, List<CompetitiveBadge> allOwnedBadges, List<CompetitiveTitle> allOwnedTitles, int schemaVersion
});


@override $PlayerProfileCopyWith<$Res> get profile;@override $PlayerProgressionCopyWith<$Res> get progression;@override $RankProgressCopyWith<$Res> get rankProgress;@override $CompetitiveTitleCopyWith<$Res>? get equippedTitle;

}
/// @nodoc
class __$CompetitiveIdentityCopyWithImpl<$Res>
    implements _$CompetitiveIdentityCopyWith<$Res> {
  __$CompetitiveIdentityCopyWithImpl(this._self, this._then);

  final _CompetitiveIdentity _self;
  final $Res Function(_CompetitiveIdentity) _then;

/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? profile = null,Object? progression = null,Object? rankProgress = null,Object? equippedTitle = freezed,Object? featuredBadges = null,Object? allOwnedBadges = null,Object? allOwnedTitles = null,Object? schemaVersion = null,}) {
  return _then(_CompetitiveIdentity(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as PlayerProfile,progression: null == progression ? _self.progression : progression // ignore: cast_nullable_to_non_nullable
as PlayerProgression,rankProgress: null == rankProgress ? _self.rankProgress : rankProgress // ignore: cast_nullable_to_non_nullable
as RankProgress,equippedTitle: freezed == equippedTitle ? _self.equippedTitle : equippedTitle // ignore: cast_nullable_to_non_nullable
as CompetitiveTitle?,featuredBadges: null == featuredBadges ? _self._featuredBadges : featuredBadges // ignore: cast_nullable_to_non_nullable
as List<CompetitiveBadge>,allOwnedBadges: null == allOwnedBadges ? _self._allOwnedBadges : allOwnedBadges // ignore: cast_nullable_to_non_nullable
as List<CompetitiveBadge>,allOwnedTitles: null == allOwnedTitles ? _self._allOwnedTitles : allOwnedTitles // ignore: cast_nullable_to_non_nullable
as List<CompetitiveTitle>,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<$Res> get profile {
  
  return $PlayerProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProgressionCopyWith<$Res> get progression {
  
  return $PlayerProgressionCopyWith<$Res>(_self.progression, (value) {
    return _then(_self.copyWith(progression: value));
  });
}/// Create a copy of CompetitiveIdentity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankProgressCopyWith<$Res> get rankProgress {
  
  return $RankProgressCopyWith<$Res>(_self.rankProgress, (value) {
    return _then(_self.copyWith(rankProgress: value));
  });
}/// Create a copy of CompetitiveIdentity
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
}
}

// dart format on
