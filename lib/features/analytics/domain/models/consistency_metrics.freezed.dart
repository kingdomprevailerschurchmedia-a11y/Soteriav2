// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consistency_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConsistencyMetrics {

 double get accuracyVariance; double get scoreVariance; double get consistencyScore;// 0.0 to 1.0
 String get consistencyLevel;// e.g., "Highly Consistent"
 int get streakStability;
/// Create a copy of ConsistencyMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsistencyMetricsCopyWith<ConsistencyMetrics> get copyWith => _$ConsistencyMetricsCopyWithImpl<ConsistencyMetrics>(this as ConsistencyMetrics, _$identity);

  /// Serializes this ConsistencyMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsistencyMetrics&&(identical(other.accuracyVariance, accuracyVariance) || other.accuracyVariance == accuracyVariance)&&(identical(other.scoreVariance, scoreVariance) || other.scoreVariance == scoreVariance)&&(identical(other.consistencyScore, consistencyScore) || other.consistencyScore == consistencyScore)&&(identical(other.consistencyLevel, consistencyLevel) || other.consistencyLevel == consistencyLevel)&&(identical(other.streakStability, streakStability) || other.streakStability == streakStability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accuracyVariance,scoreVariance,consistencyScore,consistencyLevel,streakStability);

@override
String toString() {
  return 'ConsistencyMetrics(accuracyVariance: $accuracyVariance, scoreVariance: $scoreVariance, consistencyScore: $consistencyScore, consistencyLevel: $consistencyLevel, streakStability: $streakStability)';
}


}

/// @nodoc
abstract mixin class $ConsistencyMetricsCopyWith<$Res>  {
  factory $ConsistencyMetricsCopyWith(ConsistencyMetrics value, $Res Function(ConsistencyMetrics) _then) = _$ConsistencyMetricsCopyWithImpl;
@useResult
$Res call({
 double accuracyVariance, double scoreVariance, double consistencyScore, String consistencyLevel, int streakStability
});




}
/// @nodoc
class _$ConsistencyMetricsCopyWithImpl<$Res>
    implements $ConsistencyMetricsCopyWith<$Res> {
  _$ConsistencyMetricsCopyWithImpl(this._self, this._then);

  final ConsistencyMetrics _self;
  final $Res Function(ConsistencyMetrics) _then;

/// Create a copy of ConsistencyMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accuracyVariance = null,Object? scoreVariance = null,Object? consistencyScore = null,Object? consistencyLevel = null,Object? streakStability = null,}) {
  return _then(_self.copyWith(
accuracyVariance: null == accuracyVariance ? _self.accuracyVariance : accuracyVariance // ignore: cast_nullable_to_non_nullable
as double,scoreVariance: null == scoreVariance ? _self.scoreVariance : scoreVariance // ignore: cast_nullable_to_non_nullable
as double,consistencyScore: null == consistencyScore ? _self.consistencyScore : consistencyScore // ignore: cast_nullable_to_non_nullable
as double,consistencyLevel: null == consistencyLevel ? _self.consistencyLevel : consistencyLevel // ignore: cast_nullable_to_non_nullable
as String,streakStability: null == streakStability ? _self.streakStability : streakStability // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ConsistencyMetrics].
extension ConsistencyMetricsPatterns on ConsistencyMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsistencyMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsistencyMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsistencyMetrics value)  $default,){
final _that = this;
switch (_that) {
case _ConsistencyMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsistencyMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _ConsistencyMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double accuracyVariance,  double scoreVariance,  double consistencyScore,  String consistencyLevel,  int streakStability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsistencyMetrics() when $default != null:
return $default(_that.accuracyVariance,_that.scoreVariance,_that.consistencyScore,_that.consistencyLevel,_that.streakStability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double accuracyVariance,  double scoreVariance,  double consistencyScore,  String consistencyLevel,  int streakStability)  $default,) {final _that = this;
switch (_that) {
case _ConsistencyMetrics():
return $default(_that.accuracyVariance,_that.scoreVariance,_that.consistencyScore,_that.consistencyLevel,_that.streakStability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double accuracyVariance,  double scoreVariance,  double consistencyScore,  String consistencyLevel,  int streakStability)?  $default,) {final _that = this;
switch (_that) {
case _ConsistencyMetrics() when $default != null:
return $default(_that.accuracyVariance,_that.scoreVariance,_that.consistencyScore,_that.consistencyLevel,_that.streakStability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsistencyMetrics implements ConsistencyMetrics {
  const _ConsistencyMetrics({required this.accuracyVariance, required this.scoreVariance, required this.consistencyScore, required this.consistencyLevel, required this.streakStability});
  factory _ConsistencyMetrics.fromJson(Map<String, dynamic> json) => _$ConsistencyMetricsFromJson(json);

@override final  double accuracyVariance;
@override final  double scoreVariance;
@override final  double consistencyScore;
// 0.0 to 1.0
@override final  String consistencyLevel;
// e.g., "Highly Consistent"
@override final  int streakStability;

/// Create a copy of ConsistencyMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsistencyMetricsCopyWith<_ConsistencyMetrics> get copyWith => __$ConsistencyMetricsCopyWithImpl<_ConsistencyMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsistencyMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsistencyMetrics&&(identical(other.accuracyVariance, accuracyVariance) || other.accuracyVariance == accuracyVariance)&&(identical(other.scoreVariance, scoreVariance) || other.scoreVariance == scoreVariance)&&(identical(other.consistencyScore, consistencyScore) || other.consistencyScore == consistencyScore)&&(identical(other.consistencyLevel, consistencyLevel) || other.consistencyLevel == consistencyLevel)&&(identical(other.streakStability, streakStability) || other.streakStability == streakStability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accuracyVariance,scoreVariance,consistencyScore,consistencyLevel,streakStability);

@override
String toString() {
  return 'ConsistencyMetrics(accuracyVariance: $accuracyVariance, scoreVariance: $scoreVariance, consistencyScore: $consistencyScore, consistencyLevel: $consistencyLevel, streakStability: $streakStability)';
}


}

/// @nodoc
abstract mixin class _$ConsistencyMetricsCopyWith<$Res> implements $ConsistencyMetricsCopyWith<$Res> {
  factory _$ConsistencyMetricsCopyWith(_ConsistencyMetrics value, $Res Function(_ConsistencyMetrics) _then) = __$ConsistencyMetricsCopyWithImpl;
@override @useResult
$Res call({
 double accuracyVariance, double scoreVariance, double consistencyScore, String consistencyLevel, int streakStability
});




}
/// @nodoc
class __$ConsistencyMetricsCopyWithImpl<$Res>
    implements _$ConsistencyMetricsCopyWith<$Res> {
  __$ConsistencyMetricsCopyWithImpl(this._self, this._then);

  final _ConsistencyMetrics _self;
  final $Res Function(_ConsistencyMetrics) _then;

/// Create a copy of ConsistencyMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accuracyVariance = null,Object? scoreVariance = null,Object? consistencyScore = null,Object? consistencyLevel = null,Object? streakStability = null,}) {
  return _then(_ConsistencyMetrics(
accuracyVariance: null == accuracyVariance ? _self.accuracyVariance : accuracyVariance // ignore: cast_nullable_to_non_nullable
as double,scoreVariance: null == scoreVariance ? _self.scoreVariance : scoreVariance // ignore: cast_nullable_to_non_nullable
as double,consistencyScore: null == consistencyScore ? _self.consistencyScore : consistencyScore // ignore: cast_nullable_to_non_nullable
as double,consistencyLevel: null == consistencyLevel ? _self.consistencyLevel : consistencyLevel // ignore: cast_nullable_to_non_nullable
as String,streakStability: null == streakStability ? _self.streakStability : streakStability // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
