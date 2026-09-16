// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_engagement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyEngagement {

 String get playerId;@EngagementDateConverter() String get engagementDate;// Format: YYYY-MM-DD
 bool get qualified; String get qualifyingActivityType;// e.g., 'practice', 'versus', 'daily_challenge'
 String get qualifyingActivityId;@RequiredTimestampConverter() DateTime get firstQualifiedActivityAt;@RequiredTimestampConverter() DateTime get createdAt;
/// Create a copy of DailyEngagement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyEngagementCopyWith<DailyEngagement> get copyWith => _$DailyEngagementCopyWithImpl<DailyEngagement>(this as DailyEngagement, _$identity);

  /// Serializes this DailyEngagement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyEngagement&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.engagementDate, engagementDate) || other.engagementDate == engagementDate)&&(identical(other.qualified, qualified) || other.qualified == qualified)&&(identical(other.qualifyingActivityType, qualifyingActivityType) || other.qualifyingActivityType == qualifyingActivityType)&&(identical(other.qualifyingActivityId, qualifyingActivityId) || other.qualifyingActivityId == qualifyingActivityId)&&(identical(other.firstQualifiedActivityAt, firstQualifiedActivityAt) || other.firstQualifiedActivityAt == firstQualifiedActivityAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,engagementDate,qualified,qualifyingActivityType,qualifyingActivityId,firstQualifiedActivityAt,createdAt);

@override
String toString() {
  return 'DailyEngagement(playerId: $playerId, engagementDate: $engagementDate, qualified: $qualified, qualifyingActivityType: $qualifyingActivityType, qualifyingActivityId: $qualifyingActivityId, firstQualifiedActivityAt: $firstQualifiedActivityAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DailyEngagementCopyWith<$Res>  {
  factory $DailyEngagementCopyWith(DailyEngagement value, $Res Function(DailyEngagement) _then) = _$DailyEngagementCopyWithImpl;
@useResult
$Res call({
 String playerId,@EngagementDateConverter() String engagementDate, bool qualified, String qualifyingActivityType, String qualifyingActivityId,@RequiredTimestampConverter() DateTime firstQualifiedActivityAt,@RequiredTimestampConverter() DateTime createdAt
});




}
/// @nodoc
class _$DailyEngagementCopyWithImpl<$Res>
    implements $DailyEngagementCopyWith<$Res> {
  _$DailyEngagementCopyWithImpl(this._self, this._then);

  final DailyEngagement _self;
  final $Res Function(DailyEngagement) _then;

/// Create a copy of DailyEngagement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? engagementDate = null,Object? qualified = null,Object? qualifyingActivityType = null,Object? qualifyingActivityId = null,Object? firstQualifiedActivityAt = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,engagementDate: null == engagementDate ? _self.engagementDate : engagementDate // ignore: cast_nullable_to_non_nullable
as String,qualified: null == qualified ? _self.qualified : qualified // ignore: cast_nullable_to_non_nullable
as bool,qualifyingActivityType: null == qualifyingActivityType ? _self.qualifyingActivityType : qualifyingActivityType // ignore: cast_nullable_to_non_nullable
as String,qualifyingActivityId: null == qualifyingActivityId ? _self.qualifyingActivityId : qualifyingActivityId // ignore: cast_nullable_to_non_nullable
as String,firstQualifiedActivityAt: null == firstQualifiedActivityAt ? _self.firstQualifiedActivityAt : firstQualifiedActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyEngagement].
extension DailyEngagementPatterns on DailyEngagement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyEngagement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyEngagement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyEngagement value)  $default,){
final _that = this;
switch (_that) {
case _DailyEngagement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyEngagement value)?  $default,){
final _that = this;
switch (_that) {
case _DailyEngagement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId, @EngagementDateConverter()  String engagementDate,  bool qualified,  String qualifyingActivityType,  String qualifyingActivityId, @RequiredTimestampConverter()  DateTime firstQualifiedActivityAt, @RequiredTimestampConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyEngagement() when $default != null:
return $default(_that.playerId,_that.engagementDate,_that.qualified,_that.qualifyingActivityType,_that.qualifyingActivityId,_that.firstQualifiedActivityAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId, @EngagementDateConverter()  String engagementDate,  bool qualified,  String qualifyingActivityType,  String qualifyingActivityId, @RequiredTimestampConverter()  DateTime firstQualifiedActivityAt, @RequiredTimestampConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _DailyEngagement():
return $default(_that.playerId,_that.engagementDate,_that.qualified,_that.qualifyingActivityType,_that.qualifyingActivityId,_that.firstQualifiedActivityAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId, @EngagementDateConverter()  String engagementDate,  bool qualified,  String qualifyingActivityType,  String qualifyingActivityId, @RequiredTimestampConverter()  DateTime firstQualifiedActivityAt, @RequiredTimestampConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DailyEngagement() when $default != null:
return $default(_that.playerId,_that.engagementDate,_that.qualified,_that.qualifyingActivityType,_that.qualifyingActivityId,_that.firstQualifiedActivityAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyEngagement implements DailyEngagement {
  const _DailyEngagement({required this.playerId, @EngagementDateConverter() required this.engagementDate, this.qualified = true, required this.qualifyingActivityType, required this.qualifyingActivityId, @RequiredTimestampConverter() required this.firstQualifiedActivityAt, @RequiredTimestampConverter() required this.createdAt});
  factory _DailyEngagement.fromJson(Map<String, dynamic> json) => _$DailyEngagementFromJson(json);

@override final  String playerId;
@override@EngagementDateConverter() final  String engagementDate;
// Format: YYYY-MM-DD
@override@JsonKey() final  bool qualified;
@override final  String qualifyingActivityType;
// e.g., 'practice', 'versus', 'daily_challenge'
@override final  String qualifyingActivityId;
@override@RequiredTimestampConverter() final  DateTime firstQualifiedActivityAt;
@override@RequiredTimestampConverter() final  DateTime createdAt;

/// Create a copy of DailyEngagement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyEngagementCopyWith<_DailyEngagement> get copyWith => __$DailyEngagementCopyWithImpl<_DailyEngagement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyEngagementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyEngagement&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.engagementDate, engagementDate) || other.engagementDate == engagementDate)&&(identical(other.qualified, qualified) || other.qualified == qualified)&&(identical(other.qualifyingActivityType, qualifyingActivityType) || other.qualifyingActivityType == qualifyingActivityType)&&(identical(other.qualifyingActivityId, qualifyingActivityId) || other.qualifyingActivityId == qualifyingActivityId)&&(identical(other.firstQualifiedActivityAt, firstQualifiedActivityAt) || other.firstQualifiedActivityAt == firstQualifiedActivityAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,engagementDate,qualified,qualifyingActivityType,qualifyingActivityId,firstQualifiedActivityAt,createdAt);

@override
String toString() {
  return 'DailyEngagement(playerId: $playerId, engagementDate: $engagementDate, qualified: $qualified, qualifyingActivityType: $qualifyingActivityType, qualifyingActivityId: $qualifyingActivityId, firstQualifiedActivityAt: $firstQualifiedActivityAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DailyEngagementCopyWith<$Res> implements $DailyEngagementCopyWith<$Res> {
  factory _$DailyEngagementCopyWith(_DailyEngagement value, $Res Function(_DailyEngagement) _then) = __$DailyEngagementCopyWithImpl;
@override @useResult
$Res call({
 String playerId,@EngagementDateConverter() String engagementDate, bool qualified, String qualifyingActivityType, String qualifyingActivityId,@RequiredTimestampConverter() DateTime firstQualifiedActivityAt,@RequiredTimestampConverter() DateTime createdAt
});




}
/// @nodoc
class __$DailyEngagementCopyWithImpl<$Res>
    implements _$DailyEngagementCopyWith<$Res> {
  __$DailyEngagementCopyWithImpl(this._self, this._then);

  final _DailyEngagement _self;
  final $Res Function(_DailyEngagement) _then;

/// Create a copy of DailyEngagement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? engagementDate = null,Object? qualified = null,Object? qualifyingActivityType = null,Object? qualifyingActivityId = null,Object? firstQualifiedActivityAt = null,Object? createdAt = null,}) {
  return _then(_DailyEngagement(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,engagementDate: null == engagementDate ? _self.engagementDate : engagementDate // ignore: cast_nullable_to_non_nullable
as String,qualified: null == qualified ? _self.qualified : qualified // ignore: cast_nullable_to_non_nullable
as bool,qualifyingActivityType: null == qualifyingActivityType ? _self.qualifyingActivityType : qualifyingActivityType // ignore: cast_nullable_to_non_nullable
as String,qualifyingActivityId: null == qualifyingActivityId ? _self.qualifyingActivityId : qualifyingActivityId // ignore: cast_nullable_to_non_nullable
as String,firstQualifiedActivityAt: null == firstQualifiedActivityAt ? _self.firstQualifiedActivityAt : firstQualifiedActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
