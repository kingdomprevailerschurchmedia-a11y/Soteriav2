// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_up_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PowerUpUsage {

 String get usageId; PowerUpType get type; String get sessionId; int get roundIndex; String get questionId; DateTime get activatedAt; Map<String, dynamic> get result; Duration? get duration;
/// Create a copy of PowerUpUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PowerUpUsageCopyWith<PowerUpUsage> get copyWith => _$PowerUpUsageCopyWithImpl<PowerUpUsage>(this as PowerUpUsage, _$identity);

  /// Serializes this PowerUpUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PowerUpUsage&&(identical(other.usageId, usageId) || other.usageId == usageId)&&(identical(other.type, type) || other.type == type)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.roundIndex, roundIndex) || other.roundIndex == roundIndex)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usageId,type,sessionId,roundIndex,questionId,activatedAt,const DeepCollectionEquality().hash(result),duration);

@override
String toString() {
  return 'PowerUpUsage(usageId: $usageId, type: $type, sessionId: $sessionId, roundIndex: $roundIndex, questionId: $questionId, activatedAt: $activatedAt, result: $result, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $PowerUpUsageCopyWith<$Res>  {
  factory $PowerUpUsageCopyWith(PowerUpUsage value, $Res Function(PowerUpUsage) _then) = _$PowerUpUsageCopyWithImpl;
@useResult
$Res call({
 String usageId, PowerUpType type, String sessionId, int roundIndex, String questionId, DateTime activatedAt, Map<String, dynamic> result, Duration? duration
});




}
/// @nodoc
class _$PowerUpUsageCopyWithImpl<$Res>
    implements $PowerUpUsageCopyWith<$Res> {
  _$PowerUpUsageCopyWithImpl(this._self, this._then);

  final PowerUpUsage _self;
  final $Res Function(PowerUpUsage) _then;

/// Create a copy of PowerUpUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? usageId = null,Object? type = null,Object? sessionId = null,Object? roundIndex = null,Object? questionId = null,Object? activatedAt = null,Object? result = null,Object? duration = freezed,}) {
  return _then(_self.copyWith(
usageId: null == usageId ? _self.usageId : usageId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PowerUpType,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,roundIndex: null == roundIndex ? _self.roundIndex : roundIndex // ignore: cast_nullable_to_non_nullable
as int,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,activatedAt: null == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [PowerUpUsage].
extension PowerUpUsagePatterns on PowerUpUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PowerUpUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PowerUpUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PowerUpUsage value)  $default,){
final _that = this;
switch (_that) {
case _PowerUpUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PowerUpUsage value)?  $default,){
final _that = this;
switch (_that) {
case _PowerUpUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String usageId,  PowerUpType type,  String sessionId,  int roundIndex,  String questionId,  DateTime activatedAt,  Map<String, dynamic> result,  Duration? duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PowerUpUsage() when $default != null:
return $default(_that.usageId,_that.type,_that.sessionId,_that.roundIndex,_that.questionId,_that.activatedAt,_that.result,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String usageId,  PowerUpType type,  String sessionId,  int roundIndex,  String questionId,  DateTime activatedAt,  Map<String, dynamic> result,  Duration? duration)  $default,) {final _that = this;
switch (_that) {
case _PowerUpUsage():
return $default(_that.usageId,_that.type,_that.sessionId,_that.roundIndex,_that.questionId,_that.activatedAt,_that.result,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String usageId,  PowerUpType type,  String sessionId,  int roundIndex,  String questionId,  DateTime activatedAt,  Map<String, dynamic> result,  Duration? duration)?  $default,) {final _that = this;
switch (_that) {
case _PowerUpUsage() when $default != null:
return $default(_that.usageId,_that.type,_that.sessionId,_that.roundIndex,_that.questionId,_that.activatedAt,_that.result,_that.duration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PowerUpUsage implements PowerUpUsage {
  const _PowerUpUsage({required this.usageId, required this.type, required this.sessionId, required this.roundIndex, required this.questionId, required this.activatedAt, final  Map<String, dynamic> result = const {}, this.duration}): _result = result;
  factory _PowerUpUsage.fromJson(Map<String, dynamic> json) => _$PowerUpUsageFromJson(json);

@override final  String usageId;
@override final  PowerUpType type;
@override final  String sessionId;
@override final  int roundIndex;
@override final  String questionId;
@override final  DateTime activatedAt;
 final  Map<String, dynamic> _result;
@override@JsonKey() Map<String, dynamic> get result {
  if (_result is EqualUnmodifiableMapView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_result);
}

@override final  Duration? duration;

/// Create a copy of PowerUpUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PowerUpUsageCopyWith<_PowerUpUsage> get copyWith => __$PowerUpUsageCopyWithImpl<_PowerUpUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PowerUpUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PowerUpUsage&&(identical(other.usageId, usageId) || other.usageId == usageId)&&(identical(other.type, type) || other.type == type)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.roundIndex, roundIndex) || other.roundIndex == roundIndex)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&const DeepCollectionEquality().equals(other._result, _result)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usageId,type,sessionId,roundIndex,questionId,activatedAt,const DeepCollectionEquality().hash(_result),duration);

@override
String toString() {
  return 'PowerUpUsage(usageId: $usageId, type: $type, sessionId: $sessionId, roundIndex: $roundIndex, questionId: $questionId, activatedAt: $activatedAt, result: $result, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$PowerUpUsageCopyWith<$Res> implements $PowerUpUsageCopyWith<$Res> {
  factory _$PowerUpUsageCopyWith(_PowerUpUsage value, $Res Function(_PowerUpUsage) _then) = __$PowerUpUsageCopyWithImpl;
@override @useResult
$Res call({
 String usageId, PowerUpType type, String sessionId, int roundIndex, String questionId, DateTime activatedAt, Map<String, dynamic> result, Duration? duration
});




}
/// @nodoc
class __$PowerUpUsageCopyWithImpl<$Res>
    implements _$PowerUpUsageCopyWith<$Res> {
  __$PowerUpUsageCopyWithImpl(this._self, this._then);

  final _PowerUpUsage _self;
  final $Res Function(_PowerUpUsage) _then;

/// Create a copy of PowerUpUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? usageId = null,Object? type = null,Object? sessionId = null,Object? roundIndex = null,Object? questionId = null,Object? activatedAt = null,Object? result = null,Object? duration = freezed,}) {
  return _then(_PowerUpUsage(
usageId: null == usageId ? _self.usageId : usageId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PowerUpType,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,roundIndex: null == roundIndex ? _self.roundIndex : roundIndex // ignore: cast_nullable_to_non_nullable
as int,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,activatedAt: null == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,result: null == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
