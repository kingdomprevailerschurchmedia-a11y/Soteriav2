// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'difficulty_performance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DifficultyPerformance {

 Difficulty get difficulty; int get totalQuizzes; int get totalQuestions; int get correctAnswers; double get accuracy; int get averageScore; Duration get averageResponseTime;
/// Create a copy of DifficultyPerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DifficultyPerformanceCopyWith<DifficultyPerformance> get copyWith => _$DifficultyPerformanceCopyWithImpl<DifficultyPerformance>(this as DifficultyPerformance, _$identity);

  /// Serializes this DifficultyPerformance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DifficultyPerformance&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalQuizzes, totalQuizzes) || other.totalQuizzes == totalQuizzes)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,difficulty,totalQuizzes,totalQuestions,correctAnswers,accuracy,averageScore,averageResponseTime);

@override
String toString() {
  return 'DifficultyPerformance(difficulty: $difficulty, totalQuizzes: $totalQuizzes, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, accuracy: $accuracy, averageScore: $averageScore, averageResponseTime: $averageResponseTime)';
}


}

/// @nodoc
abstract mixin class $DifficultyPerformanceCopyWith<$Res>  {
  factory $DifficultyPerformanceCopyWith(DifficultyPerformance value, $Res Function(DifficultyPerformance) _then) = _$DifficultyPerformanceCopyWithImpl;
@useResult
$Res call({
 Difficulty difficulty, int totalQuizzes, int totalQuestions, int correctAnswers, double accuracy, int averageScore, Duration averageResponseTime
});




}
/// @nodoc
class _$DifficultyPerformanceCopyWithImpl<$Res>
    implements $DifficultyPerformanceCopyWith<$Res> {
  _$DifficultyPerformanceCopyWithImpl(this._self, this._then);

  final DifficultyPerformance _self;
  final $Res Function(DifficultyPerformance) _then;

/// Create a copy of DifficultyPerformance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? difficulty = null,Object? totalQuizzes = null,Object? totalQuestions = null,Object? correctAnswers = null,Object? accuracy = null,Object? averageScore = null,Object? averageResponseTime = null,}) {
  return _then(_self.copyWith(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,totalQuizzes: null == totalQuizzes ? _self.totalQuizzes : totalQuizzes // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [DifficultyPerformance].
extension DifficultyPerformancePatterns on DifficultyPerformance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DifficultyPerformance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DifficultyPerformance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DifficultyPerformance value)  $default,){
final _that = this;
switch (_that) {
case _DifficultyPerformance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DifficultyPerformance value)?  $default,){
final _that = this;
switch (_that) {
case _DifficultyPerformance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Difficulty difficulty,  int totalQuizzes,  int totalQuestions,  int correctAnswers,  double accuracy,  int averageScore,  Duration averageResponseTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DifficultyPerformance() when $default != null:
return $default(_that.difficulty,_that.totalQuizzes,_that.totalQuestions,_that.correctAnswers,_that.accuracy,_that.averageScore,_that.averageResponseTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Difficulty difficulty,  int totalQuizzes,  int totalQuestions,  int correctAnswers,  double accuracy,  int averageScore,  Duration averageResponseTime)  $default,) {final _that = this;
switch (_that) {
case _DifficultyPerformance():
return $default(_that.difficulty,_that.totalQuizzes,_that.totalQuestions,_that.correctAnswers,_that.accuracy,_that.averageScore,_that.averageResponseTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Difficulty difficulty,  int totalQuizzes,  int totalQuestions,  int correctAnswers,  double accuracy,  int averageScore,  Duration averageResponseTime)?  $default,) {final _that = this;
switch (_that) {
case _DifficultyPerformance() when $default != null:
return $default(_that.difficulty,_that.totalQuizzes,_that.totalQuestions,_that.correctAnswers,_that.accuracy,_that.averageScore,_that.averageResponseTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DifficultyPerformance implements DifficultyPerformance {
  const _DifficultyPerformance({required this.difficulty, required this.totalQuizzes, required this.totalQuestions, required this.correctAnswers, required this.accuracy, required this.averageScore, required this.averageResponseTime});
  factory _DifficultyPerformance.fromJson(Map<String, dynamic> json) => _$DifficultyPerformanceFromJson(json);

@override final  Difficulty difficulty;
@override final  int totalQuizzes;
@override final  int totalQuestions;
@override final  int correctAnswers;
@override final  double accuracy;
@override final  int averageScore;
@override final  Duration averageResponseTime;

/// Create a copy of DifficultyPerformance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DifficultyPerformanceCopyWith<_DifficultyPerformance> get copyWith => __$DifficultyPerformanceCopyWithImpl<_DifficultyPerformance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DifficultyPerformanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DifficultyPerformance&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalQuizzes, totalQuizzes) || other.totalQuizzes == totalQuizzes)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,difficulty,totalQuizzes,totalQuestions,correctAnswers,accuracy,averageScore,averageResponseTime);

@override
String toString() {
  return 'DifficultyPerformance(difficulty: $difficulty, totalQuizzes: $totalQuizzes, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, accuracy: $accuracy, averageScore: $averageScore, averageResponseTime: $averageResponseTime)';
}


}

/// @nodoc
abstract mixin class _$DifficultyPerformanceCopyWith<$Res> implements $DifficultyPerformanceCopyWith<$Res> {
  factory _$DifficultyPerformanceCopyWith(_DifficultyPerformance value, $Res Function(_DifficultyPerformance) _then) = __$DifficultyPerformanceCopyWithImpl;
@override @useResult
$Res call({
 Difficulty difficulty, int totalQuizzes, int totalQuestions, int correctAnswers, double accuracy, int averageScore, Duration averageResponseTime
});




}
/// @nodoc
class __$DifficultyPerformanceCopyWithImpl<$Res>
    implements _$DifficultyPerformanceCopyWith<$Res> {
  __$DifficultyPerformanceCopyWithImpl(this._self, this._then);

  final _DifficultyPerformance _self;
  final $Res Function(_DifficultyPerformance) _then;

/// Create a copy of DifficultyPerformance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? difficulty = null,Object? totalQuizzes = null,Object? totalQuestions = null,Object? correctAnswers = null,Object? accuracy = null,Object? averageScore = null,Object? averageResponseTime = null,}) {
  return _then(_DifficultyPerformance(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,totalQuizzes: null == totalQuizzes ? _self.totalQuizzes : totalQuizzes // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
