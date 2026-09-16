// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AchievementDefinition {

 String get id; String get title; String get description; AchievementCategory get category; String get icon; AchievementRequirementType get requirementType; double get threshold; AchievementRarity get rarity; int get xpReward; int get coinReward; bool get isHidden; bool get isActive; Map<String, dynamic> get metadata; int get displayOrder;
/// Create a copy of AchievementDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementDefinitionCopyWith<AchievementDefinition> get copyWith => _$AchievementDefinitionCopyWithImpl<AchievementDefinition>(this as AchievementDefinition, _$identity);

  /// Serializes this AchievementDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.requirementType, requirementType) || other.requirementType == requirementType)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.coinReward, coinReward) || other.coinReward == coinReward)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,icon,requirementType,threshold,rarity,xpReward,coinReward,isHidden,isActive,const DeepCollectionEquality().hash(metadata),displayOrder);

@override
String toString() {
  return 'AchievementDefinition(id: $id, title: $title, description: $description, category: $category, icon: $icon, requirementType: $requirementType, threshold: $threshold, rarity: $rarity, xpReward: $xpReward, coinReward: $coinReward, isHidden: $isHidden, isActive: $isActive, metadata: $metadata, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $AchievementDefinitionCopyWith<$Res>  {
  factory $AchievementDefinitionCopyWith(AchievementDefinition value, $Res Function(AchievementDefinition) _then) = _$AchievementDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, AchievementCategory category, String icon, AchievementRequirementType requirementType, double threshold, AchievementRarity rarity, int xpReward, int coinReward, bool isHidden, bool isActive, Map<String, dynamic> metadata, int displayOrder
});




}
/// @nodoc
class _$AchievementDefinitionCopyWithImpl<$Res>
    implements $AchievementDefinitionCopyWith<$Res> {
  _$AchievementDefinitionCopyWithImpl(this._self, this._then);

  final AchievementDefinition _self;
  final $Res Function(AchievementDefinition) _then;

/// Create a copy of AchievementDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? icon = null,Object? requirementType = null,Object? threshold = null,Object? rarity = null,Object? xpReward = null,Object? coinReward = null,Object? isHidden = null,Object? isActive = null,Object? metadata = null,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AchievementCategory,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,requirementType: null == requirementType ? _self.requirementType : requirementType // ignore: cast_nullable_to_non_nullable
as AchievementRequirementType,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as AchievementRarity,xpReward: null == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int,coinReward: null == coinReward ? _self.coinReward : coinReward // ignore: cast_nullable_to_non_nullable
as int,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementDefinition].
extension AchievementDefinitionPatterns on AchievementDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementDefinition value)  $default,){
final _that = this;
switch (_that) {
case _AchievementDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  AchievementCategory category,  String icon,  AchievementRequirementType requirementType,  double threshold,  AchievementRarity rarity,  int xpReward,  int coinReward,  bool isHidden,  bool isActive,  Map<String, dynamic> metadata,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementDefinition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.icon,_that.requirementType,_that.threshold,_that.rarity,_that.xpReward,_that.coinReward,_that.isHidden,_that.isActive,_that.metadata,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  AchievementCategory category,  String icon,  AchievementRequirementType requirementType,  double threshold,  AchievementRarity rarity,  int xpReward,  int coinReward,  bool isHidden,  bool isActive,  Map<String, dynamic> metadata,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _AchievementDefinition():
return $default(_that.id,_that.title,_that.description,_that.category,_that.icon,_that.requirementType,_that.threshold,_that.rarity,_that.xpReward,_that.coinReward,_that.isHidden,_that.isActive,_that.metadata,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  AchievementCategory category,  String icon,  AchievementRequirementType requirementType,  double threshold,  AchievementRarity rarity,  int xpReward,  int coinReward,  bool isHidden,  bool isActive,  Map<String, dynamic> metadata,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _AchievementDefinition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.icon,_that.requirementType,_that.threshold,_that.rarity,_that.xpReward,_that.coinReward,_that.isHidden,_that.isActive,_that.metadata,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AchievementDefinition implements AchievementDefinition {
  const _AchievementDefinition({required this.id, required this.title, required this.description, required this.category, required this.icon, required this.requirementType, required this.threshold, this.rarity = AchievementRarity.common, this.xpReward = 0, this.coinReward = 0, this.isHidden = false, this.isActive = true, final  Map<String, dynamic> metadata = const {}, this.displayOrder = 0}): _metadata = metadata;
  factory _AchievementDefinition.fromJson(Map<String, dynamic> json) => _$AchievementDefinitionFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  AchievementCategory category;
@override final  String icon;
@override final  AchievementRequirementType requirementType;
@override final  double threshold;
@override@JsonKey() final  AchievementRarity rarity;
@override@JsonKey() final  int xpReward;
@override@JsonKey() final  int coinReward;
@override@JsonKey() final  bool isHidden;
@override@JsonKey() final  bool isActive;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override@JsonKey() final  int displayOrder;

/// Create a copy of AchievementDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementDefinitionCopyWith<_AchievementDefinition> get copyWith => __$AchievementDefinitionCopyWithImpl<_AchievementDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchievementDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.requirementType, requirementType) || other.requirementType == requirementType)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.coinReward, coinReward) || other.coinReward == coinReward)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,icon,requirementType,threshold,rarity,xpReward,coinReward,isHidden,isActive,const DeepCollectionEquality().hash(_metadata),displayOrder);

@override
String toString() {
  return 'AchievementDefinition(id: $id, title: $title, description: $description, category: $category, icon: $icon, requirementType: $requirementType, threshold: $threshold, rarity: $rarity, xpReward: $xpReward, coinReward: $coinReward, isHidden: $isHidden, isActive: $isActive, metadata: $metadata, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$AchievementDefinitionCopyWith<$Res> implements $AchievementDefinitionCopyWith<$Res> {
  factory _$AchievementDefinitionCopyWith(_AchievementDefinition value, $Res Function(_AchievementDefinition) _then) = __$AchievementDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, AchievementCategory category, String icon, AchievementRequirementType requirementType, double threshold, AchievementRarity rarity, int xpReward, int coinReward, bool isHidden, bool isActive, Map<String, dynamic> metadata, int displayOrder
});




}
/// @nodoc
class __$AchievementDefinitionCopyWithImpl<$Res>
    implements _$AchievementDefinitionCopyWith<$Res> {
  __$AchievementDefinitionCopyWithImpl(this._self, this._then);

  final _AchievementDefinition _self;
  final $Res Function(_AchievementDefinition) _then;

/// Create a copy of AchievementDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? icon = null,Object? requirementType = null,Object? threshold = null,Object? rarity = null,Object? xpReward = null,Object? coinReward = null,Object? isHidden = null,Object? isActive = null,Object? metadata = null,Object? displayOrder = null,}) {
  return _then(_AchievementDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AchievementCategory,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,requirementType: null == requirementType ? _self.requirementType : requirementType // ignore: cast_nullable_to_non_nullable
as AchievementRequirementType,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as AchievementRarity,xpReward: null == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int,coinReward: null == coinReward ? _self.coinReward : coinReward // ignore: cast_nullable_to_non_nullable
as int,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlayerAchievement {

 String get userId; String get achievementId; AchievementStatus get status; double get currentValue; double get targetValue;@TimestampConverter() DateTime? get unlockedAt;@TimestampConverter() DateTime? get claimedAt; int get schemaVersion;
/// Create a copy of PlayerAchievement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerAchievementCopyWith<PlayerAchievement> get copyWith => _$PlayerAchievementCopyWithImpl<PlayerAchievement>(this as PlayerAchievement, _$identity);

  /// Serializes this PlayerAchievement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerAchievement&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,achievementId,status,currentValue,targetValue,unlockedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'PlayerAchievement(userId: $userId, achievementId: $achievementId, status: $status, currentValue: $currentValue, targetValue: $targetValue, unlockedAt: $unlockedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $PlayerAchievementCopyWith<$Res>  {
  factory $PlayerAchievementCopyWith(PlayerAchievement value, $Res Function(PlayerAchievement) _then) = _$PlayerAchievementCopyWithImpl;
@useResult
$Res call({
 String userId, String achievementId, AchievementStatus status, double currentValue, double targetValue,@TimestampConverter() DateTime? unlockedAt,@TimestampConverter() DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class _$PlayerAchievementCopyWithImpl<$Res>
    implements $PlayerAchievementCopyWith<$Res> {
  _$PlayerAchievementCopyWithImpl(this._self, this._then);

  final PlayerAchievement _self;
  final $Res Function(PlayerAchievement) _then;

/// Create a copy of PlayerAchievement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? achievementId = null,Object? status = null,Object? currentValue = null,Object? targetValue = null,Object? unlockedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AchievementStatus,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as double,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerAchievement].
extension PlayerAchievementPatterns on PlayerAchievement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerAchievement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerAchievement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerAchievement value)  $default,){
final _that = this;
switch (_that) {
case _PlayerAchievement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerAchievement value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerAchievement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String achievementId,  AchievementStatus status,  double currentValue,  double targetValue, @TimestampConverter()  DateTime? unlockedAt, @TimestampConverter()  DateTime? claimedAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerAchievement() when $default != null:
return $default(_that.userId,_that.achievementId,_that.status,_that.currentValue,_that.targetValue,_that.unlockedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String achievementId,  AchievementStatus status,  double currentValue,  double targetValue, @TimestampConverter()  DateTime? unlockedAt, @TimestampConverter()  DateTime? claimedAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _PlayerAchievement():
return $default(_that.userId,_that.achievementId,_that.status,_that.currentValue,_that.targetValue,_that.unlockedAt,_that.claimedAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String achievementId,  AchievementStatus status,  double currentValue,  double targetValue, @TimestampConverter()  DateTime? unlockedAt, @TimestampConverter()  DateTime? claimedAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _PlayerAchievement() when $default != null:
return $default(_that.userId,_that.achievementId,_that.status,_that.currentValue,_that.targetValue,_that.unlockedAt,_that.claimedAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerAchievement implements PlayerAchievement {
  const _PlayerAchievement({required this.userId, required this.achievementId, required this.status, required this.currentValue, required this.targetValue, @TimestampConverter() this.unlockedAt, @TimestampConverter() this.claimedAt, this.schemaVersion = 1});
  factory _PlayerAchievement.fromJson(Map<String, dynamic> json) => _$PlayerAchievementFromJson(json);

@override final  String userId;
@override final  String achievementId;
@override final  AchievementStatus status;
@override final  double currentValue;
@override final  double targetValue;
@override@TimestampConverter() final  DateTime? unlockedAt;
@override@TimestampConverter() final  DateTime? claimedAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of PlayerAchievement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerAchievementCopyWith<_PlayerAchievement> get copyWith => __$PlayerAchievementCopyWithImpl<_PlayerAchievement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerAchievementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerAchievement&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,achievementId,status,currentValue,targetValue,unlockedAt,claimedAt,schemaVersion);

@override
String toString() {
  return 'PlayerAchievement(userId: $userId, achievementId: $achievementId, status: $status, currentValue: $currentValue, targetValue: $targetValue, unlockedAt: $unlockedAt, claimedAt: $claimedAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$PlayerAchievementCopyWith<$Res> implements $PlayerAchievementCopyWith<$Res> {
  factory _$PlayerAchievementCopyWith(_PlayerAchievement value, $Res Function(_PlayerAchievement) _then) = __$PlayerAchievementCopyWithImpl;
@override @useResult
$Res call({
 String userId, String achievementId, AchievementStatus status, double currentValue, double targetValue,@TimestampConverter() DateTime? unlockedAt,@TimestampConverter() DateTime? claimedAt, int schemaVersion
});




}
/// @nodoc
class __$PlayerAchievementCopyWithImpl<$Res>
    implements _$PlayerAchievementCopyWith<$Res> {
  __$PlayerAchievementCopyWithImpl(this._self, this._then);

  final _PlayerAchievement _self;
  final $Res Function(_PlayerAchievement) _then;

/// Create a copy of PlayerAchievement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? achievementId = null,Object? status = null,Object? currentValue = null,Object? targetValue = null,Object? unlockedAt = freezed,Object? claimedAt = freezed,Object? schemaVersion = null,}) {
  return _then(_PlayerAchievement(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AchievementStatus,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as double,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
