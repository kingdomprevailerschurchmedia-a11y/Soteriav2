// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_grant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RewardGrant {

 String get grantId; String get rewardId; String get seasonId; String get userId; RewardType get type; int get amount; GrantStatus get status; String? get transactionId;@TimestampConverter() DateTime? get grantedAt;@TimestampConverter() DateTime? get claimedAt;@RequiredTimestampConverter() DateTime get createdAt;@RequiredTimestampConverter() DateTime get updatedAt;
/// Create a copy of RewardGrant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardGrantCopyWith<RewardGrant> get copyWith => _$RewardGrantCopyWithImpl<RewardGrant>(this as RewardGrant, _$identity);

  /// Serializes this RewardGrant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardGrant&&(identical(other.grantId, grantId) || other.grantId == grantId)&&(identical(other.rewardId, rewardId) || other.rewardId == rewardId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.grantedAt, grantedAt) || other.grantedAt == grantedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grantId,rewardId,seasonId,userId,type,amount,status,transactionId,grantedAt,claimedAt,createdAt,updatedAt);

@override
String toString() {
  return 'RewardGrant(grantId: $grantId, rewardId: $rewardId, seasonId: $seasonId, userId: $userId, type: $type, amount: $amount, status: $status, transactionId: $transactionId, grantedAt: $grantedAt, claimedAt: $claimedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RewardGrantCopyWith<$Res>  {
  factory $RewardGrantCopyWith(RewardGrant value, $Res Function(RewardGrant) _then) = _$RewardGrantCopyWithImpl;
@useResult
$Res call({
 String grantId, String rewardId, String seasonId, String userId, RewardType type, int amount, GrantStatus status, String? transactionId,@TimestampConverter() DateTime? grantedAt,@TimestampConverter() DateTime? claimedAt,@RequiredTimestampConverter() DateTime createdAt,@RequiredTimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$RewardGrantCopyWithImpl<$Res>
    implements $RewardGrantCopyWith<$Res> {
  _$RewardGrantCopyWithImpl(this._self, this._then);

  final RewardGrant _self;
  final $Res Function(RewardGrant) _then;

/// Create a copy of RewardGrant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grantId = null,Object? rewardId = null,Object? seasonId = null,Object? userId = null,Object? type = null,Object? amount = null,Object? status = null,Object? transactionId = freezed,Object? grantedAt = freezed,Object? claimedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
grantId: null == grantId ? _self.grantId : grantId // ignore: cast_nullable_to_non_nullable
as String,rewardId: null == rewardId ? _self.rewardId : rewardId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RewardType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GrantStatus,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,grantedAt: freezed == grantedAt ? _self.grantedAt : grantedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardGrant].
extension RewardGrantPatterns on RewardGrant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardGrant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardGrant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardGrant value)  $default,){
final _that = this;
switch (_that) {
case _RewardGrant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardGrant value)?  $default,){
final _that = this;
switch (_that) {
case _RewardGrant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String grantId,  String rewardId,  String seasonId,  String userId,  RewardType type,  int amount,  GrantStatus status,  String? transactionId, @TimestampConverter()  DateTime? grantedAt, @TimestampConverter()  DateTime? claimedAt, @RequiredTimestampConverter()  DateTime createdAt, @RequiredTimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardGrant() when $default != null:
return $default(_that.grantId,_that.rewardId,_that.seasonId,_that.userId,_that.type,_that.amount,_that.status,_that.transactionId,_that.grantedAt,_that.claimedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String grantId,  String rewardId,  String seasonId,  String userId,  RewardType type,  int amount,  GrantStatus status,  String? transactionId, @TimestampConverter()  DateTime? grantedAt, @TimestampConverter()  DateTime? claimedAt, @RequiredTimestampConverter()  DateTime createdAt, @RequiredTimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RewardGrant():
return $default(_that.grantId,_that.rewardId,_that.seasonId,_that.userId,_that.type,_that.amount,_that.status,_that.transactionId,_that.grantedAt,_that.claimedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String grantId,  String rewardId,  String seasonId,  String userId,  RewardType type,  int amount,  GrantStatus status,  String? transactionId, @TimestampConverter()  DateTime? grantedAt, @TimestampConverter()  DateTime? claimedAt, @RequiredTimestampConverter()  DateTime createdAt, @RequiredTimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RewardGrant() when $default != null:
return $default(_that.grantId,_that.rewardId,_that.seasonId,_that.userId,_that.type,_that.amount,_that.status,_that.transactionId,_that.grantedAt,_that.claimedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardGrant implements RewardGrant {
  const _RewardGrant({required this.grantId, required this.rewardId, required this.seasonId, required this.userId, required this.type, required this.amount, required this.status, this.transactionId, @TimestampConverter() this.grantedAt, @TimestampConverter() this.claimedAt, @RequiredTimestampConverter() required this.createdAt, @RequiredTimestampConverter() required this.updatedAt});
  factory _RewardGrant.fromJson(Map<String, dynamic> json) => _$RewardGrantFromJson(json);

@override final  String grantId;
@override final  String rewardId;
@override final  String seasonId;
@override final  String userId;
@override final  RewardType type;
@override final  int amount;
@override final  GrantStatus status;
@override final  String? transactionId;
@override@TimestampConverter() final  DateTime? grantedAt;
@override@TimestampConverter() final  DateTime? claimedAt;
@override@RequiredTimestampConverter() final  DateTime createdAt;
@override@RequiredTimestampConverter() final  DateTime updatedAt;

/// Create a copy of RewardGrant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardGrantCopyWith<_RewardGrant> get copyWith => __$RewardGrantCopyWithImpl<_RewardGrant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardGrantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardGrant&&(identical(other.grantId, grantId) || other.grantId == grantId)&&(identical(other.rewardId, rewardId) || other.rewardId == rewardId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.grantedAt, grantedAt) || other.grantedAt == grantedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grantId,rewardId,seasonId,userId,type,amount,status,transactionId,grantedAt,claimedAt,createdAt,updatedAt);

@override
String toString() {
  return 'RewardGrant(grantId: $grantId, rewardId: $rewardId, seasonId: $seasonId, userId: $userId, type: $type, amount: $amount, status: $status, transactionId: $transactionId, grantedAt: $grantedAt, claimedAt: $claimedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RewardGrantCopyWith<$Res> implements $RewardGrantCopyWith<$Res> {
  factory _$RewardGrantCopyWith(_RewardGrant value, $Res Function(_RewardGrant) _then) = __$RewardGrantCopyWithImpl;
@override @useResult
$Res call({
 String grantId, String rewardId, String seasonId, String userId, RewardType type, int amount, GrantStatus status, String? transactionId,@TimestampConverter() DateTime? grantedAt,@TimestampConverter() DateTime? claimedAt,@RequiredTimestampConverter() DateTime createdAt,@RequiredTimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$RewardGrantCopyWithImpl<$Res>
    implements _$RewardGrantCopyWith<$Res> {
  __$RewardGrantCopyWithImpl(this._self, this._then);

  final _RewardGrant _self;
  final $Res Function(_RewardGrant) _then;

/// Create a copy of RewardGrant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grantId = null,Object? rewardId = null,Object? seasonId = null,Object? userId = null,Object? type = null,Object? amount = null,Object? status = null,Object? transactionId = freezed,Object? grantedAt = freezed,Object? claimedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RewardGrant(
grantId: null == grantId ? _self.grantId : grantId // ignore: cast_nullable_to_non_nullable
as String,rewardId: null == rewardId ? _self.rewardId : rewardId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RewardType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GrantStatus,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,grantedAt: freezed == grantedAt ? _self.grantedAt : grantedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
