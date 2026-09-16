// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PracticeHistory {

 int get totalSessions; int get totalQuestions; int get totalCorrect; double get averageAccuracy; Map<String, CategoryPerformance> get categoryPerformance; Map<Difficulty, double> get difficultyPerformance; List<PracticeTrendPoint> get trends; PersonalBests get personalBests; List<PracticeResult> get recentSessions;
/// Create a copy of PracticeHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeHistoryCopyWith<PracticeHistory> get copyWith => _$PracticeHistoryCopyWithImpl<PracticeHistory>(this as PracticeHistory, _$identity);

  /// Serializes this PracticeHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeHistory&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.totalCorrect, totalCorrect) || other.totalCorrect == totalCorrect)&&(identical(other.averageAccuracy, averageAccuracy) || other.averageAccuracy == averageAccuracy)&&const DeepCollectionEquality().equals(other.categoryPerformance, categoryPerformance)&&const DeepCollectionEquality().equals(other.difficultyPerformance, difficultyPerformance)&&const DeepCollectionEquality().equals(other.trends, trends)&&(identical(other.personalBests, personalBests) || other.personalBests == personalBests)&&const DeepCollectionEquality().equals(other.recentSessions, recentSessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSessions,totalQuestions,totalCorrect,averageAccuracy,const DeepCollectionEquality().hash(categoryPerformance),const DeepCollectionEquality().hash(difficultyPerformance),const DeepCollectionEquality().hash(trends),personalBests,const DeepCollectionEquality().hash(recentSessions));

@override
String toString() {
  return 'PracticeHistory(totalSessions: $totalSessions, totalQuestions: $totalQuestions, totalCorrect: $totalCorrect, averageAccuracy: $averageAccuracy, categoryPerformance: $categoryPerformance, difficultyPerformance: $difficultyPerformance, trends: $trends, personalBests: $personalBests, recentSessions: $recentSessions)';
}


}

/// @nodoc
abstract mixin class $PracticeHistoryCopyWith<$Res>  {
  factory $PracticeHistoryCopyWith(PracticeHistory value, $Res Function(PracticeHistory) _then) = _$PracticeHistoryCopyWithImpl;
@useResult
$Res call({
 int totalSessions, int totalQuestions, int totalCorrect, double averageAccuracy, Map<String, CategoryPerformance> categoryPerformance, Map<Difficulty, double> difficultyPerformance, List<PracticeTrendPoint> trends, PersonalBests personalBests, List<PracticeResult> recentSessions
});


$PersonalBestsCopyWith<$Res> get personalBests;

}
/// @nodoc
class _$PracticeHistoryCopyWithImpl<$Res>
    implements $PracticeHistoryCopyWith<$Res> {
  _$PracticeHistoryCopyWithImpl(this._self, this._then);

  final PracticeHistory _self;
  final $Res Function(PracticeHistory) _then;

/// Create a copy of PracticeHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSessions = null,Object? totalQuestions = null,Object? totalCorrect = null,Object? averageAccuracy = null,Object? categoryPerformance = null,Object? difficultyPerformance = null,Object? trends = null,Object? personalBests = null,Object? recentSessions = null,}) {
  return _then(_self.copyWith(
totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,totalCorrect: null == totalCorrect ? _self.totalCorrect : totalCorrect // ignore: cast_nullable_to_non_nullable
as int,averageAccuracy: null == averageAccuracy ? _self.averageAccuracy : averageAccuracy // ignore: cast_nullable_to_non_nullable
as double,categoryPerformance: null == categoryPerformance ? _self.categoryPerformance : categoryPerformance // ignore: cast_nullable_to_non_nullable
as Map<String, CategoryPerformance>,difficultyPerformance: null == difficultyPerformance ? _self.difficultyPerformance : difficultyPerformance // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, double>,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as List<PracticeTrendPoint>,personalBests: null == personalBests ? _self.personalBests : personalBests // ignore: cast_nullable_to_non_nullable
as PersonalBests,recentSessions: null == recentSessions ? _self.recentSessions : recentSessions // ignore: cast_nullable_to_non_nullable
as List<PracticeResult>,
  ));
}
/// Create a copy of PracticeHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalBestsCopyWith<$Res> get personalBests {
  
  return $PersonalBestsCopyWith<$Res>(_self.personalBests, (value) {
    return _then(_self.copyWith(personalBests: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeHistory].
extension PracticeHistoryPatterns on PracticeHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeHistory value)  $default,){
final _that = this;
switch (_that) {
case _PracticeHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeHistory value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSessions,  int totalQuestions,  int totalCorrect,  double averageAccuracy,  Map<String, CategoryPerformance> categoryPerformance,  Map<Difficulty, double> difficultyPerformance,  List<PracticeTrendPoint> trends,  PersonalBests personalBests,  List<PracticeResult> recentSessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeHistory() when $default != null:
return $default(_that.totalSessions,_that.totalQuestions,_that.totalCorrect,_that.averageAccuracy,_that.categoryPerformance,_that.difficultyPerformance,_that.trends,_that.personalBests,_that.recentSessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSessions,  int totalQuestions,  int totalCorrect,  double averageAccuracy,  Map<String, CategoryPerformance> categoryPerformance,  Map<Difficulty, double> difficultyPerformance,  List<PracticeTrendPoint> trends,  PersonalBests personalBests,  List<PracticeResult> recentSessions)  $default,) {final _that = this;
switch (_that) {
case _PracticeHistory():
return $default(_that.totalSessions,_that.totalQuestions,_that.totalCorrect,_that.averageAccuracy,_that.categoryPerformance,_that.difficultyPerformance,_that.trends,_that.personalBests,_that.recentSessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSessions,  int totalQuestions,  int totalCorrect,  double averageAccuracy,  Map<String, CategoryPerformance> categoryPerformance,  Map<Difficulty, double> difficultyPerformance,  List<PracticeTrendPoint> trends,  PersonalBests personalBests,  List<PracticeResult> recentSessions)?  $default,) {final _that = this;
switch (_that) {
case _PracticeHistory() when $default != null:
return $default(_that.totalSessions,_that.totalQuestions,_that.totalCorrect,_that.averageAccuracy,_that.categoryPerformance,_that.difficultyPerformance,_that.trends,_that.personalBests,_that.recentSessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeHistory implements PracticeHistory {
  const _PracticeHistory({required this.totalSessions, required this.totalQuestions, required this.totalCorrect, required this.averageAccuracy, required final  Map<String, CategoryPerformance> categoryPerformance, required final  Map<Difficulty, double> difficultyPerformance, required final  List<PracticeTrendPoint> trends, required this.personalBests, required final  List<PracticeResult> recentSessions}): _categoryPerformance = categoryPerformance,_difficultyPerformance = difficultyPerformance,_trends = trends,_recentSessions = recentSessions;
  factory _PracticeHistory.fromJson(Map<String, dynamic> json) => _$PracticeHistoryFromJson(json);

@override final  int totalSessions;
@override final  int totalQuestions;
@override final  int totalCorrect;
@override final  double averageAccuracy;
 final  Map<String, CategoryPerformance> _categoryPerformance;
@override Map<String, CategoryPerformance> get categoryPerformance {
  if (_categoryPerformance is EqualUnmodifiableMapView) return _categoryPerformance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryPerformance);
}

 final  Map<Difficulty, double> _difficultyPerformance;
@override Map<Difficulty, double> get difficultyPerformance {
  if (_difficultyPerformance is EqualUnmodifiableMapView) return _difficultyPerformance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_difficultyPerformance);
}

 final  List<PracticeTrendPoint> _trends;
@override List<PracticeTrendPoint> get trends {
  if (_trends is EqualUnmodifiableListView) return _trends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trends);
}

@override final  PersonalBests personalBests;
 final  List<PracticeResult> _recentSessions;
@override List<PracticeResult> get recentSessions {
  if (_recentSessions is EqualUnmodifiableListView) return _recentSessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSessions);
}


/// Create a copy of PracticeHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeHistoryCopyWith<_PracticeHistory> get copyWith => __$PracticeHistoryCopyWithImpl<_PracticeHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeHistory&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.totalCorrect, totalCorrect) || other.totalCorrect == totalCorrect)&&(identical(other.averageAccuracy, averageAccuracy) || other.averageAccuracy == averageAccuracy)&&const DeepCollectionEquality().equals(other._categoryPerformance, _categoryPerformance)&&const DeepCollectionEquality().equals(other._difficultyPerformance, _difficultyPerformance)&&const DeepCollectionEquality().equals(other._trends, _trends)&&(identical(other.personalBests, personalBests) || other.personalBests == personalBests)&&const DeepCollectionEquality().equals(other._recentSessions, _recentSessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSessions,totalQuestions,totalCorrect,averageAccuracy,const DeepCollectionEquality().hash(_categoryPerformance),const DeepCollectionEquality().hash(_difficultyPerformance),const DeepCollectionEquality().hash(_trends),personalBests,const DeepCollectionEquality().hash(_recentSessions));

@override
String toString() {
  return 'PracticeHistory(totalSessions: $totalSessions, totalQuestions: $totalQuestions, totalCorrect: $totalCorrect, averageAccuracy: $averageAccuracy, categoryPerformance: $categoryPerformance, difficultyPerformance: $difficultyPerformance, trends: $trends, personalBests: $personalBests, recentSessions: $recentSessions)';
}


}

/// @nodoc
abstract mixin class _$PracticeHistoryCopyWith<$Res> implements $PracticeHistoryCopyWith<$Res> {
  factory _$PracticeHistoryCopyWith(_PracticeHistory value, $Res Function(_PracticeHistory) _then) = __$PracticeHistoryCopyWithImpl;
@override @useResult
$Res call({
 int totalSessions, int totalQuestions, int totalCorrect, double averageAccuracy, Map<String, CategoryPerformance> categoryPerformance, Map<Difficulty, double> difficultyPerformance, List<PracticeTrendPoint> trends, PersonalBests personalBests, List<PracticeResult> recentSessions
});


@override $PersonalBestsCopyWith<$Res> get personalBests;

}
/// @nodoc
class __$PracticeHistoryCopyWithImpl<$Res>
    implements _$PracticeHistoryCopyWith<$Res> {
  __$PracticeHistoryCopyWithImpl(this._self, this._then);

  final _PracticeHistory _self;
  final $Res Function(_PracticeHistory) _then;

/// Create a copy of PracticeHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSessions = null,Object? totalQuestions = null,Object? totalCorrect = null,Object? averageAccuracy = null,Object? categoryPerformance = null,Object? difficultyPerformance = null,Object? trends = null,Object? personalBests = null,Object? recentSessions = null,}) {
  return _then(_PracticeHistory(
totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,totalCorrect: null == totalCorrect ? _self.totalCorrect : totalCorrect // ignore: cast_nullable_to_non_nullable
as int,averageAccuracy: null == averageAccuracy ? _self.averageAccuracy : averageAccuracy // ignore: cast_nullable_to_non_nullable
as double,categoryPerformance: null == categoryPerformance ? _self._categoryPerformance : categoryPerformance // ignore: cast_nullable_to_non_nullable
as Map<String, CategoryPerformance>,difficultyPerformance: null == difficultyPerformance ? _self._difficultyPerformance : difficultyPerformance // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, double>,trends: null == trends ? _self._trends : trends // ignore: cast_nullable_to_non_nullable
as List<PracticeTrendPoint>,personalBests: null == personalBests ? _self.personalBests : personalBests // ignore: cast_nullable_to_non_nullable
as PersonalBests,recentSessions: null == recentSessions ? _self._recentSessions : recentSessions // ignore: cast_nullable_to_non_nullable
as List<PracticeResult>,
  ));
}

/// Create a copy of PracticeHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalBestsCopyWith<$Res> get personalBests {
  
  return $PersonalBestsCopyWith<$Res>(_self.personalBests, (value) {
    return _then(_self.copyWith(personalBests: value));
  });
}
}


/// @nodoc
mixin _$PracticeTrendPoint {

 DateTime get timestamp; double get accuracy;
/// Create a copy of PracticeTrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeTrendPointCopyWith<PracticeTrendPoint> get copyWith => _$PracticeTrendPointCopyWithImpl<PracticeTrendPoint>(this as PracticeTrendPoint, _$identity);

  /// Serializes this PracticeTrendPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeTrendPoint&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,accuracy);

@override
String toString() {
  return 'PracticeTrendPoint(timestamp: $timestamp, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class $PracticeTrendPointCopyWith<$Res>  {
  factory $PracticeTrendPointCopyWith(PracticeTrendPoint value, $Res Function(PracticeTrendPoint) _then) = _$PracticeTrendPointCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, double accuracy
});




}
/// @nodoc
class _$PracticeTrendPointCopyWithImpl<$Res>
    implements $PracticeTrendPointCopyWith<$Res> {
  _$PracticeTrendPointCopyWithImpl(this._self, this._then);

  final PracticeTrendPoint _self;
  final $Res Function(PracticeTrendPoint) _then;

/// Create a copy of PracticeTrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? accuracy = null,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeTrendPoint].
extension PracticeTrendPointPatterns on PracticeTrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeTrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeTrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeTrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _PracticeTrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeTrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeTrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  double accuracy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeTrendPoint() when $default != null:
return $default(_that.timestamp,_that.accuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  double accuracy)  $default,) {final _that = this;
switch (_that) {
case _PracticeTrendPoint():
return $default(_that.timestamp,_that.accuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  double accuracy)?  $default,) {final _that = this;
switch (_that) {
case _PracticeTrendPoint() when $default != null:
return $default(_that.timestamp,_that.accuracy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeTrendPoint implements PracticeTrendPoint {
  const _PracticeTrendPoint({required this.timestamp, required this.accuracy});
  factory _PracticeTrendPoint.fromJson(Map<String, dynamic> json) => _$PracticeTrendPointFromJson(json);

@override final  DateTime timestamp;
@override final  double accuracy;

/// Create a copy of PracticeTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeTrendPointCopyWith<_PracticeTrendPoint> get copyWith => __$PracticeTrendPointCopyWithImpl<_PracticeTrendPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeTrendPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeTrendPoint&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,accuracy);

@override
String toString() {
  return 'PracticeTrendPoint(timestamp: $timestamp, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class _$PracticeTrendPointCopyWith<$Res> implements $PracticeTrendPointCopyWith<$Res> {
  factory _$PracticeTrendPointCopyWith(_PracticeTrendPoint value, $Res Function(_PracticeTrendPoint) _then) = __$PracticeTrendPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, double accuracy
});




}
/// @nodoc
class __$PracticeTrendPointCopyWithImpl<$Res>
    implements _$PracticeTrendPointCopyWith<$Res> {
  __$PracticeTrendPointCopyWithImpl(this._self, this._then);

  final _PracticeTrendPoint _self;
  final $Res Function(_PracticeTrendPoint) _then;

/// Create a copy of PracticeTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? accuracy = null,}) {
  return _then(_PracticeTrendPoint(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PersonalBests {

 double get highestAccuracy; int get mostQuestionsInSession; int get bestScore; Duration get longestSession;
/// Create a copy of PersonalBests
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalBestsCopyWith<PersonalBests> get copyWith => _$PersonalBestsCopyWithImpl<PersonalBests>(this as PersonalBests, _$identity);

  /// Serializes this PersonalBests to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalBests&&(identical(other.highestAccuracy, highestAccuracy) || other.highestAccuracy == highestAccuracy)&&(identical(other.mostQuestionsInSession, mostQuestionsInSession) || other.mostQuestionsInSession == mostQuestionsInSession)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.longestSession, longestSession) || other.longestSession == longestSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,highestAccuracy,mostQuestionsInSession,bestScore,longestSession);

@override
String toString() {
  return 'PersonalBests(highestAccuracy: $highestAccuracy, mostQuestionsInSession: $mostQuestionsInSession, bestScore: $bestScore, longestSession: $longestSession)';
}


}

/// @nodoc
abstract mixin class $PersonalBestsCopyWith<$Res>  {
  factory $PersonalBestsCopyWith(PersonalBests value, $Res Function(PersonalBests) _then) = _$PersonalBestsCopyWithImpl;
@useResult
$Res call({
 double highestAccuracy, int mostQuestionsInSession, int bestScore, Duration longestSession
});




}
/// @nodoc
class _$PersonalBestsCopyWithImpl<$Res>
    implements $PersonalBestsCopyWith<$Res> {
  _$PersonalBestsCopyWithImpl(this._self, this._then);

  final PersonalBests _self;
  final $Res Function(PersonalBests) _then;

/// Create a copy of PersonalBests
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? highestAccuracy = null,Object? mostQuestionsInSession = null,Object? bestScore = null,Object? longestSession = null,}) {
  return _then(_self.copyWith(
highestAccuracy: null == highestAccuracy ? _self.highestAccuracy : highestAccuracy // ignore: cast_nullable_to_non_nullable
as double,mostQuestionsInSession: null == mostQuestionsInSession ? _self.mostQuestionsInSession : mostQuestionsInSession // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,longestSession: null == longestSession ? _self.longestSession : longestSession // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalBests].
extension PersonalBestsPatterns on PersonalBests {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalBests value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalBests() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalBests value)  $default,){
final _that = this;
switch (_that) {
case _PersonalBests():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalBests value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalBests() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double highestAccuracy,  int mostQuestionsInSession,  int bestScore,  Duration longestSession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalBests() when $default != null:
return $default(_that.highestAccuracy,_that.mostQuestionsInSession,_that.bestScore,_that.longestSession);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double highestAccuracy,  int mostQuestionsInSession,  int bestScore,  Duration longestSession)  $default,) {final _that = this;
switch (_that) {
case _PersonalBests():
return $default(_that.highestAccuracy,_that.mostQuestionsInSession,_that.bestScore,_that.longestSession);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double highestAccuracy,  int mostQuestionsInSession,  int bestScore,  Duration longestSession)?  $default,) {final _that = this;
switch (_that) {
case _PersonalBests() when $default != null:
return $default(_that.highestAccuracy,_that.mostQuestionsInSession,_that.bestScore,_that.longestSession);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalBests implements PersonalBests {
  const _PersonalBests({required this.highestAccuracy, required this.mostQuestionsInSession, required this.bestScore, required this.longestSession});
  factory _PersonalBests.fromJson(Map<String, dynamic> json) => _$PersonalBestsFromJson(json);

@override final  double highestAccuracy;
@override final  int mostQuestionsInSession;
@override final  int bestScore;
@override final  Duration longestSession;

/// Create a copy of PersonalBests
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalBestsCopyWith<_PersonalBests> get copyWith => __$PersonalBestsCopyWithImpl<_PersonalBests>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalBestsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalBests&&(identical(other.highestAccuracy, highestAccuracy) || other.highestAccuracy == highestAccuracy)&&(identical(other.mostQuestionsInSession, mostQuestionsInSession) || other.mostQuestionsInSession == mostQuestionsInSession)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.longestSession, longestSession) || other.longestSession == longestSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,highestAccuracy,mostQuestionsInSession,bestScore,longestSession);

@override
String toString() {
  return 'PersonalBests(highestAccuracy: $highestAccuracy, mostQuestionsInSession: $mostQuestionsInSession, bestScore: $bestScore, longestSession: $longestSession)';
}


}

/// @nodoc
abstract mixin class _$PersonalBestsCopyWith<$Res> implements $PersonalBestsCopyWith<$Res> {
  factory _$PersonalBestsCopyWith(_PersonalBests value, $Res Function(_PersonalBests) _then) = __$PersonalBestsCopyWithImpl;
@override @useResult
$Res call({
 double highestAccuracy, int mostQuestionsInSession, int bestScore, Duration longestSession
});




}
/// @nodoc
class __$PersonalBestsCopyWithImpl<$Res>
    implements _$PersonalBestsCopyWith<$Res> {
  __$PersonalBestsCopyWithImpl(this._self, this._then);

  final _PersonalBests _self;
  final $Res Function(_PersonalBests) _then;

/// Create a copy of PersonalBests
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? highestAccuracy = null,Object? mostQuestionsInSession = null,Object? bestScore = null,Object? longestSession = null,}) {
  return _then(_PersonalBests(
highestAccuracy: null == highestAccuracy ? _self.highestAccuracy : highestAccuracy // ignore: cast_nullable_to_non_nullable
as double,mostQuestionsInSession: null == mostQuestionsInSession ? _self.mostQuestionsInSession : mostQuestionsInSession // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,longestSession: null == longestSession ? _self.longestSession : longestSession // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
