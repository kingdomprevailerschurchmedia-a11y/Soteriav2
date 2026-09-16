// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_performance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryPerformance {

 String get category; int get totalQuizzes; int get totalQuestions; int get correctAnswers; double get accuracy; int get averageScore; int get bestScore; Duration get averageResponseTime; int get totalXp;
/// Create a copy of CategoryPerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryPerformanceCopyWith<CategoryPerformance> get copyWith => _$CategoryPerformanceCopyWithImpl<CategoryPerformance>(this as CategoryPerformance, _$identity);

  /// Serializes this CategoryPerformance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryPerformance&&(identical(other.category, category) || other.category == category)&&(identical(other.totalQuizzes, totalQuizzes) || other.totalQuizzes == totalQuizzes)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,totalQuizzes,totalQuestions,correctAnswers,accuracy,averageScore,bestScore,averageResponseTime,totalXp);

@override
String toString() {
  return 'CategoryPerformance(category: $category, totalQuizzes: $totalQuizzes, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, accuracy: $accuracy, averageScore: $averageScore, bestScore: $bestScore, averageResponseTime: $averageResponseTime, totalXp: $totalXp)';
}


}

/// @nodoc
abstract mixin class $CategoryPerformanceCopyWith<$Res>  {
  factory $CategoryPerformanceCopyWith(CategoryPerformance value, $Res Function(CategoryPerformance) _then) = _$CategoryPerformanceCopyWithImpl;
@useResult
$Res call({
 String category, int totalQuizzes, int totalQuestions, int correctAnswers, double accuracy, int averageScore, int bestScore, Duration averageResponseTime, int totalXp
});




}
/// @nodoc
class _$CategoryPerformanceCopyWithImpl<$Res>
    implements $CategoryPerformanceCopyWith<$Res> {
  _$CategoryPerformanceCopyWithImpl(this._self, this._then);

  final CategoryPerformance _self;
  final $Res Function(CategoryPerformance) _then;

/// Create a copy of CategoryPerformance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? totalQuizzes = null,Object? totalQuestions = null,Object? correctAnswers = null,Object? accuracy = null,Object? averageScore = null,Object? bestScore = null,Object? averageResponseTime = null,Object? totalXp = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,totalQuizzes: null == totalQuizzes ? _self.totalQuizzes : totalQuizzes // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryPerformance].
extension CategoryPerformancePatterns on CategoryPerformance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryPerformance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryPerformance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryPerformance value)  $default,){
final _that = this;
switch (_that) {
case _CategoryPerformance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryPerformance value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryPerformance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  int totalQuizzes,  int totalQuestions,  int correctAnswers,  double accuracy,  int averageScore,  int bestScore,  Duration averageResponseTime,  int totalXp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryPerformance() when $default != null:
return $default(_that.category,_that.totalQuizzes,_that.totalQuestions,_that.correctAnswers,_that.accuracy,_that.averageScore,_that.bestScore,_that.averageResponseTime,_that.totalXp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  int totalQuizzes,  int totalQuestions,  int correctAnswers,  double accuracy,  int averageScore,  int bestScore,  Duration averageResponseTime,  int totalXp)  $default,) {final _that = this;
switch (_that) {
case _CategoryPerformance():
return $default(_that.category,_that.totalQuizzes,_that.totalQuestions,_that.correctAnswers,_that.accuracy,_that.averageScore,_that.bestScore,_that.averageResponseTime,_that.totalXp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  int totalQuizzes,  int totalQuestions,  int correctAnswers,  double accuracy,  int averageScore,  int bestScore,  Duration averageResponseTime,  int totalXp)?  $default,) {final _that = this;
switch (_that) {
case _CategoryPerformance() when $default != null:
return $default(_that.category,_that.totalQuizzes,_that.totalQuestions,_that.correctAnswers,_that.accuracy,_that.averageScore,_that.bestScore,_that.averageResponseTime,_that.totalXp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryPerformance implements CategoryPerformance {
  const _CategoryPerformance({required this.category, required this.totalQuizzes, required this.totalQuestions, required this.correctAnswers, required this.accuracy, required this.averageScore, required this.bestScore, required this.averageResponseTime, required this.totalXp});
  factory _CategoryPerformance.fromJson(Map<String, dynamic> json) => _$CategoryPerformanceFromJson(json);

@override final  String category;
@override final  int totalQuizzes;
@override final  int totalQuestions;
@override final  int correctAnswers;
@override final  double accuracy;
@override final  int averageScore;
@override final  int bestScore;
@override final  Duration averageResponseTime;
@override final  int totalXp;

/// Create a copy of CategoryPerformance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryPerformanceCopyWith<_CategoryPerformance> get copyWith => __$CategoryPerformanceCopyWithImpl<_CategoryPerformance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryPerformanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryPerformance&&(identical(other.category, category) || other.category == category)&&(identical(other.totalQuizzes, totalQuizzes) || other.totalQuizzes == totalQuizzes)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,totalQuizzes,totalQuestions,correctAnswers,accuracy,averageScore,bestScore,averageResponseTime,totalXp);

@override
String toString() {
  return 'CategoryPerformance(category: $category, totalQuizzes: $totalQuizzes, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, accuracy: $accuracy, averageScore: $averageScore, bestScore: $bestScore, averageResponseTime: $averageResponseTime, totalXp: $totalXp)';
}


}

/// @nodoc
abstract mixin class _$CategoryPerformanceCopyWith<$Res> implements $CategoryPerformanceCopyWith<$Res> {
  factory _$CategoryPerformanceCopyWith(_CategoryPerformance value, $Res Function(_CategoryPerformance) _then) = __$CategoryPerformanceCopyWithImpl;
@override @useResult
$Res call({
 String category, int totalQuizzes, int totalQuestions, int correctAnswers, double accuracy, int averageScore, int bestScore, Duration averageResponseTime, int totalXp
});




}
/// @nodoc
class __$CategoryPerformanceCopyWithImpl<$Res>
    implements _$CategoryPerformanceCopyWith<$Res> {
  __$CategoryPerformanceCopyWithImpl(this._self, this._then);

  final _CategoryPerformance _self;
  final $Res Function(_CategoryPerformance) _then;

/// Create a copy of CategoryPerformance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? totalQuizzes = null,Object? totalQuestions = null,Object? correctAnswers = null,Object? accuracy = null,Object? averageScore = null,Object? bestScore = null,Object? averageResponseTime = null,Object? totalXp = null,}) {
  return _then(_CategoryPerformance(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,totalQuizzes: null == totalQuizzes ? _self.totalQuizzes : totalQuizzes // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
