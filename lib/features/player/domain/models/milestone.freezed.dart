// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milestone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MilestoneDefinition {

 String get id; String get name; String get description; MilestoneType get type; MilestoneCategory get category; double get threshold; String? get icon; bool get isActive; Map<String, dynamic> get metadata; RewardType? get rewardType; int? get rewardAmount; String? get achievementId; int get displayOrder;
/// Create a copy of MilestoneDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilestoneDefinitionCopyWith<MilestoneDefinition> get copyWith => _$MilestoneDefinitionCopyWithImpl<MilestoneDefinition>(this as MilestoneDefinition, _$identity);

  /// Serializes this MilestoneDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilestoneDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,category,threshold,icon,isActive,const DeepCollectionEquality().hash(metadata),rewardType,rewardAmount,achievementId,displayOrder);

@override
String toString() {
  return 'MilestoneDefinition(id: $id, name: $name, description: $description, type: $type, category: $category, threshold: $threshold, icon: $icon, isActive: $isActive, metadata: $metadata, rewardType: $rewardType, rewardAmount: $rewardAmount, achievementId: $achievementId, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $MilestoneDefinitionCopyWith<$Res>  {
  factory $MilestoneDefinitionCopyWith(MilestoneDefinition value, $Res Function(MilestoneDefinition) _then) = _$MilestoneDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, MilestoneType type, MilestoneCategory category, double threshold, String? icon, bool isActive, Map<String, dynamic> metadata, RewardType? rewardType, int? rewardAmount, String? achievementId, int displayOrder
});




}
/// @nodoc
class _$MilestoneDefinitionCopyWithImpl<$Res>
    implements $MilestoneDefinitionCopyWith<$Res> {
  _$MilestoneDefinitionCopyWithImpl(this._self, this._then);

  final MilestoneDefinition _self;
  final $Res Function(MilestoneDefinition) _then;

/// Create a copy of MilestoneDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? category = null,Object? threshold = null,Object? icon = freezed,Object? isActive = null,Object? metadata = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? achievementId = freezed,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MilestoneType,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MilestoneCategory,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,achievementId: freezed == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MilestoneDefinition].
extension MilestoneDefinitionPatterns on MilestoneDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MilestoneDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MilestoneDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MilestoneDefinition value)  $default,){
final _that = this;
switch (_that) {
case _MilestoneDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MilestoneDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _MilestoneDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  MilestoneType type,  MilestoneCategory category,  double threshold,  String? icon,  bool isActive,  Map<String, dynamic> metadata,  RewardType? rewardType,  int? rewardAmount,  String? achievementId,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MilestoneDefinition() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.category,_that.threshold,_that.icon,_that.isActive,_that.metadata,_that.rewardType,_that.rewardAmount,_that.achievementId,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  MilestoneType type,  MilestoneCategory category,  double threshold,  String? icon,  bool isActive,  Map<String, dynamic> metadata,  RewardType? rewardType,  int? rewardAmount,  String? achievementId,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _MilestoneDefinition():
return $default(_that.id,_that.name,_that.description,_that.type,_that.category,_that.threshold,_that.icon,_that.isActive,_that.metadata,_that.rewardType,_that.rewardAmount,_that.achievementId,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  MilestoneType type,  MilestoneCategory category,  double threshold,  String? icon,  bool isActive,  Map<String, dynamic> metadata,  RewardType? rewardType,  int? rewardAmount,  String? achievementId,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _MilestoneDefinition() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.category,_that.threshold,_that.icon,_that.isActive,_that.metadata,_that.rewardType,_that.rewardAmount,_that.achievementId,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MilestoneDefinition implements MilestoneDefinition {
  const _MilestoneDefinition({required this.id, required this.name, required this.description, required this.type, required this.category, required this.threshold, this.icon, this.isActive = true, final  Map<String, dynamic> metadata = const {}, this.rewardType, this.rewardAmount, this.achievementId, this.displayOrder = 0}): _metadata = metadata;
  factory _MilestoneDefinition.fromJson(Map<String, dynamic> json) => _$MilestoneDefinitionFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  MilestoneType type;
@override final  MilestoneCategory category;
@override final  double threshold;
@override final  String? icon;
@override@JsonKey() final  bool isActive;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  RewardType? rewardType;
@override final  int? rewardAmount;
@override final  String? achievementId;
@override@JsonKey() final  int displayOrder;

/// Create a copy of MilestoneDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilestoneDefinitionCopyWith<_MilestoneDefinition> get copyWith => __$MilestoneDefinitionCopyWithImpl<_MilestoneDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MilestoneDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilestoneDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,category,threshold,icon,isActive,const DeepCollectionEquality().hash(_metadata),rewardType,rewardAmount,achievementId,displayOrder);

@override
String toString() {
  return 'MilestoneDefinition(id: $id, name: $name, description: $description, type: $type, category: $category, threshold: $threshold, icon: $icon, isActive: $isActive, metadata: $metadata, rewardType: $rewardType, rewardAmount: $rewardAmount, achievementId: $achievementId, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$MilestoneDefinitionCopyWith<$Res> implements $MilestoneDefinitionCopyWith<$Res> {
  factory _$MilestoneDefinitionCopyWith(_MilestoneDefinition value, $Res Function(_MilestoneDefinition) _then) = __$MilestoneDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, MilestoneType type, MilestoneCategory category, double threshold, String? icon, bool isActive, Map<String, dynamic> metadata, RewardType? rewardType, int? rewardAmount, String? achievementId, int displayOrder
});




}
/// @nodoc
class __$MilestoneDefinitionCopyWithImpl<$Res>
    implements _$MilestoneDefinitionCopyWith<$Res> {
  __$MilestoneDefinitionCopyWithImpl(this._self, this._then);

  final _MilestoneDefinition _self;
  final $Res Function(_MilestoneDefinition) _then;

/// Create a copy of MilestoneDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? category = null,Object? threshold = null,Object? icon = freezed,Object? isActive = null,Object? metadata = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? achievementId = freezed,Object? displayOrder = null,}) {
  return _then(_MilestoneDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MilestoneType,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MilestoneCategory,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,achievementId: freezed == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlayerMilestone {

 String get userId; String get milestoneId; MilestoneStatus get status; double get currentProgress;@TimestampConverter() DateTime? get unlockedAt;@TimestampConverter() DateTime? get claimedAt; int get schemaVersion;
/// Create a copy of PlayerMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerMilestoneCopyWith<PlayerMilestone> get copyWith => _$PlayerMilestoneCopyWithImpl<PlayerMilestone>(this as PlayerMilestone, _$identity);

  /// Serializes this PlayerMilestone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerMilestone&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.milestoneId, milestoneId) || other.milestoneId == milestoneId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentProgress, currentProgress) || other.currentProgress == currentProgress)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,milestoneId,status,currentProgress,unlockedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'PlayerMilestone(userId: $userId, milestoneId: $milestoneId, status: $status, currentProgress: $currentProgress, unlockedAt: $unlockedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $PlayerMilestoneCopyWith<$Res>  {
  factory $PlayerMilestoneCopyWith(PlayerMilestone value, $Res Function(PlayerMilestone) _then) = _$PlayerMilestoneCopyWithImpl;
@useResult
$Res call({
 String userId, String milestoneId, MilestoneStatus status, double currentProgress,@TimestampConverter() DateTime? unlockedAt,@TimestampConverter() DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class _$PlayerMilestoneCopyWithImpl<$Res>
    implements $PlayerMilestoneCopyWith<$Res> {
  _$PlayerMilestoneCopyWithImpl(this._self, this._then);

  final PlayerMilestone _self;
  final $Res Function(PlayerMilestone) _then;

/// Create a copy of PlayerMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? milestoneId = null,Object? status = null,Object? currentProgress = null,Object? unlockedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,milestoneId: null == milestoneId ? _self.milestoneId : milestoneId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus,currentProgress: null == currentProgress ? _self.currentProgress : currentProgress // ignore: cast_nullable_to_non_nullable
as double,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerMilestone].
extension PlayerMilestonePatterns on PlayerMilestone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerMilestone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerMilestone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerMilestone value)  $default,){
final _that = this;
switch (_that) {
case _PlayerMilestone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerMilestone value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerMilestone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String milestoneId,  MilestoneStatus status,  double currentProgress, @TimestampConverter()  DateTime? unlockedAt, @TimestampConverter()  DateTime? claimedAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerMilestone() when $default != null:
return $default(_that.userId,_that.milestoneId,_that.status,_that.currentProgress,_that.unlockedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String milestoneId,  MilestoneStatus status,  double currentProgress, @TimestampConverter()  DateTime? unlockedAt, @TimestampConverter()  DateTime? claimedAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _PlayerMilestone():
return $default(_that.userId,_that.milestoneId,_that.status,_that.currentProgress,_that.unlockedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String milestoneId,  MilestoneStatus status,  double currentProgress, @TimestampConverter()  DateTime? unlockedAt, @TimestampConverter()  DateTime? claimedAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _PlayerMilestone() when $default != null:
return $default(_that.userId,_that.milestoneId,_that.status,_that.currentProgress,_that.unlockedAt,_that.claimedAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerMilestone implements PlayerMilestone {
  const _PlayerMilestone({required this.userId, required this.milestoneId, required this.status, required this.currentProgress, @TimestampConverter() this.unlockedAt, @TimestampConverter() this.claimedAt, this.schemaVersion = 1});
  factory _PlayerMilestone.fromJson(Map<String, dynamic> json) => _$PlayerMilestoneFromJson(json);

@override final  String userId;
@override final  String milestoneId;
@override final  MilestoneStatus status;
@override final  double currentProgress;
@override@TimestampConverter() final  DateTime? unlockedAt;
@override@TimestampConverter() final  DateTime? claimedAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of PlayerMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerMilestoneCopyWith<_PlayerMilestone> get copyWith => __$PlayerMilestoneCopyWithImpl<_PlayerMilestone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerMilestoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerMilestone&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.milestoneId, milestoneId) || other.milestoneId == milestoneId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentProgress, currentProgress) || other.currentProgress == currentProgress)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,milestoneId,status,currentProgress,unlockedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'PlayerMilestone(userId: $userId, milestoneId: $milestoneId, status: $status, currentProgress: $currentProgress, unlockedAt: $unlockedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$PlayerMilestoneCopyWith<$Res> implements $PlayerMilestoneCopyWith<$Res> {
  factory _$PlayerMilestoneCopyWith(_PlayerMilestone value, $Res Function(_PlayerMilestone) _then) = __$PlayerMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String userId, String milestoneId, MilestoneStatus status, double currentProgress,@TimestampConverter() DateTime? unlockedAt,@TimestampConverter() DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class __$PlayerMilestoneCopyWithImpl<$Res>
    implements _$PlayerMilestoneCopyWith<$Res> {
  __$PlayerMilestoneCopyWithImpl(this._self, this._then);

  final _PlayerMilestone _self;
  final $Res Function(_PlayerMilestone) _then;

/// Create a copy of PlayerMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? milestoneId = null,Object? status = null,Object? currentProgress = null,Object? unlockedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_PlayerMilestone(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,milestoneId: null == milestoneId ? _self.milestoneId : milestoneId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus,currentProgress: null == currentProgress ? _self.currentProgress : currentProgress // ignore: cast_nullable_to_non_nullable
as double,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$MilestoneProgress {

 MilestoneDefinition get definition; PlayerMilestone? get playerState;
/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilestoneProgressCopyWith<MilestoneProgress> get copyWith => _$MilestoneProgressCopyWithImpl<MilestoneProgress>(this as MilestoneProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilestoneProgress&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.playerState, playerState) || other.playerState == playerState));
}


@override
int get hashCode => Object.hash(runtimeType,definition,playerState);

@override
String toString() {
  return 'MilestoneProgress(definition: $definition, playerState: $playerState)';
}


}

/// @nodoc
abstract mixin class $MilestoneProgressCopyWith<$Res>  {
  factory $MilestoneProgressCopyWith(MilestoneProgress value, $Res Function(MilestoneProgress) _then) = _$MilestoneProgressCopyWithImpl;
@useResult
$Res call({
 MilestoneDefinition definition, PlayerMilestone? playerState
});


$MilestoneDefinitionCopyWith<$Res> get definition;$PlayerMilestoneCopyWith<$Res>? get playerState;

}
/// @nodoc
class _$MilestoneProgressCopyWithImpl<$Res>
    implements $MilestoneProgressCopyWith<$Res> {
  _$MilestoneProgressCopyWithImpl(this._self, this._then);

  final MilestoneProgress _self;
  final $Res Function(MilestoneProgress) _then;

/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? definition = null,Object? playerState = freezed,}) {
  return _then(_self.copyWith(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as MilestoneDefinition,playerState: freezed == playerState ? _self.playerState : playerState // ignore: cast_nullable_to_non_nullable
as PlayerMilestone?,
  ));
}
/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MilestoneDefinitionCopyWith<$Res> get definition {
  
  return $MilestoneDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerMilestoneCopyWith<$Res>? get playerState {
    if (_self.playerState == null) {
    return null;
  }

  return $PlayerMilestoneCopyWith<$Res>(_self.playerState!, (value) {
    return _then(_self.copyWith(playerState: value));
  });
}
}


/// Adds pattern-matching-related methods to [MilestoneProgress].
extension MilestoneProgressPatterns on MilestoneProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MilestoneProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MilestoneProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MilestoneProgress value)  $default,){
final _that = this;
switch (_that) {
case _MilestoneProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MilestoneProgress value)?  $default,){
final _that = this;
switch (_that) {
case _MilestoneProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MilestoneDefinition definition,  PlayerMilestone? playerState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MilestoneProgress() when $default != null:
return $default(_that.definition,_that.playerState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MilestoneDefinition definition,  PlayerMilestone? playerState)  $default,) {final _that = this;
switch (_that) {
case _MilestoneProgress():
return $default(_that.definition,_that.playerState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MilestoneDefinition definition,  PlayerMilestone? playerState)?  $default,) {final _that = this;
switch (_that) {
case _MilestoneProgress() when $default != null:
return $default(_that.definition,_that.playerState);case _:
  return null;

}
}

}

/// @nodoc


class _MilestoneProgress extends MilestoneProgress {
  const _MilestoneProgress({required this.definition, required this.playerState}): super._();
  

@override final  MilestoneDefinition definition;
@override final  PlayerMilestone? playerState;

/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilestoneProgressCopyWith<_MilestoneProgress> get copyWith => __$MilestoneProgressCopyWithImpl<_MilestoneProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilestoneProgress&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.playerState, playerState) || other.playerState == playerState));
}


@override
int get hashCode => Object.hash(runtimeType,definition,playerState);

@override
String toString() {
  return 'MilestoneProgress(definition: $definition, playerState: $playerState)';
}


}

/// @nodoc
abstract mixin class _$MilestoneProgressCopyWith<$Res> implements $MilestoneProgressCopyWith<$Res> {
  factory _$MilestoneProgressCopyWith(_MilestoneProgress value, $Res Function(_MilestoneProgress) _then) = __$MilestoneProgressCopyWithImpl;
@override @useResult
$Res call({
 MilestoneDefinition definition, PlayerMilestone? playerState
});


@override $MilestoneDefinitionCopyWith<$Res> get definition;@override $PlayerMilestoneCopyWith<$Res>? get playerState;

}
/// @nodoc
class __$MilestoneProgressCopyWithImpl<$Res>
    implements _$MilestoneProgressCopyWith<$Res> {
  __$MilestoneProgressCopyWithImpl(this._self, this._then);

  final _MilestoneProgress _self;
  final $Res Function(_MilestoneProgress) _then;

/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? definition = null,Object? playerState = freezed,}) {
  return _then(_MilestoneProgress(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as MilestoneDefinition,playerState: freezed == playerState ? _self.playerState : playerState // ignore: cast_nullable_to_non_nullable
as PlayerMilestone?,
  ));
}

/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MilestoneDefinitionCopyWith<$Res> get definition {
  
  return $MilestoneDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of MilestoneProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerMilestoneCopyWith<$Res>? get playerState {
    if (_self.playerState == null) {
    return null;
  }

  return $PlayerMilestoneCopyWith<$Res>(_self.playerState!, (value) {
    return _then(_self.copyWith(playerState: value));
  });
}
}

// dart format on
