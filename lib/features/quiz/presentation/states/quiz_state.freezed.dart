// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizState {

 QuizStatus get status; Question? get currentQuestion; int get currentIndex; List<Question> get questions; QuizSession? get session; QuizResult? get result; int get score; int get streak; int get bestStreak; int get xp; ScoreResult? get lastScoreResult; List<RewardEvent> get rewardEvents; List<PlayerAnswer> get answeredQuestions; TimerState? get timer; List<PowerUpState> get powerUps; Set<String> get hiddenOptionIds; Map<String, double> get audienceDistribution; TimerState? get powerUpTimer; bool get isLoading; String? get error; bool get isOffline; String? get selectedOptionId; bool get isAnswerLocked; DateTime? get questionStartTime;
/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizStateCopyWith<QuizState> get copyWith => _$QuizStateCopyWithImpl<QuizState>(this as QuizState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentQuestion, currentQuestion) || other.currentQuestion == currentQuestion)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.session, session) || other.session == session)&&(identical(other.result, result) || other.result == result)&&(identical(other.score, score) || other.score == score)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.lastScoreResult, lastScoreResult) || other.lastScoreResult == lastScoreResult)&&const DeepCollectionEquality().equals(other.rewardEvents, rewardEvents)&&const DeepCollectionEquality().equals(other.answeredQuestions, answeredQuestions)&&(identical(other.timer, timer) || other.timer == timer)&&const DeepCollectionEquality().equals(other.powerUps, powerUps)&&const DeepCollectionEquality().equals(other.hiddenOptionIds, hiddenOptionIds)&&const DeepCollectionEquality().equals(other.audienceDistribution, audienceDistribution)&&(identical(other.powerUpTimer, powerUpTimer) || other.powerUpTimer == powerUpTimer)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.selectedOptionId, selectedOptionId) || other.selectedOptionId == selectedOptionId)&&(identical(other.isAnswerLocked, isAnswerLocked) || other.isAnswerLocked == isAnswerLocked)&&(identical(other.questionStartTime, questionStartTime) || other.questionStartTime == questionStartTime));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,currentQuestion,currentIndex,const DeepCollectionEquality().hash(questions),session,result,score,streak,bestStreak,xp,lastScoreResult,const DeepCollectionEquality().hash(rewardEvents),const DeepCollectionEquality().hash(answeredQuestions),timer,const DeepCollectionEquality().hash(powerUps),const DeepCollectionEquality().hash(hiddenOptionIds),const DeepCollectionEquality().hash(audienceDistribution),powerUpTimer,isLoading,error,isOffline,selectedOptionId,isAnswerLocked,questionStartTime]);

@override
String toString() {
  return 'QuizState(status: $status, currentQuestion: $currentQuestion, currentIndex: $currentIndex, questions: $questions, session: $session, result: $result, score: $score, streak: $streak, bestStreak: $bestStreak, xp: $xp, lastScoreResult: $lastScoreResult, rewardEvents: $rewardEvents, answeredQuestions: $answeredQuestions, timer: $timer, powerUps: $powerUps, hiddenOptionIds: $hiddenOptionIds, audienceDistribution: $audienceDistribution, powerUpTimer: $powerUpTimer, isLoading: $isLoading, error: $error, isOffline: $isOffline, selectedOptionId: $selectedOptionId, isAnswerLocked: $isAnswerLocked, questionStartTime: $questionStartTime)';
}


}

/// @nodoc
abstract mixin class $QuizStateCopyWith<$Res>  {
  factory $QuizStateCopyWith(QuizState value, $Res Function(QuizState) _then) = _$QuizStateCopyWithImpl;
@useResult
$Res call({
 QuizStatus status, Question? currentQuestion, int currentIndex, List<Question> questions, QuizSession? session, QuizResult? result, int score, int streak, int bestStreak, int xp, ScoreResult? lastScoreResult, List<RewardEvent> rewardEvents, List<PlayerAnswer> answeredQuestions, TimerState? timer, List<PowerUpState> powerUps, Set<String> hiddenOptionIds, Map<String, double> audienceDistribution, TimerState? powerUpTimer, bool isLoading, String? error, bool isOffline, String? selectedOptionId, bool isAnswerLocked, DateTime? questionStartTime
});


$QuestionCopyWith<$Res>? get currentQuestion;$QuizSessionCopyWith<$Res>? get session;$QuizResultCopyWith<$Res>? get result;$ScoreResultCopyWith<$Res>? get lastScoreResult;$TimerStateCopyWith<$Res>? get timer;$TimerStateCopyWith<$Res>? get powerUpTimer;

}
/// @nodoc
class _$QuizStateCopyWithImpl<$Res>
    implements $QuizStateCopyWith<$Res> {
  _$QuizStateCopyWithImpl(this._self, this._then);

  final QuizState _self;
  final $Res Function(QuizState) _then;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? currentQuestion = freezed,Object? currentIndex = null,Object? questions = null,Object? session = freezed,Object? result = freezed,Object? score = null,Object? streak = null,Object? bestStreak = null,Object? xp = null,Object? lastScoreResult = freezed,Object? rewardEvents = null,Object? answeredQuestions = null,Object? timer = freezed,Object? powerUps = null,Object? hiddenOptionIds = null,Object? audienceDistribution = null,Object? powerUpTimer = freezed,Object? isLoading = null,Object? error = freezed,Object? isOffline = null,Object? selectedOptionId = freezed,Object? isAnswerLocked = null,Object? questionStartTime = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuizStatus,currentQuestion: freezed == currentQuestion ? _self.currentQuestion : currentQuestion // ignore: cast_nullable_to_non_nullable
as Question?,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as QuizSession?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as QuizResult?,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,lastScoreResult: freezed == lastScoreResult ? _self.lastScoreResult : lastScoreResult // ignore: cast_nullable_to_non_nullable
as ScoreResult?,rewardEvents: null == rewardEvents ? _self.rewardEvents : rewardEvents // ignore: cast_nullable_to_non_nullable
as List<RewardEvent>,answeredQuestions: null == answeredQuestions ? _self.answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as List<PlayerAnswer>,timer: freezed == timer ? _self.timer : timer // ignore: cast_nullable_to_non_nullable
as TimerState?,powerUps: null == powerUps ? _self.powerUps : powerUps // ignore: cast_nullable_to_non_nullable
as List<PowerUpState>,hiddenOptionIds: null == hiddenOptionIds ? _self.hiddenOptionIds : hiddenOptionIds // ignore: cast_nullable_to_non_nullable
as Set<String>,audienceDistribution: null == audienceDistribution ? _self.audienceDistribution : audienceDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, double>,powerUpTimer: freezed == powerUpTimer ? _self.powerUpTimer : powerUpTimer // ignore: cast_nullable_to_non_nullable
as TimerState?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,selectedOptionId: freezed == selectedOptionId ? _self.selectedOptionId : selectedOptionId // ignore: cast_nullable_to_non_nullable
as String?,isAnswerLocked: null == isAnswerLocked ? _self.isAnswerLocked : isAnswerLocked // ignore: cast_nullable_to_non_nullable
as bool,questionStartTime: freezed == questionStartTime ? _self.questionStartTime : questionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionCopyWith<$Res>? get currentQuestion {
    if (_self.currentQuestion == null) {
    return null;
  }

  return $QuestionCopyWith<$Res>(_self.currentQuestion!, (value) {
    return _then(_self.copyWith(currentQuestion: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $QuizSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $QuizResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreResultCopyWith<$Res>? get lastScoreResult {
    if (_self.lastScoreResult == null) {
    return null;
  }

  return $ScoreResultCopyWith<$Res>(_self.lastScoreResult!, (value) {
    return _then(_self.copyWith(lastScoreResult: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get timer {
    if (_self.timer == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.timer!, (value) {
    return _then(_self.copyWith(timer: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get powerUpTimer {
    if (_self.powerUpTimer == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.powerUpTimer!, (value) {
    return _then(_self.copyWith(powerUpTimer: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuizState].
extension QuizStatePatterns on QuizState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizState value)  $default,){
final _that = this;
switch (_that) {
case _QuizState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizState value)?  $default,){
final _that = this;
switch (_that) {
case _QuizState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuizStatus status,  Question? currentQuestion,  int currentIndex,  List<Question> questions,  QuizSession? session,  QuizResult? result,  int score,  int streak,  int bestStreak,  int xp,  ScoreResult? lastScoreResult,  List<RewardEvent> rewardEvents,  List<PlayerAnswer> answeredQuestions,  TimerState? timer,  List<PowerUpState> powerUps,  Set<String> hiddenOptionIds,  Map<String, double> audienceDistribution,  TimerState? powerUpTimer,  bool isLoading,  String? error,  bool isOffline,  String? selectedOptionId,  bool isAnswerLocked,  DateTime? questionStartTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that.status,_that.currentQuestion,_that.currentIndex,_that.questions,_that.session,_that.result,_that.score,_that.streak,_that.bestStreak,_that.xp,_that.lastScoreResult,_that.rewardEvents,_that.answeredQuestions,_that.timer,_that.powerUps,_that.hiddenOptionIds,_that.audienceDistribution,_that.powerUpTimer,_that.isLoading,_that.error,_that.isOffline,_that.selectedOptionId,_that.isAnswerLocked,_that.questionStartTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuizStatus status,  Question? currentQuestion,  int currentIndex,  List<Question> questions,  QuizSession? session,  QuizResult? result,  int score,  int streak,  int bestStreak,  int xp,  ScoreResult? lastScoreResult,  List<RewardEvent> rewardEvents,  List<PlayerAnswer> answeredQuestions,  TimerState? timer,  List<PowerUpState> powerUps,  Set<String> hiddenOptionIds,  Map<String, double> audienceDistribution,  TimerState? powerUpTimer,  bool isLoading,  String? error,  bool isOffline,  String? selectedOptionId,  bool isAnswerLocked,  DateTime? questionStartTime)  $default,) {final _that = this;
switch (_that) {
case _QuizState():
return $default(_that.status,_that.currentQuestion,_that.currentIndex,_that.questions,_that.session,_that.result,_that.score,_that.streak,_that.bestStreak,_that.xp,_that.lastScoreResult,_that.rewardEvents,_that.answeredQuestions,_that.timer,_that.powerUps,_that.hiddenOptionIds,_that.audienceDistribution,_that.powerUpTimer,_that.isLoading,_that.error,_that.isOffline,_that.selectedOptionId,_that.isAnswerLocked,_that.questionStartTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuizStatus status,  Question? currentQuestion,  int currentIndex,  List<Question> questions,  QuizSession? session,  QuizResult? result,  int score,  int streak,  int bestStreak,  int xp,  ScoreResult? lastScoreResult,  List<RewardEvent> rewardEvents,  List<PlayerAnswer> answeredQuestions,  TimerState? timer,  List<PowerUpState> powerUps,  Set<String> hiddenOptionIds,  Map<String, double> audienceDistribution,  TimerState? powerUpTimer,  bool isLoading,  String? error,  bool isOffline,  String? selectedOptionId,  bool isAnswerLocked,  DateTime? questionStartTime)?  $default,) {final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that.status,_that.currentQuestion,_that.currentIndex,_that.questions,_that.session,_that.result,_that.score,_that.streak,_that.bestStreak,_that.xp,_that.lastScoreResult,_that.rewardEvents,_that.answeredQuestions,_that.timer,_that.powerUps,_that.hiddenOptionIds,_that.audienceDistribution,_that.powerUpTimer,_that.isLoading,_that.error,_that.isOffline,_that.selectedOptionId,_that.isAnswerLocked,_that.questionStartTime);case _:
  return null;

}
}

}

/// @nodoc


class _QuizState implements QuizState {
  const _QuizState({this.status = QuizStatus.idle, this.currentQuestion, this.currentIndex = 0, final  List<Question> questions = const [], this.session, this.result, this.score = 0, this.streak = 0, this.bestStreak = 0, this.xp = 0, this.lastScoreResult, final  List<RewardEvent> rewardEvents = const [], final  List<PlayerAnswer> answeredQuestions = const [], this.timer, final  List<PowerUpState> powerUps = const [], final  Set<String> hiddenOptionIds = const {}, final  Map<String, double> audienceDistribution = const {}, this.powerUpTimer, this.isLoading = false, this.error, this.isOffline = false, this.selectedOptionId, this.isAnswerLocked = false, this.questionStartTime}): _questions = questions,_rewardEvents = rewardEvents,_answeredQuestions = answeredQuestions,_powerUps = powerUps,_hiddenOptionIds = hiddenOptionIds,_audienceDistribution = audienceDistribution;
  

@override@JsonKey() final  QuizStatus status;
@override final  Question? currentQuestion;
@override@JsonKey() final  int currentIndex;
 final  List<Question> _questions;
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  QuizSession? session;
@override final  QuizResult? result;
@override@JsonKey() final  int score;
@override@JsonKey() final  int streak;
@override@JsonKey() final  int bestStreak;
@override@JsonKey() final  int xp;
@override final  ScoreResult? lastScoreResult;
 final  List<RewardEvent> _rewardEvents;
@override@JsonKey() List<RewardEvent> get rewardEvents {
  if (_rewardEvents is EqualUnmodifiableListView) return _rewardEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rewardEvents);
}

 final  List<PlayerAnswer> _answeredQuestions;
@override@JsonKey() List<PlayerAnswer> get answeredQuestions {
  if (_answeredQuestions is EqualUnmodifiableListView) return _answeredQuestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answeredQuestions);
}

@override final  TimerState? timer;
 final  List<PowerUpState> _powerUps;
@override@JsonKey() List<PowerUpState> get powerUps {
  if (_powerUps is EqualUnmodifiableListView) return _powerUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_powerUps);
}

 final  Set<String> _hiddenOptionIds;
@override@JsonKey() Set<String> get hiddenOptionIds {
  if (_hiddenOptionIds is EqualUnmodifiableSetView) return _hiddenOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_hiddenOptionIds);
}

 final  Map<String, double> _audienceDistribution;
@override@JsonKey() Map<String, double> get audienceDistribution {
  if (_audienceDistribution is EqualUnmodifiableMapView) return _audienceDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_audienceDistribution);
}

@override final  TimerState? powerUpTimer;
@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override@JsonKey() final  bool isOffline;
@override final  String? selectedOptionId;
@override@JsonKey() final  bool isAnswerLocked;
@override final  DateTime? questionStartTime;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizStateCopyWith<_QuizState> get copyWith => __$QuizStateCopyWithImpl<_QuizState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentQuestion, currentQuestion) || other.currentQuestion == currentQuestion)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.session, session) || other.session == session)&&(identical(other.result, result) || other.result == result)&&(identical(other.score, score) || other.score == score)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.lastScoreResult, lastScoreResult) || other.lastScoreResult == lastScoreResult)&&const DeepCollectionEquality().equals(other._rewardEvents, _rewardEvents)&&const DeepCollectionEquality().equals(other._answeredQuestions, _answeredQuestions)&&(identical(other.timer, timer) || other.timer == timer)&&const DeepCollectionEquality().equals(other._powerUps, _powerUps)&&const DeepCollectionEquality().equals(other._hiddenOptionIds, _hiddenOptionIds)&&const DeepCollectionEquality().equals(other._audienceDistribution, _audienceDistribution)&&(identical(other.powerUpTimer, powerUpTimer) || other.powerUpTimer == powerUpTimer)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.selectedOptionId, selectedOptionId) || other.selectedOptionId == selectedOptionId)&&(identical(other.isAnswerLocked, isAnswerLocked) || other.isAnswerLocked == isAnswerLocked)&&(identical(other.questionStartTime, questionStartTime) || other.questionStartTime == questionStartTime));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,currentQuestion,currentIndex,const DeepCollectionEquality().hash(_questions),session,result,score,streak,bestStreak,xp,lastScoreResult,const DeepCollectionEquality().hash(_rewardEvents),const DeepCollectionEquality().hash(_answeredQuestions),timer,const DeepCollectionEquality().hash(_powerUps),const DeepCollectionEquality().hash(_hiddenOptionIds),const DeepCollectionEquality().hash(_audienceDistribution),powerUpTimer,isLoading,error,isOffline,selectedOptionId,isAnswerLocked,questionStartTime]);

@override
String toString() {
  return 'QuizState(status: $status, currentQuestion: $currentQuestion, currentIndex: $currentIndex, questions: $questions, session: $session, result: $result, score: $score, streak: $streak, bestStreak: $bestStreak, xp: $xp, lastScoreResult: $lastScoreResult, rewardEvents: $rewardEvents, answeredQuestions: $answeredQuestions, timer: $timer, powerUps: $powerUps, hiddenOptionIds: $hiddenOptionIds, audienceDistribution: $audienceDistribution, powerUpTimer: $powerUpTimer, isLoading: $isLoading, error: $error, isOffline: $isOffline, selectedOptionId: $selectedOptionId, isAnswerLocked: $isAnswerLocked, questionStartTime: $questionStartTime)';
}


}

/// @nodoc
abstract mixin class _$QuizStateCopyWith<$Res> implements $QuizStateCopyWith<$Res> {
  factory _$QuizStateCopyWith(_QuizState value, $Res Function(_QuizState) _then) = __$QuizStateCopyWithImpl;
@override @useResult
$Res call({
 QuizStatus status, Question? currentQuestion, int currentIndex, List<Question> questions, QuizSession? session, QuizResult? result, int score, int streak, int bestStreak, int xp, ScoreResult? lastScoreResult, List<RewardEvent> rewardEvents, List<PlayerAnswer> answeredQuestions, TimerState? timer, List<PowerUpState> powerUps, Set<String> hiddenOptionIds, Map<String, double> audienceDistribution, TimerState? powerUpTimer, bool isLoading, String? error, bool isOffline, String? selectedOptionId, bool isAnswerLocked, DateTime? questionStartTime
});


@override $QuestionCopyWith<$Res>? get currentQuestion;@override $QuizSessionCopyWith<$Res>? get session;@override $QuizResultCopyWith<$Res>? get result;@override $ScoreResultCopyWith<$Res>? get lastScoreResult;@override $TimerStateCopyWith<$Res>? get timer;@override $TimerStateCopyWith<$Res>? get powerUpTimer;

}
/// @nodoc
class __$QuizStateCopyWithImpl<$Res>
    implements _$QuizStateCopyWith<$Res> {
  __$QuizStateCopyWithImpl(this._self, this._then);

  final _QuizState _self;
  final $Res Function(_QuizState) _then;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? currentQuestion = freezed,Object? currentIndex = null,Object? questions = null,Object? session = freezed,Object? result = freezed,Object? score = null,Object? streak = null,Object? bestStreak = null,Object? xp = null,Object? lastScoreResult = freezed,Object? rewardEvents = null,Object? answeredQuestions = null,Object? timer = freezed,Object? powerUps = null,Object? hiddenOptionIds = null,Object? audienceDistribution = null,Object? powerUpTimer = freezed,Object? isLoading = null,Object? error = freezed,Object? isOffline = null,Object? selectedOptionId = freezed,Object? isAnswerLocked = null,Object? questionStartTime = freezed,}) {
  return _then(_QuizState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuizStatus,currentQuestion: freezed == currentQuestion ? _self.currentQuestion : currentQuestion // ignore: cast_nullable_to_non_nullable
as Question?,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as QuizSession?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as QuizResult?,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,lastScoreResult: freezed == lastScoreResult ? _self.lastScoreResult : lastScoreResult // ignore: cast_nullable_to_non_nullable
as ScoreResult?,rewardEvents: null == rewardEvents ? _self._rewardEvents : rewardEvents // ignore: cast_nullable_to_non_nullable
as List<RewardEvent>,answeredQuestions: null == answeredQuestions ? _self._answeredQuestions : answeredQuestions // ignore: cast_nullable_to_non_nullable
as List<PlayerAnswer>,timer: freezed == timer ? _self.timer : timer // ignore: cast_nullable_to_non_nullable
as TimerState?,powerUps: null == powerUps ? _self._powerUps : powerUps // ignore: cast_nullable_to_non_nullable
as List<PowerUpState>,hiddenOptionIds: null == hiddenOptionIds ? _self._hiddenOptionIds : hiddenOptionIds // ignore: cast_nullable_to_non_nullable
as Set<String>,audienceDistribution: null == audienceDistribution ? _self._audienceDistribution : audienceDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, double>,powerUpTimer: freezed == powerUpTimer ? _self.powerUpTimer : powerUpTimer // ignore: cast_nullable_to_non_nullable
as TimerState?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,selectedOptionId: freezed == selectedOptionId ? _self.selectedOptionId : selectedOptionId // ignore: cast_nullable_to_non_nullable
as String?,isAnswerLocked: null == isAnswerLocked ? _self.isAnswerLocked : isAnswerLocked // ignore: cast_nullable_to_non_nullable
as bool,questionStartTime: freezed == questionStartTime ? _self.questionStartTime : questionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionCopyWith<$Res>? get currentQuestion {
    if (_self.currentQuestion == null) {
    return null;
  }

  return $QuestionCopyWith<$Res>(_self.currentQuestion!, (value) {
    return _then(_self.copyWith(currentQuestion: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $QuizSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $QuizResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreResultCopyWith<$Res>? get lastScoreResult {
    if (_self.lastScoreResult == null) {
    return null;
  }

  return $ScoreResultCopyWith<$Res>(_self.lastScoreResult!, (value) {
    return _then(_self.copyWith(lastScoreResult: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get timer {
    if (_self.timer == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.timer!, (value) {
    return _then(_self.copyWith(timer: value));
  });
}/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get powerUpTimer {
    if (_self.powerUpTimer == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.powerUpTimer!, (value) {
    return _then(_self.copyWith(powerUpTimer: value));
  });
}
}

// dart format on
