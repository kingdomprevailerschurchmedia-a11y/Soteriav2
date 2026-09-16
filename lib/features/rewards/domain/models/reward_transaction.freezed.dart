// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RewardTransaction {

 String get id; String get userId; RewardType get type;// Keep for backward compatibility with existing UI
 WalletTransactionType get transactionType; TransactionDirection get direction; int get amount; String get currency;// 'coins' or 'tokens'
 RewardSource get source; String? get referenceId; TransactionStatus get status; DateTime get createdAt; Map<String, dynamic> get metadata;
/// Create a copy of RewardTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardTransactionCopyWith<RewardTransaction> get copyWith => _$RewardTransactionCopyWithImpl<RewardTransaction>(this as RewardTransaction, _$identity);

  /// Serializes this RewardTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.source, source) || other.source == source)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,transactionType,direction,amount,currency,source,referenceId,status,createdAt,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'RewardTransaction(id: $id, userId: $userId, type: $type, transactionType: $transactionType, direction: $direction, amount: $amount, currency: $currency, source: $source, referenceId: $referenceId, status: $status, createdAt: $createdAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $RewardTransactionCopyWith<$Res>  {
  factory $RewardTransactionCopyWith(RewardTransaction value, $Res Function(RewardTransaction) _then) = _$RewardTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, RewardType type, WalletTransactionType transactionType, TransactionDirection direction, int amount, String currency, RewardSource source, String? referenceId, TransactionStatus status, DateTime createdAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$RewardTransactionCopyWithImpl<$Res>
    implements $RewardTransactionCopyWith<$Res> {
  _$RewardTransactionCopyWithImpl(this._self, this._then);

  final RewardTransaction _self;
  final $Res Function(RewardTransaction) _then;

/// Create a copy of RewardTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? transactionType = null,Object? direction = null,Object? amount = null,Object? currency = null,Object? source = null,Object? referenceId = freezed,Object? status = null,Object? createdAt = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RewardType,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as WalletTransactionType,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TransactionDirection,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RewardSource,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardTransaction].
extension RewardTransactionPatterns on RewardTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardTransaction value)  $default,){
final _that = this;
switch (_that) {
case _RewardTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _RewardTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  RewardType type,  WalletTransactionType transactionType,  TransactionDirection direction,  int amount,  String currency,  RewardSource source,  String? referenceId,  TransactionStatus status,  DateTime createdAt,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardTransaction() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.transactionType,_that.direction,_that.amount,_that.currency,_that.source,_that.referenceId,_that.status,_that.createdAt,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  RewardType type,  WalletTransactionType transactionType,  TransactionDirection direction,  int amount,  String currency,  RewardSource source,  String? referenceId,  TransactionStatus status,  DateTime createdAt,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _RewardTransaction():
return $default(_that.id,_that.userId,_that.type,_that.transactionType,_that.direction,_that.amount,_that.currency,_that.source,_that.referenceId,_that.status,_that.createdAt,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  RewardType type,  WalletTransactionType transactionType,  TransactionDirection direction,  int amount,  String currency,  RewardSource source,  String? referenceId,  TransactionStatus status,  DateTime createdAt,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _RewardTransaction() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.transactionType,_that.direction,_that.amount,_that.currency,_that.source,_that.referenceId,_that.status,_that.createdAt,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardTransaction implements RewardTransaction {
  const _RewardTransaction({required this.id, required this.userId, required this.type, required this.transactionType, required this.direction, required this.amount, this.currency = 'coins', required this.source, this.referenceId, this.status = TransactionStatus.completed, required this.createdAt, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _RewardTransaction.fromJson(Map<String, dynamic> json) => _$RewardTransactionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  RewardType type;
// Keep for backward compatibility with existing UI
@override final  WalletTransactionType transactionType;
@override final  TransactionDirection direction;
@override final  int amount;
@override@JsonKey() final  String currency;
// 'coins' or 'tokens'
@override final  RewardSource source;
@override final  String? referenceId;
@override@JsonKey() final  TransactionStatus status;
@override final  DateTime createdAt;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of RewardTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardTransactionCopyWith<_RewardTransaction> get copyWith => __$RewardTransactionCopyWithImpl<_RewardTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.source, source) || other.source == source)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,transactionType,direction,amount,currency,source,referenceId,status,createdAt,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'RewardTransaction(id: $id, userId: $userId, type: $type, transactionType: $transactionType, direction: $direction, amount: $amount, currency: $currency, source: $source, referenceId: $referenceId, status: $status, createdAt: $createdAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$RewardTransactionCopyWith<$Res> implements $RewardTransactionCopyWith<$Res> {
  factory _$RewardTransactionCopyWith(_RewardTransaction value, $Res Function(_RewardTransaction) _then) = __$RewardTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, RewardType type, WalletTransactionType transactionType, TransactionDirection direction, int amount, String currency, RewardSource source, String? referenceId, TransactionStatus status, DateTime createdAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$RewardTransactionCopyWithImpl<$Res>
    implements _$RewardTransactionCopyWith<$Res> {
  __$RewardTransactionCopyWithImpl(this._self, this._then);

  final _RewardTransaction _self;
  final $Res Function(_RewardTransaction) _then;

/// Create a copy of RewardTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? transactionType = null,Object? direction = null,Object? amount = null,Object? currency = null,Object? source = null,Object? referenceId = freezed,Object? status = null,Object? createdAt = null,Object? metadata = null,}) {
  return _then(_RewardTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RewardType,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as WalletTransactionType,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TransactionDirection,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RewardSource,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
