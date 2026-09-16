// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankTransaction {

 String get transactionId; String get userId; String get seasonId; String get resultId; int get previousRankPoints; int get changeAmount; int get newRankPoints;@RequiredTimestampConverter() DateTime get timestamp; int get schemaVersion;
/// Create a copy of RankTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankTransactionCopyWith<RankTransaction> get copyWith => _$RankTransactionCopyWithImpl<RankTransaction>(this as RankTransaction, _$identity);

  /// Serializes this RankTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankTransaction&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.resultId, resultId) || other.resultId == resultId)&&(identical(other.previousRankPoints, previousRankPoints) || other.previousRankPoints == previousRankPoints)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.newRankPoints, newRankPoints) || other.newRankPoints == newRankPoints)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,seasonId,resultId,previousRankPoints,changeAmount,newRankPoints,timestamp,schemaVersion);

@override
String toString() {
  return 'RankTransaction(transactionId: $transactionId, userId: $userId, seasonId: $seasonId, resultId: $resultId, previousRankPoints: $previousRankPoints, changeAmount: $changeAmount, newRankPoints: $newRankPoints, timestamp: $timestamp, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $RankTransactionCopyWith<$Res>  {
  factory $RankTransactionCopyWith(RankTransaction value, $Res Function(RankTransaction) _then) = _$RankTransactionCopyWithImpl;
@useResult
$Res call({
 String transactionId, String userId, String seasonId, String resultId, int previousRankPoints, int changeAmount, int newRankPoints,@RequiredTimestampConverter() DateTime timestamp, int schemaVersion
});




}
/// @nodoc
class _$RankTransactionCopyWithImpl<$Res>
    implements $RankTransactionCopyWith<$Res> {
  _$RankTransactionCopyWithImpl(this._self, this._then);

  final RankTransaction _self;
  final $Res Function(RankTransaction) _then;

/// Create a copy of RankTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? userId = null,Object? seasonId = null,Object? resultId = null,Object? previousRankPoints = null,Object? changeAmount = null,Object? newRankPoints = null,Object? timestamp = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,resultId: null == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String,previousRankPoints: null == previousRankPoints ? _self.previousRankPoints : previousRankPoints // ignore: cast_nullable_to_non_nullable
as int,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as int,newRankPoints: null == newRankPoints ? _self.newRankPoints : newRankPoints // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RankTransaction].
extension RankTransactionPatterns on RankTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankTransaction value)  $default,){
final _that = this;
switch (_that) {
case _RankTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _RankTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transactionId,  String userId,  String seasonId,  String resultId,  int previousRankPoints,  int changeAmount,  int newRankPoints, @RequiredTimestampConverter()  DateTime timestamp,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankTransaction() when $default != null:
return $default(_that.transactionId,_that.userId,_that.seasonId,_that.resultId,_that.previousRankPoints,_that.changeAmount,_that.newRankPoints,_that.timestamp,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transactionId,  String userId,  String seasonId,  String resultId,  int previousRankPoints,  int changeAmount,  int newRankPoints, @RequiredTimestampConverter()  DateTime timestamp,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _RankTransaction():
return $default(_that.transactionId,_that.userId,_that.seasonId,_that.resultId,_that.previousRankPoints,_that.changeAmount,_that.newRankPoints,_that.timestamp,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transactionId,  String userId,  String seasonId,  String resultId,  int previousRankPoints,  int changeAmount,  int newRankPoints, @RequiredTimestampConverter()  DateTime timestamp,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _RankTransaction() when $default != null:
return $default(_that.transactionId,_that.userId,_that.seasonId,_that.resultId,_that.previousRankPoints,_that.changeAmount,_that.newRankPoints,_that.timestamp,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankTransaction implements RankTransaction {
  const _RankTransaction({required this.transactionId, required this.userId, required this.seasonId, required this.resultId, required this.previousRankPoints, required this.changeAmount, required this.newRankPoints, @RequiredTimestampConverter() required this.timestamp, this.schemaVersion = 1});
  factory _RankTransaction.fromJson(Map<String, dynamic> json) => _$RankTransactionFromJson(json);

@override final  String transactionId;
@override final  String userId;
@override final  String seasonId;
@override final  String resultId;
@override final  int previousRankPoints;
@override final  int changeAmount;
@override final  int newRankPoints;
@override@RequiredTimestampConverter() final  DateTime timestamp;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of RankTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankTransactionCopyWith<_RankTransaction> get copyWith => __$RankTransactionCopyWithImpl<_RankTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankTransaction&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.resultId, resultId) || other.resultId == resultId)&&(identical(other.previousRankPoints, previousRankPoints) || other.previousRankPoints == previousRankPoints)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.newRankPoints, newRankPoints) || other.newRankPoints == newRankPoints)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,seasonId,resultId,previousRankPoints,changeAmount,newRankPoints,timestamp,schemaVersion);

@override
String toString() {
  return 'RankTransaction(transactionId: $transactionId, userId: $userId, seasonId: $seasonId, resultId: $resultId, previousRankPoints: $previousRankPoints, changeAmount: $changeAmount, newRankPoints: $newRankPoints, timestamp: $timestamp, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$RankTransactionCopyWith<$Res> implements $RankTransactionCopyWith<$Res> {
  factory _$RankTransactionCopyWith(_RankTransaction value, $Res Function(_RankTransaction) _then) = __$RankTransactionCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, String userId, String seasonId, String resultId, int previousRankPoints, int changeAmount, int newRankPoints,@RequiredTimestampConverter() DateTime timestamp, int schemaVersion
});




}
/// @nodoc
class __$RankTransactionCopyWithImpl<$Res>
    implements _$RankTransactionCopyWith<$Res> {
  __$RankTransactionCopyWithImpl(this._self, this._then);

  final _RankTransaction _self;
  final $Res Function(_RankTransaction) _then;

/// Create a copy of RankTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? userId = null,Object? seasonId = null,Object? resultId = null,Object? previousRankPoints = null,Object? changeAmount = null,Object? newRankPoints = null,Object? timestamp = null,Object? schemaVersion = null,}) {
  return _then(_RankTransaction(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,resultId: null == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String,previousRankPoints: null == previousRankPoints ? _self.previousRankPoints : previousRankPoints // ignore: cast_nullable_to_non_nullable
as int,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as int,newRankPoints: null == newRankPoints ? _self.newRankPoints : newRankPoints // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
