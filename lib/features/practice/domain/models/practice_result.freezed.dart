// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PracticeResult {

 String get sessionId; String get userId; DateTime get completedAt; int get totalQuestions; int get answeredQuestions; int get correctAnswers; int get incorrectAnswers; int get skippedQuestions; double get accuracy; int get score; Duration get totalTime; Map<String, CategoryPerformance> get categoryPerformance; Map<Difficulty, double> get difficultyPerformance; List<QuestionReviewItem> get reviewItems; List<LearningInsight> get insights; PracticeRecommendation? get recommendation; int get xpEarned; int get coinsEarned; String? get performanceMessage; Map<String, dynamic> get metadata;
/// Create a copy of PracticeResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeResultCopyWith<PracticeResult> get copyWith => _$PracticeResultCopyWithImpl<PracticeResult>(this as PracticeResult, _$identity);

  /// Serializes this PracticeResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.answeredQuestions, answeredQuestions) || other.answeredQuestions == answeredQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.incorrectAnswers, incorrectAnswers) || other.incorrectAnswers == incorrectAnswers)&&(identical(other.skippedQuestions, skippedQuestions) || other.skippedQuestions == skippedQuestions)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime)&&const DeepCollectionEquality().equals(other.categoryPerformance, categoryPerformance)&&const DeepCollectionEquality().equals(other.difficultyPerformance, difficultyPerformance)&&const DeepCollectionEquality().equals(other.reviewItems, reviewItems)&&const DeepCollectionEquality().equals(other.insights, insights)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.performanceMessage, performanceMessage) || other.performanceMessage == performanceMessage)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sessionId,userId,completedAt,totalQuestions,answeredQuestions,correctAnswers,incorrectAnswers,skippedQuestions,accuracy,score,totalTime,const DeepCollectionEquality().hash(categoryPerformance),const DeepCollectionEquality().hash(difficultyPerformance),const DeepCollectionEquality().hash(reviewItems),const DeepCollectionEquality().hash(insights),recommendation,xpEarned,coinsEarned,performanceMessage,const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'PracticeResult(sessionId: $sessionId, userId: $userId, completedAt: $completedAt, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, incorrectAnswers: $incorrectAnswers, skippedQuestions: $skippedQuestions, accuracy: $accuracy, score: $score, totalTime: $totalTime, categoryPerformance: $categoryPerformance, difficultyPerformance: $difficultyPerformance, reviewItems: $reviewItems, insights: $insights, recommendation: $recommendation, xpEarned: $xpEarned, coinsEarned: $coinsEarned, performanceMessage: $performanceMessage, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PracticeResultCopyWith<$Res>  {
  factory $PracticeResultCopyWith(PracticeResult value, $Res Function(PracticeResult) _then) = _$PracticeResultCopyWithImpl;
@useResult
$Res call({
 String sessionId, String userId, DateTime completedAt, int totalQuestions, int answeredQuestions, int correctAnswers, int incorrectAnswers, int skippedQuestions, double accuracy, int score, Duration totalTime, Map<String, CategoryPerformance> categoryPerformance, Map<Difficulty, double> difficultyPerformance, List<QuestionReviewItem> reviewItems, List<LearningInsight> insights, PracticeRecommendation? recommendation, int xpEarned, int coinsEarned, String? performanceMessage, Map<String, dynamic> metadata
});


$PracticeRecommendationCopyWith<$Res>? get recommendation;

}
/// @nodoc
class _$PracticeResultCopyWithImpl<$Res>
    implements $PracticeResultCopyWith<$Res> {
  _$PracticeResultCopyWithImpl(this._self, this._then);

  final PracticeResult _self;
  final $Res Function(PracticeResult) _then;

/// Create a copy of PracticeResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? userId = null,Object? completedAt = null,Object? totalQuestions = null,Object? answeredQuestions = null,Object? correctAnswers = null,Object? incorrectAnswers = null,Object? skippedQuestions = null,Object? accuracy = null,Object? score = null,Object? totalTime = null,Object? categoryPerformance = null,Object? difficultyPerformance = null,Object? reviewItems = null,Object? insights = null,Object? recommendation = freezed,Object? xpEarned = null,Object? coinsEarned = null,Object? performanceMessage = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,answeredQuestions: null == answeredQuestions ? _self.answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,incorrectAnswers: null == incorrectAnswers ? _self.incorrectAnswers : incorrectAnswers // ignore: cast_nullable_to_non_nullable
as int,skippedQuestions: null == skippedQuestions ? _self.skippedQuestions : skippedQuestions // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as Duration,categoryPerformance: null == categoryPerformance ? _self.categoryPerformance : categoryPerformance // ignore: cast_nullable_to_non_nullable
as Map<String, CategoryPerformance>,difficultyPerformance: null == difficultyPerformance ? _self.difficultyPerformance : difficultyPerformance // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, double>,reviewItems: null == reviewItems ? _self.reviewItems : reviewItems // ignore: cast_nullable_to_non_nullable
as List<QuestionReviewItem>,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<LearningInsight>,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as PracticeRecommendation?,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,performanceMessage: freezed == performanceMessage ? _self.performanceMessage : performanceMessage // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of PracticeResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeRecommendationCopyWith<$Res>? get recommendation {
    if (_self.recommendation == null) {
    return null;
  }

  return $PracticeRecommendationCopyWith<$Res>(_self.recommendation!, (value) {
    return _then(_self.copyWith(recommendation: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeResult].
extension PracticeResultPatterns on PracticeResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeResult value)  $default,){
final _that = this;
switch (_that) {
case _PracticeResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeResult value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String userId,  DateTime completedAt,  int totalQuestions,  int answeredQuestions,  int correctAnswers,  int incorrectAnswers,  int skippedQuestions,  double accuracy,  int score,  Duration totalTime,  Map<String, CategoryPerformance> categoryPerformance,  Map<Difficulty, double> difficultyPerformance,  List<QuestionReviewItem> reviewItems,  List<LearningInsight> insights,  PracticeRecommendation? recommendation,  int xpEarned,  int coinsEarned,  String? performanceMessage,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeResult() when $default != null:
return $default(_that.sessionId,_that.userId,_that.completedAt,_that.totalQuestions,_that.answeredQuestions,_that.correctAnswers,_that.incorrectAnswers,_that.skippedQuestions,_that.accuracy,_that.score,_that.totalTime,_that.categoryPerformance,_that.difficultyPerformance,_that.reviewItems,_that.insights,_that.recommendation,_that.xpEarned,_that.coinsEarned,_that.performanceMessage,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String userId,  DateTime completedAt,  int totalQuestions,  int answeredQuestions,  int correctAnswers,  int incorrectAnswers,  int skippedQuestions,  double accuracy,  int score,  Duration totalTime,  Map<String, CategoryPerformance> categoryPerformance,  Map<Difficulty, double> difficultyPerformance,  List<QuestionReviewItem> reviewItems,  List<LearningInsight> insights,  PracticeRecommendation? recommendation,  int xpEarned,  int coinsEarned,  String? performanceMessage,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _PracticeResult():
return $default(_that.sessionId,_that.userId,_that.completedAt,_that.totalQuestions,_that.answeredQuestions,_that.correctAnswers,_that.incorrectAnswers,_that.skippedQuestions,_that.accuracy,_that.score,_that.totalTime,_that.categoryPerformance,_that.difficultyPerformance,_that.reviewItems,_that.insights,_that.recommendation,_that.xpEarned,_that.coinsEarned,_that.performanceMessage,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String userId,  DateTime completedAt,  int totalQuestions,  int answeredQuestions,  int correctAnswers,  int incorrectAnswers,  int skippedQuestions,  double accuracy,  int score,  Duration totalTime,  Map<String, CategoryPerformance> categoryPerformance,  Map<Difficulty, double> difficultyPerformance,  List<QuestionReviewItem> reviewItems,  List<LearningInsight> insights,  PracticeRecommendation? recommendation,  int xpEarned,  int coinsEarned,  String? performanceMessage,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _PracticeResult() when $default != null:
return $default(_that.sessionId,_that.userId,_that.completedAt,_that.totalQuestions,_that.answeredQuestions,_that.correctAnswers,_that.incorrectAnswers,_that.skippedQuestions,_that.accuracy,_that.score,_that.totalTime,_that.categoryPerformance,_that.difficultyPerformance,_that.reviewItems,_that.insights,_that.recommendation,_that.xpEarned,_that.coinsEarned,_that.performanceMessage,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PracticeResult implements PracticeResult {
  const _PracticeResult({required this.sessionId, required this.userId, required this.completedAt, required this.totalQuestions, required this.answeredQuestions, required this.correctAnswers, required this.incorrectAnswers, required this.skippedQuestions, required this.accuracy, required this.score, required this.totalTime, required final  Map<String, CategoryPerformance> categoryPerformance, required final  Map<Difficulty, double> difficultyPerformance, required final  List<QuestionReviewItem> reviewItems, final  List<LearningInsight> insights = const [], this.recommendation, this.xpEarned = 0, this.coinsEarned = 0, this.performanceMessage, final  Map<String, dynamic> metadata = const {}}): _categoryPerformance = categoryPerformance,_difficultyPerformance = difficultyPerformance,_reviewItems = reviewItems,_insights = insights,_metadata = metadata;
  factory _PracticeResult.fromJson(Map<String, dynamic> json) => _$PracticeResultFromJson(json);

@override final  String sessionId;
@override final  String userId;
@override final  DateTime completedAt;
@override final  int totalQuestions;
@override final  int answeredQuestions;
@override final  int correctAnswers;
@override final  int incorrectAnswers;
@override final  int skippedQuestions;
@override final  double accuracy;
@override final  int score;
@override final  Duration totalTime;
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

 final  List<QuestionReviewItem> _reviewItems;
@override List<QuestionReviewItem> get reviewItems {
  if (_reviewItems is EqualUnmodifiableListView) return _reviewItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviewItems);
}

 final  List<LearningInsight> _insights;
@override@JsonKey() List<LearningInsight> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}

@override final  PracticeRecommendation? recommendation;
@override@JsonKey() final  int xpEarned;
@override@JsonKey() final  int coinsEarned;
@override final  String? performanceMessage;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of PracticeResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeResultCopyWith<_PracticeResult> get copyWith => __$PracticeResultCopyWithImpl<_PracticeResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.answeredQuestions, answeredQuestions) || other.answeredQuestions == answeredQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.incorrectAnswers, incorrectAnswers) || other.incorrectAnswers == incorrectAnswers)&&(identical(other.skippedQuestions, skippedQuestions) || other.skippedQuestions == skippedQuestions)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime)&&const DeepCollectionEquality().equals(other._categoryPerformance, _categoryPerformance)&&const DeepCollectionEquality().equals(other._difficultyPerformance, _difficultyPerformance)&&const DeepCollectionEquality().equals(other._reviewItems, _reviewItems)&&const DeepCollectionEquality().equals(other._insights, _insights)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.performanceMessage, performanceMessage) || other.performanceMessage == performanceMessage)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sessionId,userId,completedAt,totalQuestions,answeredQuestions,correctAnswers,incorrectAnswers,skippedQuestions,accuracy,score,totalTime,const DeepCollectionEquality().hash(_categoryPerformance),const DeepCollectionEquality().hash(_difficultyPerformance),const DeepCollectionEquality().hash(_reviewItems),const DeepCollectionEquality().hash(_insights),recommendation,xpEarned,coinsEarned,performanceMessage,const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'PracticeResult(sessionId: $sessionId, userId: $userId, completedAt: $completedAt, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, incorrectAnswers: $incorrectAnswers, skippedQuestions: $skippedQuestions, accuracy: $accuracy, score: $score, totalTime: $totalTime, categoryPerformance: $categoryPerformance, difficultyPerformance: $difficultyPerformance, reviewItems: $reviewItems, insights: $insights, recommendation: $recommendation, xpEarned: $xpEarned, coinsEarned: $coinsEarned, performanceMessage: $performanceMessage, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PracticeResultCopyWith<$Res> implements $PracticeResultCopyWith<$Res> {
  factory _$PracticeResultCopyWith(_PracticeResult value, $Res Function(_PracticeResult) _then) = __$PracticeResultCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String userId, DateTime completedAt, int totalQuestions, int answeredQuestions, int correctAnswers, int incorrectAnswers, int skippedQuestions, double accuracy, int score, Duration totalTime, Map<String, CategoryPerformance> categoryPerformance, Map<Difficulty, double> difficultyPerformance, List<QuestionReviewItem> reviewItems, List<LearningInsight> insights, PracticeRecommendation? recommendation, int xpEarned, int coinsEarned, String? performanceMessage, Map<String, dynamic> metadata
});


@override $PracticeRecommendationCopyWith<$Res>? get recommendation;

}
/// @nodoc
class __$PracticeResultCopyWithImpl<$Res>
    implements _$PracticeResultCopyWith<$Res> {
  __$PracticeResultCopyWithImpl(this._self, this._then);

  final _PracticeResult _self;
  final $Res Function(_PracticeResult) _then;

/// Create a copy of PracticeResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? userId = null,Object? completedAt = null,Object? totalQuestions = null,Object? answeredQuestions = null,Object? correctAnswers = null,Object? incorrectAnswers = null,Object? skippedQuestions = null,Object? accuracy = null,Object? score = null,Object? totalTime = null,Object? categoryPerformance = null,Object? difficultyPerformance = null,Object? reviewItems = null,Object? insights = null,Object? recommendation = freezed,Object? xpEarned = null,Object? coinsEarned = null,Object? performanceMessage = freezed,Object? metadata = null,}) {
  return _then(_PracticeResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,answeredQuestions: null == answeredQuestions ? _self.answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,incorrectAnswers: null == incorrectAnswers ? _self.incorrectAnswers : incorrectAnswers // ignore: cast_nullable_to_non_nullable
as int,skippedQuestions: null == skippedQuestions ? _self.skippedQuestions : skippedQuestions // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as Duration,categoryPerformance: null == categoryPerformance ? _self._categoryPerformance : categoryPerformance // ignore: cast_nullable_to_non_nullable
as Map<String, CategoryPerformance>,difficultyPerformance: null == difficultyPerformance ? _self._difficultyPerformance : difficultyPerformance // ignore: cast_nullable_to_non_nullable
as Map<Difficulty, double>,reviewItems: null == reviewItems ? _self._reviewItems : reviewItems // ignore: cast_nullable_to_non_nullable
as List<QuestionReviewItem>,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<LearningInsight>,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as PracticeRecommendation?,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,performanceMessage: freezed == performanceMessage ? _self.performanceMessage : performanceMessage // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of PracticeResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeRecommendationCopyWith<$Res>? get recommendation {
    if (_self.recommendation == null) {
    return null;
  }

  return $PracticeRecommendationCopyWith<$Res>(_self.recommendation!, (value) {
    return _then(_self.copyWith(recommendation: value));
  });
}
}


/// @nodoc
mixin _$CategoryPerformance {

 String get categoryId; int get total; int get correct; double get accuracy;
/// Create a copy of CategoryPerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryPerformanceCopyWith<CategoryPerformance> get copyWith => _$CategoryPerformanceCopyWithImpl<CategoryPerformance>(this as CategoryPerformance, _$identity);

  /// Serializes this CategoryPerformance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryPerformance&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.total, total) || other.total == total)&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,total,correct,accuracy);

@override
String toString() {
  return 'CategoryPerformance(categoryId: $categoryId, total: $total, correct: $correct, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class $CategoryPerformanceCopyWith<$Res>  {
  factory $CategoryPerformanceCopyWith(CategoryPerformance value, $Res Function(CategoryPerformance) _then) = _$CategoryPerformanceCopyWithImpl;
@useResult
$Res call({
 String categoryId, int total, int correct, double accuracy
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
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? total = null,Object? correct = null,Object? accuracy = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  int total,  int correct,  double accuracy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryPerformance() when $default != null:
return $default(_that.categoryId,_that.total,_that.correct,_that.accuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  int total,  int correct,  double accuracy)  $default,) {final _that = this;
switch (_that) {
case _CategoryPerformance():
return $default(_that.categoryId,_that.total,_that.correct,_that.accuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  int total,  int correct,  double accuracy)?  $default,) {final _that = this;
switch (_that) {
case _CategoryPerformance() when $default != null:
return $default(_that.categoryId,_that.total,_that.correct,_that.accuracy);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _CategoryPerformance implements CategoryPerformance {
  const _CategoryPerformance({required this.categoryId, required this.total, required this.correct, required this.accuracy});
  factory _CategoryPerformance.fromJson(Map<String, dynamic> json) => _$CategoryPerformanceFromJson(json);

@override final  String categoryId;
@override final  int total;
@override final  int correct;
@override final  double accuracy;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryPerformance&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.total, total) || other.total == total)&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,total,correct,accuracy);

@override
String toString() {
  return 'CategoryPerformance(categoryId: $categoryId, total: $total, correct: $correct, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class _$CategoryPerformanceCopyWith<$Res> implements $CategoryPerformanceCopyWith<$Res> {
  factory _$CategoryPerformanceCopyWith(_CategoryPerformance value, $Res Function(_CategoryPerformance) _then) = __$CategoryPerformanceCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, int total, int correct, double accuracy
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
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? total = null,Object? correct = null,Object? accuracy = null,}) {
  return _then(_CategoryPerformance(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$QuestionReviewItem {

 String get questionId; String get questionText; List<String> get selectedOptionIds; List<String> get correctOptionIds; bool get isCorrect; bool get isSkipped; String? get explanation; String get categoryId; Difficulty get difficulty; Duration get responseTime; String? get questionVersion;
/// Create a copy of QuestionReviewItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionReviewItemCopyWith<QuestionReviewItem> get copyWith => _$QuestionReviewItemCopyWithImpl<QuestionReviewItem>(this as QuestionReviewItem, _$identity);

  /// Serializes this QuestionReviewItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionReviewItem&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other.selectedOptionIds, selectedOptionIds)&&const DeepCollectionEquality().equals(other.correctOptionIds, correctOptionIds)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.questionVersion, questionVersion) || other.questionVersion == questionVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,questionText,const DeepCollectionEquality().hash(selectedOptionIds),const DeepCollectionEquality().hash(correctOptionIds),isCorrect,isSkipped,explanation,categoryId,difficulty,responseTime,questionVersion);

@override
String toString() {
  return 'QuestionReviewItem(questionId: $questionId, questionText: $questionText, selectedOptionIds: $selectedOptionIds, correctOptionIds: $correctOptionIds, isCorrect: $isCorrect, isSkipped: $isSkipped, explanation: $explanation, categoryId: $categoryId, difficulty: $difficulty, responseTime: $responseTime, questionVersion: $questionVersion)';
}


}

/// @nodoc
abstract mixin class $QuestionReviewItemCopyWith<$Res>  {
  factory $QuestionReviewItemCopyWith(QuestionReviewItem value, $Res Function(QuestionReviewItem) _then) = _$QuestionReviewItemCopyWithImpl;
@useResult
$Res call({
 String questionId, String questionText, List<String> selectedOptionIds, List<String> correctOptionIds, bool isCorrect, bool isSkipped, String? explanation, String categoryId, Difficulty difficulty, Duration responseTime, String? questionVersion
});




}
/// @nodoc
class _$QuestionReviewItemCopyWithImpl<$Res>
    implements $QuestionReviewItemCopyWith<$Res> {
  _$QuestionReviewItemCopyWithImpl(this._self, this._then);

  final QuestionReviewItem _self;
  final $Res Function(QuestionReviewItem) _then;

/// Create a copy of QuestionReviewItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? questionText = null,Object? selectedOptionIds = null,Object? correctOptionIds = null,Object? isCorrect = null,Object? isSkipped = null,Object? explanation = freezed,Object? categoryId = null,Object? difficulty = null,Object? responseTime = null,Object? questionVersion = freezed,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,selectedOptionIds: null == selectedOptionIds ? _self.selectedOptionIds : selectedOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,correctOptionIds: null == correctOptionIds ? _self.correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,questionVersion: freezed == questionVersion ? _self.questionVersion : questionVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionReviewItem].
extension QuestionReviewItemPatterns on QuestionReviewItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionReviewItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionReviewItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionReviewItem value)  $default,){
final _that = this;
switch (_that) {
case _QuestionReviewItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionReviewItem value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionReviewItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  String questionText,  List<String> selectedOptionIds,  List<String> correctOptionIds,  bool isCorrect,  bool isSkipped,  String? explanation,  String categoryId,  Difficulty difficulty,  Duration responseTime,  String? questionVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionReviewItem() when $default != null:
return $default(_that.questionId,_that.questionText,_that.selectedOptionIds,_that.correctOptionIds,_that.isCorrect,_that.isSkipped,_that.explanation,_that.categoryId,_that.difficulty,_that.responseTime,_that.questionVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  String questionText,  List<String> selectedOptionIds,  List<String> correctOptionIds,  bool isCorrect,  bool isSkipped,  String? explanation,  String categoryId,  Difficulty difficulty,  Duration responseTime,  String? questionVersion)  $default,) {final _that = this;
switch (_that) {
case _QuestionReviewItem():
return $default(_that.questionId,_that.questionText,_that.selectedOptionIds,_that.correctOptionIds,_that.isCorrect,_that.isSkipped,_that.explanation,_that.categoryId,_that.difficulty,_that.responseTime,_that.questionVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  String questionText,  List<String> selectedOptionIds,  List<String> correctOptionIds,  bool isCorrect,  bool isSkipped,  String? explanation,  String categoryId,  Difficulty difficulty,  Duration responseTime,  String? questionVersion)?  $default,) {final _that = this;
switch (_that) {
case _QuestionReviewItem() when $default != null:
return $default(_that.questionId,_that.questionText,_that.selectedOptionIds,_that.correctOptionIds,_that.isCorrect,_that.isSkipped,_that.explanation,_that.categoryId,_that.difficulty,_that.responseTime,_that.questionVersion);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _QuestionReviewItem implements QuestionReviewItem {
  const _QuestionReviewItem({required this.questionId, required this.questionText, required final  List<String> selectedOptionIds, required final  List<String> correctOptionIds, required this.isCorrect, required this.isSkipped, this.explanation, required this.categoryId, required this.difficulty, required this.responseTime, this.questionVersion}): _selectedOptionIds = selectedOptionIds,_correctOptionIds = correctOptionIds;
  factory _QuestionReviewItem.fromJson(Map<String, dynamic> json) => _$QuestionReviewItemFromJson(json);

@override final  String questionId;
@override final  String questionText;
 final  List<String> _selectedOptionIds;
@override List<String> get selectedOptionIds {
  if (_selectedOptionIds is EqualUnmodifiableListView) return _selectedOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedOptionIds);
}

 final  List<String> _correctOptionIds;
@override List<String> get correctOptionIds {
  if (_correctOptionIds is EqualUnmodifiableListView) return _correctOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctOptionIds);
}

@override final  bool isCorrect;
@override final  bool isSkipped;
@override final  String? explanation;
@override final  String categoryId;
@override final  Difficulty difficulty;
@override final  Duration responseTime;
@override final  String? questionVersion;

/// Create a copy of QuestionReviewItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionReviewItemCopyWith<_QuestionReviewItem> get copyWith => __$QuestionReviewItemCopyWithImpl<_QuestionReviewItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionReviewItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionReviewItem&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other._selectedOptionIds, _selectedOptionIds)&&const DeepCollectionEquality().equals(other._correctOptionIds, _correctOptionIds)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.questionVersion, questionVersion) || other.questionVersion == questionVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,questionText,const DeepCollectionEquality().hash(_selectedOptionIds),const DeepCollectionEquality().hash(_correctOptionIds),isCorrect,isSkipped,explanation,categoryId,difficulty,responseTime,questionVersion);

@override
String toString() {
  return 'QuestionReviewItem(questionId: $questionId, questionText: $questionText, selectedOptionIds: $selectedOptionIds, correctOptionIds: $correctOptionIds, isCorrect: $isCorrect, isSkipped: $isSkipped, explanation: $explanation, categoryId: $categoryId, difficulty: $difficulty, responseTime: $responseTime, questionVersion: $questionVersion)';
}


}

/// @nodoc
abstract mixin class _$QuestionReviewItemCopyWith<$Res> implements $QuestionReviewItemCopyWith<$Res> {
  factory _$QuestionReviewItemCopyWith(_QuestionReviewItem value, $Res Function(_QuestionReviewItem) _then) = __$QuestionReviewItemCopyWithImpl;
@override @useResult
$Res call({
 String questionId, String questionText, List<String> selectedOptionIds, List<String> correctOptionIds, bool isCorrect, bool isSkipped, String? explanation, String categoryId, Difficulty difficulty, Duration responseTime, String? questionVersion
});




}
/// @nodoc
class __$QuestionReviewItemCopyWithImpl<$Res>
    implements _$QuestionReviewItemCopyWith<$Res> {
  __$QuestionReviewItemCopyWithImpl(this._self, this._then);

  final _QuestionReviewItem _self;
  final $Res Function(_QuestionReviewItem) _then;

/// Create a copy of QuestionReviewItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? questionText = null,Object? selectedOptionIds = null,Object? correctOptionIds = null,Object? isCorrect = null,Object? isSkipped = null,Object? explanation = freezed,Object? categoryId = null,Object? difficulty = null,Object? responseTime = null,Object? questionVersion = freezed,}) {
  return _then(_QuestionReviewItem(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,selectedOptionIds: null == selectedOptionIds ? _self._selectedOptionIds : selectedOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,correctOptionIds: null == correctOptionIds ? _self._correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,questionVersion: freezed == questionVersion ? _self.questionVersion : questionVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LearningInsight {

 String get title; String get description; LearningInsightType get type; bool get isPositive;
/// Create a copy of LearningInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningInsightCopyWith<LearningInsight> get copyWith => _$LearningInsightCopyWithImpl<LearningInsight>(this as LearningInsight, _$identity);

  /// Serializes this LearningInsight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningInsight&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,type,isPositive);

@override
String toString() {
  return 'LearningInsight(title: $title, description: $description, type: $type, isPositive: $isPositive)';
}


}

/// @nodoc
abstract mixin class $LearningInsightCopyWith<$Res>  {
  factory $LearningInsightCopyWith(LearningInsight value, $Res Function(LearningInsight) _then) = _$LearningInsightCopyWithImpl;
@useResult
$Res call({
 String title, String description, LearningInsightType type, bool isPositive
});




}
/// @nodoc
class _$LearningInsightCopyWithImpl<$Res>
    implements $LearningInsightCopyWith<$Res> {
  _$LearningInsightCopyWithImpl(this._self, this._then);

  final LearningInsight _self;
  final $Res Function(LearningInsight) _then;

/// Create a copy of LearningInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? type = null,Object? isPositive = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LearningInsightType,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningInsight].
extension LearningInsightPatterns on LearningInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningInsight value)  $default,){
final _that = this;
switch (_that) {
case _LearningInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningInsight value)?  $default,){
final _that = this;
switch (_that) {
case _LearningInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  LearningInsightType type,  bool isPositive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningInsight() when $default != null:
return $default(_that.title,_that.description,_that.type,_that.isPositive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  LearningInsightType type,  bool isPositive)  $default,) {final _that = this;
switch (_that) {
case _LearningInsight():
return $default(_that.title,_that.description,_that.type,_that.isPositive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  LearningInsightType type,  bool isPositive)?  $default,) {final _that = this;
switch (_that) {
case _LearningInsight() when $default != null:
return $default(_that.title,_that.description,_that.type,_that.isPositive);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _LearningInsight implements LearningInsight {
  const _LearningInsight({required this.title, required this.description, required this.type, required this.isPositive});
  factory _LearningInsight.fromJson(Map<String, dynamic> json) => _$LearningInsightFromJson(json);

@override final  String title;
@override final  String description;
@override final  LearningInsightType type;
@override final  bool isPositive;

/// Create a copy of LearningInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningInsightCopyWith<_LearningInsight> get copyWith => __$LearningInsightCopyWithImpl<_LearningInsight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearningInsightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningInsight&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,type,isPositive);

@override
String toString() {
  return 'LearningInsight(title: $title, description: $description, type: $type, isPositive: $isPositive)';
}


}

/// @nodoc
abstract mixin class _$LearningInsightCopyWith<$Res> implements $LearningInsightCopyWith<$Res> {
  factory _$LearningInsightCopyWith(_LearningInsight value, $Res Function(_LearningInsight) _then) = __$LearningInsightCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, LearningInsightType type, bool isPositive
});




}
/// @nodoc
class __$LearningInsightCopyWithImpl<$Res>
    implements _$LearningInsightCopyWith<$Res> {
  __$LearningInsightCopyWithImpl(this._self, this._then);

  final _LearningInsight _self;
  final $Res Function(_LearningInsight) _then;

/// Create a copy of LearningInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? type = null,Object? isPositive = null,}) {
  return _then(_LearningInsight(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LearningInsightType,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PracticeRecommendation {

 String get title; String get description; String get categoryId; Difficulty get difficulty; int get questionCount; String? get icon;
/// Create a copy of PracticeRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeRecommendationCopyWith<PracticeRecommendation> get copyWith => _$PracticeRecommendationCopyWithImpl<PracticeRecommendation>(this as PracticeRecommendation, _$identity);

  /// Serializes this PracticeRecommendation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeRecommendation&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,categoryId,difficulty,questionCount,icon);

@override
String toString() {
  return 'PracticeRecommendation(title: $title, description: $description, categoryId: $categoryId, difficulty: $difficulty, questionCount: $questionCount, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $PracticeRecommendationCopyWith<$Res>  {
  factory $PracticeRecommendationCopyWith(PracticeRecommendation value, $Res Function(PracticeRecommendation) _then) = _$PracticeRecommendationCopyWithImpl;
@useResult
$Res call({
 String title, String description, String categoryId, Difficulty difficulty, int questionCount, String? icon
});




}
/// @nodoc
class _$PracticeRecommendationCopyWithImpl<$Res>
    implements $PracticeRecommendationCopyWith<$Res> {
  _$PracticeRecommendationCopyWithImpl(this._self, this._then);

  final PracticeRecommendation _self;
  final $Res Function(PracticeRecommendation) _then;

/// Create a copy of PracticeRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? categoryId = null,Object? difficulty = null,Object? questionCount = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeRecommendation].
extension PracticeRecommendationPatterns on PracticeRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _PracticeRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String categoryId,  Difficulty difficulty,  int questionCount,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeRecommendation() when $default != null:
return $default(_that.title,_that.description,_that.categoryId,_that.difficulty,_that.questionCount,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String categoryId,  Difficulty difficulty,  int questionCount,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _PracticeRecommendation():
return $default(_that.title,_that.description,_that.categoryId,_that.difficulty,_that.questionCount,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String categoryId,  Difficulty difficulty,  int questionCount,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _PracticeRecommendation() when $default != null:
return $default(_that.title,_that.description,_that.categoryId,_that.difficulty,_that.questionCount,_that.icon);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PracticeRecommendation implements PracticeRecommendation {
  const _PracticeRecommendation({required this.title, required this.description, required this.categoryId, required this.difficulty, required this.questionCount, this.icon});
  factory _PracticeRecommendation.fromJson(Map<String, dynamic> json) => _$PracticeRecommendationFromJson(json);

@override final  String title;
@override final  String description;
@override final  String categoryId;
@override final  Difficulty difficulty;
@override final  int questionCount;
@override final  String? icon;

/// Create a copy of PracticeRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeRecommendationCopyWith<_PracticeRecommendation> get copyWith => __$PracticeRecommendationCopyWithImpl<_PracticeRecommendation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeRecommendationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeRecommendation&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,categoryId,difficulty,questionCount,icon);

@override
String toString() {
  return 'PracticeRecommendation(title: $title, description: $description, categoryId: $categoryId, difficulty: $difficulty, questionCount: $questionCount, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$PracticeRecommendationCopyWith<$Res> implements $PracticeRecommendationCopyWith<$Res> {
  factory _$PracticeRecommendationCopyWith(_PracticeRecommendation value, $Res Function(_PracticeRecommendation) _then) = __$PracticeRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String categoryId, Difficulty difficulty, int questionCount, String? icon
});




}
/// @nodoc
class __$PracticeRecommendationCopyWithImpl<$Res>
    implements _$PracticeRecommendationCopyWith<$Res> {
  __$PracticeRecommendationCopyWithImpl(this._self, this._then);

  final _PracticeRecommendation _self;
  final $Res Function(_PracticeRecommendation) _then;

/// Create a copy of PracticeRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? categoryId = null,Object? difficulty = null,Object? questionCount = null,Object? icon = freezed,}) {
  return _then(_PracticeRecommendation(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
