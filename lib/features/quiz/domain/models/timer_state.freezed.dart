// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimerState {

 Duration get totalDuration; Duration get remainingTime; double get progress; bool get isPaused; bool get isRunning; bool get hasExpired; TimerStatus get status; DateTime? get deadline; bool get isWarning; bool get isCritical;
/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerStateCopyWith<TimerState> get copyWith => _$TimerStateCopyWithImpl<TimerState>(this as TimerState, _$identity);

  /// Serializes this TimerState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerState&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration)&&(identical(other.remainingTime, remainingTime) || other.remainingTime == remainingTime)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.hasExpired, hasExpired) || other.hasExpired == hasExpired)&&(identical(other.status, status) || other.status == status)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isCritical, isCritical) || other.isCritical == isCritical));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDuration,remainingTime,progress,isPaused,isRunning,hasExpired,status,deadline,isWarning,isCritical);

@override
String toString() {
  return 'TimerState(totalDuration: $totalDuration, remainingTime: $remainingTime, progress: $progress, isPaused: $isPaused, isRunning: $isRunning, hasExpired: $hasExpired, status: $status, deadline: $deadline, isWarning: $isWarning, isCritical: $isCritical)';
}


}

/// @nodoc
abstract mixin class $TimerStateCopyWith<$Res>  {
  factory $TimerStateCopyWith(TimerState value, $Res Function(TimerState) _then) = _$TimerStateCopyWithImpl;
@useResult
$Res call({
 Duration totalDuration, Duration remainingTime, double progress, bool isPaused, bool isRunning, bool hasExpired, TimerStatus status, DateTime? deadline, bool isWarning, bool isCritical
});




}
/// @nodoc
class _$TimerStateCopyWithImpl<$Res>
    implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._self, this._then);

  final TimerState _self;
  final $Res Function(TimerState) _then;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDuration = null,Object? remainingTime = null,Object? progress = null,Object? isPaused = null,Object? isRunning = null,Object? hasExpired = null,Object? status = null,Object? deadline = freezed,Object? isWarning = null,Object? isCritical = null,}) {
  return _then(_self.copyWith(
totalDuration: null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration,remainingTime: null == remainingTime ? _self.remainingTime : remainingTime // ignore: cast_nullable_to_non_nullable
as Duration,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,hasExpired: null == hasExpired ? _self.hasExpired : hasExpired // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TimerStatus,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,isCritical: null == isCritical ? _self.isCritical : isCritical // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TimerState].
extension TimerStatePatterns on TimerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimerState value)  $default,){
final _that = this;
switch (_that) {
case _TimerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimerState value)?  $default,){
final _that = this;
switch (_that) {
case _TimerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration totalDuration,  Duration remainingTime,  double progress,  bool isPaused,  bool isRunning,  bool hasExpired,  TimerStatus status,  DateTime? deadline,  bool isWarning,  bool isCritical)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimerState() when $default != null:
return $default(_that.totalDuration,_that.remainingTime,_that.progress,_that.isPaused,_that.isRunning,_that.hasExpired,_that.status,_that.deadline,_that.isWarning,_that.isCritical);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration totalDuration,  Duration remainingTime,  double progress,  bool isPaused,  bool isRunning,  bool hasExpired,  TimerStatus status,  DateTime? deadline,  bool isWarning,  bool isCritical)  $default,) {final _that = this;
switch (_that) {
case _TimerState():
return $default(_that.totalDuration,_that.remainingTime,_that.progress,_that.isPaused,_that.isRunning,_that.hasExpired,_that.status,_that.deadline,_that.isWarning,_that.isCritical);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration totalDuration,  Duration remainingTime,  double progress,  bool isPaused,  bool isRunning,  bool hasExpired,  TimerStatus status,  DateTime? deadline,  bool isWarning,  bool isCritical)?  $default,) {final _that = this;
switch (_that) {
case _TimerState() when $default != null:
return $default(_that.totalDuration,_that.remainingTime,_that.progress,_that.isPaused,_that.isRunning,_that.hasExpired,_that.status,_that.deadline,_that.isWarning,_that.isCritical);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimerState implements TimerState {
  const _TimerState({required this.totalDuration, required this.remainingTime, this.progress = 1.0, this.isPaused = false, this.isRunning = false, this.hasExpired = false, this.status = TimerStatus.idle, this.deadline, this.isWarning = false, this.isCritical = false});
  factory _TimerState.fromJson(Map<String, dynamic> json) => _$TimerStateFromJson(json);

@override final  Duration totalDuration;
@override final  Duration remainingTime;
@override@JsonKey() final  double progress;
@override@JsonKey() final  bool isPaused;
@override@JsonKey() final  bool isRunning;
@override@JsonKey() final  bool hasExpired;
@override@JsonKey() final  TimerStatus status;
@override final  DateTime? deadline;
@override@JsonKey() final  bool isWarning;
@override@JsonKey() final  bool isCritical;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimerStateCopyWith<_TimerState> get copyWith => __$TimerStateCopyWithImpl<_TimerState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimerStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimerState&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration)&&(identical(other.remainingTime, remainingTime) || other.remainingTime == remainingTime)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.hasExpired, hasExpired) || other.hasExpired == hasExpired)&&(identical(other.status, status) || other.status == status)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isCritical, isCritical) || other.isCritical == isCritical));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDuration,remainingTime,progress,isPaused,isRunning,hasExpired,status,deadline,isWarning,isCritical);

@override
String toString() {
  return 'TimerState(totalDuration: $totalDuration, remainingTime: $remainingTime, progress: $progress, isPaused: $isPaused, isRunning: $isRunning, hasExpired: $hasExpired, status: $status, deadline: $deadline, isWarning: $isWarning, isCritical: $isCritical)';
}


}

/// @nodoc
abstract mixin class _$TimerStateCopyWith<$Res> implements $TimerStateCopyWith<$Res> {
  factory _$TimerStateCopyWith(_TimerState value, $Res Function(_TimerState) _then) = __$TimerStateCopyWithImpl;
@override @useResult
$Res call({
 Duration totalDuration, Duration remainingTime, double progress, bool isPaused, bool isRunning, bool hasExpired, TimerStatus status, DateTime? deadline, bool isWarning, bool isCritical
});




}
/// @nodoc
class __$TimerStateCopyWithImpl<$Res>
    implements _$TimerStateCopyWith<$Res> {
  __$TimerStateCopyWithImpl(this._self, this._then);

  final _TimerState _self;
  final $Res Function(_TimerState) _then;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDuration = null,Object? remainingTime = null,Object? progress = null,Object? isPaused = null,Object? isRunning = null,Object? hasExpired = null,Object? status = null,Object? deadline = freezed,Object? isWarning = null,Object? isCritical = null,}) {
  return _then(_TimerState(
totalDuration: null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration,remainingTime: null == remainingTime ? _self.remainingTime : remainingTime // ignore: cast_nullable_to_non_nullable
as Duration,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,hasExpired: null == hasExpired ? _self.hasExpired : hasExpired // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TimerStatus,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,isCritical: null == isCritical ? _self.isCritical : isCritical // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
