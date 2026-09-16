// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PerformanceInsight {

 InsightType get type; String get title; String get description; String get metricLabel; String get metricValue; TrendDirection get direction; InsightConfidence get confidence; DateTime get generatedAt; String? get recommendation;
/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceInsightCopyWith<PerformanceInsight> get copyWith => _$PerformanceInsightCopyWithImpl<PerformanceInsight>(this as PerformanceInsight, _$identity);

  /// Serializes this PerformanceInsight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceInsight&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.metricValue, metricValue) || other.metricValue == metricValue)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,description,metricLabel,metricValue,direction,confidence,generatedAt,recommendation);

@override
String toString() {
  return 'PerformanceInsight(type: $type, title: $title, description: $description, metricLabel: $metricLabel, metricValue: $metricValue, direction: $direction, confidence: $confidence, generatedAt: $generatedAt, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class $PerformanceInsightCopyWith<$Res>  {
  factory $PerformanceInsightCopyWith(PerformanceInsight value, $Res Function(PerformanceInsight) _then) = _$PerformanceInsightCopyWithImpl;
@useResult
$Res call({
 InsightType type, String title, String description, String metricLabel, String metricValue, TrendDirection direction, InsightConfidence confidence, DateTime generatedAt, String? recommendation
});




}
/// @nodoc
class _$PerformanceInsightCopyWithImpl<$Res>
    implements $PerformanceInsightCopyWith<$Res> {
  _$PerformanceInsightCopyWithImpl(this._self, this._then);

  final PerformanceInsight _self;
  final $Res Function(PerformanceInsight) _then;

/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? description = null,Object? metricLabel = null,Object? metricValue = null,Object? direction = null,Object? confidence = null,Object? generatedAt = null,Object? recommendation = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InsightType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,metricLabel: null == metricLabel ? _self.metricLabel : metricLabel // ignore: cast_nullable_to_non_nullable
as String,metricValue: null == metricValue ? _self.metricValue : metricValue // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TrendDirection,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as InsightConfidence,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceInsight].
extension PerformanceInsightPatterns on PerformanceInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceInsight value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceInsight value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InsightType type,  String title,  String description,  String metricLabel,  String metricValue,  TrendDirection direction,  InsightConfidence confidence,  DateTime generatedAt,  String? recommendation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
return $default(_that.type,_that.title,_that.description,_that.metricLabel,_that.metricValue,_that.direction,_that.confidence,_that.generatedAt,_that.recommendation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InsightType type,  String title,  String description,  String metricLabel,  String metricValue,  TrendDirection direction,  InsightConfidence confidence,  DateTime generatedAt,  String? recommendation)  $default,) {final _that = this;
switch (_that) {
case _PerformanceInsight():
return $default(_that.type,_that.title,_that.description,_that.metricLabel,_that.metricValue,_that.direction,_that.confidence,_that.generatedAt,_that.recommendation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InsightType type,  String title,  String description,  String metricLabel,  String metricValue,  TrendDirection direction,  InsightConfidence confidence,  DateTime generatedAt,  String? recommendation)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceInsight() when $default != null:
return $default(_that.type,_that.title,_that.description,_that.metricLabel,_that.metricValue,_that.direction,_that.confidence,_that.generatedAt,_that.recommendation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceInsight implements PerformanceInsight {
  const _PerformanceInsight({required this.type, required this.title, required this.description, required this.metricLabel, required this.metricValue, required this.direction, required this.confidence, required this.generatedAt, this.recommendation});
  factory _PerformanceInsight.fromJson(Map<String, dynamic> json) => _$PerformanceInsightFromJson(json);

@override final  InsightType type;
@override final  String title;
@override final  String description;
@override final  String metricLabel;
@override final  String metricValue;
@override final  TrendDirection direction;
@override final  InsightConfidence confidence;
@override final  DateTime generatedAt;
@override final  String? recommendation;

/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceInsightCopyWith<_PerformanceInsight> get copyWith => __$PerformanceInsightCopyWithImpl<_PerformanceInsight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceInsightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceInsight&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.metricValue, metricValue) || other.metricValue == metricValue)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,description,metricLabel,metricValue,direction,confidence,generatedAt,recommendation);

@override
String toString() {
  return 'PerformanceInsight(type: $type, title: $title, description: $description, metricLabel: $metricLabel, metricValue: $metricValue, direction: $direction, confidence: $confidence, generatedAt: $generatedAt, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class _$PerformanceInsightCopyWith<$Res> implements $PerformanceInsightCopyWith<$Res> {
  factory _$PerformanceInsightCopyWith(_PerformanceInsight value, $Res Function(_PerformanceInsight) _then) = __$PerformanceInsightCopyWithImpl;
@override @useResult
$Res call({
 InsightType type, String title, String description, String metricLabel, String metricValue, TrendDirection direction, InsightConfidence confidence, DateTime generatedAt, String? recommendation
});




}
/// @nodoc
class __$PerformanceInsightCopyWithImpl<$Res>
    implements _$PerformanceInsightCopyWith<$Res> {
  __$PerformanceInsightCopyWithImpl(this._self, this._then);

  final _PerformanceInsight _self;
  final $Res Function(_PerformanceInsight) _then;

/// Create a copy of PerformanceInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? description = null,Object? metricLabel = null,Object? metricValue = null,Object? direction = null,Object? confidence = null,Object? generatedAt = null,Object? recommendation = freezed,}) {
  return _then(_PerformanceInsight(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InsightType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,metricLabel: null == metricLabel ? _self.metricLabel : metricLabel // ignore: cast_nullable_to_non_nullable
as String,metricValue: null == metricValue ? _self.metricValue : metricValue // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TrendDirection,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as InsightConfidence,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
