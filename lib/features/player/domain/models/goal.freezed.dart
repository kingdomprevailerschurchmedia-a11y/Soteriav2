// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalDefinition {

 String get id; String get title; String get description; GoalType get type; GoalCategory get category; double get target; String? get icon; bool get isActive; Map<String, dynamic> get metadata; RewardType? get rewardType; int? get rewardAmount; int get displayOrder;
/// Create a copy of GoalDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalDefinitionCopyWith<GoalDefinition> get copyWith => _$GoalDefinitionCopyWithImpl<GoalDefinition>(this as GoalDefinition, _$identity);

  /// Serializes this GoalDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.target, target) || other.target == target)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,type,category,target,icon,isActive,const DeepCollectionEquality().hash(metadata),rewardType,rewardAmount,displayOrder);

@override
String toString() {
  return 'GoalDefinition(id: $id, title: $title, description: $description, type: $type, category: $category, target: $target, icon: $icon, isActive: $isActive, metadata: $metadata, rewardType: $rewardType, rewardAmount: $rewardAmount, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $GoalDefinitionCopyWith<$Res>  {
  factory $GoalDefinitionCopyWith(GoalDefinition value, $Res Function(GoalDefinition) _then) = _$GoalDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, GoalType type, GoalCategory category, double target, String? icon, bool isActive, Map<String, dynamic> metadata, RewardType? rewardType, int? rewardAmount, int displayOrder
});




}
/// @nodoc
class _$GoalDefinitionCopyWithImpl<$Res>
    implements $GoalDefinitionCopyWith<$Res> {
  _$GoalDefinitionCopyWithImpl(this._self, this._then);

  final GoalDefinition _self;
  final $Res Function(GoalDefinition) _then;

/// Create a copy of GoalDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? type = null,Object? category = null,Object? target = null,Object? icon = freezed,Object? isActive = null,Object? metadata = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as GoalCategory,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalDefinition].
extension GoalDefinitionPatterns on GoalDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalDefinition value)  $default,){
final _that = this;
switch (_that) {
case _GoalDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _GoalDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  GoalType type,  GoalCategory category,  double target,  String? icon,  bool isActive,  Map<String, dynamic> metadata,  RewardType? rewardType,  int? rewardAmount,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalDefinition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.type,_that.category,_that.target,_that.icon,_that.isActive,_that.metadata,_that.rewardType,_that.rewardAmount,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  GoalType type,  GoalCategory category,  double target,  String? icon,  bool isActive,  Map<String, dynamic> metadata,  RewardType? rewardType,  int? rewardAmount,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _GoalDefinition():
return $default(_that.id,_that.title,_that.description,_that.type,_that.category,_that.target,_that.icon,_that.isActive,_that.metadata,_that.rewardType,_that.rewardAmount,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  GoalType type,  GoalCategory category,  double target,  String? icon,  bool isActive,  Map<String, dynamic> metadata,  RewardType? rewardType,  int? rewardAmount,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _GoalDefinition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.type,_that.category,_that.target,_that.icon,_that.isActive,_that.metadata,_that.rewardType,_that.rewardAmount,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalDefinition implements GoalDefinition {
  const _GoalDefinition({required this.id, required this.title, required this.description, required this.type, required this.category, required this.target, this.icon, this.isActive = true, final  Map<String, dynamic> metadata = const {}, this.rewardType, this.rewardAmount, this.displayOrder = 0}): _metadata = metadata;
  factory _GoalDefinition.fromJson(Map<String, dynamic> json) => _$GoalDefinitionFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  GoalType type;
@override final  GoalCategory category;
@override final  double target;
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
@override@JsonKey() final  int displayOrder;

/// Create a copy of GoalDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalDefinitionCopyWith<_GoalDefinition> get copyWith => __$GoalDefinitionCopyWithImpl<_GoalDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.target, target) || other.target == target)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,type,category,target,icon,isActive,const DeepCollectionEquality().hash(_metadata),rewardType,rewardAmount,displayOrder);

@override
String toString() {
  return 'GoalDefinition(id: $id, title: $title, description: $description, type: $type, category: $category, target: $target, icon: $icon, isActive: $isActive, metadata: $metadata, rewardType: $rewardType, rewardAmount: $rewardAmount, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$GoalDefinitionCopyWith<$Res> implements $GoalDefinitionCopyWith<$Res> {
  factory _$GoalDefinitionCopyWith(_GoalDefinition value, $Res Function(_GoalDefinition) _then) = __$GoalDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, GoalType type, GoalCategory category, double target, String? icon, bool isActive, Map<String, dynamic> metadata, RewardType? rewardType, int? rewardAmount, int displayOrder
});




}
/// @nodoc
class __$GoalDefinitionCopyWithImpl<$Res>
    implements _$GoalDefinitionCopyWith<$Res> {
  __$GoalDefinitionCopyWithImpl(this._self, this._then);

  final _GoalDefinition _self;
  final $Res Function(_GoalDefinition) _then;

/// Create a copy of GoalDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? type = null,Object? category = null,Object? target = null,Object? icon = freezed,Object? isActive = null,Object? metadata = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? displayOrder = null,}) {
  return _then(_GoalDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as GoalCategory,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlayerGoal {

 String get userId; String get goalId; GoalStatus get status; double get currentProgress; DateTime get startedAt; DateTime get expiresAt; DateTime? get completedAt; DateTime? get claimedAt; int get schemaVersion;
/// Create a copy of PlayerGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerGoalCopyWith<PlayerGoal> get copyWith => _$PlayerGoalCopyWithImpl<PlayerGoal>(this as PlayerGoal, _$identity);

  /// Serializes this PlayerGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerGoal&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentProgress, currentProgress) || other.currentProgress == currentProgress)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,goalId,status,currentProgress,startedAt,expiresAt,completedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'PlayerGoal(userId: $userId, goalId: $goalId, status: $status, currentProgress: $currentProgress, startedAt: $startedAt, expiresAt: $expiresAt, completedAt: $completedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $PlayerGoalCopyWith<$Res>  {
  factory $PlayerGoalCopyWith(PlayerGoal value, $Res Function(PlayerGoal) _then) = _$PlayerGoalCopyWithImpl;
@useResult
$Res call({
 String userId, String goalId, GoalStatus status, double currentProgress, DateTime startedAt, DateTime expiresAt, DateTime? completedAt, DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class _$PlayerGoalCopyWithImpl<$Res>
    implements $PlayerGoalCopyWith<$Res> {
  _$PlayerGoalCopyWithImpl(this._self, this._then);

  final PlayerGoal _self;
  final $Res Function(PlayerGoal) _then;

/// Create a copy of PlayerGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? goalId = null,Object? status = null,Object? currentProgress = null,Object? startedAt = null,Object? expiresAt = null,Object? completedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,currentProgress: null == currentProgress ? _self.currentProgress : currentProgress // ignore: cast_nullable_to_non_nullable
as double,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerGoal].
extension PlayerGoalPatterns on PlayerGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerGoal value)  $default,){
final _that = this;
switch (_that) {
case _PlayerGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerGoal value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String goalId,  GoalStatus status,  double currentProgress,  DateTime startedAt,  DateTime expiresAt,  DateTime? completedAt,  DateTime? claimedAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerGoal() when $default != null:
return $default(_that.userId,_that.goalId,_that.status,_that.currentProgress,_that.startedAt,_that.expiresAt,_that.completedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String goalId,  GoalStatus status,  double currentProgress,  DateTime startedAt,  DateTime expiresAt,  DateTime? completedAt,  DateTime? claimedAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _PlayerGoal():
return $default(_that.userId,_that.goalId,_that.status,_that.currentProgress,_that.startedAt,_that.expiresAt,_that.completedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String goalId,  GoalStatus status,  double currentProgress,  DateTime startedAt,  DateTime expiresAt,  DateTime? completedAt,  DateTime? claimedAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _PlayerGoal() when $default != null:
return $default(_that.userId,_that.goalId,_that.status,_that.currentProgress,_that.startedAt,_that.expiresAt,_that.completedAt,_that.claimedAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerGoal extends PlayerGoal {
  const _PlayerGoal({required this.userId, required this.goalId, required this.status, required this.currentProgress, required this.startedAt, required this.expiresAt, this.completedAt, this.claimedAt, this.schemaVersion = 1}): super._();
  factory _PlayerGoal.fromJson(Map<String, dynamic> json) => _$PlayerGoalFromJson(json);

@override final  String userId;
@override final  String goalId;
@override final  GoalStatus status;
@override final  double currentProgress;
@override final  DateTime startedAt;
@override final  DateTime expiresAt;
@override final  DateTime? completedAt;
@override final  DateTime? claimedAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of PlayerGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerGoalCopyWith<_PlayerGoal> get copyWith => __$PlayerGoalCopyWithImpl<_PlayerGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerGoal&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentProgress, currentProgress) || other.currentProgress == currentProgress)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,goalId,status,currentProgress,startedAt,expiresAt,completedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'PlayerGoal(userId: $userId, goalId: $goalId, status: $status, currentProgress: $currentProgress, startedAt: $startedAt, expiresAt: $expiresAt, completedAt: $completedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$PlayerGoalCopyWith<$Res> implements $PlayerGoalCopyWith<$Res> {
  factory _$PlayerGoalCopyWith(_PlayerGoal value, $Res Function(_PlayerGoal) _then) = __$PlayerGoalCopyWithImpl;
@override @useResult
$Res call({
 String userId, String goalId, GoalStatus status, double currentProgress, DateTime startedAt, DateTime expiresAt, DateTime? completedAt, DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class __$PlayerGoalCopyWithImpl<$Res>
    implements _$PlayerGoalCopyWith<$Res> {
  __$PlayerGoalCopyWithImpl(this._self, this._then);

  final _PlayerGoal _self;
  final $Res Function(_PlayerGoal) _then;

/// Create a copy of PlayerGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? goalId = null,Object? status = null,Object? currentProgress = null,Object? startedAt = null,Object? expiresAt = null,Object? completedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_PlayerGoal(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,currentProgress: null == currentProgress ? _self.currentProgress : currentProgress // ignore: cast_nullable_to_non_nullable
as double,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GoalProgress {

 GoalDefinition get definition; PlayerGoal? get playerState;
/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalProgressCopyWith<GoalProgress> get copyWith => _$GoalProgressCopyWithImpl<GoalProgress>(this as GoalProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalProgress&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.playerState, playerState) || other.playerState == playerState));
}


@override
int get hashCode => Object.hash(runtimeType,definition,playerState);

@override
String toString() {
  return 'GoalProgress(definition: $definition, playerState: $playerState)';
}


}

/// @nodoc
abstract mixin class $GoalProgressCopyWith<$Res>  {
  factory $GoalProgressCopyWith(GoalProgress value, $Res Function(GoalProgress) _then) = _$GoalProgressCopyWithImpl;
@useResult
$Res call({
 GoalDefinition definition, PlayerGoal? playerState
});


$GoalDefinitionCopyWith<$Res> get definition;$PlayerGoalCopyWith<$Res>? get playerState;

}
/// @nodoc
class _$GoalProgressCopyWithImpl<$Res>
    implements $GoalProgressCopyWith<$Res> {
  _$GoalProgressCopyWithImpl(this._self, this._then);

  final GoalProgress _self;
  final $Res Function(GoalProgress) _then;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? definition = null,Object? playerState = freezed,}) {
  return _then(_self.copyWith(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as GoalDefinition,playerState: freezed == playerState ? _self.playerState : playerState // ignore: cast_nullable_to_non_nullable
as PlayerGoal?,
  ));
}
/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalDefinitionCopyWith<$Res> get definition {
  
  return $GoalDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerGoalCopyWith<$Res>? get playerState {
    if (_self.playerState == null) {
    return null;
  }

  return $PlayerGoalCopyWith<$Res>(_self.playerState!, (value) {
    return _then(_self.copyWith(playerState: value));
  });
}
}


/// Adds pattern-matching-related methods to [GoalProgress].
extension GoalProgressPatterns on GoalProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalProgress value)  $default,){
final _that = this;
switch (_that) {
case _GoalProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalProgress value)?  $default,){
final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GoalDefinition definition,  PlayerGoal? playerState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GoalDefinition definition,  PlayerGoal? playerState)  $default,) {final _that = this;
switch (_that) {
case _GoalProgress():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GoalDefinition definition,  PlayerGoal? playerState)?  $default,) {final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
return $default(_that.definition,_that.playerState);case _:
  return null;

}
}

}

/// @nodoc


class _GoalProgress extends GoalProgress {
  const _GoalProgress({required this.definition, required this.playerState}): super._();
  

@override final  GoalDefinition definition;
@override final  PlayerGoal? playerState;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalProgressCopyWith<_GoalProgress> get copyWith => __$GoalProgressCopyWithImpl<_GoalProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalProgress&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.playerState, playerState) || other.playerState == playerState));
}


@override
int get hashCode => Object.hash(runtimeType,definition,playerState);

@override
String toString() {
  return 'GoalProgress(definition: $definition, playerState: $playerState)';
}


}

/// @nodoc
abstract mixin class _$GoalProgressCopyWith<$Res> implements $GoalProgressCopyWith<$Res> {
  factory _$GoalProgressCopyWith(_GoalProgress value, $Res Function(_GoalProgress) _then) = __$GoalProgressCopyWithImpl;
@override @useResult
$Res call({
 GoalDefinition definition, PlayerGoal? playerState
});


@override $GoalDefinitionCopyWith<$Res> get definition;@override $PlayerGoalCopyWith<$Res>? get playerState;

}
/// @nodoc
class __$GoalProgressCopyWithImpl<$Res>
    implements _$GoalProgressCopyWith<$Res> {
  __$GoalProgressCopyWithImpl(this._self, this._then);

  final _GoalProgress _self;
  final $Res Function(_GoalProgress) _then;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? definition = null,Object? playerState = freezed,}) {
  return _then(_GoalProgress(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as GoalDefinition,playerState: freezed == playerState ? _self.playerState : playerState // ignore: cast_nullable_to_non_nullable
as PlayerGoal?,
  ));
}

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalDefinitionCopyWith<$Res> get definition {
  
  return $GoalDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerGoalCopyWith<$Res>? get playerState {
    if (_self.playerState == null) {
    return null;
  }

  return $PlayerGoalCopyWith<$Res>(_self.playerState!, (value) {
    return _then(_self.copyWith(playerState: value));
  });
}
}

// dart format on
