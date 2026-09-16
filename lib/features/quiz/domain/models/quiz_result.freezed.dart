// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizResult {

 String get sessionId; String get playerId; GameMode get gameMode; String get category; Difficulty get difficulty; int get totalQuestions; int get answeredQuestions; int get correctAnswers; int get wrongAnswers; int get skipped; int get timedOut; double get accuracy; int get finalScore; int get xpEarned; int get coinsEarned; int get longestStreak; int get finalStreak; Duration get averageResponseTime; Duration get fastestResponseTime; Duration get slowestResponseTime; List<QuestionResult> get questionResults; List<PowerUpType> get powerUpsUsed; DateTime get completedAt; DateTime? get createdAt; Duration get completionTime; String get performanceRating; int get version;
/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizResultCopyWith<QuizResult> get copyWith => _$QuizResultCopyWithImpl<QuizResult>(this as QuizResult, _$identity);

  /// Serializes this QuizResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.gameMode, gameMode) || other.gameMode == gameMode)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.answeredQuestions, answeredQuestions) || other.answeredQuestions == answeredQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&(identical(other.skipped, skipped) || other.skipped == skipped)&&(identical(other.timedOut, timedOut) || other.timedOut == timedOut)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.finalStreak, finalStreak) || other.finalStreak == finalStreak)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.fastestResponseTime, fastestResponseTime) || other.fastestResponseTime == fastestResponseTime)&&(identical(other.slowestResponseTime, slowestResponseTime) || other.slowestResponseTime == slowestResponseTime)&&const DeepCollectionEquality().equals(other.questionResults, questionResults)&&const DeepCollectionEquality().equals(other.powerUpsUsed, powerUpsUsed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completionTime, completionTime) || other.completionTime == completionTime)&&(identical(other.performanceRating, performanceRating) || other.performanceRating == performanceRating)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sessionId,playerId,gameMode,category,difficulty,totalQuestions,answeredQuestions,correctAnswers,wrongAnswers,skipped,timedOut,accuracy,finalScore,xpEarned,coinsEarned,longestStreak,finalStreak,averageResponseTime,fastestResponseTime,slowestResponseTime,const DeepCollectionEquality().hash(questionResults),const DeepCollectionEquality().hash(powerUpsUsed),completedAt,createdAt,completionTime,performanceRating,version]);

@override
String toString() {
  return 'QuizResult(sessionId: $sessionId, playerId: $playerId, gameMode: $gameMode, category: $category, difficulty: $difficulty, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, skipped: $skipped, timedOut: $timedOut, accuracy: $accuracy, finalScore: $finalScore, xpEarned: $xpEarned, coinsEarned: $coinsEarned, longestStreak: $longestStreak, finalStreak: $finalStreak, averageResponseTime: $averageResponseTime, fastestResponseTime: $fastestResponseTime, slowestResponseTime: $slowestResponseTime, questionResults: $questionResults, powerUpsUsed: $powerUpsUsed, completedAt: $completedAt, createdAt: $createdAt, completionTime: $completionTime, performanceRating: $performanceRating, version: $version)';
}


}

/// @nodoc
abstract mixin class $QuizResultCopyWith<$Res>  {
  factory $QuizResultCopyWith(QuizResult value, $Res Function(QuizResult) _then) = _$QuizResultCopyWithImpl;
@useResult
$Res call({
 String sessionId, String playerId, GameMode gameMode, String category, Difficulty difficulty, int totalQuestions, int answeredQuestions, int correctAnswers, int wrongAnswers, int skipped, int timedOut, double accuracy, int finalScore, int xpEarned, int coinsEarned, int longestStreak, int finalStreak, Duration averageResponseTime, Duration fastestResponseTime, Duration slowestResponseTime, List<QuestionResult> questionResults, List<PowerUpType> powerUpsUsed, DateTime completedAt, DateTime? createdAt, Duration completionTime, String performanceRating, int version
});




}
/// @nodoc
class _$QuizResultCopyWithImpl<$Res>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._self, this._then);

  final QuizResult _self;
  final $Res Function(QuizResult) _then;

/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? playerId = null,Object? gameMode = null,Object? category = null,Object? difficulty = null,Object? totalQuestions = null,Object? answeredQuestions = null,Object? correctAnswers = null,Object? wrongAnswers = null,Object? skipped = null,Object? timedOut = null,Object? accuracy = null,Object? finalScore = null,Object? xpEarned = null,Object? coinsEarned = null,Object? longestStreak = null,Object? finalStreak = null,Object? averageResponseTime = null,Object? fastestResponseTime = null,Object? slowestResponseTime = null,Object? questionResults = null,Object? powerUpsUsed = null,Object? completedAt = null,Object? createdAt = freezed,Object? completionTime = null,Object? performanceRating = null,Object? version = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,gameMode: null == gameMode ? _self.gameMode : gameMode // ignore: cast_nullable_to_non_nullable
as GameMode,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,answeredQuestions: null == answeredQuestions ? _self.answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,skipped: null == skipped ? _self.skipped : skipped // ignore: cast_nullable_to_non_nullable
as int,timedOut: null == timedOut ? _self.timedOut : timedOut // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,finalStreak: null == finalStreak ? _self.finalStreak : finalStreak // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,fastestResponseTime: null == fastestResponseTime ? _self.fastestResponseTime : fastestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,slowestResponseTime: null == slowestResponseTime ? _self.slowestResponseTime : slowestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,questionResults: null == questionResults ? _self.questionResults : questionResults // ignore: cast_nullable_to_non_nullable
as List<QuestionResult>,powerUpsUsed: null == powerUpsUsed ? _self.powerUpsUsed : powerUpsUsed // ignore: cast_nullable_to_non_nullable
as List<PowerUpType>,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completionTime: null == completionTime ? _self.completionTime : completionTime // ignore: cast_nullable_to_non_nullable
as Duration,performanceRating: null == performanceRating ? _self.performanceRating : performanceRating // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizResult].
extension QuizResultPatterns on QuizResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizResult value)  $default,){
final _that = this;
switch (_that) {
case _QuizResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizResult value)?  $default,){
final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String playerId,  GameMode gameMode,  String category,  Difficulty difficulty,  int totalQuestions,  int answeredQuestions,  int correctAnswers,  int wrongAnswers,  int skipped,  int timedOut,  double accuracy,  int finalScore,  int xpEarned,  int coinsEarned,  int longestStreak,  int finalStreak,  Duration averageResponseTime,  Duration fastestResponseTime,  Duration slowestResponseTime,  List<QuestionResult> questionResults,  List<PowerUpType> powerUpsUsed,  DateTime completedAt,  DateTime? createdAt,  Duration completionTime,  String performanceRating,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
return $default(_that.sessionId,_that.playerId,_that.gameMode,_that.category,_that.difficulty,_that.totalQuestions,_that.answeredQuestions,_that.correctAnswers,_that.wrongAnswers,_that.skipped,_that.timedOut,_that.accuracy,_that.finalScore,_that.xpEarned,_that.coinsEarned,_that.longestStreak,_that.finalStreak,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.questionResults,_that.powerUpsUsed,_that.completedAt,_that.createdAt,_that.completionTime,_that.performanceRating,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String playerId,  GameMode gameMode,  String category,  Difficulty difficulty,  int totalQuestions,  int answeredQuestions,  int correctAnswers,  int wrongAnswers,  int skipped,  int timedOut,  double accuracy,  int finalScore,  int xpEarned,  int coinsEarned,  int longestStreak,  int finalStreak,  Duration averageResponseTime,  Duration fastestResponseTime,  Duration slowestResponseTime,  List<QuestionResult> questionResults,  List<PowerUpType> powerUpsUsed,  DateTime completedAt,  DateTime? createdAt,  Duration completionTime,  String performanceRating,  int version)  $default,) {final _that = this;
switch (_that) {
case _QuizResult():
return $default(_that.sessionId,_that.playerId,_that.gameMode,_that.category,_that.difficulty,_that.totalQuestions,_that.answeredQuestions,_that.correctAnswers,_that.wrongAnswers,_that.skipped,_that.timedOut,_that.accuracy,_that.finalScore,_that.xpEarned,_that.coinsEarned,_that.longestStreak,_that.finalStreak,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.questionResults,_that.powerUpsUsed,_that.completedAt,_that.createdAt,_that.completionTime,_that.performanceRating,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String playerId,  GameMode gameMode,  String category,  Difficulty difficulty,  int totalQuestions,  int answeredQuestions,  int correctAnswers,  int wrongAnswers,  int skipped,  int timedOut,  double accuracy,  int finalScore,  int xpEarned,  int coinsEarned,  int longestStreak,  int finalStreak,  Duration averageResponseTime,  Duration fastestResponseTime,  Duration slowestResponseTime,  List<QuestionResult> questionResults,  List<PowerUpType> powerUpsUsed,  DateTime completedAt,  DateTime? createdAt,  Duration completionTime,  String performanceRating,  int version)?  $default,) {final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
return $default(_that.sessionId,_that.playerId,_that.gameMode,_that.category,_that.difficulty,_that.totalQuestions,_that.answeredQuestions,_that.correctAnswers,_that.wrongAnswers,_that.skipped,_that.timedOut,_that.accuracy,_that.finalScore,_that.xpEarned,_that.coinsEarned,_that.longestStreak,_that.finalStreak,_that.averageResponseTime,_that.fastestResponseTime,_that.slowestResponseTime,_that.questionResults,_that.powerUpsUsed,_that.completedAt,_that.createdAt,_that.completionTime,_that.performanceRating,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizResult implements QuizResult {
  const _QuizResult({required this.sessionId, required this.playerId, required this.gameMode, required this.category, required this.difficulty, required this.totalQuestions, required this.answeredQuestions, required this.correctAnswers, required this.wrongAnswers, required this.skipped, required this.timedOut, required this.accuracy, required this.finalScore, required this.xpEarned, this.coinsEarned = 0, required this.longestStreak, required this.finalStreak, required this.averageResponseTime, required this.fastestResponseTime, required this.slowestResponseTime, required final  List<QuestionResult> questionResults, final  List<PowerUpType> powerUpsUsed = const [], required this.completedAt, this.createdAt, required this.completionTime, required this.performanceRating, this.version = 1}): _questionResults = questionResults,_powerUpsUsed = powerUpsUsed;
  factory _QuizResult.fromJson(Map<String, dynamic> json) => _$QuizResultFromJson(json);

@override final  String sessionId;
@override final  String playerId;
@override final  GameMode gameMode;
@override final  String category;
@override final  Difficulty difficulty;
@override final  int totalQuestions;
@override final  int answeredQuestions;
@override final  int correctAnswers;
@override final  int wrongAnswers;
@override final  int skipped;
@override final  int timedOut;
@override final  double accuracy;
@override final  int finalScore;
@override final  int xpEarned;
@override@JsonKey() final  int coinsEarned;
@override final  int longestStreak;
@override final  int finalStreak;
@override final  Duration averageResponseTime;
@override final  Duration fastestResponseTime;
@override final  Duration slowestResponseTime;
 final  List<QuestionResult> _questionResults;
@override List<QuestionResult> get questionResults {
  if (_questionResults is EqualUnmodifiableListView) return _questionResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questionResults);
}

 final  List<PowerUpType> _powerUpsUsed;
@override@JsonKey() List<PowerUpType> get powerUpsUsed {
  if (_powerUpsUsed is EqualUnmodifiableListView) return _powerUpsUsed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_powerUpsUsed);
}

@override final  DateTime completedAt;
@override final  DateTime? createdAt;
@override final  Duration completionTime;
@override final  String performanceRating;
@override@JsonKey() final  int version;

/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizResultCopyWith<_QuizResult> get copyWith => __$QuizResultCopyWithImpl<_QuizResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.gameMode, gameMode) || other.gameMode == gameMode)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.answeredQuestions, answeredQuestions) || other.answeredQuestions == answeredQuestions)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&(identical(other.skipped, skipped) || other.skipped == skipped)&&(identical(other.timedOut, timedOut) || other.timedOut == timedOut)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.finalStreak, finalStreak) || other.finalStreak == finalStreak)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&(identical(other.fastestResponseTime, fastestResponseTime) || other.fastestResponseTime == fastestResponseTime)&&(identical(other.slowestResponseTime, slowestResponseTime) || other.slowestResponseTime == slowestResponseTime)&&const DeepCollectionEquality().equals(other._questionResults, _questionResults)&&const DeepCollectionEquality().equals(other._powerUpsUsed, _powerUpsUsed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completionTime, completionTime) || other.completionTime == completionTime)&&(identical(other.performanceRating, performanceRating) || other.performanceRating == performanceRating)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sessionId,playerId,gameMode,category,difficulty,totalQuestions,answeredQuestions,correctAnswers,wrongAnswers,skipped,timedOut,accuracy,finalScore,xpEarned,coinsEarned,longestStreak,finalStreak,averageResponseTime,fastestResponseTime,slowestResponseTime,const DeepCollectionEquality().hash(_questionResults),const DeepCollectionEquality().hash(_powerUpsUsed),completedAt,createdAt,completionTime,performanceRating,version]);

@override
String toString() {
  return 'QuizResult(sessionId: $sessionId, playerId: $playerId, gameMode: $gameMode, category: $category, difficulty: $difficulty, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, skipped: $skipped, timedOut: $timedOut, accuracy: $accuracy, finalScore: $finalScore, xpEarned: $xpEarned, coinsEarned: $coinsEarned, longestStreak: $longestStreak, finalStreak: $finalStreak, averageResponseTime: $averageResponseTime, fastestResponseTime: $fastestResponseTime, slowestResponseTime: $slowestResponseTime, questionResults: $questionResults, powerUpsUsed: $powerUpsUsed, completedAt: $completedAt, createdAt: $createdAt, completionTime: $completionTime, performanceRating: $performanceRating, version: $version)';
}


}

/// @nodoc
abstract mixin class _$QuizResultCopyWith<$Res> implements $QuizResultCopyWith<$Res> {
  factory _$QuizResultCopyWith(_QuizResult value, $Res Function(_QuizResult) _then) = __$QuizResultCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String playerId, GameMode gameMode, String category, Difficulty difficulty, int totalQuestions, int answeredQuestions, int correctAnswers, int wrongAnswers, int skipped, int timedOut, double accuracy, int finalScore, int xpEarned, int coinsEarned, int longestStreak, int finalStreak, Duration averageResponseTime, Duration fastestResponseTime, Duration slowestResponseTime, List<QuestionResult> questionResults, List<PowerUpType> powerUpsUsed, DateTime completedAt, DateTime? createdAt, Duration completionTime, String performanceRating, int version
});




}
/// @nodoc
class __$QuizResultCopyWithImpl<$Res>
    implements _$QuizResultCopyWith<$Res> {
  __$QuizResultCopyWithImpl(this._self, this._then);

  final _QuizResult _self;
  final $Res Function(_QuizResult) _then;

/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? playerId = null,Object? gameMode = null,Object? category = null,Object? difficulty = null,Object? totalQuestions = null,Object? answeredQuestions = null,Object? correctAnswers = null,Object? wrongAnswers = null,Object? skipped = null,Object? timedOut = null,Object? accuracy = null,Object? finalScore = null,Object? xpEarned = null,Object? coinsEarned = null,Object? longestStreak = null,Object? finalStreak = null,Object? averageResponseTime = null,Object? fastestResponseTime = null,Object? slowestResponseTime = null,Object? questionResults = null,Object? powerUpsUsed = null,Object? completedAt = null,Object? createdAt = freezed,Object? completionTime = null,Object? performanceRating = null,Object? version = null,}) {
  return _then(_QuizResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,gameMode: null == gameMode ? _self.gameMode : gameMode // ignore: cast_nullable_to_non_nullable
as GameMode,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,answeredQuestions: null == answeredQuestions ? _self.answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,skipped: null == skipped ? _self.skipped : skipped // ignore: cast_nullable_to_non_nullable
as int,timedOut: null == timedOut ? _self.timedOut : timedOut // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,finalStreak: null == finalStreak ? _self.finalStreak : finalStreak // ignore: cast_nullable_to_non_nullable
as int,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,fastestResponseTime: null == fastestResponseTime ? _self.fastestResponseTime : fastestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,slowestResponseTime: null == slowestResponseTime ? _self.slowestResponseTime : slowestResponseTime // ignore: cast_nullable_to_non_nullable
as Duration,questionResults: null == questionResults ? _self._questionResults : questionResults // ignore: cast_nullable_to_non_nullable
as List<QuestionResult>,powerUpsUsed: null == powerUpsUsed ? _self._powerUpsUsed : powerUpsUsed // ignore: cast_nullable_to_non_nullable
as List<PowerUpType>,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completionTime: null == completionTime ? _self.completionTime : completionTime // ignore: cast_nullable_to_non_nullable
as Duration,performanceRating: null == performanceRating ? _self.performanceRating : performanceRating // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
