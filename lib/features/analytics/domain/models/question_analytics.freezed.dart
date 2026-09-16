// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionAnalytics {

 String get questionId; String get version; String get categoryId; Difficulty get difficulty; int get totalAttempts; int get correctAttempts; int get incorrectAttempts; int get timeoutCount; int get skipCount;@DurationConverter() Duration get averageResponseTime;@DurationConverter() Duration get fastestResponseTime;@DurationConverter() Duration get slowestResponseTime;@TimestampConverter() DateTime? get firstAttemptAt;@TimestampConverter() DateTime? get lastAttemptAt; Map<String, int> get modeBreakdown;
/// Create a copy of QuestionAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionAnalyticsCopyWith<QuestionAnalytics> get copyWith => _$QuestionAnalyticsCopyWithImpl<QuestionAnalytics>(this as QuestionAnalytics, _$identity);

  /// Serializes this QuestionAnalytics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionAnalytics&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.version, version) || other.version == version)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalAttempts, totalAttempts) || other.totalAttempts == totalAttempts)&&(identical(other.correctAttempts, correctAttempts) || other.correctAttempts == correctAttempts)&&(identical(other.incorrectAttempts, incorrectAttempts) || other.incorrectAttempts == incorrectAttempts)&&(identical(other.timeoutCount, timeoutCount) || other.timeoutCount == timeoutCount)&&(identical(other.skipCount, skipCount) || other.skipCount == skipCount)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.fastestResponseTime, fastestResponseTime) || other.fastestResponseTime == fastestResponseTime)&&(identical(other.slowestResponseTime, slowestResponseTime) || other.slowestResponseTime == slowestResponseTime)&&(identical(other.firstAttemptAt, firstAttemptAt) || other.firstAttemptAt == firstAttemptAt)&&(identical(other.lastAttemptAt, lastAttemptAt) || other.lastAttemptAt == lastAttemptAt)&&const DeepCollectionEquality().equals(other.modeBreakdown, modeBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,version,categoryId,difficulty,totalAttempts,correctAttempts,incorrectAttempts,timeoutCount,skipCount,averageResponseTime,fastestResponseTime,slowestResponseTime,firstAttemptAt,lastAttemptAt,const DeepCollectionEquality().hash(modeBreakdown));

@override
String toString() {
  return 'QuestionAnalytics(questionId: $questionId, version: $version, categoryId: $categoryId, difficulty: $difficulty, totalAttempts: $totalAttempts, correctAttempts: $correctAttempts, incorrectAttempts: $incorrectAttempts, timeoutCount: $timeoutCount, skipCount: $skipCount, averageResponseTime: $averageResponseTime, fastestResponseTime: $fastestResponseTime, slowestResponseTime: $slowestResponseTime, firstAttemptAt: $firstAttemptAt, lastAttemptAt: $lastAttemptAt, modeBreakdown: $modeBreakdown)';
}


}

/// @nodoc
abstract mixin class $QuestionAnalyticsCopyWith<$Res>  {
  factory $QuestionAnalyticsCopyWith(QuestionAnalytics value, $Res Function(QuestionAnalytics) _then) = _$QuestionAnalyticsCopyWithImpl;
@useResult
$Res call({
 String questionId, String version, String categoryId, Difficulty difficulty, int totalAttempts, int correctAttempts, int incorrectAttempts, int timeoutCount, int skipCount,@DurationConverter() Duration averageResponseTime,@DurationConverter() Duration fastestResponseTime,@DurationConverter() Duration slowestResponseTime,@TimestampConverter() DateTime? firstAttemptAt,@TimestampConverter() DateTime? lastAttemptAt, Map<String, int> modeBreakdown
});




}
/// @nodoc
class _$QuestionAnalyticsCopyWithImpl<$Res>
    implements $QuestionAnalyticsCopyWith<$Res> {
  _$QuestionAnalyticsCopyWithImpl(this._self, this._then);

  final QuestionAnalytics _self;
  final $Res Function(QuestionAnalytics) _then;

/// Create a copy of QuestionAnalytics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? version = null,Object? categoryId = null,Object? difficulty = null,Object? totalAttempts = null,Object? correctAttempts = null,Object? incorrectAttempts = null,Object? timeoutCount = null,Object? skipCount = null,Object? averageResponseTime = null,Object? fastestResponseTime = null,Object? slowestResponseTime = null,Object? firstAttemptAt = freezed,Object? lastAttemptAt = freezed,Object? modeBreakdown = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,totalAttempts: null == totalAttempts ? _self.totalAttempts : totalAttempts // ignore: cast_nullable_to_non_nullable
as int,correctAttempts: null == correctAttempts ? _self.correctAttempts : correctAttempts // ignore: cast_nullable_to_non_nullable
as int,incorrectAttempts: null == incorrectAttempts ? _self.incorrectAttempts : incorrectAttempts // ignore: cast_nullable_to_non_nullable
as int,timeoutCount: null == timeoutCount ? _self.timeoutCount : timeoutCount // ignore: cast_nullable_to_non_nullable
as int,skipCount: null == skipCount ? _self.skipCount : skipCount // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,fastestResponseTime: null == fastestResponseTime ? _self.fastestResponseTime : fastestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,slowestResponseTime: null == slowestResponseTime ? _self.slowestResponseTime : slowestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,firstAttemptAt: freezed == firstAttemptAt ? _self.firstAttemptAt : firstAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,modeBreakdown: null == modeBreakdown ? _self.modeBreakdown : modeBreakdown // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionAnalytics].
extension QuestionAnalyticsPatterns on QuestionAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _QuestionAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  String version,  String categoryId,  Difficulty difficulty,  int totalAttempts,  int correctAttempts,  int incorrectAttempts,  int timeoutCount,  int skipCount, @DurationConverter()  Duration averageResponseTime, @DurationConverter()  Duration fastestResponseTime, @DurationConverter()  Duration slowestResponseTime, @TimestampConverter()  DateTime? firstAttemptAt, @TimestampConverter()  DateTime? lastAttemptAt,  Map<String, int> modeBreakdown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionAnalytics() when $default != null:
return $default(_that.questionId,_that.version,_that.categoryId,_that.difficulty,_that.totalAttempts,_that.correctAttempts,_that.incorrectAttempts,_that.timeoutCount,_that.skipCount,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.firstAttemptAt,_that.lastAttemptAt,_that.modeBreakdown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  String version,  String categoryId,  Difficulty difficulty,  int totalAttempts,  int correctAttempts,  int incorrectAttempts,  int timeoutCount,  int skipCount, @DurationConverter()  Duration averageResponseTime, @DurationConverter()  Duration fastestResponseTime, @DurationConverter()  Duration slowestResponseTime, @TimestampConverter()  DateTime? firstAttemptAt, @TimestampConverter()  DateTime? lastAttemptAt,  Map<String, int> modeBreakdown)  $default,) {final _that = this;
switch (_that) {
case _QuestionAnalytics():
return $default(_that.questionId,_that.version,_that.categoryId,_that.difficulty,_that.totalAttempts,_that.correctAttempts,_that.incorrectAttempts,_that.timeoutCount,_that.skipCount,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.firstAttemptAt,_that.lastAttemptAt,_that.modeBreakdown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  String version,  String categoryId,  Difficulty difficulty,  int totalAttempts,  int correctAttempts,  int incorrectAttempts,  int timeoutCount,  int skipCount, @DurationConverter()  Duration averageResponseTime, @DurationConverter()  Duration fastestResponseTime, @DurationConverter()  Duration slowestResponseTime, @TimestampConverter()  DateTime? firstAttemptAt, @TimestampConverter()  DateTime? lastAttemptAt,  Map<String, int> modeBreakdown)?  $default,) {final _that = this;
switch (_that) {
case _QuestionAnalytics() when $default != null:
return $default(_that.questionId,_that.version,_that.categoryId,_that.difficulty,_that.totalAttempts,_that.correctAttempts,_that.incorrectAttempts,_that.timeoutCount,_that.skipCount,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.firstAttemptAt,_that.lastAttemptAt,_that.modeBreakdown);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionAnalytics extends QuestionAnalytics {
  const _QuestionAnalytics({required this.questionId, required this.version, required this.categoryId, required this.difficulty, this.totalAttempts = 0, this.correctAttempts = 0, this.incorrectAttempts = 0, this.timeoutCount = 0, this.skipCount = 0, @DurationConverter() this.averageResponseTime = Duration.zero, @DurationConverter() this.fastestResponseTime = Duration.zero, @DurationConverter() this.slowestResponseTime = Duration.zero, @TimestampConverter() this.firstAttemptAt, @TimestampConverter() this.lastAttemptAt, final  Map<String, int> modeBreakdown = const {}}): _modeBreakdown = modeBreakdown,super._();
  factory _QuestionAnalytics.fromJson(Map<String, dynamic> json) => _$QuestionAnalyticsFromJson(json);

@override final  String questionId;
@override final  String version;
@override final  String categoryId;
@override final  Difficulty difficulty;
@override@JsonKey() final  int totalAttempts;
@override@JsonKey() final  int correctAttempts;
@override@JsonKey() final  int incorrectAttempts;
@override@JsonKey() final  int timeoutCount;
@override@JsonKey() final  int skipCount;
@override@JsonKey()@DurationConverter() final  Duration averageResponseTime;
@override@JsonKey()@DurationConverter() final  Duration fastestResponseTime;
@override@JsonKey()@DurationConverter() final  Duration slowestResponseTime;
@override@TimestampConverter() final  DateTime? firstAttemptAt;
@override@TimestampConverter() final  DateTime? lastAttemptAt;
 final  Map<String, int> _modeBreakdown;
@override@JsonKey() Map<String, int> get modeBreakdown {
  if (_modeBreakdown is EqualUnmodifiableMapView) return _modeBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_modeBreakdown);
}


/// Create a copy of QuestionAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionAnalyticsCopyWith<_QuestionAnalytics> get copyWith => __$QuestionAnalyticsCopyWithImpl<_QuestionAnalytics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionAnalyticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionAnalytics&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.version, version) || other.version == version)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalAttempts, totalAttempts) || other.totalAttempts == totalAttempts)&&(identical(other.correctAttempts, correctAttempts) || other.correctAttempts == correctAttempts)&&(identical(other.incorrectAttempts, incorrectAttempts) || other.incorrectAttempts == incorrectAttempts)&&(identical(other.timeoutCount, timeoutCount) || other.timeoutCount == timeoutCount)&&(identical(other.skipCount, skipCount) || other.skipCount == skipCount)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.fastestResponseTime, fastestResponseTime) || other.fastestResponseTime == fastestResponseTime)&&(identical(other.slowestResponseTime, slowestResponseTime) || other.slowestResponseTime == slowestResponseTime)&&(identical(other.firstAttemptAt, firstAttemptAt) || other.firstAttemptAt == firstAttemptAt)&&(identical(other.lastAttemptAt, lastAttemptAt) || other.lastAttemptAt == lastAttemptAt)&&const DeepCollectionEquality().equals(other._modeBreakdown, _modeBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,version,categoryId,difficulty,totalAttempts,correctAttempts,incorrectAttempts,timeoutCount,skipCount,averageResponseTime,fastestResponseTime,slowestResponseTime,firstAttemptAt,lastAttemptAt,const DeepCollectionEquality().hash(_modeBreakdown));

@override
String toString() {
  return 'QuestionAnalytics(questionId: $questionId, version: $version, categoryId: $categoryId, difficulty: $difficulty, totalAttempts: $totalAttempts, correctAttempts: $correctAttempts, incorrectAttempts: $incorrectAttempts, timeoutCount: $timeoutCount, skipCount: $skipCount, averageResponseTime: $averageResponseTime, fastestResponseTime: $fastestResponseTime, slowestResponseTime: $slowestResponseTime, firstAttemptAt: $firstAttemptAt, lastAttemptAt: $lastAttemptAt, modeBreakdown: $modeBreakdown)';
}


}

/// @nodoc
abstract mixin class _$QuestionAnalyticsCopyWith<$Res> implements $QuestionAnalyticsCopyWith<$Res> {
  factory _$QuestionAnalyticsCopyWith(_QuestionAnalytics value, $Res Function(_QuestionAnalytics) _then) = __$QuestionAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 String questionId, String version, String categoryId, Difficulty difficulty, int totalAttempts, int correctAttempts, int incorrectAttempts, int timeoutCount, int skipCount,@DurationConverter() Duration averageResponseTime,@DurationConverter() Duration fastestResponseTime,@DurationConverter() Duration slowestResponseTime,@TimestampConverter() DateTime? firstAttemptAt,@TimestampConverter() DateTime? lastAttemptAt, Map<String, int> modeBreakdown
});




}
/// @nodoc
class __$QuestionAnalyticsCopyWithImpl<$Res>
    implements _$QuestionAnalyticsCopyWith<$Res> {
  __$QuestionAnalyticsCopyWithImpl(this._self, this._then);

  final _QuestionAnalytics _self;
  final $Res Function(_QuestionAnalytics) _then;

/// Create a copy of QuestionAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? version = null,Object? categoryId = null,Object? difficulty = null,Object? totalAttempts = null,Object? correctAttempts = null,Object? incorrectAttempts = null,Object? timeoutCount = null,Object? skipCount = null,Object? averageResponseTime = null,Object? fastestResponseTime = null,Object? slowestResponseTime = null,Object? firstAttemptAt = freezed,Object? lastAttemptAt = freezed,Object? modeBreakdown = null,}) {
  return _then(_QuestionAnalytics(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,totalAttempts: null == totalAttempts ? _self.totalAttempts : totalAttempts // ignore: cast_nullable_to_non_nullable
as int,correctAttempts: null == correctAttempts ? _self.correctAttempts : correctAttempts // ignore: cast_nullable_to_non_nullable
as int,incorrectAttempts: null == incorrectAttempts ? _self.incorrectAttempts : incorrectAttempts // ignore: cast_nullable_to_non_nullable
as int,timeoutCount: null == timeoutCount ? _self.timeoutCount : timeoutCount // ignore: cast_nullable_to_non_nullable
as int,skipCount: null == skipCount ? _self.skipCount : skipCount // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,fastestResponseTime: null == fastestResponseTime ? _self.fastestResponseTime : fastestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,slowestResponseTime: null == slowestResponseTime ? _self.slowestResponseTime : slowestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,firstAttemptAt: freezed == firstAttemptAt ? _self.firstAttemptAt : firstAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,modeBreakdown: null == modeBreakdown ? _self._modeBreakdown : modeBreakdown // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
