// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scoring_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoringConfiguration {

 Map<Difficulty, int> get basePoints; Map<Difficulty, double> get difficultyMultipliers; double get streakBonusMultiplier; double get maxStreakBonus; int get maxSpeedBonus; double get speedBonusThreshold;// Answering in < 50% of time gives bonus
 int get xpPerCorrect; double get xpMultiplier;
/// Create a copy of ScoringConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoringConfigurationCopyWith<ScoringConfiguration> get copyWith => _$ScoringConfigurationCopyWithImpl<ScoringConfiguration>(this as ScoringConfiguration, _$identity);

  /// Serializes this ScoringConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoringConfiguration&&const DeepCollectionEquality().equals(other.basePoints, basePoints)&&const DeepCollectionEquality().equals(other.difficultyMultipliers, difficultyMultipliers)&&(identical(other.streakBonusMultiplier, streakBonusMultiplier) || other.streakBonusMultiplier == streakBonusMultiplier)&&(identical(other.maxStreakBonus, maxStreakBonus) || other.maxStreakBonus == maxStreakBonus)&&(identical(other.maxSpeedBonus, maxSpeedBonus) || other.maxSpeedBonus == maxSpeedBonus)&&(identical(other.speedBonusThreshold, speedBonusThreshold) || other.speedBonusThreshold == speedBonusThreshold)&&(identical(other.xpPerCorrect, xpPerCorrect) || other.xpPerCorrect == xpPerCorrect)&&(identical(other.xpMultiplier, xpMultiplier) || other.xpMultiplier == xpMultiplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(basePoints),const DeepCollectionEquality().hash(difficultyMultipliers),streakBonusMultiplier,maxStreakBonus,maxSpeedBonus,speedBonusThreshold,xpPerCorrect,xpMultiplier);

@override
String toString() {
  return 'ScoringConfiguration(basePoints: $basePoints, difficultyMultipliers: $difficultyMultipliers, streakBonusMultiplier: $streakBonusMultiplier, maxStreakBonus: $maxStreakBonus, maxSpeedBonus: $maxSpeedBonus, speedBonusThreshold: $speedBonusThreshold, xpPerCorrect: $xpPerCorrect, xpMultiplier: $xpMultiplier)';
}


}

/// @nodoc
abstract mixin class $ScoringConfigurationCopyWith<$Res>  {
  factory $ScoringConfigurationCopyWith(ScoringConfiguration value, $Res Function(ScoringConfiguration) _then) = _$ScoringConfigurationCopyWithImpl;
@useResult
$Res call({
 Map<Difficulty, int> basePoints, Map<Difficulty, double> difficultyMultipliers, double streakBonusMultiplier, double maxStreakBonus, int maxSpeedBonus, double speedBonusThreshold, int xpPerCorrect, double xpMultiplier
});




}
/// @nodoc
class _$ScoringConfigurationCopyWithImpl<$Res>
    implements $ScoringConfigurationCopyWith<$Res> {
  _$ScoringConfigurationCopyWithImpl(this._self, this._then);

  final ScoringConfiguration _self;
  final $Res Function(ScoringConfiguration) _then;

/// Create a copy of ScoringConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? basePoints = null,Object? difficultyMultipliers = null,Object? streakBonusMultiplier = null,Object? maxStreakBonus = null,Object? maxSpeedBonus = null,Object? speedBonusThreshold = null,Object? xpPerCorrect = null,Object? xpMultiplier = null,}) {
  return _then(_self.copyWith(
basePoints: null == basePoints ? _self.basePoints : basePoints // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, int>,difficultyMultipliers: null == difficultyMultipliers ? _self.difficultyMultipliers : difficultyMultipliers // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, double>,streakBonusMultiplier: null == streakBonusMultiplier ? _self.streakBonusMultiplier : streakBonusMultiplier // ignore: cast_nullable_to_non_nullable
as double,maxStreakBonus: null == maxStreakBonus ? _self.maxStreakBonus : maxStreakBonus // ignore: cast_nullable_to_non_nullable
as double,maxSpeedBonus: null == maxSpeedBonus ? _self.maxSpeedBonus : maxSpeedBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonusThreshold: null == speedBonusThreshold ? _self.speedBonusThreshold : speedBonusThreshold // ignore: cast_nullable_to_non_nullable
as double,xpPerCorrect: null == xpPerCorrect ? _self.xpPerCorrect : xpPerCorrect // ignore: cast_nullable_to_non_nullable
as int,xpMultiplier: null == xpMultiplier ? _self.xpMultiplier : xpMultiplier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoringConfiguration].
extension ScoringConfigurationPatterns on ScoringConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoringConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoringConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoringConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _ScoringConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoringConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _ScoringConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<Difficulty, int> basePoints,  Map<Difficulty, double> difficultyMultipliers,  double streakBonusMultiplier,  double maxStreakBonus,  int maxSpeedBonus,  double speedBonusThreshold,  int xpPerCorrect,  double xpMultiplier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoringConfiguration() when $default != null:
return $default(_that.basePoints,_that.difficultyMultipliers,_that.streakBonusMultiplier,_that.maxStreakBonus,_that.maxSpeedBonus,_that.speedBonusThreshold,_that.xpPerCorrect,_that.xpMultiplier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<Difficulty, int> basePoints,  Map<Difficulty, double> difficultyMultipliers,  double streakBonusMultiplier,  double maxStreakBonus,  int maxSpeedBonus,  double speedBonusThreshold,  int xpPerCorrect,  double xpMultiplier)  $default,) {final _that = this;
switch (_that) {
case _ScoringConfiguration():
return $default(_that.basePoints,_that.difficultyMultipliers,_that.streakBonusMultiplier,_that.maxStreakBonus,_that.maxSpeedBonus,_that.speedBonusThreshold,_that.xpPerCorrect,_that.xpMultiplier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<Difficulty, int> basePoints,  Map<Difficulty, double> difficultyMultipliers,  double streakBonusMultiplier,  double maxStreakBonus,  int maxSpeedBonus,  double speedBonusThreshold,  int xpPerCorrect,  double xpMultiplier)?  $default,) {final _that = this;
switch (_that) {
case _ScoringConfiguration() when $default != null:
return $default(_that.basePoints,_that.difficultyMultipliers,_that.streakBonusMultiplier,_that.maxStreakBonus,_that.maxSpeedBonus,_that.speedBonusThreshold,_that.xpPerCorrect,_that.xpMultiplier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoringConfiguration implements ScoringConfiguration {
  const _ScoringConfiguration({required final  Map<Difficulty, int> basePoints, required final  Map<Difficulty, double> difficultyMultipliers, this.streakBonusMultiplier = 0.1, this.maxStreakBonus = 1.0, this.maxSpeedBonus = 50, this.speedBonusThreshold = 0.5, this.xpPerCorrect = 10, this.xpMultiplier = 1.0}): _basePoints = basePoints,_difficultyMultipliers = difficultyMultipliers;
  factory _ScoringConfiguration.fromJson(Map<String, dynamic> json) => _$ScoringConfigurationFromJson(json);

 final  Map<Difficulty, int> _basePoints;
@override Map<Difficulty, int> get basePoints {
  if (_basePoints is EqualUnmodifiableMapView) return _basePoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_basePoints);
}

 final  Map<Difficulty, double> _difficultyMultipliers;
@override Map<Difficulty, double> get difficultyMultipliers {
  if (_difficultyMultipliers is EqualUnmodifiableMapView) return _difficultyMultipliers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_difficultyMultipliers);
}

@override@JsonKey() final  double streakBonusMultiplier;
@override@JsonKey() final  double maxStreakBonus;
@override@JsonKey() final  int maxSpeedBonus;
@override@JsonKey() final  double speedBonusThreshold;
// Answering in < 50% of time gives bonus
@override@JsonKey() final  int xpPerCorrect;
@override@JsonKey() final  double xpMultiplier;

/// Create a copy of ScoringConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoringConfigurationCopyWith<_ScoringConfiguration> get copyWith => __$ScoringConfigurationCopyWithImpl<_ScoringConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoringConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoringConfiguration&&const DeepCollectionEquality().equals(other._basePoints, _basePoints)&&const DeepCollectionEquality().equals(other._difficultyMultipliers, _difficultyMultipliers)&&(identical(other.streakBonusMultiplier, streakBonusMultiplier) || other.streakBonusMultiplier == streakBonusMultiplier)&&(identical(other.maxStreakBonus, maxStreakBonus) || other.maxStreakBonus == maxStreakBonus)&&(identical(other.maxSpeedBonus, maxSpeedBonus) || other.maxSpeedBonus == maxSpeedBonus)&&(identical(other.speedBonusThreshold, speedBonusThreshold) || other.speedBonusThreshold == speedBonusThreshold)&&(identical(other.xpPerCorrect, xpPerCorrect) || other.xpPerCorrect == xpPerCorrect)&&(identical(other.xpMultiplier, xpMultiplier) || other.xpMultiplier == xpMultiplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_basePoints),const DeepCollectionEquality().hash(_difficultyMultipliers),streakBonusMultiplier,maxStreakBonus,maxSpeedBonus,speedBonusThreshold,xpPerCorrect,xpMultiplier);

@override
String toString() {
  return 'ScoringConfiguration(basePoints: $basePoints, difficultyMultipliers: $difficultyMultipliers, streakBonusMultiplier: $streakBonusMultiplier, maxStreakBonus: $maxStreakBonus, maxSpeedBonus: $maxSpeedBonus, speedBonusThreshold: $speedBonusThreshold, xpPerCorrect: $xpPerCorrect, xpMultiplier: $xpMultiplier)';
}


}

/// @nodoc
abstract mixin class _$ScoringConfigurationCopyWith<$Res> implements $ScoringConfigurationCopyWith<$Res> {
  factory _$ScoringConfigurationCopyWith(_ScoringConfiguration value, $Res Function(_ScoringConfiguration) _then) = __$ScoringConfigurationCopyWithImpl;
@override @useResult
$Res call({
 Map<Difficulty, int> basePoints, Map<Difficulty, double> difficultyMultipliers, double streakBonusMultiplier, double maxStreakBonus, int maxSpeedBonus, double speedBonusThreshold, int xpPerCorrect, double xpMultiplier
});




}
/// @nodoc
class __$ScoringConfigurationCopyWithImpl<$Res>
    implements _$ScoringConfigurationCopyWith<$Res> {
  __$ScoringConfigurationCopyWithImpl(this._self, this._then);

  final _ScoringConfiguration _self;
  final $Res Function(_ScoringConfiguration) _then;

/// Create a copy of ScoringConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? basePoints = null,Object? difficultyMultipliers = null,Object? streakBonusMultiplier = null,Object? maxStreakBonus = null,Object? maxSpeedBonus = null,Object? speedBonusThreshold = null,Object? xpPerCorrect = null,Object? xpMultiplier = null,}) {
  return _then(_ScoringConfiguration(
basePoints: null == basePoints ? _self._basePoints : basePoints // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, int>,difficultyMultipliers: null == difficultyMultipliers ? _self._difficultyMultipliers : difficultyMultipliers // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, double>,streakBonusMultiplier: null == streakBonusMultiplier ? _self.streakBonusMultiplier : streakBonusMultiplier // ignore: cast_nullable_to_non_nullable
as double,maxStreakBonus: null == maxStreakBonus ? _self.maxStreakBonus : maxStreakBonus // ignore: cast_nullable_to_non_nullable
as double,maxSpeedBonus: null == maxSpeedBonus ? _self.maxSpeedBonus : maxSpeedBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonusThreshold: null == speedBonusThreshold ? _self.speedBonusThreshold : speedBonusThreshold // ignore: cast_nullable_to_non_nullable
as double,xpPerCorrect: null == xpPerCorrect ? _self.xpPerCorrect : xpPerCorrect // ignore: cast_nullable_to_non_nullable
as int,xpMultiplier: null == xpMultiplier ? _self.xpMultiplier : xpMultiplier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
