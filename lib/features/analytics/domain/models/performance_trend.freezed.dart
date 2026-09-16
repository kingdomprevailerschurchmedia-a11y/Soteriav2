// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_trend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PerformanceTrendPoint {

 DateTime get date; double get value; double get secondaryValue; String? get label;
/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceTrendPointCopyWith<PerformanceTrendPoint> get copyWith => _$PerformanceTrendPointCopyWithImpl<PerformanceTrendPoint>(this as PerformanceTrendPoint, _$identity);

  /// Serializes this PerformanceTrendPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceTrendPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.value, value) || other.value == value)&&(identical(other.secondaryValue, secondaryValue) || other.secondaryValue == secondaryValue)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,value,secondaryValue,label);

@override
String toString() {
  return 'PerformanceTrendPoint(date: $date, value: $value, secondaryValue: $secondaryValue, label: $label)';
}


}

/// @nodoc
abstract mixin class $PerformanceTrendPointCopyWith<$Res>  {
  factory $PerformanceTrendPointCopyWith(PerformanceTrendPoint value, $Res Function(PerformanceTrendPoint) _then) = _$PerformanceTrendPointCopyWithImpl;
@useResult
$Res call({
 DateTime date, double value, double secondaryValue, String? label
});




}
/// @nodoc
class _$PerformanceTrendPointCopyWithImpl<$Res>
    implements $PerformanceTrendPointCopyWith<$Res> {
  _$PerformanceTrendPointCopyWithImpl(this._self, this._then);

  final PerformanceTrendPoint _self;
  final $Res Function(PerformanceTrendPoint) _then;

/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? value = null,Object? secondaryValue = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,secondaryValue: null == secondaryValue ? _self.secondaryValue : secondaryValue // ignore: cast_nullable_to_non_nullable
as double,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceTrendPoint].
extension PerformanceTrendPointPatterns on PerformanceTrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceTrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceTrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceTrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double value,  double secondaryValue,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
return $default(_that.date,_that.value,_that.secondaryValue,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double value,  double secondaryValue,  String? label)  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrendPoint():
return $default(_that.date,_that.value,_that.secondaryValue,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double value,  double secondaryValue,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
return $default(_that.date,_that.value,_that.secondaryValue,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceTrendPoint implements PerformanceTrendPoint {
  const _PerformanceTrendPoint({required this.date, required this.value, this.secondaryValue = 0.0, this.label});
  factory _PerformanceTrendPoint.fromJson(Map<String, dynamic> json) => _$PerformanceTrendPointFromJson(json);

@override final  DateTime date;
@override final  double value;
@override@JsonKey() final  double secondaryValue;
@override final  String? label;

/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceTrendPointCopyWith<_PerformanceTrendPoint> get copyWith => __$PerformanceTrendPointCopyWithImpl<_PerformanceTrendPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceTrendPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceTrendPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.value, value) || other.value == value)&&(identical(other.secondaryValue, secondaryValue) || other.secondaryValue == secondaryValue)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,value,secondaryValue,label);

@override
String toString() {
  return 'PerformanceTrendPoint(date: $date, value: $value, secondaryValue: $secondaryValue, label: $label)';
}


}

/// @nodoc
abstract mixin class _$PerformanceTrendPointCopyWith<$Res> implements $PerformanceTrendPointCopyWith<$Res> {
  factory _$PerformanceTrendPointCopyWith(_PerformanceTrendPoint value, $Res Function(_PerformanceTrendPoint) _then) = __$PerformanceTrendPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double value, double secondaryValue, String? label
});




}
/// @nodoc
class __$PerformanceTrendPointCopyWithImpl<$Res>
    implements _$PerformanceTrendPointCopyWith<$Res> {
  __$PerformanceTrendPointCopyWithImpl(this._self, this._then);

  final _PerformanceTrendPoint _self;
  final $Res Function(_PerformanceTrendPoint) _then;

/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? value = null,Object? secondaryValue = null,Object? label = freezed,}) {
  return _then(_PerformanceTrendPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,secondaryValue: null == secondaryValue ? _self.secondaryValue : secondaryValue // ignore: cast_nullable_to_non_nullable
as double,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PerformanceTrend {

 String get label; List<PerformanceTrendPoint> get points; double get averageValue; double get minValue; double get maxValue; double get changeValue; double get changePercentage;
/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<PerformanceTrend> get copyWith => _$PerformanceTrendCopyWithImpl<PerformanceTrend>(this as PerformanceTrend, _$identity);

  /// Serializes this PerformanceTrend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceTrend&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.averageValue, averageValue) || other.averageValue == averageValue)&&(identical(other.minValue, minValue) || other.minValue == minValue)&&(identical(other.maxValue, maxValue) || other.maxValue == maxValue)&&(identical(other.changeValue, changeValue) || other.changeValue == changeValue)&&(identical(other.changePercentage, changePercentage) || other.changePercentage == changePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(points),averageValue,minValue,maxValue,changeValue,changePercentage);

@override
String toString() {
  return 'PerformanceTrend(label: $label, points: $points, averageValue: $averageValue, minValue: $minValue, maxValue: $maxValue, changeValue: $changeValue, changePercentage: $changePercentage)';
}


}

/// @nodoc
abstract mixin class $PerformanceTrendCopyWith<$Res>  {
  factory $PerformanceTrendCopyWith(PerformanceTrend value, $Res Function(PerformanceTrend) _then) = _$PerformanceTrendCopyWithImpl;
@useResult
$Res call({
 String label, List<PerformanceTrendPoint> points, double averageValue, double minValue, double maxValue, double changeValue, double changePercentage
});




}
/// @nodoc
class _$PerformanceTrendCopyWithImpl<$Res>
    implements $PerformanceTrendCopyWith<$Res> {
  _$PerformanceTrendCopyWithImpl(this._self, this._then);

  final PerformanceTrend _self;
  final $Res Function(PerformanceTrend) _then;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? points = null,Object? averageValue = null,Object? minValue = null,Object? maxValue = null,Object? changeValue = null,Object? changePercentage = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrendPoint>,averageValue: null == averageValue ? _self.averageValue : averageValue // ignore: cast_nullable_to_non_nullable
as double,minValue: null == minValue ? _self.minValue : minValue // ignore: cast_nullable_to_non_nullable
as double,maxValue: null == maxValue ? _self.maxValue : maxValue // ignore: cast_nullable_to_non_nullable
as double,changeValue: null == changeValue ? _self.changeValue : changeValue // ignore: cast_nullable_to_non_nullable
as double,changePercentage: null == changePercentage ? _self.changePercentage : changePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceTrend].
extension PerformanceTrendPatterns on PerformanceTrend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceTrend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceTrend value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceTrend value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  List<PerformanceTrendPoint> points,  double averageValue,  double minValue,  double maxValue,  double changeValue,  double changePercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
return $default(_that.label,_that.points,_that.averageValue,_that.minValue,_that.maxValue,_that.changeValue,_that.changePercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  List<PerformanceTrendPoint> points,  double averageValue,  double minValue,  double maxValue,  double changeValue,  double changePercentage)  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrend():
return $default(_that.label,_that.points,_that.averageValue,_that.minValue,_that.maxValue,_that.changeValue,_that.changePercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  List<PerformanceTrendPoint> points,  double averageValue,  double minValue,  double maxValue,  double changeValue,  double changePercentage)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
return $default(_that.label,_that.points,_that.averageValue,_that.minValue,_that.maxValue,_that.changeValue,_that.changePercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceTrend implements PerformanceTrend {
  const _PerformanceTrend({required this.label, required final  List<PerformanceTrendPoint> points, required this.averageValue, required this.minValue, required this.maxValue, required this.changeValue, required this.changePercentage}): _points = points;
  factory _PerformanceTrend.fromJson(Map<String, dynamic> json) => _$PerformanceTrendFromJson(json);

@override final  String label;
 final  List<PerformanceTrendPoint> _points;
@override List<PerformanceTrendPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  double averageValue;
@override final  double minValue;
@override final  double maxValue;
@override final  double changeValue;
@override final  double changePercentage;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceTrendCopyWith<_PerformanceTrend> get copyWith => __$PerformanceTrendCopyWithImpl<_PerformanceTrend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceTrendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceTrend&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.averageValue, averageValue) || other.averageValue == averageValue)&&(identical(other.minValue, minValue) || other.minValue == minValue)&&(identical(other.maxValue, maxValue) || other.maxValue == maxValue)&&(identical(other.changeValue, changeValue) || other.changeValue == changeValue)&&(identical(other.changePercentage, changePercentage) || other.changePercentage == changePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(_points),averageValue,minValue,maxValue,changeValue,changePercentage);

@override
String toString() {
  return 'PerformanceTrend(label: $label, points: $points, averageValue: $averageValue, minValue: $minValue, maxValue: $maxValue, changeValue: $changeValue, changePercentage: $changePercentage)';
}


}

/// @nodoc
abstract mixin class _$PerformanceTrendCopyWith<$Res> implements $PerformanceTrendCopyWith<$Res> {
  factory _$PerformanceTrendCopyWith(_PerformanceTrend value, $Res Function(_PerformanceTrend) _then) = __$PerformanceTrendCopyWithImpl;
@override @useResult
$Res call({
 String label, List<PerformanceTrendPoint> points, double averageValue, double minValue, double maxValue, double changeValue, double changePercentage
});




}
/// @nodoc
class __$PerformanceTrendCopyWithImpl<$Res>
    implements _$PerformanceTrendCopyWith<$Res> {
  __$PerformanceTrendCopyWithImpl(this._self, this._then);

  final _PerformanceTrend _self;
  final $Res Function(_PerformanceTrend) _then;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? points = null,Object? averageValue = null,Object? minValue = null,Object? maxValue = null,Object? changeValue = null,Object? changePercentage = null,}) {
  return _then(_PerformanceTrend(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrendPoint>,averageValue: null == averageValue ? _self.averageValue : averageValue // ignore: cast_nullable_to_non_nullable
as double,minValue: null == minValue ? _self.minValue : minValue // ignore: cast_nullable_to_non_nullable
as double,maxValue: null == maxValue ? _self.maxValue : maxValue // ignore: cast_nullable_to_non_nullable
as double,changeValue: null == changeValue ? _self.changeValue : changeValue // ignore: cast_nullable_to_non_nullable
as double,changePercentage: null == changePercentage ? _self.changePercentage : changePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
