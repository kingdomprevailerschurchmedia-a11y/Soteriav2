// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PurchaseRecord {

 String get purchaseId; String get userId; String get productId; String get storeProductId; String get platform;// 'ios' or 'android'
 String get platformTransactionId; String get purchaseType;// 'one_time' or 'subscription'
 PurchaseStatus get status; VerificationState get verificationState; DateTime get createdAt; DateTime? get processedAt; Map<String, dynamic> get metadata;
/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseRecordCopyWith<PurchaseRecord> get copyWith => _$PurchaseRecordCopyWithImpl<PurchaseRecord>(this as PurchaseRecord, _$identity);

  /// Serializes this PurchaseRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseRecord&&(identical(other.purchaseId, purchaseId) || other.purchaseId == purchaseId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.storeProductId, storeProductId) || other.storeProductId == storeProductId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.platformTransactionId, platformTransactionId) || other.platformTransactionId == platformTransactionId)&&(identical(other.purchaseType, purchaseType) || other.purchaseType == purchaseType)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationState, verificationState) || other.verificationState == verificationState)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purchaseId,userId,productId,storeProductId,platform,platformTransactionId,purchaseType,status,verificationState,createdAt,processedAt,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PurchaseRecord(purchaseId: $purchaseId, userId: $userId, productId: $productId, storeProductId: $storeProductId, platform: $platform, platformTransactionId: $platformTransactionId, purchaseType: $purchaseType, status: $status, verificationState: $verificationState, createdAt: $createdAt, processedAt: $processedAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PurchaseRecordCopyWith<$Res>  {
  factory $PurchaseRecordCopyWith(PurchaseRecord value, $Res Function(PurchaseRecord) _then) = _$PurchaseRecordCopyWithImpl;
@useResult
$Res call({
 String purchaseId, String userId, String productId, String storeProductId, String platform, String platformTransactionId, String purchaseType, PurchaseStatus status, VerificationState verificationState, DateTime createdAt, DateTime? processedAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$PurchaseRecordCopyWithImpl<$Res>
    implements $PurchaseRecordCopyWith<$Res> {
  _$PurchaseRecordCopyWithImpl(this._self, this._then);

  final PurchaseRecord _self;
  final $Res Function(PurchaseRecord) _then;

/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? purchaseId = null,Object? userId = null,Object? productId = null,Object? storeProductId = null,Object? platform = null,Object? platformTransactionId = null,Object? purchaseType = null,Object? status = null,Object? verificationState = null,Object? createdAt = null,Object? processedAt = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
purchaseId: null == purchaseId ? _self.purchaseId : purchaseId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,storeProductId: null == storeProductId ? _self.storeProductId : storeProductId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,platformTransactionId: null == platformTransactionId ? _self.platformTransactionId : platformTransactionId // ignore: cast_nullable_to_non_nullable
as String,purchaseType: null == purchaseType ? _self.purchaseType : purchaseType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PurchaseStatus,verificationState: null == verificationState ? _self.verificationState : verificationState // ignore: cast_nullable_to_non_nullable
as VerificationState,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseRecord].
extension PurchaseRecordPatterns on PurchaseRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseRecord value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String purchaseId,  String userId,  String productId,  String storeProductId,  String platform,  String platformTransactionId,  String purchaseType,  PurchaseStatus status,  VerificationState verificationState,  DateTime createdAt,  DateTime? processedAt,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
return $default(_that.purchaseId,_that.userId,_that.productId,_that.storeProductId,_that.platform,_that.platformTransactionId,_that.purchaseType,_that.status,_that.verificationState,_that.createdAt,_that.processedAt,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String purchaseId,  String userId,  String productId,  String storeProductId,  String platform,  String platformTransactionId,  String purchaseType,  PurchaseStatus status,  VerificationState verificationState,  DateTime createdAt,  DateTime? processedAt,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _PurchaseRecord():
return $default(_that.purchaseId,_that.userId,_that.productId,_that.storeProductId,_that.platform,_that.platformTransactionId,_that.purchaseType,_that.status,_that.verificationState,_that.createdAt,_that.processedAt,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String purchaseId,  String userId,  String productId,  String storeProductId,  String platform,  String platformTransactionId,  String purchaseType,  PurchaseStatus status,  VerificationState verificationState,  DateTime createdAt,  DateTime? processedAt,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
return $default(_that.purchaseId,_that.userId,_that.productId,_that.storeProductId,_that.platform,_that.platformTransactionId,_that.purchaseType,_that.status,_that.verificationState,_that.createdAt,_that.processedAt,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseRecord implements PurchaseRecord {
  const _PurchaseRecord({required this.purchaseId, required this.userId, required this.productId, required this.storeProductId, required this.platform, required this.platformTransactionId, required this.purchaseType, this.status = PurchaseStatus.pending, this.verificationState = VerificationState.unverified, required this.createdAt, this.processedAt, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _PurchaseRecord.fromJson(Map<String, dynamic> json) => _$PurchaseRecordFromJson(json);

@override final  String purchaseId;
@override final  String userId;
@override final  String productId;
@override final  String storeProductId;
@override final  String platform;
// 'ios' or 'android'
@override final  String platformTransactionId;
@override final  String purchaseType;
// 'one_time' or 'subscription'
@override@JsonKey() final  PurchaseStatus status;
@override@JsonKey() final  VerificationState verificationState;
@override final  DateTime createdAt;
@override final  DateTime? processedAt;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseRecordCopyWith<_PurchaseRecord> get copyWith => __$PurchaseRecordCopyWithImpl<_PurchaseRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseRecord&&(identical(other.purchaseId, purchaseId) || other.purchaseId == purchaseId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.storeProductId, storeProductId) || other.storeProductId == storeProductId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.platformTransactionId, platformTransactionId) || other.platformTransactionId == platformTransactionId)&&(identical(other.purchaseType, purchaseType) || other.purchaseType == purchaseType)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationState, verificationState) || other.verificationState == verificationState)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purchaseId,userId,productId,storeProductId,platform,platformTransactionId,purchaseType,status,verificationState,createdAt,processedAt,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'PurchaseRecord(purchaseId: $purchaseId, userId: $userId, productId: $productId, storeProductId: $storeProductId, platform: $platform, platformTransactionId: $platformTransactionId, purchaseType: $purchaseType, status: $status, verificationState: $verificationState, createdAt: $createdAt, processedAt: $processedAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PurchaseRecordCopyWith<$Res> implements $PurchaseRecordCopyWith<$Res> {
  factory _$PurchaseRecordCopyWith(_PurchaseRecord value, $Res Function(_PurchaseRecord) _then) = __$PurchaseRecordCopyWithImpl;
@override @useResult
$Res call({
 String purchaseId, String userId, String productId, String storeProductId, String platform, String platformTransactionId, String purchaseType, PurchaseStatus status, VerificationState verificationState, DateTime createdAt, DateTime? processedAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$PurchaseRecordCopyWithImpl<$Res>
    implements _$PurchaseRecordCopyWith<$Res> {
  __$PurchaseRecordCopyWithImpl(this._self, this._then);

  final _PurchaseRecord _self;
  final $Res Function(_PurchaseRecord) _then;

/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? purchaseId = null,Object? userId = null,Object? productId = null,Object? storeProductId = null,Object? platform = null,Object? platformTransactionId = null,Object? purchaseType = null,Object? status = null,Object? verificationState = null,Object? createdAt = null,Object? processedAt = freezed,Object? metadata = null,}) {
  return _then(_PurchaseRecord(
purchaseId: null == purchaseId ? _self.purchaseId : purchaseId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,storeProductId: null == storeProductId ? _self.storeProductId : storeProductId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,platformTransactionId: null == platformTransactionId ? _self.platformTransactionId : platformTransactionId // ignore: cast_nullable_to_non_nullable
as String,purchaseType: null == purchaseType ? _self.purchaseType : purchaseType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PurchaseStatus,verificationState: null == verificationState ? _self.verificationState : verificationState // ignore: cast_nullable_to_non_nullable
as VerificationState,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
