// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_up_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PowerUpConfiguration {

 int get maxPauseDurationSeconds; int get fiftyFiftyUsesPerRound; int get pauseTimerUsesPerRound; int get askAudienceUsesPerRound;
/// Create a copy of PowerUpConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PowerUpConfigurationCopyWith<PowerUpConfiguration> get copyWith => _$PowerUpConfigurationCopyWithImpl<PowerUpConfiguration>(this as PowerUpConfiguration, _$identity);

  /// Serializes this PowerUpConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PowerUpConfiguration&&(identical(other.maxPauseDurationSeconds, maxPauseDurationSeconds) || other.maxPauseDurationSeconds == maxPauseDurationSeconds)&&(identical(other.fiftyFiftyUsesPerRound, fiftyFiftyUsesPerRound) || other.fiftyFiftyUsesPerRound == fiftyFiftyUsesPerRound)&&(identical(other.pauseTimerUsesPerRound, pauseTimerUsesPerRound) || other.pauseTimerUsesPerRound == pauseTimerUsesPerRound)&&(identical(other.askAudienceUsesPerRound, askAudienceUsesPerRound) || other.askAudienceUsesPerRound == askAudienceUsesPerRound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxPauseDurationSeconds,fiftyFiftyUsesPerRound,pauseTimerUsesPerRound,askAudienceUsesPerRound);

@override
String toString() {
  return 'PowerUpConfiguration(maxPauseDurationSeconds: $maxPauseDurationSeconds, fiftyFiftyUsesPerRound: $fiftyFiftyUsesPerRound, pauseTimerUsesPerRound: $pauseTimerUsesPerRound, askAudienceUsesPerRound: $askAudienceUsesPerRound)';
}


}

/// @nodoc
abstract mixin class $PowerUpConfigurationCopyWith<$Res>  {
  factory $PowerUpConfigurationCopyWith(PowerUpConfiguration value, $Res Function(PowerUpConfiguration) _then) = _$PowerUpConfigurationCopyWithImpl;
@useResult
$Res call({
 int maxPauseDurationSeconds, int fiftyFiftyUsesPerRound, int pauseTimerUsesPerRound, int askAudienceUsesPerRound
});




}
/// @nodoc
class _$PowerUpConfigurationCopyWithImpl<$Res>
    implements $PowerUpConfigurationCopyWith<$Res> {
  _$PowerUpConfigurationCopyWithImpl(this._self, this._then);

  final PowerUpConfiguration _self;
  final $Res Function(PowerUpConfiguration) _then;

/// Create a copy of PowerUpConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxPauseDurationSeconds = null,Object? fiftyFiftyUsesPerRound = null,Object? pauseTimerUsesPerRound = null,Object? askAudienceUsesPerRound = null,}) {
  return _then(_self.copyWith(
maxPauseDurationSeconds: null == maxPauseDurationSeconds ? _self.maxPauseDurationSeconds : maxPauseDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,fiftyFiftyUsesPerRound: null == fiftyFiftyUsesPerRound ? _self.fiftyFiftyUsesPerRound : fiftyFiftyUsesPerRound // ignore: cast_nullable_to_non_nullable
as int,pauseTimerUsesPerRound: null == pauseTimerUsesPerRound ? _self.pauseTimerUsesPerRound : pauseTimerUsesPerRound // ignore: cast_nullable_to_non_nullable
as int,askAudienceUsesPerRound: null == askAudienceUsesPerRound ? _self.askAudienceUsesPerRound : askAudienceUsesPerRound // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PowerUpConfiguration].
extension PowerUpConfigurationPatterns on PowerUpConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PowerUpConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PowerUpConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PowerUpConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _PowerUpConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PowerUpConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _PowerUpConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxPauseDurationSeconds,  int fiftyFiftyUsesPerRound,  int pauseTimerUsesPerRound,  int askAudienceUsesPerRound)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PowerUpConfiguration() when $default != null:
return $default(_that.maxPauseDurationSeconds,_that.fiftyFiftyUsesPerRound,_that.pauseTimerUsesPerRound,_that.askAudienceUsesPerRound);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxPauseDurationSeconds,  int fiftyFiftyUsesPerRound,  int pauseTimerUsesPerRound,  int askAudienceUsesPerRound)  $default,) {final _that = this;
switch (_that) {
case _PowerUpConfiguration():
return $default(_that.maxPauseDurationSeconds,_that.fiftyFiftyUsesPerRound,_that.pauseTimerUsesPerRound,_that.askAudienceUsesPerRound);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxPauseDurationSeconds,  int fiftyFiftyUsesPerRound,  int pauseTimerUsesPerRound,  int askAudienceUsesPerRound)?  $default,) {final _that = this;
switch (_that) {
case _PowerUpConfiguration() when $default != null:
return $default(_that.maxPauseDurationSeconds,_that.fiftyFiftyUsesPerRound,_that.pauseTimerUsesPerRound,_that.askAudienceUsesPerRound);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PowerUpConfiguration implements PowerUpConfiguration {
  const _PowerUpConfiguration({this.maxPauseDurationSeconds = 10, this.fiftyFiftyUsesPerRound = 1, this.pauseTimerUsesPerRound = 1, this.askAudienceUsesPerRound = 1});
  factory _PowerUpConfiguration.fromJson(Map<String, dynamic> json) => _$PowerUpConfigurationFromJson(json);

@override@JsonKey() final  int maxPauseDurationSeconds;
@override@JsonKey() final  int fiftyFiftyUsesPerRound;
@override@JsonKey() final  int pauseTimerUsesPerRound;
@override@JsonKey() final  int askAudienceUsesPerRound;

/// Create a copy of PowerUpConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PowerUpConfigurationCopyWith<_PowerUpConfiguration> get copyWith => __$PowerUpConfigurationCopyWithImpl<_PowerUpConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PowerUpConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PowerUpConfiguration&&(identical(other.maxPauseDurationSeconds, maxPauseDurationSeconds) || other.maxPauseDurationSeconds == maxPauseDurationSeconds)&&(identical(other.fiftyFiftyUsesPerRound, fiftyFiftyUsesPerRound) || other.fiftyFiftyUsesPerRound == fiftyFiftyUsesPerRound)&&(identical(other.pauseTimerUsesPerRound, pauseTimerUsesPerRound) || other.pauseTimerUsesPerRound == pauseTimerUsesPerRound)&&(identical(other.askAudienceUsesPerRound, askAudienceUsesPerRound) || other.askAudienceUsesPerRound == askAudienceUsesPerRound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxPauseDurationSeconds,fiftyFiftyUsesPerRound,pauseTimerUsesPerRound,askAudienceUsesPerRound);

@override
String toString() {
  return 'PowerUpConfiguration(maxPauseDurationSeconds: $maxPauseDurationSeconds, fiftyFiftyUsesPerRound: $fiftyFiftyUsesPerRound, pauseTimerUsesPerRound: $pauseTimerUsesPerRound, askAudienceUsesPerRound: $askAudienceUsesPerRound)';
}


}

/// @nodoc
abstract mixin class _$PowerUpConfigurationCopyWith<$Res> implements $PowerUpConfigurationCopyWith<$Res> {
  factory _$PowerUpConfigurationCopyWith(_PowerUpConfiguration value, $Res Function(_PowerUpConfiguration) _then) = __$PowerUpConfigurationCopyWithImpl;
@override @useResult
$Res call({
 int maxPauseDurationSeconds, int fiftyFiftyUsesPerRound, int pauseTimerUsesPerRound, int askAudienceUsesPerRound
});




}
/// @nodoc
class __$PowerUpConfigurationCopyWithImpl<$Res>
    implements _$PowerUpConfigurationCopyWith<$Res> {
  __$PowerUpConfigurationCopyWithImpl(this._self, this._then);

  final _PowerUpConfiguration _self;
  final $Res Function(_PowerUpConfiguration) _then;

/// Create a copy of PowerUpConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxPauseDurationSeconds = null,Object? fiftyFiftyUsesPerRound = null,Object? pauseTimerUsesPerRound = null,Object? askAudienceUsesPerRound = null,}) {
  return _then(_PowerUpConfiguration(
maxPauseDurationSeconds: null == maxPauseDurationSeconds ? _self.maxPauseDurationSeconds : maxPauseDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,fiftyFiftyUsesPerRound: null == fiftyFiftyUsesPerRound ? _self.fiftyFiftyUsesPerRound : fiftyFiftyUsesPerRound // ignore: cast_nullable_to_non_nullable
as int,pauseTimerUsesPerRound: null == pauseTimerUsesPerRound ? _self.pauseTimerUsesPerRound : pauseTimerUsesPerRound // ignore: cast_nullable_to_non_nullable
as int,askAudienceUsesPerRound: null == askAudienceUsesPerRound ? _self.askAudienceUsesPerRound : askAudienceUsesPerRound // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
