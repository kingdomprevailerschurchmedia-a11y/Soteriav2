// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_mission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissionDefinition {

 String get id; MissionType get type; MissionPeriod get period; String get title; String get description; double get target; MissionDifficulty get difficulty; RewardType get rewardType; int get rewardAmount; String? get categoryId; String? get seasonId; String? get eventId; Map<String, dynamic> get metadata; String? get icon;
/// Create a copy of MissionDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionDefinitionCopyWith<MissionDefinition> get copyWith => _$MissionDefinitionCopyWithImpl<MissionDefinition>(this as MissionDefinition, _$identity);

  /// Serializes this MissionDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.target, target) || other.target == target)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,period,title,description,target,difficulty,rewardType,rewardAmount,categoryId,seasonId,eventId,const DeepCollectionEquality().hash(metadata),icon);

@override
String toString() {
  return 'MissionDefinition(id: $id, type: $type, period: $period, title: $title, description: $description, target: $target, difficulty: $difficulty, rewardType: $rewardType, rewardAmount: $rewardAmount, categoryId: $categoryId, seasonId: $seasonId, eventId: $eventId, metadata: $metadata, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $MissionDefinitionCopyWith<$Res>  {
  factory $MissionDefinitionCopyWith(MissionDefinition value, $Res Function(MissionDefinition) _then) = _$MissionDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, MissionType type, MissionPeriod period, String title, String description, double target, MissionDifficulty difficulty, RewardType rewardType, int rewardAmount, String? categoryId, String? seasonId, String? eventId, Map<String, dynamic> metadata, String? icon
});




}
/// @nodoc
class _$MissionDefinitionCopyWithImpl<$Res>
    implements $MissionDefinitionCopyWith<$Res> {
  _$MissionDefinitionCopyWithImpl(this._self, this._then);

  final MissionDefinition _self;
  final $Res Function(MissionDefinition) _then;

/// Create a copy of MissionDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? period = null,Object? title = null,Object? description = null,Object? target = null,Object? difficulty = null,Object? rewardType = null,Object? rewardAmount = null,Object? categoryId = freezed,Object? seasonId = freezed,Object? eventId = freezed,Object? metadata = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MissionType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as MissionPeriod,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as MissionDifficulty,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType,rewardAmount: null == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionDefinition].
extension MissionDefinitionPatterns on MissionDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionDefinition value)  $default,){
final _that = this;
switch (_that) {
case _MissionDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _MissionDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  MissionType type,  MissionPeriod period,  String title,  String description,  double target,  MissionDifficulty difficulty,  RewardType rewardType,  int rewardAmount,  String? categoryId,  String? seasonId,  String? eventId,  Map<String, dynamic> metadata,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionDefinition() when $default != null:
return $default(_that.id,_that.type,_that.period,_that.title,_that.description,_that.target,_that.difficulty,_that.rewardType,_that.rewardAmount,_that.categoryId,_that.seasonId,_that.eventId,_that.metadata,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  MissionType type,  MissionPeriod period,  String title,  String description,  double target,  MissionDifficulty difficulty,  RewardType rewardType,  int rewardAmount,  String? categoryId,  String? seasonId,  String? eventId,  Map<String, dynamic> metadata,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _MissionDefinition():
return $default(_that.id,_that.type,_that.period,_that.title,_that.description,_that.target,_that.difficulty,_that.rewardType,_that.rewardAmount,_that.categoryId,_that.seasonId,_that.eventId,_that.metadata,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  MissionType type,  MissionPeriod period,  String title,  String description,  double target,  MissionDifficulty difficulty,  RewardType rewardType,  int rewardAmount,  String? categoryId,  String? seasonId,  String? eventId,  Map<String, dynamic> metadata,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _MissionDefinition() when $default != null:
return $default(_that.id,_that.type,_that.period,_that.title,_that.description,_that.target,_that.difficulty,_that.rewardType,_that.rewardAmount,_that.categoryId,_that.seasonId,_that.eventId,_that.metadata,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissionDefinition implements MissionDefinition {
  const _MissionDefinition({required this.id, required this.type, required this.period, required this.title, required this.description, required this.target, required this.difficulty, required this.rewardType, required this.rewardAmount, this.categoryId, this.seasonId, this.eventId, final  Map<String, dynamic> metadata = const {}, this.icon}): _metadata = metadata;
  factory _MissionDefinition.fromJson(Map<String, dynamic> json) => _$MissionDefinitionFromJson(json);

@override final  String id;
@override final  MissionType type;
@override final  MissionPeriod period;
@override final  String title;
@override final  String description;
@override final  double target;
@override final  MissionDifficulty difficulty;
@override final  RewardType rewardType;
@override final  int rewardAmount;
@override final  String? categoryId;
@override final  String? seasonId;
@override final  String? eventId;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  String? icon;

/// Create a copy of MissionDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionDefinitionCopyWith<_MissionDefinition> get copyWith => __$MissionDefinitionCopyWithImpl<_MissionDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissionDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.target, target) || other.target == target)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,period,title,description,target,difficulty,rewardType,rewardAmount,categoryId,seasonId,eventId,const DeepCollectionEquality().hash(_metadata),icon);

@override
String toString() {
  return 'MissionDefinition(id: $id, type: $type, period: $period, title: $title, description: $description, target: $target, difficulty: $difficulty, rewardType: $rewardType, rewardAmount: $rewardAmount, categoryId: $categoryId, seasonId: $seasonId, eventId: $eventId, metadata: $metadata, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$MissionDefinitionCopyWith<$Res> implements $MissionDefinitionCopyWith<$Res> {
  factory _$MissionDefinitionCopyWith(_MissionDefinition value, $Res Function(_MissionDefinition) _then) = __$MissionDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, MissionType type, MissionPeriod period, String title, String description, double target, MissionDifficulty difficulty, RewardType rewardType, int rewardAmount, String? categoryId, String? seasonId, String? eventId, Map<String, dynamic> metadata, String? icon
});




}
/// @nodoc
class __$MissionDefinitionCopyWithImpl<$Res>
    implements _$MissionDefinitionCopyWith<$Res> {
  __$MissionDefinitionCopyWithImpl(this._self, this._then);

  final _MissionDefinition _self;
  final $Res Function(_MissionDefinition) _then;

/// Create a copy of MissionDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? period = null,Object? title = null,Object? description = null,Object? target = null,Object? difficulty = null,Object? rewardType = null,Object? rewardAmount = null,Object? categoryId = freezed,Object? seasonId = freezed,Object? eventId = freezed,Object? metadata = null,Object? icon = freezed,}) {
  return _then(_MissionDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MissionType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as MissionPeriod,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as MissionDifficulty,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType,rewardAmount: null == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserMissionState {

 String get userId; String get missionId; double get progress; MissionStatus get status; DateTime get startAt; DateTime get endAt; DateTime? get completedAt; DateTime? get claimedAt; int get schemaVersion;
/// Create a copy of UserMissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMissionStateCopyWith<UserMissionState> get copyWith => _$UserMissionStateCopyWithImpl<UserMissionState>(this as UserMissionState, _$identity);

  /// Serializes this UserMissionState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMissionState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,missionId,progress,status,startAt,endAt,completedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'UserMissionState(userId: $userId, missionId: $missionId, progress: $progress, status: $status, startAt: $startAt, endAt: $endAt, completedAt: $completedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $UserMissionStateCopyWith<$Res>  {
  factory $UserMissionStateCopyWith(UserMissionState value, $Res Function(UserMissionState) _then) = _$UserMissionStateCopyWithImpl;
@useResult
$Res call({
 String userId, String missionId, double progress, MissionStatus status, DateTime startAt, DateTime endAt, DateTime? completedAt, DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class _$UserMissionStateCopyWithImpl<$Res>
    implements $UserMissionStateCopyWith<$Res> {
  _$UserMissionStateCopyWithImpl(this._self, this._then);

  final UserMissionState _self;
  final $Res Function(UserMissionState) _then;

/// Create a copy of UserMissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? missionId = null,Object? progress = null,Object? status = null,Object? startAt = null,Object? endAt = null,Object? completedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MissionStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMissionState].
extension UserMissionStatePatterns on UserMissionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMissionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMissionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMissionState value)  $default,){
final _that = this;
switch (_that) {
case _UserMissionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMissionState value)?  $default,){
final _that = this;
switch (_that) {
case _UserMissionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String missionId,  double progress,  MissionStatus status,  DateTime startAt,  DateTime endAt,  DateTime? completedAt,  DateTime? claimedAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMissionState() when $default != null:
return $default(_that.userId,_that.missionId,_that.progress,_that.status,_that.startAt,_that.endAt,_that.completedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String missionId,  double progress,  MissionStatus status,  DateTime startAt,  DateTime endAt,  DateTime? completedAt,  DateTime? claimedAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _UserMissionState():
return $default(_that.userId,_that.missionId,_that.progress,_that.status,_that.startAt,_that.endAt,_that.completedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String missionId,  double progress,  MissionStatus status,  DateTime startAt,  DateTime endAt,  DateTime? completedAt,  DateTime? claimedAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _UserMissionState() when $default != null:
return $default(_that.userId,_that.missionId,_that.progress,_that.status,_that.startAt,_that.endAt,_that.completedAt,_that.claimedAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMissionState implements UserMissionState {
  const _UserMissionState({required this.userId, required this.missionId, required this.progress, required this.status, required this.startAt, required this.endAt, this.completedAt, this.claimedAt, this.schemaVersion = 1});
  factory _UserMissionState.fromJson(Map<String, dynamic> json) => _$UserMissionStateFromJson(json);

@override final  String userId;
@override final  String missionId;
@override final  double progress;
@override final  MissionStatus status;
@override final  DateTime startAt;
@override final  DateTime endAt;
@override final  DateTime? completedAt;
@override final  DateTime? claimedAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of UserMissionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMissionStateCopyWith<_UserMissionState> get copyWith => __$UserMissionStateCopyWithImpl<_UserMissionState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMissionStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMissionState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,missionId,progress,status,startAt,endAt,completedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'UserMissionState(userId: $userId, missionId: $missionId, progress: $progress, status: $status, startAt: $startAt, endAt: $endAt, completedAt: $completedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$UserMissionStateCopyWith<$Res> implements $UserMissionStateCopyWith<$Res> {
  factory _$UserMissionStateCopyWith(_UserMissionState value, $Res Function(_UserMissionState) _then) = __$UserMissionStateCopyWithImpl;
@override @useResult
$Res call({
 String userId, String missionId, double progress, MissionStatus status, DateTime startAt, DateTime endAt, DateTime? completedAt, DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class __$UserMissionStateCopyWithImpl<$Res>
    implements _$UserMissionStateCopyWith<$Res> {
  __$UserMissionStateCopyWithImpl(this._self, this._then);

  final _UserMissionState _self;
  final $Res Function(_UserMissionState) _then;

/// Create a copy of UserMissionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? missionId = null,Object? progress = null,Object? status = null,Object? startAt = null,Object? endAt = null,Object? completedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_UserMissionState(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MissionStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CompetitiveMission {

 MissionDefinition get definition; UserMissionState get state;
/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveMissionCopyWith<CompetitiveMission> get copyWith => _$CompetitiveMissionCopyWithImpl<CompetitiveMission>(this as CompetitiveMission, _$identity);

  /// Serializes this CompetitiveMission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveMission&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,definition,state);

@override
String toString() {
  return 'CompetitiveMission(definition: $definition, state: $state)';
}


}

/// @nodoc
abstract mixin class $CompetitiveMissionCopyWith<$Res>  {
  factory $CompetitiveMissionCopyWith(CompetitiveMission value, $Res Function(CompetitiveMission) _then) = _$CompetitiveMissionCopyWithImpl;
@useResult
$Res call({
 MissionDefinition definition, UserMissionState state
});


$MissionDefinitionCopyWith<$Res> get definition;$UserMissionStateCopyWith<$Res> get state;

}
/// @nodoc
class _$CompetitiveMissionCopyWithImpl<$Res>
    implements $CompetitiveMissionCopyWith<$Res> {
  _$CompetitiveMissionCopyWithImpl(this._self, this._then);

  final CompetitiveMission _self;
  final $Res Function(CompetitiveMission) _then;

/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? definition = null,Object? state = null,}) {
  return _then(_self.copyWith(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as MissionDefinition,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as UserMissionState,
  ));
}
/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MissionDefinitionCopyWith<$Res> get definition {
  
  return $MissionDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMissionStateCopyWith<$Res> get state {
  
  return $UserMissionStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetitiveMission].
extension CompetitiveMissionPatterns on CompetitiveMission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveMission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveMission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveMission value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveMission value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MissionDefinition definition,  UserMissionState state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveMission() when $default != null:
return $default(_that.definition,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MissionDefinition definition,  UserMissionState state)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMission():
return $default(_that.definition,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MissionDefinition definition,  UserMissionState state)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMission() when $default != null:
return $default(_that.definition,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveMission extends CompetitiveMission {
  const _CompetitiveMission({required this.definition, required this.state}): super._();
  factory _CompetitiveMission.fromJson(Map<String, dynamic> json) => _$CompetitiveMissionFromJson(json);

@override final  MissionDefinition definition;
@override final  UserMissionState state;

/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveMissionCopyWith<_CompetitiveMission> get copyWith => __$CompetitiveMissionCopyWithImpl<_CompetitiveMission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveMissionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveMission&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,definition,state);

@override
String toString() {
  return 'CompetitiveMission(definition: $definition, state: $state)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveMissionCopyWith<$Res> implements $CompetitiveMissionCopyWith<$Res> {
  factory _$CompetitiveMissionCopyWith(_CompetitiveMission value, $Res Function(_CompetitiveMission) _then) = __$CompetitiveMissionCopyWithImpl;
@override @useResult
$Res call({
 MissionDefinition definition, UserMissionState state
});


@override $MissionDefinitionCopyWith<$Res> get definition;@override $UserMissionStateCopyWith<$Res> get state;

}
/// @nodoc
class __$CompetitiveMissionCopyWithImpl<$Res>
    implements _$CompetitiveMissionCopyWith<$Res> {
  __$CompetitiveMissionCopyWithImpl(this._self, this._then);

  final _CompetitiveMission _self;
  final $Res Function(_CompetitiveMission) _then;

/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? definition = null,Object? state = null,}) {
  return _then(_CompetitiveMission(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as MissionDefinition,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as UserMissionState,
  ));
}

/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MissionDefinitionCopyWith<$Res> get definition {
  
  return $MissionDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of CompetitiveMission
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMissionStateCopyWith<$Res> get state {
  
  return $UserMissionStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

// dart format on
