// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xp_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$XpTransaction {

 String get transactionId; String get userId; int get amount; XpSource get source; String get referenceId;@RequiredTimestampConverter() DateTime get createdAt; int get schemaVersion;
/// Create a copy of XpTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$XpTransactionCopyWith<XpTransaction> get copyWith => _$XpTransactionCopyWithImpl<XpTransaction>(this as XpTransaction, _$identity);

  /// Serializes this XpTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is XpTransaction&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.source, source) || other.source == source)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,amount,source,referenceId,createdAt,schemaVersion);

@override
String toString() {
  return 'XpTransaction(transactionId: $transactionId, userId: $userId, amount: $amount, source: $source, referenceId: $referenceId, createdAt: $createdAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $XpTransactionCopyWith<$Res>  {
  factory $XpTransactionCopyWith(XpTransaction value, $Res Function(XpTransaction) _then) = _$XpTransactionCopyWithImpl;
@useResult
$Res call({
 String transactionId, String userId, int amount, XpSource source, String referenceId,@RequiredTimestampConverter() DateTime createdAt, int schemaVersion
});




}
/// @nodoc
class _$XpTransactionCopyWithImpl<$Res>
    implements $XpTransactionCopyWith<$Res> {
  _$XpTransactionCopyWithImpl(this._self, this._then);

  final XpTransaction _self;
  final $Res Function(XpTransaction) _then;

/// Create a copy of XpTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? userId = null,Object? amount = null,Object? source = null,Object? referenceId = null,Object? createdAt = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as XpSource,referenceId: null == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [XpTransaction].
extension XpTransactionPatterns on XpTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _XpTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _XpTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _XpTransaction value)  $default,){
final _that = this;
switch (_that) {
case _XpTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _XpTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _XpTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transactionId,  String userId,  int amount,  XpSource source,  String referenceId, @RequiredTimestampConverter()  DateTime createdAt,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _XpTransaction() when $default != null:
return $default(_that.transactionId,_that.userId,_that.amount,_that.source,_that.referenceId,_that.createdAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transactionId,  String userId,  int amount,  XpSource source,  String referenceId, @RequiredTimestampConverter()  DateTime createdAt,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _XpTransaction():
return $default(_that.transactionId,_that.userId,_that.amount,_that.source,_that.referenceId,_that.createdAt,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transactionId,  String userId,  int amount,  XpSource source,  String referenceId, @RequiredTimestampConverter()  DateTime createdAt,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _XpTransaction() when $default != null:
return $default(_that.transactionId,_that.userId,_that.amount,_that.source,_that.referenceId,_that.createdAt,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _XpTransaction implements XpTransaction {
  const _XpTransaction({required this.transactionId, required this.userId, required this.amount, required this.source, required this.referenceId, @RequiredTimestampConverter() required this.createdAt, this.schemaVersion = 1});
  factory _XpTransaction.fromJson(Map<String, dynamic> json) => _$XpTransactionFromJson(json);

@override final  String transactionId;
@override final  String userId;
@override final  int amount;
@override final  XpSource source;
@override final  String referenceId;
@override@RequiredTimestampConverter() final  DateTime createdAt;
@override@JsonKey() final  int schemaVersion;

/// Create a copy of XpTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$XpTransactionCopyWith<_XpTransaction> get copyWith => __$XpTransactionCopyWithImpl<_XpTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$XpTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _XpTransaction&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.source, source) || other.source == source)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,amount,source,referenceId,createdAt,schemaVersion);

@override
String toString() {
  return 'XpTransaction(transactionId: $transactionId, userId: $userId, amount: $amount, source: $source, referenceId: $referenceId, createdAt: $createdAt, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$XpTransactionCopyWith<$Res> implements $XpTransactionCopyWith<$Res> {
  factory _$XpTransactionCopyWith(_XpTransaction value, $Res Function(_XpTransaction) _then) = __$XpTransactionCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, String userId, int amount, XpSource source, String referenceId,@RequiredTimestampConverter() DateTime createdAt, int schemaVersion
});




}
/// @nodoc
class __$XpTransactionCopyWithImpl<$Res>
    implements _$XpTransactionCopyWith<$Res> {
  __$XpTransactionCopyWithImpl(this._self, this._then);

  final _XpTransaction _self;
  final $Res Function(_XpTransaction) _then;

/// Create a copy of XpTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? userId = null,Object? amount = null,Object? source = null,Object? referenceId = null,Object? createdAt = null,Object? schemaVersion = null,}) {
  return _then(_XpTransaction(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as XpSource,referenceId: null == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
