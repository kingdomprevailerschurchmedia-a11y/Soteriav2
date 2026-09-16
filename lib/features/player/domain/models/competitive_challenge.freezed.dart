// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveChallenge {

 String get challengeId; String get challengerId; String get challengedPlayerId; ChallengeType get type; double get target; ChallengeStatus get status; DateTime get createdAt; DateTime get expiresAt; DateTime? get startAt; DateTime? get completedAt; double get challengerProgress; double get opponentProgress; String? get seasonId; RewardType? get rewardType; int? get rewardAmount; GameMode get mode; Map<String, dynamic> get configuration; int get schemaVersion;
/// Create a copy of CompetitiveChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveChallengeCopyWith<CompetitiveChallenge> get copyWith => _$CompetitiveChallengeCopyWithImpl<CompetitiveChallenge>(this as CompetitiveChallenge, _$identity);

  /// Serializes this CompetitiveChallenge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveChallenge&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.challengerId, challengerId) || other.challengerId == challengerId)&&(identical(other.challengedPlayerId, challengedPlayerId) || other.challengedPlayerId == challengedPlayerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.target, target) || other.target == target)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.challengerProgress, challengerProgress) || other.challengerProgress == challengerProgress)&&(identical(other.opponentProgress, opponentProgress) || other.opponentProgress == opponentProgress)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.configuration, configuration)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,challengeId,challengerId,challengedPlayerId,type,target,status,createdAt,expiresAt,startAt,completedAt,challengerProgress,opponentProgress,seasonId,rewardType,rewardAmount,mode,const DeepCollectionEquality().hash(configuration),schemaVersion);

@override
String toString() {
  return 'CompetitiveChallenge(challengeId: $challengeId, challengerId: $challengerId, challengedPlayerId: $challengedPlayerId, type: $type, target: $target, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, startAt: $startAt, completedAt: $completedAt, challengerProgress: $challengerProgress, opponentProgress: $opponentProgress, seasonId: $seasonId, rewardType: $rewardType, rewardAmount: $rewardAmount, mode: $mode, configuration: $configuration, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $CompetitiveChallengeCopyWith<$Res>  {
  factory $CompetitiveChallengeCopyWith(CompetitiveChallenge value, $Res Function(CompetitiveChallenge) _then) = _$CompetitiveChallengeCopyWithImpl;
@useResult
$Res call({
 String challengeId, String challengerId, String challengedPlayerId, ChallengeType type, double target, ChallengeStatus status, DateTime createdAt, DateTime expiresAt, DateTime? startAt, DateTime? completedAt, double challengerProgress, double opponentProgress, String? seasonId, RewardType? rewardType, int? rewardAmount, GameMode mode, Map<String, dynamic> configuration, int schemaVersion
});




}
/// @nodoc
class _$CompetitiveChallengeCopyWithImpl<$Res>
    implements $CompetitiveChallengeCopyWith<$Res> {
  _$CompetitiveChallengeCopyWithImpl(this._self, this._then);

  final CompetitiveChallenge _self;
  final $Res Function(CompetitiveChallenge) _then;

/// Create a copy of CompetitiveChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? challengeId = null,Object? challengerId = null,Object? challengedPlayerId = null,Object? type = null,Object? target = null,Object? status = null,Object? createdAt = null,Object? expiresAt = null,Object? startAt = freezed,Object? completedAt = freezed,Object? challengerProgress = null,Object? opponentProgress = null,Object? seasonId = freezed,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? mode = null,Object? configuration = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
challengeId: null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String,challengerId: null == challengerId ? _self.challengerId : challengerId // ignore: cast_nullable_to_non_nullable
as String,challengedPlayerId: null == challengedPlayerId ? _self.challengedPlayerId : challengedPlayerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChallengeType,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChallengeStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,challengerProgress: null == challengerProgress ? _self.challengerProgress : challengerProgress // ignore: cast_nullable_to_non_nullable
as double,opponentProgress: null == opponentProgress ? _self.opponentProgress : opponentProgress // ignore: cast_nullable_to_non_nullable
as double,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,configuration: null == configuration ? _self.configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveChallenge].
extension CompetitiveChallengePatterns on CompetitiveChallenge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveChallenge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveChallenge value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveChallenge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveChallenge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String challengeId,  String challengerId,  String challengedPlayerId,  ChallengeType type,  double target,  ChallengeStatus status,  DateTime createdAt,  DateTime expiresAt,  DateTime? startAt,  DateTime? completedAt,  double challengerProgress,  double opponentProgress,  String? seasonId,  RewardType? rewardType,  int? rewardAmount,  GameMode mode,  Map<String, dynamic> configuration,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveChallenge() when $default != null:
return $default(_that.challengeId,_that.challengerId,_that.challengedPlayerId,_that.type,_that.target,_that.status,_that.createdAt,_that.expiresAt,_that.startAt,_that.completedAt,_that.challengerProgress,_that.opponentProgress,_that.seasonId,_that.rewardType,_that.rewardAmount,_that.mode,_that.configuration,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String challengeId,  String challengerId,  String challengedPlayerId,  ChallengeType type,  double target,  ChallengeStatus status,  DateTime createdAt,  DateTime expiresAt,  DateTime? startAt,  DateTime? completedAt,  double challengerProgress,  double opponentProgress,  String? seasonId,  RewardType? rewardType,  int? rewardAmount,  GameMode mode,  Map<String, dynamic> configuration,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveChallenge():
return $default(_that.challengeId,_that.challengerId,_that.challengedPlayerId,_that.type,_that.target,_that.status,_that.createdAt,_that.expiresAt,_that.startAt,_that.completedAt,_that.challengerProgress,_that.opponentProgress,_that.seasonId,_that.rewardType,_that.rewardAmount,_that.mode,_that.configuration,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String challengeId,  String challengerId,  String challengedPlayerId,  ChallengeType type,  double target,  ChallengeStatus status,  DateTime createdAt,  DateTime expiresAt,  DateTime? startAt,  DateTime? completedAt,  double challengerProgress,  double opponentProgress,  String? seasonId,  RewardType? rewardType,  int? rewardAmount,  GameMode mode,  Map<String, dynamic> configuration,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveChallenge() when $default != null:
return $default(_that.challengeId,_that.challengerId,_that.challengedPlayerId,_that.type,_that.target,_that.status,_that.createdAt,_that.expiresAt,_that.startAt,_that.completedAt,_that.challengerProgress,_that.opponentProgress,_that.seasonId,_that.rewardType,_that.rewardAmount,_that.mode,_that.configuration,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveChallenge extends CompetitiveChallenge {
  const _CompetitiveChallenge({required this.challengeId, required this.challengerId, required this.challengedPlayerId, required this.type, required this.target, required this.status, required this.createdAt, required this.expiresAt, this.startAt, this.completedAt, this.challengerProgress = 0.0, this.opponentProgress = 0.0, this.seasonId, this.rewardType, this.rewardAmount, this.mode = GameMode.versus, final  Map<String, dynamic> configuration = const {}, this.schemaVersion = 1}): _configuration = configuration,super._();
  factory _CompetitiveChallenge.fromJson(Map<String, dynamic> json) => _$CompetitiveChallengeFromJson(json);

@override final  String challengeId;
@override final  String challengerId;
@override final  String challengedPlayerId;
@override final  ChallengeType type;
@override final  double target;
@override final  ChallengeStatus status;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;
@override final  DateTime? startAt;
@override final  DateTime? completedAt;
@override@JsonKey() final  double challengerProgress;
@override@JsonKey() final  double opponentProgress;
@override final  String? seasonId;
@override final  RewardType? rewardType;
@override final  int? rewardAmount;
@override@JsonKey() final  GameMode mode;
 final  Map<String, dynamic> _configuration;
@override@JsonKey() Map<String, dynamic> get configuration {
  if (_configuration is EqualUnmodifiableMapView) return _configuration;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_configuration);
}

@override@JsonKey() final  int schemaVersion;

/// Create a copy of CompetitiveChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveChallengeCopyWith<_CompetitiveChallenge> get copyWith => __$CompetitiveChallengeCopyWithImpl<_CompetitiveChallenge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveChallengeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveChallenge&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.challengerId, challengerId) || other.challengerId == challengerId)&&(identical(other.challengedPlayerId, challengedPlayerId) || other.challengedPlayerId == challengedPlayerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.target, target) || other.target == target)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.challengerProgress, challengerProgress) || other.challengerProgress == challengerProgress)&&(identical(other.opponentProgress, opponentProgress) || other.opponentProgress == opponentProgress)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._configuration, _configuration)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,challengeId,challengerId,challengedPlayerId,type,target,status,createdAt,expiresAt,startAt,completedAt,challengerProgress,opponentProgress,seasonId,rewardType,rewardAmount,mode,const DeepCollectionEquality().hash(_configuration),schemaVersion);

@override
String toString() {
  return 'CompetitiveChallenge(challengeId: $challengeId, challengerId: $challengerId, challengedPlayerId: $challengedPlayerId, type: $type, target: $target, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, startAt: $startAt, completedAt: $completedAt, challengerProgress: $challengerProgress, opponentProgress: $opponentProgress, seasonId: $seasonId, rewardType: $rewardType, rewardAmount: $rewardAmount, mode: $mode, configuration: $configuration, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveChallengeCopyWith<$Res> implements $CompetitiveChallengeCopyWith<$Res> {
  factory _$CompetitiveChallengeCopyWith(_CompetitiveChallenge value, $Res Function(_CompetitiveChallenge) _then) = __$CompetitiveChallengeCopyWithImpl;
@override @useResult
$Res call({
 String challengeId, String challengerId, String challengedPlayerId, ChallengeType type, double target, ChallengeStatus status, DateTime createdAt, DateTime expiresAt, DateTime? startAt, DateTime? completedAt, double challengerProgress, double opponentProgress, String? seasonId, RewardType? rewardType, int? rewardAmount, GameMode mode, Map<String, dynamic> configuration, int schemaVersion
});




}
/// @nodoc
class __$CompetitiveChallengeCopyWithImpl<$Res>
    implements _$CompetitiveChallengeCopyWith<$Res> {
  __$CompetitiveChallengeCopyWithImpl(this._self, this._then);

  final _CompetitiveChallenge _self;
  final $Res Function(_CompetitiveChallenge) _then;

/// Create a copy of CompetitiveChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? challengeId = null,Object? challengerId = null,Object? challengedPlayerId = null,Object? type = null,Object? target = null,Object? status = null,Object? createdAt = null,Object? expiresAt = null,Object? startAt = freezed,Object? completedAt = freezed,Object? challengerProgress = null,Object? opponentProgress = null,Object? seasonId = freezed,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? mode = null,Object? configuration = null,Object? schemaVersion = null,}) {
  return _then(_CompetitiveChallenge(
challengeId: null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String,challengerId: null == challengerId ? _self.challengerId : challengerId // ignore: cast_nullable_to_non_nullable
as String,challengedPlayerId: null == challengedPlayerId ? _self.challengedPlayerId : challengedPlayerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChallengeType,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChallengeStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,challengerProgress: null == challengerProgress ? _self.challengerProgress : challengerProgress // ignore: cast_nullable_to_non_nullable
as double,opponentProgress: null == opponentProgress ? _self.opponentProgress : opponentProgress // ignore: cast_nullable_to_non_nullable
as double,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,configuration: null == configuration ? _self._configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
