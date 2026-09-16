// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_countdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeasonCountdown {

 int get days; int get hours; int get minutes; int get seconds; Duration get totalRemaining; CountdownStatus get status;
/// Create a copy of SeasonCountdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonCountdownCopyWith<SeasonCountdown> get copyWith => _$SeasonCountdownCopyWithImpl<SeasonCountdown>(this as SeasonCountdown, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonCountdown&&(identical(other.days, days) || other.days == days)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.totalRemaining, totalRemaining) || other.totalRemaining == totalRemaining)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,days,hours,minutes,seconds,totalRemaining,status);

@override
String toString() {
  return 'SeasonCountdown(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds, totalRemaining: $totalRemaining, status: $status)';
}


}

/// @nodoc
abstract mixin class $SeasonCountdownCopyWith<$Res>  {
  factory $SeasonCountdownCopyWith(SeasonCountdown value, $Res Function(SeasonCountdown) _then) = _$SeasonCountdownCopyWithImpl;
@useResult
$Res call({
 int days, int hours, int minutes, int seconds, Duration totalRemaining, CountdownStatus status
});




}
/// @nodoc
class _$SeasonCountdownCopyWithImpl<$Res>
    implements $SeasonCountdownCopyWith<$Res> {
  _$SeasonCountdownCopyWithImpl(this._self, this._then);

  final SeasonCountdown _self;
  final $Res Function(SeasonCountdown) _then;

/// Create a copy of SeasonCountdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? hours = null,Object? minutes = null,Object? seconds = null,Object? totalRemaining = null,Object? status = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,totalRemaining: null == totalRemaining ? _self.totalRemaining : totalRemaining // ignore: cast_nullable_to_non_nullable
as Duration,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CountdownStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonCountdown].
extension SeasonCountdownPatterns on SeasonCountdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonCountdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonCountdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonCountdown value)  $default,){
final _that = this;
switch (_that) {
case _SeasonCountdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonCountdown value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonCountdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int days,  int hours,  int minutes,  int seconds,  Duration totalRemaining,  CountdownStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonCountdown() when $default != null:
return $default(_that.days,_that.hours,_that.minutes,_that.seconds,_that.totalRemaining,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int days,  int hours,  int minutes,  int seconds,  Duration totalRemaining,  CountdownStatus status)  $default,) {final _that = this;
switch (_that) {
case _SeasonCountdown():
return $default(_that.days,_that.hours,_that.minutes,_that.seconds,_that.totalRemaining,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int days,  int hours,  int minutes,  int seconds,  Duration totalRemaining,  CountdownStatus status)?  $default,) {final _that = this;
switch (_that) {
case _SeasonCountdown() when $default != null:
return $default(_that.days,_that.hours,_that.minutes,_that.seconds,_that.totalRemaining,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _SeasonCountdown implements SeasonCountdown {
  const _SeasonCountdown({required this.days, required this.hours, required this.minutes, required this.seconds, required this.totalRemaining, required this.status});
  

@override final  int days;
@override final  int hours;
@override final  int minutes;
@override final  int seconds;
@override final  Duration totalRemaining;
@override final  CountdownStatus status;

/// Create a copy of SeasonCountdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonCountdownCopyWith<_SeasonCountdown> get copyWith => __$SeasonCountdownCopyWithImpl<_SeasonCountdown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonCountdown&&(identical(other.days, days) || other.days == days)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.totalRemaining, totalRemaining) || other.totalRemaining == totalRemaining)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,days,hours,minutes,seconds,totalRemaining,status);

@override
String toString() {
  return 'SeasonCountdown(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds, totalRemaining: $totalRemaining, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SeasonCountdownCopyWith<$Res> implements $SeasonCountdownCopyWith<$Res> {
  factory _$SeasonCountdownCopyWith(_SeasonCountdown value, $Res Function(_SeasonCountdown) _then) = __$SeasonCountdownCopyWithImpl;
@override @useResult
$Res call({
 int days, int hours, int minutes, int seconds, Duration totalRemaining, CountdownStatus status
});




}
/// @nodoc
class __$SeasonCountdownCopyWithImpl<$Res>
    implements _$SeasonCountdownCopyWith<$Res> {
  __$SeasonCountdownCopyWithImpl(this._self, this._then);

  final _SeasonCountdown _self;
  final $Res Function(_SeasonCountdown) _then;

/// Create a copy of SeasonCountdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? hours = null,Object? minutes = null,Object? seconds = null,Object? totalRemaining = null,Object? status = null,}) {
  return _then(_SeasonCountdown(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,totalRemaining: null == totalRemaining ? _self.totalRemaining : totalRemaining // ignore: cast_nullable_to_non_nullable
as Duration,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CountdownStatus,
  ));
}


}

// dart format on
