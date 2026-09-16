// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonalPerformanceAnalytics {

 String get playerId; TimePeriod get period; int get totalQuizzes; int get totalQuestions; int get totalCorrect; int get totalIncorrect; int get totalSkipped; int get totalTimedOut; double get averageAccuracy; int get averageScore; int get bestScore; double get bestAccuracy; int get bestStreak; Duration get averageResponseTime; Duration get fastestResponseTime; Duration get slowestResponseTime; int get totalXp; List<CategoryPerformance> get categoryPerformance; List<DifficultyPerformance> get difficultyPerformance; PerformanceTrend get accuracyTrend; PerformanceTrend get scoreTrend; PerformanceTrend get speedTrend; PerformanceTrend get xpTrend; ConsistencyMetrics get consistency; List<PerformanceInsight> get insights; DateTime get calculatedAt;
/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalPerformanceAnalyticsCopyWith<PersonalPerformanceAnalytics> get copyWith => _$PersonalPerformanceAnalyticsCopyWithImpl<PersonalPerformanceAnalytics>(this as PersonalPerformanceAnalytics, _$identity);

  /// Serializes this PersonalPerformanceAnalytics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalPerformanceAnalytics&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.period, period) || other.period == period)&&(identical(other.totalQuizzes, totalQuizzes) || other.totalQuizzes == totalQuizzes)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.totalCorrect, totalCorrect) || other.totalCorrect == totalCorrect)&&(identical(other.totalIncorrect, totalIncorrect) || other.totalIncorrect == totalIncorrect)&&(identical(other.totalSkipped, totalSkipped) || other.totalSkipped == totalSkipped)&&(identical(other.totalTimedOut, totalTimedOut) || other.totalTimedOut == totalTimedOut)&&(identical(other.averageAccuracy, averageAccuracy) || other.averageAccuracy == averageAccuracy)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.bestAccuracy, bestAccuracy) || other.bestAccuracy == bestAccuracy)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.fastestResponseTime, fastestResponseTime) || other.fastestResponseTime == fastestResponseTime)&&(identical(other.slowestResponseTime, slowestResponseTime) || other.slowestResponseTime == slowestResponseTime)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&const DeepCollectionEquality().equals(other.categoryPerformance, categoryPerformance)&&const DeepCollectionEquality().equals(other.difficultyPerformance, difficultyPerformance)&&(identical(other.accuracyTrend, accuracyTrend) || other.accuracyTrend == accuracyTrend)&&(identical(other.scoreTrend, scoreTrend) || other.scoreTrend == scoreTrend)&&(identical(other.speedTrend, speedTrend) || other.speedTrend == speedTrend)&&(identical(other.xpTrend, xpTrend) || other.xpTrend == xpTrend)&&(identical(other.consistency, consistency) || other.consistency == consistency)&&const DeepCollectionEquality().equals(other.insights, insights)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,playerId,period,totalQuizzes,totalQuestions,totalCorrect,totalIncorrect,totalSkipped,totalTimedOut,averageAccuracy,averageScore,bestScore,bestAccuracy,bestStreak,averageResponseTime,fastestResponseTime,slowestResponseTime,totalXp,const DeepCollectionEquality().hash(categoryPerformance),const DeepCollectionEquality().hash(difficultyPerformance),accuracyTrend,scoreTrend,speedTrend,xpTrend,consistency,const DeepCollectionEquality().hash(insights),calculatedAt]);

@override
String toString() {
  return 'PersonalPerformanceAnalytics(playerId: $playerId, period: $period, totalQuizzes: $totalQuizzes, totalQuestions: $totalQuestions, totalCorrect: $totalCorrect, totalIncorrect: $totalIncorrect, totalSkipped: $totalSkipped, totalTimedOut: $totalTimedOut, averageAccuracy: $averageAccuracy, averageScore: $averageScore, bestScore: $bestScore, bestAccuracy: $bestAccuracy, bestStreak: $bestStreak, averageResponseTime: $averageResponseTime, fastestResponseTime: $fastestResponseTime, slowestResponseTime: $slowestResponseTime, totalXp: $totalXp, categoryPerformance: $categoryPerformance, difficultyPerformance: $difficultyPerformance, accuracyTrend: $accuracyTrend, scoreTrend: $scoreTrend, speedTrend: $speedTrend, xpTrend: $xpTrend, consistency: $consistency, insights: $insights, calculatedAt: $calculatedAt)';
}


}

/// @nodoc
abstract mixin class $PersonalPerformanceAnalyticsCopyWith<$Res>  {
  factory $PersonalPerformanceAnalyticsCopyWith(PersonalPerformanceAnalytics value, $Res Function(PersonalPerformanceAnalytics) _then) = _$PersonalPerformanceAnalyticsCopyWithImpl;
@useResult
$Res call({
 String playerId, TimePeriod period, int totalQuizzes, int totalQuestions, int totalCorrect, int totalIncorrect, int totalSkipped, int totalTimedOut, double averageAccuracy, int averageScore, int bestScore, double bestAccuracy, int bestStreak, Duration averageResponseTime, Duration fastestResponseTime, Duration slowestResponseTime, int totalXp, List<CategoryPerformance> categoryPerformance, List<DifficultyPerformance> difficultyPerformance, PerformanceTrend accuracyTrend, PerformanceTrend scoreTrend, PerformanceTrend speedTrend, PerformanceTrend xpTrend, ConsistencyMetrics consistency, List<PerformanceInsight> insights, DateTime calculatedAt
});


$PerformanceTrendCopyWith<$Res> get accuracyTrend;$PerformanceTrendCopyWith<$Res> get scoreTrend;$PerformanceTrendCopyWith<$Res> get speedTrend;$PerformanceTrendCopyWith<$Res> get xpTrend;$ConsistencyMetricsCopyWith<$Res> get consistency;

}
/// @nodoc
class _$PersonalPerformanceAnalyticsCopyWithImpl<$Res>
    implements $PersonalPerformanceAnalyticsCopyWith<$Res> {
  _$PersonalPerformanceAnalyticsCopyWithImpl(this._self, this._then);

  final PersonalPerformanceAnalytics _self;
  final $Res Function(PersonalPerformanceAnalytics) _then;

/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? period = null,Object? totalQuizzes = null,Object? totalQuestions = null,Object? totalCorrect = null,Object? totalIncorrect = null,Object? totalSkipped = null,Object? totalTimedOut = null,Object? averageAccuracy = null,Object? averageScore = null,Object? bestScore = null,Object? bestAccuracy = null,Object? bestStreak = null,Object? averageResponseTime = null,Object? fastestResponseTime = null,Object? slowestResponseTime = null,Object? totalXp = null,Object? categoryPerformance = null,Object? difficultyPerformance = null,Object? accuracyTrend = null,Object? scoreTrend = null,Object? speedTrend = null,Object? xpTrend = null,Object? consistency = null,Object? insights = null,Object? calculatedAt = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as TimePeriod,totalQuizzes: null == totalQuizzes ? _self.totalQuizzes : totalQuizzes // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,totalCorrect: null == totalCorrect ? _self.totalCorrect : totalCorrect // ignore: cast_nullable_to_non_nullable
as int,totalIncorrect: null == totalIncorrect ? _self.totalIncorrect : totalIncorrect // ignore: cast_nullable_to_non_nullable
as int,totalSkipped: null == totalSkipped ? _self.totalSkipped : totalSkipped // ignore: cast_nullable_to_non_nullable
as int,totalTimedOut: null == totalTimedOut ? _self.totalTimedOut : totalTimedOut // ignore: cast_nullable_to_non_nullable
as int,averageAccuracy: null == averageAccuracy ? _self.averageAccuracy : averageAccuracy // ignore: cast_nullable_to_non_nullable
as double,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,bestAccuracy: null == bestAccuracy ? _self.bestAccuracy : bestAccuracy // ignore: cast_nullable_to_non_nullable
as double,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,fastestResponseTime: null == fastestResponseTime ? _self.fastestResponseTime : fastestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,slowestResponseTime: null == slowestResponseTime ? _self.slowestResponseTime : slowestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,categoryPerformance: null == categoryPerformance ? _self.categoryPerformance : categoryPerformance // ignore: cast_nullable_to_non_nullable
as List<CategoryPerformance>,difficultyPerformance: null == difficultyPerformance ? _self.difficultyPerformance : difficultyPerformance // ignore: cast_nullable_to_non_nullable
as List<DifficultyPerformance>,accuracyTrend: null == accuracyTrend ? _self.accuracyTrend : accuracyTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,scoreTrend: null == scoreTrend ? _self.scoreTrend : scoreTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,speedTrend: null == speedTrend ? _self.speedTrend : speedTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,xpTrend: null == xpTrend ? _self.xpTrend : xpTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,consistency: null == consistency ? _self.consistency : consistency // ignore: cast_nullable_to_non_nullable
as ConsistencyMetrics,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<PerformanceInsight>,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get accuracyTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.accuracyTrend, (value) {
    return _then(_self.copyWith(accuracyTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get scoreTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.scoreTrend, (value) {
    return _then(_self.copyWith(scoreTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get speedTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.speedTrend, (value) {
    return _then(_self.copyWith(speedTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get xpTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.xpTrend, (value) {
    return _then(_self.copyWith(xpTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsistencyMetricsCopyWith<$Res> get consistency {
  
  return $ConsistencyMetricsCopyWith<$Res>(_self.consistency, (value) {
    return _then(_self.copyWith(consistency: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonalPerformanceAnalytics].
extension PersonalPerformanceAnalyticsPatterns on PersonalPerformanceAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalPerformanceAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalPerformanceAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalPerformanceAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _PersonalPerformanceAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalPerformanceAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalPerformanceAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  TimePeriod period,  int totalQuizzes,  int totalQuestions,  int totalCorrect,  int totalIncorrect,  int totalSkipped,  int totalTimedOut,  double averageAccuracy,  int averageScore,  int bestScore,  double bestAccuracy,  int bestStreak,  Duration averageResponseTime,  Duration fastestResponseTime,  Duration slowestResponseTime,  int totalXp,  List<CategoryPerformance> categoryPerformance,  List<DifficultyPerformance> difficultyPerformance,  PerformanceTrend accuracyTrend,  PerformanceTrend scoreTrend,  PerformanceTrend speedTrend,  PerformanceTrend xpTrend,  ConsistencyMetrics consistency,  List<PerformanceInsight> insights,  DateTime calculatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalPerformanceAnalytics() when $default != null:
return $default(_that.playerId,_that.period,_that.totalQuizzes,_that.totalQuestions,_that.totalCorrect,_that.totalIncorrect,_that.totalSkipped,_that.totalTimedOut,_that.averageAccuracy,_that.averageScore,_that.bestScore,_that.bestAccuracy,_that.bestStreak,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.totalXp,_that.categoryPerformance,_that.difficultyPerformance,_that.accuracyTrend,_that.scoreTrend,_that.speedTrend,_that.xpTrend,_that.consistency,_that.insights,_that.calculatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  TimePeriod period,  int totalQuizzes,  int totalQuestions,  int totalCorrect,  int totalIncorrect,  int totalSkipped,  int totalTimedOut,  double averageAccuracy,  int averageScore,  int bestScore,  double bestAccuracy,  int bestStreak,  Duration averageResponseTime,  Duration fastestResponseTime,  Duration slowestResponseTime,  int totalXp,  List<CategoryPerformance> categoryPerformance,  List<DifficultyPerformance> difficultyPerformance,  PerformanceTrend accuracyTrend,  PerformanceTrend scoreTrend,  PerformanceTrend speedTrend,  PerformanceTrend xpTrend,  ConsistencyMetrics consistency,  List<PerformanceInsight> insights,  DateTime calculatedAt)  $default,) {final _that = this;
switch (_that) {
case _PersonalPerformanceAnalytics():
return $default(_that.playerId,_that.period,_that.totalQuizzes,_that.totalQuestions,_that.totalCorrect,_that.totalIncorrect,_that.totalSkipped,_that.totalTimedOut,_that.averageAccuracy,_that.averageScore,_that.bestScore,_that.bestAccuracy,_that.bestStreak,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.totalXp,_that.categoryPerformance,_that.difficultyPerformance,_that.accuracyTrend,_that.scoreTrend,_that.speedTrend,_that.xpTrend,_that.consistency,_that.insights,_that.calculatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  TimePeriod period,  int totalQuizzes,  int totalQuestions,  int totalCorrect,  int totalIncorrect,  int totalSkipped,  int totalTimedOut,  double averageAccuracy,  int averageScore,  int bestScore,  double bestAccuracy,  int bestStreak,  Duration averageResponseTime,  Duration fastestResponseTime,  Duration slowestResponseTime,  int totalXp,  List<CategoryPerformance> categoryPerformance,  List<DifficultyPerformance> difficultyPerformance,  PerformanceTrend accuracyTrend,  PerformanceTrend scoreTrend,  PerformanceTrend speedTrend,  PerformanceTrend xpTrend,  ConsistencyMetrics consistency,  List<PerformanceInsight> insights,  DateTime calculatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PersonalPerformanceAnalytics() when $default != null:
return $default(_that.playerId,_that.period,_that.totalQuizzes,_that.totalQuestions,_that.totalCorrect,_that.totalIncorrect,_that.totalSkipped,_that.totalTimedOut,_that.averageAccuracy,_that.averageScore,_that.bestScore,_that.bestAccuracy,_that.bestStreak,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.totalXp,_that.categoryPerformance,_that.difficultyPerformance,_that.accuracyTrend,_that.scoreTrend,_that.speedTrend,_that.xpTrend,_that.consistency,_that.insights,_that.calculatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PersonalPerformanceAnalytics implements PersonalPerformanceAnalytics {
  const _PersonalPerformanceAnalytics({required this.playerId, required this.period, required this.totalQuizzes, required this.totalQuestions, required this.totalCorrect, required this.totalIncorrect, required this.totalSkipped, required this.totalTimedOut, required this.averageAccuracy, required this.averageScore, required this.bestScore, required this.bestAccuracy, required this.bestStreak, required this.averageResponseTime, required this.fastestResponseTime, required this.slowestResponseTime, required this.totalXp, required final  List<CategoryPerformance> categoryPerformance, required final  List<DifficultyPerformance> difficultyPerformance, required this.accuracyTrend, required this.scoreTrend, required this.speedTrend, required this.xpTrend, required this.consistency, required final  List<PerformanceInsight> insights, required this.calculatedAt}): _categoryPerformance = categoryPerformance,_difficultyPerformance = difficultyPerformance,_insights = insights;
  factory _PersonalPerformanceAnalytics.fromJson(Map<String, dynamic> json) => _$PersonalPerformanceAnalyticsFromJson(json);

@override final  String playerId;
@override final  TimePeriod period;
@override final  int totalQuizzes;
@override final  int totalQuestions;
@override final  int totalCorrect;
@override final  int totalIncorrect;
@override final  int totalSkipped;
@override final  int totalTimedOut;
@override final  double averageAccuracy;
@override final  int averageScore;
@override final  int bestScore;
@override final  double bestAccuracy;
@override final  int bestStreak;
@override final  Duration averageResponseTime;
@override final  Duration fastestResponseTime;
@override final  Duration slowestResponseTime;
@override final  int totalXp;
 final  List<CategoryPerformance> _categoryPerformance;
@override List<CategoryPerformance> get categoryPerformance {
  if (_categoryPerformance is EqualUnmodifiableListView) return _categoryPerformance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryPerformance);
}

 final  List<DifficultyPerformance> _difficultyPerformance;
@override List<DifficultyPerformance> get difficultyPerformance {
  if (_difficultyPerformance is EqualUnmodifiableListView) return _difficultyPerformance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_difficultyPerformance);
}

@override final  PerformanceTrend accuracyTrend;
@override final  PerformanceTrend scoreTrend;
@override final  PerformanceTrend speedTrend;
@override final  PerformanceTrend xpTrend;
@override final  ConsistencyMetrics consistency;
 final  List<PerformanceInsight> _insights;
@override List<PerformanceInsight> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}

@override final  DateTime calculatedAt;

/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalPerformanceAnalyticsCopyWith<_PersonalPerformanceAnalytics> get copyWith => __$PersonalPerformanceAnalyticsCopyWithImpl<_PersonalPerformanceAnalytics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalPerformanceAnalyticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalPerformanceAnalytics&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.period, period) || other.period == period)&&(identical(other.totalQuizzes, totalQuizzes) || other.totalQuizzes == totalQuizzes)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.totalCorrect, totalCorrect) || other.totalCorrect == totalCorrect)&&(identical(other.totalIncorrect, totalIncorrect) || other.totalIncorrect == totalIncorrect)&&(identical(other.totalSkipped, totalSkipped) || other.totalSkipped == totalSkipped)&&(identical(other.totalTimedOut, totalTimedOut) || other.totalTimedOut == totalTimedOut)&&(identical(other.averageAccuracy, averageAccuracy) || other.averageAccuracy == averageAccuracy)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.bestAccuracy, bestAccuracy) || other.bestAccuracy == bestAccuracy)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.fastestResponseTime, fastestResponseTime) || other.fastestResponseTime == fastestResponseTime)&&(identical(other.slowestResponseTime, slowestResponseTime) || other.slowestResponseTime == slowestResponseTime)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&const DeepCollectionEquality().equals(other._categoryPerformance, _categoryPerformance)&&const DeepCollectionEquality().equals(other._difficultyPerformance, _difficultyPerformance)&&(identical(other.accuracyTrend, accuracyTrend) || other.accuracyTrend == accuracyTrend)&&(identical(other.scoreTrend, scoreTrend) || other.scoreTrend == scoreTrend)&&(identical(other.speedTrend, speedTrend) || other.speedTrend == speedTrend)&&(identical(other.xpTrend, xpTrend) || other.xpTrend == xpTrend)&&(identical(other.consistency, consistency) || other.consistency == consistency)&&const DeepCollectionEquality().equals(other._insights, _insights)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,playerId,period,totalQuizzes,totalQuestions,totalCorrect,totalIncorrect,totalSkipped,totalTimedOut,averageAccuracy,averageScore,bestScore,bestAccuracy,bestStreak,averageResponseTime,fastestResponseTime,slowestResponseTime,totalXp,const DeepCollectionEquality().hash(_categoryPerformance),const DeepCollectionEquality().hash(_difficultyPerformance),accuracyTrend,scoreTrend,speedTrend,xpTrend,consistency,const DeepCollectionEquality().hash(_insights),calculatedAt]);

@override
String toString() {
  return 'PersonalPerformanceAnalytics(playerId: $playerId, period: $period, totalQuizzes: $totalQuizzes, totalQuestions: $totalQuestions, totalCorrect: $totalCorrect, totalIncorrect: $totalIncorrect, totalSkipped: $totalSkipped, totalTimedOut: $totalTimedOut, averageAccuracy: $averageAccuracy, averageScore: $averageScore, bestScore: $bestScore, bestAccuracy: $bestAccuracy, bestStreak: $bestStreak, averageResponseTime: $averageResponseTime, fastestResponseTime: $fastestResponseTime, slowestResponseTime: $slowestResponseTime, totalXp: $totalXp, categoryPerformance: $categoryPerformance, difficultyPerformance: $difficultyPerformance, accuracyTrend: $accuracyTrend, scoreTrend: $scoreTrend, speedTrend: $speedTrend, xpTrend: $xpTrend, consistency: $consistency, insights: $insights, calculatedAt: $calculatedAt)';
}


}

/// @nodoc
abstract mixin class _$PersonalPerformanceAnalyticsCopyWith<$Res> implements $PersonalPerformanceAnalyticsCopyWith<$Res> {
  factory _$PersonalPerformanceAnalyticsCopyWith(_PersonalPerformanceAnalytics value, $Res Function(_PersonalPerformanceAnalytics) _then) = __$PersonalPerformanceAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 String playerId, TimePeriod period, int totalQuizzes, int totalQuestions, int totalCorrect, int totalIncorrect, int totalSkipped, int totalTimedOut, double averageAccuracy, int averageScore, int bestScore, double bestAccuracy, int bestStreak, Duration averageResponseTime, Duration fastestResponseTime, Duration slowestResponseTime, int totalXp, List<CategoryPerformance> categoryPerformance, List<DifficultyPerformance> difficultyPerformance, PerformanceTrend accuracyTrend, PerformanceTrend scoreTrend, PerformanceTrend speedTrend, PerformanceTrend xpTrend, ConsistencyMetrics consistency, List<PerformanceInsight> insights, DateTime calculatedAt
});


@override $PerformanceTrendCopyWith<$Res> get accuracyTrend;@override $PerformanceTrendCopyWith<$Res> get scoreTrend;@override $PerformanceTrendCopyWith<$Res> get speedTrend;@override $PerformanceTrendCopyWith<$Res> get xpTrend;@override $ConsistencyMetricsCopyWith<$Res> get consistency;

}
/// @nodoc
class __$PersonalPerformanceAnalyticsCopyWithImpl<$Res>
    implements _$PersonalPerformanceAnalyticsCopyWith<$Res> {
  __$PersonalPerformanceAnalyticsCopyWithImpl(this._self, this._then);

  final _PersonalPerformanceAnalytics _self;
  final $Res Function(_PersonalPerformanceAnalytics) _then;

/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? period = null,Object? totalQuizzes = null,Object? totalQuestions = null,Object? totalCorrect = null,Object? totalIncorrect = null,Object? totalSkipped = null,Object? totalTimedOut = null,Object? averageAccuracy = null,Object? averageScore = null,Object? bestScore = null,Object? bestAccuracy = null,Object? bestStreak = null,Object? averageResponseTime = null,Object? fastestResponseTime = null,Object? slowestResponseTime = null,Object? totalXp = null,Object? categoryPerformance = null,Object? difficultyPerformance = null,Object? accuracyTrend = null,Object? scoreTrend = null,Object? speedTrend = null,Object? xpTrend = null,Object? consistency = null,Object? insights = null,Object? calculatedAt = null,}) {
  return _then(_PersonalPerformanceAnalytics(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as TimePeriod,totalQuizzes: null == totalQuizzes ? _self.totalQuizzes : totalQuizzes // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,totalCorrect: null == totalCorrect ? _self.totalCorrect : totalCorrect // ignore: cast_nullable_to_non_nullable
as int,totalIncorrect: null == totalIncorrect ? _self.totalIncorrect : totalIncorrect // ignore: cast_nullable_to_non_nullable
as int,totalSkipped: null == totalSkipped ? _self.totalSkipped : totalSkipped // ignore: cast_nullable_to_non_nullable
as int,totalTimedOut: null == totalTimedOut ? _self.totalTimedOut : totalTimedOut // ignore: cast_nullable_to_non_nullable
as int,averageAccuracy: null == averageAccuracy ? _self.averageAccuracy : averageAccuracy // ignore: cast_nullable_to_non_nullable
as double,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,bestAccuracy: null == bestAccuracy ? _self.bestAccuracy : bestAccuracy // ignore: cast_nullable_to_non_nullable
as double,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,fastestResponseTime: null == fastestResponseTime ? _self.fastestResponseTime : fastestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,slowestResponseTime: null == slowestResponseTime ? _self.slowestResponseTime : slowestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,categoryPerformance: null == categoryPerformance ? _self._categoryPerformance : categoryPerformance // ignore: cast_nullable_to_non_nullable
as List<CategoryPerformance>,difficultyPerformance: null == difficultyPerformance ? _self._difficultyPerformance : difficultyPerformance // ignore: cast_nullable_to_non_nullable
as List<DifficultyPerformance>,accuracyTrend: null == accuracyTrend ? _self.accuracyTrend : accuracyTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,scoreTrend: null == scoreTrend ? _self.scoreTrend : scoreTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,speedTrend: null == speedTrend ? _self.speedTrend : speedTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,xpTrend: null == xpTrend ? _self.xpTrend : xpTrend // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,consistency: null == consistency ? _self.consistency : consistency // ignore: cast_nullable_to_non_nullable
as ConsistencyMetrics,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<PerformanceInsight>,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get accuracyTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.accuracyTrend, (value) {
    return _then(_self.copyWith(accuracyTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get scoreTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.scoreTrend, (value) {
    return _then(_self.copyWith(scoreTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get speedTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.speedTrend, (value) {
    return _then(_self.copyWith(speedTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get xpTrend {
  
  return $PerformanceTrendCopyWith<$Res>(_self.xpTrend, (value) {
    return _then(_self.copyWith(xpTrend: value));
  });
}/// Create a copy of PersonalPerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsistencyMetricsCopyWith<$Res> get consistency {
  
  return $ConsistencyMetricsCopyWith<$Res>(_self.consistency, (value) {
    return _then(_self.copyWith(consistency: value));
  });
}
}

// dart format on
