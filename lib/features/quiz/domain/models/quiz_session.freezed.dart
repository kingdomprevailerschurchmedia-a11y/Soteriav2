// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizSession {

 String get sessionId; String get playerId; GameMode get gameMode; String get category; Difficulty get difficulty; DateTime get startedTime; DateTime? get endedTime; DateTime? get lastUpdatedTime; int get currentQuestionIndex; String? get currentQuestionId; List<String> get questionIds; List<PlayerAnswer> get answeredQuestions; int get remainingQuestions; int get currentScore; int get currentStreak; int get bestStreak; double get accuracy; int get xpEarned; int get coinsEarned; QuizStatus get completionStatus; SessionStatus get sessionStatus; List<PowerUpState> get powerUps; TimerState? get timerState; DateTime? get questionStartTime; int get version;
/// Create a copy of QuizSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizSessionCopyWith<QuizSession> get copyWith => _$QuizSessionCopyWithImpl<QuizSession>(this as QuizSession, _$identity);

  /// Serializes this QuizSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.gameMode, gameMode) || other.gameMode == gameMode)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.startedTime, startedTime) || other.startedTime == startedTime)&&(identical(other.endedTime, endedTime) || other.endedTime == endedTime)&&(identical(other.lastUpdatedTime, lastUpdatedTime) || other.lastUpdatedTime == lastUpdatedTime)&&(identical(other.currentQuestionIndex, currentQuestionIndex) || other.currentQuestionIndex == currentQuestionIndex)&&(identical(other.currentQuestionId, currentQuestionId) || other.currentQuestionId == currentQuestionId)&&const DeepCollectionEquality().equals(other.questionIds, questionIds)&&const DeepCollectionEquality().equals(other.answeredQuestions, answeredQuestions)&&(identical(other.remainingQuestions, remainingQuestions) || other.remainingQuestions == remainingQuestions)&&(identical(other.currentScore, currentScore) || other.currentScore == currentScore)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus)&&(identical(other.sessionStatus, sessionStatus) || other.sessionStatus == sessionStatus)&&const DeepCollectionEquality().equals(other.powerUps, powerUps)&&(identical(other.timerState, timerState) || other.timerState == timerState)&&(identical(other.questionStartTime, questionStartTime) || other.questionStartTime == questionStartTime)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sessionId,playerId,gameMode,category,difficulty,startedTime,endedTime,lastUpdatedTime,currentQuestionIndex,currentQuestionId,const DeepCollectionEquality().hash(questionIds),const DeepCollectionEquality().hash(answeredQuestions),remainingQuestions,currentScore,currentStreak,bestStreak,accuracy,xpEarned,coinsEarned,completionStatus,sessionStatus,const DeepCollectionEquality().hash(powerUps),timerState,questionStartTime,version]);

@override
String toString() {
  return 'QuizSession(sessionId: $sessionId, playerId: $playerId, gameMode: $gameMode, category: $category, difficulty: $difficulty, startedTime: $startedTime, endedTime: $endedTime, lastUpdatedTime: $lastUpdatedTime, currentQuestionIndex: $currentQuestionIndex, currentQuestionId: $currentQuestionId, questionIds: $questionIds, answeredQuestions: $answeredQuestions, remainingQuestions: $remainingQuestions, currentScore: $currentScore, currentStreak: $currentStreak, bestStreak: $bestStreak, accuracy: $accuracy, xpEarned: $xpEarned, coinsEarned: $coinsEarned, completionStatus: $completionStatus, sessionStatus: $sessionStatus, powerUps: $powerUps, timerState: $timerState, questionStartTime: $questionStartTime, version: $version)';
}


}

/// @nodoc
abstract mixin class $QuizSessionCopyWith<$Res>  {
  factory $QuizSessionCopyWith(QuizSession value, $Res Function(QuizSession) _then) = _$QuizSessionCopyWithImpl;
@useResult
$Res call({
 String sessionId, String playerId, GameMode gameMode, String category, Difficulty difficulty, DateTime startedTime, DateTime? endedTime, DateTime? lastUpdatedTime, int currentQuestionIndex, String? currentQuestionId, List<String> questionIds, List<PlayerAnswer> answeredQuestions, int remainingQuestions, int currentScore, int currentStreak, int bestStreak, double accuracy, int xpEarned, int coinsEarned, QuizStatus completionStatus, SessionStatus sessionStatus, List<PowerUpState> powerUps, TimerState? timerState, DateTime? questionStartTime, int version
});


$TimerStateCopyWith<$Res>? get timerState;

}
/// @nodoc
class _$QuizSessionCopyWithImpl<$Res>
    implements $QuizSessionCopyWith<$Res> {
  _$QuizSessionCopyWithImpl(this._self, this._then);

  final QuizSession _self;
  final $Res Function(QuizSession) _then;

/// Create a copy of QuizSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? playerId = null,Object? gameMode = null,Object? category = null,Object? difficulty = null,Object? startedTime = null,Object? endedTime = freezed,Object? lastUpdatedTime = freezed,Object? currentQuestionIndex = null,Object? currentQuestionId = freezed,Object? questionIds = null,Object? answeredQuestions = null,Object? remainingQuestions = null,Object? currentScore = null,Object? currentStreak = null,Object? bestStreak = null,Object? accuracy = null,Object? xpEarned = null,Object? coinsEarned = null,Object? completionStatus = null,Object? sessionStatus = null,Object? powerUps = null,Object? timerState = freezed,Object? questionStartTime = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,gameMode: null == gameMode ? _self.gameMode : gameMode // ignore: cast_nullable_to_non_nullable
as GameMode,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,startedTime: null == startedTime ? _self.startedTime : startedTime // ignore: cast_nullable_to_non_nullable
as DateTime,endedTime: freezed == endedTime ? _self.endedTime : endedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedTime: freezed == lastUpdatedTime ? _self.lastUpdatedTime : lastUpdatedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,currentQuestionIndex: null == currentQuestionIndex ? _self.currentQuestionIndex : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
as int,currentQuestionId: freezed == currentQuestionId ? _self.currentQuestionId : currentQuestionId // ignore: cast_nullable_to_non_nullable
as String?,questionIds: null == questionIds ? _self.questionIds : questionIds // ignore: cast_nullable_to_non_nullable
as List<String>,answeredQuestions: null == answeredQuestions ? _self.answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as List<PlayerAnswer>,remainingQuestions: null == remainingQuestions ? _self.remainingQuestions : remainingQuestions // ignore: cast_nullable_to_non_nullable
as int,currentScore: null == currentScore ? _self.currentScore : currentScore // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as QuizStatus,sessionStatus: null == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as SessionStatus,powerUps: null == powerUps ? _self.powerUps : powerUps // ignore: cast_nullable_to_non_nullable
as List<PowerUpState>,timerState: freezed == timerState ? _self.timerState : timerState // ignore: cast_nullable_to_non_nullable
as TimerState?,questionStartTime: freezed == questionStartTime ? _self.questionStartTime : questionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of QuizSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get timerState {
    if (_self.timerState == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.timerState!, (value) {
    return _then(_self.copyWith(timerState: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuizSession].
extension QuizSessionPatterns on QuizSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizSession value)  $default,){
final _that = this;
switch (_that) {
case _QuizSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizSession value)?  $default,){
final _that = this;
switch (_that) {
case _QuizSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String playerId,  GameMode gameMode,  String category,  Difficulty difficulty,  DateTime startedTime,  DateTime? endedTime,  DateTime? lastUpdatedTime,  int currentQuestionIndex,  String? currentQuestionId,  List<String> questionIds,  List<PlayerAnswer> answeredQuestions,  int remainingQuestions,  int currentScore,  int currentStreak,  int bestStreak,  double accuracy,  int xpEarned,  int coinsEarned,  QuizStatus completionStatus,  SessionStatus sessionStatus,  List<PowerUpState> powerUps,  TimerState? timerState,  DateTime? questionStartTime,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizSession() when $default != null:
return $default(_that.sessionId,_that.playerId,_that.gameMode,_that.category,_that.difficulty,_that.startedTime,_that.endedTime,_that.lastUpdatedTime,_that.currentQuestionIndex,_that.currentQuestionId,_that.questionIds,_that.answeredQuestions,_that.remainingQuestions,_that.currentScore,_that.currentStreak,_that.bestStreak,_that.accuracy,_that.xpEarned,_that.coinsEarned,_that.completionStatus,_that.sessionStatus,_that.powerUps,_that.timerState,_that.questionStartTime,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String playerId,  GameMode gameMode,  String category,  Difficulty difficulty,  DateTime startedTime,  DateTime? endedTime,  DateTime? lastUpdatedTime,  int currentQuestionIndex,  String? currentQuestionId,  List<String> questionIds,  List<PlayerAnswer> answeredQuestions,  int remainingQuestions,  int currentScore,  int currentStreak,  int bestStreak,  double accuracy,  int xpEarned,  int coinsEarned,  QuizStatus completionStatus,  SessionStatus sessionStatus,  List<PowerUpState> powerUps,  TimerState? timerState,  DateTime? questionStartTime,  int version)  $default,) {final _that = this;
switch (_that) {
case _QuizSession():
return $default(_that.sessionId,_that.playerId,_that.gameMode,_that.category,_that.difficulty,_that.startedTime,_that.endedTime,_that.lastUpdatedTime,_that.currentQuestionIndex,_that.currentQuestionId,_that.questionIds,_that.answeredQuestions,_that.remainingQuestions,_that.currentScore,_that.currentStreak,_that.bestStreak,_that.accuracy,_that.xpEarned,_that.coinsEarned,_that.completionStatus,_that.sessionStatus,_that.powerUps,_that.timerState,_that.questionStartTime,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String playerId,  GameMode gameMode,  String category,  Difficulty difficulty,  DateTime startedTime,  DateTime? endedTime,  DateTime? lastUpdatedTime,  int currentQuestionIndex,  String? currentQuestionId,  List<String> questionIds,  List<PlayerAnswer> answeredQuestions,  int remainingQuestions,  int currentScore,  int currentStreak,  int bestStreak,  double accuracy,  int xpEarned,  int coinsEarned,  QuizStatus completionStatus,  SessionStatus sessionStatus,  List<PowerUpState> powerUps,  TimerState? timerState,  DateTime? questionStartTime,  int version)?  $default,) {final _that = this;
switch (_that) {
case _QuizSession() when $default != null:
return $default(_that.sessionId,_that.playerId,_that.gameMode,_that.category,_that.difficulty,_that.startedTime,_that.endedTime,_that.lastUpdatedTime,_that.currentQuestionIndex,_that.currentQuestionId,_that.questionIds,_that.answeredQuestions,_that.remainingQuestions,_that.currentScore,_that.currentStreak,_that.bestStreak,_that.accuracy,_that.xpEarned,_that.coinsEarned,_that.completionStatus,_that.sessionStatus,_that.powerUps,_that.timerState,_that.questionStartTime,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizSession implements QuizSession {
  const _QuizSession({required this.sessionId, required this.playerId, required this.gameMode, required this.category, required this.difficulty, required this.startedTime, this.endedTime, this.lastUpdatedTime, this.currentQuestionIndex = 0, this.currentQuestionId, final  List<String> questionIds = const [], final  List<PlayerAnswer> answeredQuestions = const [], this.remainingQuestions = 0, this.currentScore = 0, this.currentStreak = 0, this.bestStreak = 0, this.accuracy = 0.0, this.xpEarned = 0, this.coinsEarned = 0, this.completionStatus = QuizStatus.idle, this.sessionStatus = SessionStatus.created, final  List<PowerUpState> powerUps = const [], this.timerState, this.questionStartTime, this.version = 1}): _questionIds = questionIds,_answeredQuestions = answeredQuestions,_powerUps = powerUps;
  factory _QuizSession.fromJson(Map<String, dynamic> json) => _$QuizSessionFromJson(json);

@override final  String sessionId;
@override final  String playerId;
@override final  GameMode gameMode;
@override final  String category;
@override final  Difficulty difficulty;
@override final  DateTime startedTime;
@override final  DateTime? endedTime;
@override final  DateTime? lastUpdatedTime;
@override@JsonKey() final  int currentQuestionIndex;
@override final  String? currentQuestionId;
 final  List<String> _questionIds;
@override@JsonKey() List<String> get questionIds {
  if (_questionIds is EqualUnmodifiableListView) return _questionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questionIds);
}

 final  List<PlayerAnswer> _answeredQuestions;
@override@JsonKey() List<PlayerAnswer> get answeredQuestions {
  if (_answeredQuestions is EqualUnmodifiableListView) return _answeredQuestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answeredQuestions);
}

@override@JsonKey() final  int remainingQuestions;
@override@JsonKey() final  int currentScore;
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int bestStreak;
@override@JsonKey() final  double accuracy;
@override@JsonKey() final  int xpEarned;
@override@JsonKey() final  int coinsEarned;
@override@JsonKey() final  QuizStatus completionStatus;
@override@JsonKey() final  SessionStatus sessionStatus;
 final  List<PowerUpState> _powerUps;
@override@JsonKey() List<PowerUpState> get powerUps {
  if (_powerUps is EqualUnmodifiableListView) return _powerUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_powerUps);
}

@override final  TimerState? timerState;
@override final  DateTime? questionStartTime;
@override@JsonKey() final  int version;

/// Create a copy of QuizSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizSessionCopyWith<_QuizSession> get copyWith => __$QuizSessionCopyWithImpl<_QuizSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.gameMode, gameMode) || other.gameMode == gameMode)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.startedTime, startedTime) || other.startedTime == startedTime)&&(identical(other.endedTime, endedTime) || other.endedTime == endedTime)&&(identical(other.lastUpdatedTime, lastUpdatedTime) || other.lastUpdatedTime == lastUpdatedTime)&&(identical(other.currentQuestionIndex, currentQuestionIndex) || other.currentQuestionIndex == currentQuestionIndex)&&(identical(other.currentQuestionId, currentQuestionId) || other.currentQuestionId == currentQuestionId)&&const DeepCollectionEquality().equals(other._questionIds, _questionIds)&&const DeepCollectionEquality().equals(other._answeredQuestions, _answeredQuestions)&&(identical(other.remainingQuestions, remainingQuestions) || other.remainingQuestions == remainingQuestions)&&(identical(other.currentScore, currentScore) || other.currentScore == currentScore)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned)&&(identical(other.coinsEarned, coinsEarned) || other.coinsEarned == coinsEarned)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus)&&(identical(other.sessionStatus, sessionStatus) || other.sessionStatus == sessionStatus)&&const DeepCollectionEquality().equals(other._powerUps, _powerUps)&&(identical(other.timerState, timerState) || other.timerState == timerState)&&(identical(other.questionStartTime, questionStartTime) || other.questionStartTime == questionStartTime)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sessionId,playerId,gameMode,category,difficulty,startedTime,endedTime,lastUpdatedTime,currentQuestionIndex,currentQuestionId,const DeepCollectionEquality().hash(_questionIds),const DeepCollectionEquality().hash(_answeredQuestions),remainingQuestions,currentScore,currentStreak,bestStreak,accuracy,xpEarned,coinsEarned,completionStatus,sessionStatus,const DeepCollectionEquality().hash(_powerUps),timerState,questionStartTime,version]);

@override
String toString() {
  return 'QuizSession(sessionId: $sessionId, playerId: $playerId, gameMode: $gameMode, category: $category, difficulty: $difficulty, startedTime: $startedTime, endedTime: $endedTime, lastUpdatedTime: $lastUpdatedTime, currentQuestionIndex: $currentQuestionIndex, currentQuestionId: $currentQuestionId, questionIds: $questionIds, answeredQuestions: $answeredQuestions, remainingQuestions: $remainingQuestions, currentScore: $currentScore, currentStreak: $currentStreak, bestStreak: $bestStreak, accuracy: $accuracy, xpEarned: $xpEarned, coinsEarned: $coinsEarned, completionStatus: $completionStatus, sessionStatus: $sessionStatus, powerUps: $powerUps, timerState: $timerState, questionStartTime: $questionStartTime, version: $version)';
}


}

/// @nodoc
abstract mixin class _$QuizSessionCopyWith<$Res> implements $QuizSessionCopyWith<$Res> {
  factory _$QuizSessionCopyWith(_QuizSession value, $Res Function(_QuizSession) _then) = __$QuizSessionCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String playerId, GameMode gameMode, String category, Difficulty difficulty, DateTime startedTime, DateTime? endedTime, DateTime? lastUpdatedTime, int currentQuestionIndex, String? currentQuestionId, List<String> questionIds, List<PlayerAnswer> answeredQuestions, int remainingQuestions, int currentScore, int currentStreak, int bestStreak, double accuracy, int xpEarned, int coinsEarned, QuizStatus completionStatus, SessionStatus sessionStatus, List<PowerUpState> powerUps, TimerState? timerState, DateTime? questionStartTime, int version
});


@override $TimerStateCopyWith<$Res>? get timerState;

}
/// @nodoc
class __$QuizSessionCopyWithImpl<$Res>
    implements _$QuizSessionCopyWith<$Res> {
  __$QuizSessionCopyWithImpl(this._self, this._then);

  final _QuizSession _self;
  final $Res Function(_QuizSession) _then;

/// Create a copy of QuizSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? playerId = null,Object? gameMode = null,Object? category = null,Object? difficulty = null,Object? startedTime = null,Object? endedTime = freezed,Object? lastUpdatedTime = freezed,Object? currentQuestionIndex = null,Object? currentQuestionId = freezed,Object? questionIds = null,Object? answeredQuestions = null,Object? remainingQuestions = null,Object? currentScore = null,Object? currentStreak = null,Object? bestStreak = null,Object? accuracy = null,Object? xpEarned = null,Object? coinsEarned = null,Object? completionStatus = null,Object? sessionStatus = null,Object? powerUps = null,Object? timerState = freezed,Object? questionStartTime = freezed,Object? version = null,}) {
  return _then(_QuizSession(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,gameMode: null == gameMode ? _self.gameMode : gameMode // ignore: cast_nullable_to_non_nullable
as GameMode,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,startedTime: null == startedTime ? _self.startedTime : startedTime // ignore: cast_nullable_to_non_nullable
as DateTime,endedTime: freezed == endedTime ? _self.endedTime : endedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedTime: freezed == lastUpdatedTime ? _self.lastUpdatedTime : lastUpdatedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,currentQuestionIndex: null == currentQuestionIndex ? _self.currentQuestionIndex : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
as int,currentQuestionId: freezed == currentQuestionId ? _self.currentQuestionId : currentQuestionId // ignore: cast_nullable_to_non_nullable
as String?,questionIds: null == questionIds ? _self._questionIds : questionIds // ignore: cast_nullable_to_non_nullable
as List<String>,answeredQuestions: null == answeredQuestions ? _self._answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as List<PlayerAnswer>,remainingQuestions: null == remainingQuestions ? _self.remainingQuestions : remainingQuestions // ignore: cast_nullable_to_non_nullable
as int,currentScore: null == currentScore ? _self.currentScore : currentScore // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,coinsEarned: null == coinsEarned ? _self.coinsEarned : coinsEarned // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as QuizStatus,sessionStatus: null == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as SessionStatus,powerUps: null == powerUps ? _self._powerUps : powerUps // ignore: cast_nullable_to_non_nullable
as List<PowerUpState>,timerState: freezed == timerState ? _self.timerState : timerState // ignore: cast_nullable_to_non_nullable
as TimerState?,questionStartTime: freezed == questionStartTime ? _self.questionStartTime : questionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of QuizSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get timerState {
    if (_self.timerState == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.timerState!, (value) {
    return _then(_self.copyWith(timerState: value));
  });
}
}

// dart format on
