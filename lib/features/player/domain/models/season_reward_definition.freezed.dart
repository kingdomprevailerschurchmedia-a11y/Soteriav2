// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_reward_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeasonRewardDefinition {

 String get rewardId; String get seasonId; String get name; String get description; RewardType get type; int get amount; bool get isActive; DateTime? get createdAt; DateTime? get updatedAt;// Eligibility criteria
 int? get minimumPosition; int? get maximumPosition; String? get minimumRank; int? get minimumTier; int? get minimumDivision; bool? get participationRequired;
/// Create a copy of SeasonRewardDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonRewardDefinitionCopyWith<SeasonRewardDefinition> get copyWith => _$SeasonRewardDefinitionCopyWithImpl<SeasonRewardDefinition>(this as SeasonRewardDefinition, _$identity);

  /// Serializes this SeasonRewardDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonRewardDefinition&&(identical(other.rewardId, rewardId) || other.rewardId == rewardId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.minimumPosition, minimumPosition) || other.minimumPosition == minimumPosition)&&(identical(other.maximumPosition, maximumPosition) || other.maximumPosition == maximumPosition)&&(identical(other.minimumRank, minimumRank) || other.minimumRank == minimumRank)&&(identical(other.minimumTier, minimumTier) || other.minimumTier == minimumTier)&&(identical(other.minimumDivision, minimumDivision) || other.minimumDivision == minimumDivision)&&(identical(other.participationRequired, participationRequired) || other.participationRequired == participationRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rewardId,seasonId,name,description,type,amount,isActive,createdAt,updatedAt,minimumPosition,maximumPosition,minimumRank,minimumTier,minimumDivision,participationRequired);

@override
String toString() {
  return 'SeasonRewardDefinition(rewardId: $rewardId, seasonId: $seasonId, name: $name, description: $description, type: $type, amount: $amount, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, minimumPosition: $minimumPosition, maximumPosition: $maximumPosition, minimumRank: $minimumRank, minimumTier: $minimumTier, minimumDivision: $minimumDivision, participationRequired: $participationRequired)';
}


}

/// @nodoc
abstract mixin class $SeasonRewardDefinitionCopyWith<$Res>  {
  factory $SeasonRewardDefinitionCopyWith(SeasonRewardDefinition value, $Res Function(SeasonRewardDefinition) _then) = _$SeasonRewardDefinitionCopyWithImpl;
@useResult
$Res call({
 String rewardId, String seasonId, String name, String description, RewardType type, int amount, bool isActive, DateTime? createdAt, DateTime? updatedAt, int? minimumPosition, int? maximumPosition, String? minimumRank, int? minimumTier, int? minimumDivision, bool? participationRequired
});




}
/// @nodoc
class _$SeasonRewardDefinitionCopyWithImpl<$Res>
    implements $SeasonRewardDefinitionCopyWith<$Res> {
  _$SeasonRewardDefinitionCopyWithImpl(this._self, this._then);

  final SeasonRewardDefinition _self;
  final $Res Function(SeasonRewardDefinition) _then;

/// Create a copy of SeasonRewardDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rewardId = null,Object? seasonId = null,Object? name = null,Object? description = null,Object? type = null,Object? amount = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? minimumPosition = freezed,Object? maximumPosition = freezed,Object? minimumRank = freezed,Object? minimumTier = freezed,Object? minimumDivision = freezed,Object? participationRequired = freezed,}) {
  return _then(_self.copyWith(
rewardId: null == rewardId ? _self.rewardId : rewardId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RewardType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,minimumPosition: freezed == minimumPosition ? _self.minimumPosition : minimumPosition // ignore: cast_nullable_to_non_nullable
as int?,maximumPosition: freezed == maximumPosition ? _self.maximumPosition : maximumPosition // ignore: cast_nullable_to_non_nullable
as int?,minimumRank: freezed == minimumRank ? _self.minimumRank : minimumRank // ignore: cast_nullable_to_non_nullable
as String?,minimumTier: freezed == minimumTier ? _self.minimumTier : minimumTier // ignore: cast_nullable_to_non_nullable
as int?,minimumDivision: freezed == minimumDivision ? _self.minimumDivision : minimumDivision // ignore: cast_nullable_to_non_nullable
as int?,participationRequired: freezed == participationRequired ? _self.participationRequired : participationRequired // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonRewardDefinition].
extension SeasonRewardDefinitionPatterns on SeasonRewardDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonRewardDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonRewardDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonRewardDefinition value)  $default,){
final _that = this;
switch (_that) {
case _SeasonRewardDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonRewardDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonRewardDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rewardId,  String seasonId,  String name,  String description,  RewardType type,  int amount,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt,  int? minimumPosition,  int? maximumPosition,  String? minimumRank,  int? minimumTier,  int? minimumDivision,  bool? participationRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonRewardDefinition() when $default != null:
return $default(_that.rewardId,_that.seasonId,_that.name,_that.description,_that.type,_that.amount,_that.isActive,_that.createdAt,_that.updatedAt,_that.minimumPosition,_that.maximumPosition,_that.minimumRank,_that.minimumTier,_that.minimumDivision,_that.participationRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rewardId,  String seasonId,  String name,  String description,  RewardType type,  int amount,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt,  int? minimumPosition,  int? maximumPosition,  String? minimumRank,  int? minimumTier,  int? minimumDivision,  bool? participationRequired)  $default,) {final _that = this;
switch (_that) {
case _SeasonRewardDefinition():
return $default(_that.rewardId,_that.seasonId,_that.name,_that.description,_that.type,_that.amount,_that.isActive,_that.createdAt,_that.updatedAt,_that.minimumPosition,_that.maximumPosition,_that.minimumRank,_that.minimumTier,_that.minimumDivision,_that.participationRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rewardId,  String seasonId,  String name,  String description,  RewardType type,  int amount,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt,  int? minimumPosition,  int? maximumPosition,  String? minimumRank,  int? minimumTier,  int? minimumDivision,  bool? participationRequired)?  $default,) {final _that = this;
switch (_that) {
case _SeasonRewardDefinition() when $default != null:
return $default(_that.rewardId,_that.seasonId,_that.name,_that.description,_that.type,_that.amount,_that.isActive,_that.createdAt,_that.updatedAt,_that.minimumPosition,_that.maximumPosition,_that.minimumRank,_that.minimumTier,_that.minimumDivision,_that.participationRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonRewardDefinition implements SeasonRewardDefinition {
  const _SeasonRewardDefinition({required this.rewardId, required this.seasonId, required this.name, required this.description, required this.type, required this.amount, this.isActive = true, this.createdAt, this.updatedAt, this.minimumPosition, this.maximumPosition, this.minimumRank, this.minimumTier, this.minimumDivision, this.participationRequired});
  factory _SeasonRewardDefinition.fromJson(Map<String, dynamic> json) => _$SeasonRewardDefinitionFromJson(json);

@override final  String rewardId;
@override final  String seasonId;
@override final  String name;
@override final  String description;
@override final  RewardType type;
@override final  int amount;
@override@JsonKey() final  bool isActive;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
// Eligibility criteria
@override final  int? minimumPosition;
@override final  int? maximumPosition;
@override final  String? minimumRank;
@override final  int? minimumTier;
@override final  int? minimumDivision;
@override final  bool? participationRequired;

/// Create a copy of SeasonRewardDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonRewardDefinitionCopyWith<_SeasonRewardDefinition> get copyWith => __$SeasonRewardDefinitionCopyWithImpl<_SeasonRewardDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonRewardDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonRewardDefinition&&(identical(other.rewardId, rewardId) || other.rewardId == rewardId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.minimumPosition, minimumPosition) || other.minimumPosition == minimumPosition)&&(identical(other.maximumPosition, maximumPosition) || other.maximumPosition == maximumPosition)&&(identical(other.minimumRank, minimumRank) || other.minimumRank == minimumRank)&&(identical(other.minimumTier, minimumTier) || other.minimumTier == minimumTier)&&(identical(other.minimumDivision, minimumDivision) || other.minimumDivision == minimumDivision)&&(identical(other.participationRequired, participationRequired) || other.participationRequired == participationRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rewardId,seasonId,name,description,type,amount,isActive,createdAt,updatedAt,minimumPosition,maximumPosition,minimumRank,minimumTier,minimumDivision,participationRequired);

@override
String toString() {
  return 'SeasonRewardDefinition(rewardId: $rewardId, seasonId: $seasonId, name: $name, description: $description, type: $type, amount: $amount, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, minimumPosition: $minimumPosition, maximumPosition: $maximumPosition, minimumRank: $minimumRank, minimumTier: $minimumTier, minimumDivision: $minimumDivision, participationRequired: $participationRequired)';
}


}

/// @nodoc
abstract mixin class _$SeasonRewardDefinitionCopyWith<$Res> implements $SeasonRewardDefinitionCopyWith<$Res> {
  factory _$SeasonRewardDefinitionCopyWith(_SeasonRewardDefinition value, $Res Function(_SeasonRewardDefinition) _then) = __$SeasonRewardDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String rewardId, String seasonId, String name, String description, RewardType type, int amount, bool isActive, DateTime? createdAt, DateTime? updatedAt, int? minimumPosition, int? maximumPosition, String? minimumRank, int? minimumTier, int? minimumDivision, bool? participationRequired
});




}
/// @nodoc
class __$SeasonRewardDefinitionCopyWithImpl<$Res>
    implements _$SeasonRewardDefinitionCopyWith<$Res> {
  __$SeasonRewardDefinitionCopyWithImpl(this._self, this._then);

  final _SeasonRewardDefinition _self;
  final $Res Function(_SeasonRewardDefinition) _then;

/// Create a copy of SeasonRewardDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rewardId = null,Object? seasonId = null,Object? name = null,Object? description = null,Object? type = null,Object? amount = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? minimumPosition = freezed,Object? maximumPosition = freezed,Object? minimumRank = freezed,Object? minimumTier = freezed,Object? minimumDivision = freezed,Object? participationRequired = freezed,}) {
  return _then(_SeasonRewardDefinition(
rewardId: null == rewardId ? _self.rewardId : rewardId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RewardType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,minimumPosition: freezed == minimumPosition ? _self.minimumPosition : minimumPosition // ignore: cast_nullable_to_non_nullable
as int?,maximumPosition: freezed == maximumPosition ? _self.maximumPosition : maximumPosition // ignore: cast_nullable_to_non_nullable
as int?,minimumRank: freezed == minimumRank ? _self.minimumRank : minimumRank // ignore: cast_nullable_to_non_nullable
as String?,minimumTier: freezed == minimumTier ? _self.minimumTier : minimumTier // ignore: cast_nullable_to_non_nullable
as int?,minimumDivision: freezed == minimumDivision ? _self.minimumDivision : minimumDivision // ignore: cast_nullable_to_non_nullable
as int?,participationRequired: freezed == participationRequired ? _self.participationRequired : participationRequired // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
