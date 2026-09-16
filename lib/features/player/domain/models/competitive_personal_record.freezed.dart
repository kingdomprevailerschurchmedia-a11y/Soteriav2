// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_personal_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitivePersonalRecord {

 String get id; String get userId; CompetitiveRecordType get type; double get value; String get displayValue; String? get matchId; String? get seasonId; String? get mode; DateTime get achievedAt; double? get previousValue; bool get isCareerRecord;
/// Create a copy of CompetitivePersonalRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitivePersonalRecordCopyWith<CompetitivePersonalRecord> get copyWith => _$CompetitivePersonalRecordCopyWithImpl<CompetitivePersonalRecord>(this as CompetitivePersonalRecord, _$identity);

  /// Serializes this CompetitivePersonalRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitivePersonalRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt)&&(identical(other.previousValue, previousValue) || other.previousValue == previousValue)&&(identical(other.isCareerRecord, isCareerRecord) || other.isCareerRecord == isCareerRecord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,value,displayValue,matchId,seasonId,mode,achievedAt,previousValue,isCareerRecord);

@override
String toString() {
  return 'CompetitivePersonalRecord(id: $id, userId: $userId, type: $type, value: $value, displayValue: $displayValue, matchId: $matchId, seasonId: $seasonId, mode: $mode, achievedAt: $achievedAt, previousValue: $previousValue, isCareerRecord: $isCareerRecord)';
}


}

/// @nodoc
abstract mixin class $CompetitivePersonalRecordCopyWith<$Res>  {
  factory $CompetitivePersonalRecordCopyWith(CompetitivePersonalRecord value, $Res Function(CompetitivePersonalRecord) _then) = _$CompetitivePersonalRecordCopyWithImpl;
@useResult
$Res call({
 String id, String userId, CompetitiveRecordType type, double value, String displayValue, String? matchId, String? seasonId, String? mode, DateTime achievedAt, double? previousValue, bool isCareerRecord
});




}
/// @nodoc
class _$CompetitivePersonalRecordCopyWithImpl<$Res>
    implements $CompetitivePersonalRecordCopyWith<$Res> {
  _$CompetitivePersonalRecordCopyWithImpl(this._self, this._then);

  final CompetitivePersonalRecord _self;
  final $Res Function(CompetitivePersonalRecord) _then;

/// Create a copy of CompetitivePersonalRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? value = null,Object? displayValue = null,Object? matchId = freezed,Object? seasonId = freezed,Object? mode = freezed,Object? achievedAt = null,Object? previousValue = freezed,Object? isCareerRecord = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CompetitiveRecordType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,matchId: freezed == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String?,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,previousValue: freezed == previousValue ? _self.previousValue : previousValue // ignore: cast_nullable_to_non_nullable
as double?,isCareerRecord: null == isCareerRecord ? _self.isCareerRecord : isCareerRecord // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitivePersonalRecord].
extension CompetitivePersonalRecordPatterns on CompetitivePersonalRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitivePersonalRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitivePersonalRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitivePersonalRecord value)  $default,){
final _that = this;
switch (_that) {
case _CompetitivePersonalRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitivePersonalRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitivePersonalRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  CompetitiveRecordType type,  double value,  String displayValue,  String? matchId,  String? seasonId,  String? mode,  DateTime achievedAt,  double? previousValue,  bool isCareerRecord)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitivePersonalRecord() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.value,_that.displayValue,_that.matchId,_that.seasonId,_that.mode,_that.achievedAt,_that.previousValue,_that.isCareerRecord);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  CompetitiveRecordType type,  double value,  String displayValue,  String? matchId,  String? seasonId,  String? mode,  DateTime achievedAt,  double? previousValue,  bool isCareerRecord)  $default,) {final _that = this;
switch (_that) {
case _CompetitivePersonalRecord():
return $default(_that.id,_that.userId,_that.type,_that.value,_that.displayValue,_that.matchId,_that.seasonId,_that.mode,_that.achievedAt,_that.previousValue,_that.isCareerRecord);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  CompetitiveRecordType type,  double value,  String displayValue,  String? matchId,  String? seasonId,  String? mode,  DateTime achievedAt,  double? previousValue,  bool isCareerRecord)?  $default,) {final _that = this;
switch (_that) {
case _CompetitivePersonalRecord() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.value,_that.displayValue,_that.matchId,_that.seasonId,_that.mode,_that.achievedAt,_that.previousValue,_that.isCareerRecord);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitivePersonalRecord implements CompetitivePersonalRecord {
  const _CompetitivePersonalRecord({required this.id, required this.userId, required this.type, required this.value, required this.displayValue, this.matchId, this.seasonId, this.mode, required this.achievedAt, this.previousValue, this.isCareerRecord = false});
  factory _CompetitivePersonalRecord.fromJson(Map<String, dynamic> json) => _$CompetitivePersonalRecordFromJson(json);

@override final  String id;
@override final  String userId;
@override final  CompetitiveRecordType type;
@override final  double value;
@override final  String displayValue;
@override final  String? matchId;
@override final  String? seasonId;
@override final  String? mode;
@override final  DateTime achievedAt;
@override final  double? previousValue;
@override@JsonKey() final  bool isCareerRecord;

/// Create a copy of CompetitivePersonalRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitivePersonalRecordCopyWith<_CompetitivePersonalRecord> get copyWith => __$CompetitivePersonalRecordCopyWithImpl<_CompetitivePersonalRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitivePersonalRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitivePersonalRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt)&&(identical(other.previousValue, previousValue) || other.previousValue == previousValue)&&(identical(other.isCareerRecord, isCareerRecord) || other.isCareerRecord == isCareerRecord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,value,displayValue,matchId,seasonId,mode,achievedAt,previousValue,isCareerRecord);

@override
String toString() {
  return 'CompetitivePersonalRecord(id: $id, userId: $userId, type: $type, value: $value, displayValue: $displayValue, matchId: $matchId, seasonId: $seasonId, mode: $mode, achievedAt: $achievedAt, previousValue: $previousValue, isCareerRecord: $isCareerRecord)';
}


}

/// @nodoc
abstract mixin class _$CompetitivePersonalRecordCopyWith<$Res> implements $CompetitivePersonalRecordCopyWith<$Res> {
  factory _$CompetitivePersonalRecordCopyWith(_CompetitivePersonalRecord value, $Res Function(_CompetitivePersonalRecord) _then) = __$CompetitivePersonalRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, CompetitiveRecordType type, double value, String displayValue, String? matchId, String? seasonId, String? mode, DateTime achievedAt, double? previousValue, bool isCareerRecord
});




}
/// @nodoc
class __$CompetitivePersonalRecordCopyWithImpl<$Res>
    implements _$CompetitivePersonalRecordCopyWith<$Res> {
  __$CompetitivePersonalRecordCopyWithImpl(this._self, this._then);

  final _CompetitivePersonalRecord _self;
  final $Res Function(_CompetitivePersonalRecord) _then;

/// Create a copy of CompetitivePersonalRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? value = null,Object? displayValue = null,Object? matchId = freezed,Object? seasonId = freezed,Object? mode = freezed,Object? achievedAt = null,Object? previousValue = freezed,Object? isCareerRecord = null,}) {
  return _then(_CompetitivePersonalRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CompetitiveRecordType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,displayValue: null == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String,matchId: freezed == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String?,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,previousValue: freezed == previousValue ? _self.previousValue : previousValue // ignore: cast_nullable_to_non_nullable
as double?,isCareerRecord: null == isCareerRecord ? _self.isCareerRecord : isCareerRecord // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
