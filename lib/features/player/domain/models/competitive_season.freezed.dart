// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_season.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveSeason {

 String get seasonId; String get name; String? get displayName; SeasonStatus get status; DateTime get startAt; DateTime get endAt; DateTime get createdAt; DateTime get updatedAt; String? get rankConfigId; String? get leaderboardId; String? get description; int? get seasonNumber; bool get isCurrent; bool get isVisible; DateTime? get archiveAt; int get version;
/// Create a copy of CompetitiveSeason
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveSeasonCopyWith<CompetitiveSeason> get copyWith => _$CompetitiveSeasonCopyWithImpl<CompetitiveSeason>(this as CompetitiveSeason, _$identity);

  /// Serializes this CompetitiveSeason to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveSeason&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.name, name) || other.name == name)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.rankConfigId, rankConfigId) || other.rankConfigId == rankConfigId)&&(identical(other.leaderboardId, leaderboardId) || other.leaderboardId == leaderboardId)&&(identical(other.description, description) || other.description == description)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.archiveAt, archiveAt) || other.archiveAt == archiveAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,name,displayName,status,startAt,endAt,createdAt,updatedAt,rankConfigId,leaderboardId,description,seasonNumber,isCurrent,isVisible,archiveAt,version);

@override
String toString() {
  return 'CompetitiveSeason(seasonId: $seasonId, name: $name, displayName: $displayName, status: $status, startAt: $startAt, endAt: $endAt, createdAt: $createdAt, updatedAt: $updatedAt, rankConfigId: $rankConfigId, leaderboardId: $leaderboardId, description: $description, seasonNumber: $seasonNumber, isCurrent: $isCurrent, isVisible: $isVisible, archiveAt: $archiveAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $CompetitiveSeasonCopyWith<$Res>  {
  factory $CompetitiveSeasonCopyWith(CompetitiveSeason value, $Res Function(CompetitiveSeason) _then) = _$CompetitiveSeasonCopyWithImpl;
@useResult
$Res call({
 String seasonId, String name, String? displayName, SeasonStatus status, DateTime startAt, DateTime endAt, DateTime createdAt, DateTime updatedAt, String? rankConfigId, String? leaderboardId, String? description, int? seasonNumber, bool isCurrent, bool isVisible, DateTime? archiveAt, int version
});




}
/// @nodoc
class _$CompetitiveSeasonCopyWithImpl<$Res>
    implements $CompetitiveSeasonCopyWith<$Res> {
  _$CompetitiveSeasonCopyWithImpl(this._self, this._then);

  final CompetitiveSeason _self;
  final $Res Function(CompetitiveSeason) _then;

/// Create a copy of CompetitiveSeason
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seasonId = null,Object? name = null,Object? displayName = freezed,Object? status = null,Object? startAt = null,Object? endAt = null,Object? createdAt = null,Object? updatedAt = null,Object? rankConfigId = freezed,Object? leaderboardId = freezed,Object? description = freezed,Object? seasonNumber = freezed,Object? isCurrent = null,Object? isVisible = null,Object? archiveAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SeasonStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,rankConfigId: freezed == rankConfigId ? _self.rankConfigId : rankConfigId // ignore: cast_nullable_to_non_nullable
as String?,leaderboardId: freezed == leaderboardId ? _self.leaderboardId : leaderboardId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,archiveAt: freezed == archiveAt ? _self.archiveAt : archiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveSeason].
extension CompetitiveSeasonPatterns on CompetitiveSeason {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveSeason value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveSeason() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveSeason value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveSeason():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveSeason value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveSeason() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String seasonId,  String name,  String? displayName,  SeasonStatus status,  DateTime startAt,  DateTime endAt,  DateTime createdAt,  DateTime updatedAt,  String? rankConfigId,  String? leaderboardId,  String? description,  int? seasonNumber,  bool isCurrent,  bool isVisible,  DateTime? archiveAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveSeason() when $default != null:
return $default(_that.seasonId,_that.name,_that.displayName,_that.status,_that.startAt,_that.endAt,_that.createdAt,_that.updatedAt,_that.rankConfigId,_that.leaderboardId,_that.description,_that.seasonNumber,_that.isCurrent,_that.isVisible,_that.archiveAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String seasonId,  String name,  String? displayName,  SeasonStatus status,  DateTime startAt,  DateTime endAt,  DateTime createdAt,  DateTime updatedAt,  String? rankConfigId,  String? leaderboardId,  String? description,  int? seasonNumber,  bool isCurrent,  bool isVisible,  DateTime? archiveAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveSeason():
return $default(_that.seasonId,_that.name,_that.displayName,_that.status,_that.startAt,_that.endAt,_that.createdAt,_that.updatedAt,_that.rankConfigId,_that.leaderboardId,_that.description,_that.seasonNumber,_that.isCurrent,_that.isVisible,_that.archiveAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String seasonId,  String name,  String? displayName,  SeasonStatus status,  DateTime startAt,  DateTime endAt,  DateTime createdAt,  DateTime updatedAt,  String? rankConfigId,  String? leaderboardId,  String? description,  int? seasonNumber,  bool isCurrent,  bool isVisible,  DateTime? archiveAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveSeason() when $default != null:
return $default(_that.seasonId,_that.name,_that.displayName,_that.status,_that.startAt,_that.endAt,_that.createdAt,_that.updatedAt,_that.rankConfigId,_that.leaderboardId,_that.description,_that.seasonNumber,_that.isCurrent,_that.isVisible,_that.archiveAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveSeason implements CompetitiveSeason {
  const _CompetitiveSeason({required this.seasonId, required this.name, this.displayName, required this.status, required this.startAt, required this.endAt, required this.createdAt, required this.updatedAt, this.rankConfigId, this.leaderboardId, this.description, this.seasonNumber, this.isCurrent = false, this.isVisible = true, this.archiveAt, this.version = 1});
  factory _CompetitiveSeason.fromJson(Map<String, dynamic> json) => _$CompetitiveSeasonFromJson(json);

@override final  String seasonId;
@override final  String name;
@override final  String? displayName;
@override final  SeasonStatus status;
@override final  DateTime startAt;
@override final  DateTime endAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? rankConfigId;
@override final  String? leaderboardId;
@override final  String? description;
@override final  int? seasonNumber;
@override@JsonKey() final  bool isCurrent;
@override@JsonKey() final  bool isVisible;
@override final  DateTime? archiveAt;
@override@JsonKey() final  int version;

/// Create a copy of CompetitiveSeason
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveSeasonCopyWith<_CompetitiveSeason> get copyWith => __$CompetitiveSeasonCopyWithImpl<_CompetitiveSeason>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveSeasonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveSeason&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.name, name) || other.name == name)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.rankConfigId, rankConfigId) || other.rankConfigId == rankConfigId)&&(identical(other.leaderboardId, leaderboardId) || other.leaderboardId == leaderboardId)&&(identical(other.description, description) || other.description == description)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.archiveAt, archiveAt) || other.archiveAt == archiveAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,name,displayName,status,startAt,endAt,createdAt,updatedAt,rankConfigId,leaderboardId,description,seasonNumber,isCurrent,isVisible,archiveAt,version);

@override
String toString() {
  return 'CompetitiveSeason(seasonId: $seasonId, name: $name, displayName: $displayName, status: $status, startAt: $startAt, endAt: $endAt, createdAt: $createdAt, updatedAt: $updatedAt, rankConfigId: $rankConfigId, leaderboardId: $leaderboardId, description: $description, seasonNumber: $seasonNumber, isCurrent: $isCurrent, isVisible: $isVisible, archiveAt: $archiveAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveSeasonCopyWith<$Res> implements $CompetitiveSeasonCopyWith<$Res> {
  factory _$CompetitiveSeasonCopyWith(_CompetitiveSeason value, $Res Function(_CompetitiveSeason) _then) = __$CompetitiveSeasonCopyWithImpl;
@override @useResult
$Res call({
 String seasonId, String name, String? displayName, SeasonStatus status, DateTime startAt, DateTime endAt, DateTime createdAt, DateTime updatedAt, String? rankConfigId, String? leaderboardId, String? description, int? seasonNumber, bool isCurrent, bool isVisible, DateTime? archiveAt, int version
});




}
/// @nodoc
class __$CompetitiveSeasonCopyWithImpl<$Res>
    implements _$CompetitiveSeasonCopyWith<$Res> {
  __$CompetitiveSeasonCopyWithImpl(this._self, this._then);

  final _CompetitiveSeason _self;
  final $Res Function(_CompetitiveSeason) _then;

/// Create a copy of CompetitiveSeason
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seasonId = null,Object? name = null,Object? displayName = freezed,Object? status = null,Object? startAt = null,Object? endAt = null,Object? createdAt = null,Object? updatedAt = null,Object? rankConfigId = freezed,Object? leaderboardId = freezed,Object? description = freezed,Object? seasonNumber = freezed,Object? isCurrent = null,Object? isVisible = null,Object? archiveAt = freezed,Object? version = null,}) {
  return _then(_CompetitiveSeason(
seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SeasonStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,rankConfigId: freezed == rankConfigId ? _self.rankConfigId : rankConfigId // ignore: cast_nullable_to_non_nullable
as String?,leaderboardId: freezed == leaderboardId ? _self.leaderboardId : leaderboardId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,archiveAt: freezed == archiveAt ? _self.archiveAt : archiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
