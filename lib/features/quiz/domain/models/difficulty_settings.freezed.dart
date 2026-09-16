// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'difficulty_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DifficultySettings {

 Difficulty get difficulty; int get baseXP; double get xpMultiplier; int get baseCoins; int get timeLimitSeconds; int get penaltyPoints;
/// Create a copy of DifficultySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DifficultySettingsCopyWith<DifficultySettings> get copyWith => _$DifficultySettingsCopyWithImpl<DifficultySettings>(this as DifficultySettings, _$identity);

  /// Serializes this DifficultySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DifficultySettings&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.baseXP, baseXP) || other.baseXP == baseXP)&&(identical(other.xpMultiplier, xpMultiplier) || other.xpMultiplier == xpMultiplier)&&(identical(other.baseCoins, baseCoins) || other.baseCoins == baseCoins)&&(identical(other.timeLimitSeconds, timeLimitSeconds) || other.timeLimitSeconds == timeLimitSeconds)&&(identical(other.penaltyPoints, penaltyPoints) || other.penaltyPoints == penaltyPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,difficulty,baseXP,xpMultiplier,baseCoins,timeLimitSeconds,penaltyPoints);

@override
String toString() {
  return 'DifficultySettings(difficulty: $difficulty, baseXP: $baseXP, xpMultiplier: $xpMultiplier, baseCoins: $baseCoins, timeLimitSeconds: $timeLimitSeconds, penaltyPoints: $penaltyPoints)';
}


}

/// @nodoc
abstract mixin class $DifficultySettingsCopyWith<$Res>  {
  factory $DifficultySettingsCopyWith(DifficultySettings value, $Res Function(DifficultySettings) _then) = _$DifficultySettingsCopyWithImpl;
@useResult
$Res call({
 Difficulty difficulty, int baseXP, double xpMultiplier, int baseCoins, int timeLimitSeconds, int penaltyPoints
});




}
/// @nodoc
class _$DifficultySettingsCopyWithImpl<$Res>
    implements $DifficultySettingsCopyWith<$Res> {
  _$DifficultySettingsCopyWithImpl(this._self, this._then);

  final DifficultySettings _self;
  final $Res Function(DifficultySettings) _then;

/// Create a copy of DifficultySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? difficulty = null,Object? baseXP = null,Object? xpMultiplier = null,Object? baseCoins = null,Object? timeLimitSeconds = null,Object? penaltyPoints = null,}) {
  return _then(_self.copyWith(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,baseXP: null == baseXP ? _self.baseXP : baseXP // ignore: cast_nullable_to_non_nullable
as int,xpMultiplier: null == xpMultiplier ? _self.xpMultiplier : xpMultiplier // ignore: cast_nullable_to_non_nullable
as double,baseCoins: null == baseCoins ? _self.baseCoins : baseCoins // ignore: cast_nullable_to_non_nullable
as int,timeLimitSeconds: null == timeLimitSeconds ? _self.timeLimitSeconds : timeLimitSeconds // ignore: cast_nullable_to_non_nullable
as int,penaltyPoints: null == penaltyPoints ? _self.penaltyPoints : penaltyPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DifficultySettings].
extension DifficultySettingsPatterns on DifficultySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DifficultySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DifficultySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DifficultySettings value)  $default,){
final _that = this;
switch (_that) {
case _DifficultySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DifficultySettings value)?  $default,){
final _that = this;
switch (_that) {
case _DifficultySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Difficulty difficulty,  int baseXP,  double xpMultiplier,  int baseCoins,  int timeLimitSeconds,  int penaltyPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DifficultySettings() when $default != null:
return $default(_that.difficulty,_that.baseXP,_that.xpMultiplier,_that.baseCoins,_that.timeLimitSeconds,_that.penaltyPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Difficulty difficulty,  int baseXP,  double xpMultiplier,  int baseCoins,  int timeLimitSeconds,  int penaltyPoints)  $default,) {final _that = this;
switch (_that) {
case _DifficultySettings():
return $default(_that.difficulty,_that.baseXP,_that.xpMultiplier,_that.baseCoins,_that.timeLimitSeconds,_that.penaltyPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Difficulty difficulty,  int baseXP,  double xpMultiplier,  int baseCoins,  int timeLimitSeconds,  int penaltyPoints)?  $default,) {final _that = this;
switch (_that) {
case _DifficultySettings() when $default != null:
return $default(_that.difficulty,_that.baseXP,_that.xpMultiplier,_that.baseCoins,_that.timeLimitSeconds,_that.penaltyPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DifficultySettings implements DifficultySettings {
  const _DifficultySettings({required this.difficulty, required this.baseXP, required this.xpMultiplier, required this.baseCoins, required this.timeLimitSeconds, required this.penaltyPoints});
  factory _DifficultySettings.fromJson(Map<String, dynamic> json) => _$DifficultySettingsFromJson(json);

@override final  Difficulty difficulty;
@override final  int baseXP;
@override final  double xpMultiplier;
@override final  int baseCoins;
@override final  int timeLimitSeconds;
@override final  int penaltyPoints;

/// Create a copy of DifficultySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DifficultySettingsCopyWith<_DifficultySettings> get copyWith => __$DifficultySettingsCopyWithImpl<_DifficultySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DifficultySettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DifficultySettings&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.baseXP, baseXP) || other.baseXP == baseXP)&&(identical(other.xpMultiplier, xpMultiplier) || other.xpMultiplier == xpMultiplier)&&(identical(other.baseCoins, baseCoins) || other.baseCoins == baseCoins)&&(identical(other.timeLimitSeconds, timeLimitSeconds) || other.timeLimitSeconds == timeLimitSeconds)&&(identical(other.penaltyPoints, penaltyPoints) || other.penaltyPoints == penaltyPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,difficulty,baseXP,xpMultiplier,baseCoins,timeLimitSeconds,penaltyPoints);

@override
String toString() {
  return 'DifficultySettings(difficulty: $difficulty, baseXP: $baseXP, xpMultiplier: $xpMultiplier, baseCoins: $baseCoins, timeLimitSeconds: $timeLimitSeconds, penaltyPoints: $penaltyPoints)';
}


}

/// @nodoc
abstract mixin class _$DifficultySettingsCopyWith<$Res> implements $DifficultySettingsCopyWith<$Res> {
  factory _$DifficultySettingsCopyWith(_DifficultySettings value, $Res Function(_DifficultySettings) _then) = __$DifficultySettingsCopyWithImpl;
@override @useResult
$Res call({
 Difficulty difficulty, int baseXP, double xpMultiplier, int baseCoins, int timeLimitSeconds, int penaltyPoints
});




}
/// @nodoc
class __$DifficultySettingsCopyWithImpl<$Res>
    implements _$DifficultySettingsCopyWith<$Res> {
  __$DifficultySettingsCopyWithImpl(this._self, this._then);

  final _DifficultySettings _self;
  final $Res Function(_DifficultySettings) _then;

/// Create a copy of DifficultySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? difficulty = null,Object? baseXP = null,Object? xpMultiplier = null,Object? baseCoins = null,Object? timeLimitSeconds = null,Object? penaltyPoints = null,}) {
  return _then(_DifficultySettings(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,baseXP: null == baseXP ? _self.baseXP : baseXP // ignore: cast_nullable_to_non_nullable
as int,xpMultiplier: null == xpMultiplier ? _self.xpMultiplier : xpMultiplier // ignore: cast_nullable_to_non_nullable
as double,baseCoins: null == baseCoins ? _self.baseCoins : baseCoins // ignore: cast_nullable_to_non_nullable
as int,timeLimitSeconds: null == timeLimitSeconds ? _self.timeLimitSeconds : timeLimitSeconds // ignore: cast_nullable_to_non_nullable
as int,penaltyPoints: null == penaltyPoints ? _self.penaltyPoints : penaltyPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
