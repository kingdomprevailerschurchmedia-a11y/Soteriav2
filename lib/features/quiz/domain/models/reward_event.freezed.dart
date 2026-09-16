// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RewardEvent()';
}


}

/// @nodoc
class $RewardEventCopyWith<$Res>  {
$RewardEventCopyWith(RewardEvent _, $Res Function(RewardEvent) __);
}


/// Adds pattern-matching-related methods to [RewardEvent].
extension RewardEventPatterns on RewardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QuestionCorrectEvent value)?  questionCorrect,TResult Function( QuestionIncorrectEvent value)?  questionIncorrect,TResult Function( QuestionTimedOutEvent value)?  questionTimedOut,TResult Function( QuizCompletedEvent value)?  quizCompleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QuestionCorrectEvent() when questionCorrect != null:
return questionCorrect(_that);case QuestionIncorrectEvent() when questionIncorrect != null:
return questionIncorrect(_that);case QuestionTimedOutEvent() when questionTimedOut != null:
return questionTimedOut(_that);case QuizCompletedEvent() when quizCompleted != null:
return quizCompleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QuestionCorrectEvent value)  questionCorrect,required TResult Function( QuestionIncorrectEvent value)  questionIncorrect,required TResult Function( QuestionTimedOutEvent value)  questionTimedOut,required TResult Function( QuizCompletedEvent value)  quizCompleted,}){
final _that = this;
switch (_that) {
case QuestionCorrectEvent():
return questionCorrect(_that);case QuestionIncorrectEvent():
return questionIncorrect(_that);case QuestionTimedOutEvent():
return questionTimedOut(_that);case QuizCompletedEvent():
return quizCompleted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QuestionCorrectEvent value)?  questionCorrect,TResult? Function( QuestionIncorrectEvent value)?  questionIncorrect,TResult? Function( QuestionTimedOutEvent value)?  questionTimedOut,TResult? Function( QuizCompletedEvent value)?  quizCompleted,}){
final _that = this;
switch (_that) {
case QuestionCorrectEvent() when questionCorrect != null:
return questionCorrect(_that);case QuestionIncorrectEvent() when questionIncorrect != null:
return questionIncorrect(_that);case QuestionTimedOutEvent() when questionTimedOut != null:
return questionTimedOut(_that);case QuizCompletedEvent() when quizCompleted != null:
return quizCompleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String questionId,  ScoreResult result,  int newStreak)?  questionCorrect,TResult Function( String questionId,  int streakResetTo)?  questionIncorrect,TResult Function( String questionId,  int streakResetTo)?  questionTimedOut,TResult Function( int finalScore,  int totalXp,  int perfectStreak,  double accuracy)?  quizCompleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QuestionCorrectEvent() when questionCorrect != null:
return questionCorrect(_that.questionId,_that.result,_that.newStreak);case QuestionIncorrectEvent() when questionIncorrect != null:
return questionIncorrect(_that.questionId,_that.streakResetTo);case QuestionTimedOutEvent() when questionTimedOut != null:
return questionTimedOut(_that.questionId,_that.streakResetTo);case QuizCompletedEvent() when quizCompleted != null:
return quizCompleted(_that.finalScore,_that.totalXp,_that.perfectStreak,_that.accuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String questionId,  ScoreResult result,  int newStreak)  questionCorrect,required TResult Function( String questionId,  int streakResetTo)  questionIncorrect,required TResult Function( String questionId,  int streakResetTo)  questionTimedOut,required TResult Function( int finalScore,  int totalXp,  int perfectStreak,  double accuracy)  quizCompleted,}) {final _that = this;
switch (_that) {
case QuestionCorrectEvent():
return questionCorrect(_that.questionId,_that.result,_that.newStreak);case QuestionIncorrectEvent():
return questionIncorrect(_that.questionId,_that.streakResetTo);case QuestionTimedOutEvent():
return questionTimedOut(_that.questionId,_that.streakResetTo);case QuizCompletedEvent():
return quizCompleted(_that.finalScore,_that.totalXp,_that.perfectStreak,_that.accuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String questionId,  ScoreResult result,  int newStreak)?  questionCorrect,TResult? Function( String questionId,  int streakResetTo)?  questionIncorrect,TResult? Function( String questionId,  int streakResetTo)?  questionTimedOut,TResult? Function( int finalScore,  int totalXp,  int perfectStreak,  double accuracy)?  quizCompleted,}) {final _that = this;
switch (_that) {
case QuestionCorrectEvent() when questionCorrect != null:
return questionCorrect(_that.questionId,_that.result,_that.newStreak);case QuestionIncorrectEvent() when questionIncorrect != null:
return questionIncorrect(_that.questionId,_that.streakResetTo);case QuestionTimedOutEvent() when questionTimedOut != null:
return questionTimedOut(_that.questionId,_that.streakResetTo);case QuizCompletedEvent() when quizCompleted != null:
return quizCompleted(_that.finalScore,_that.totalXp,_that.perfectStreak,_that.accuracy);case _:
  return null;

}
}

}

/// @nodoc


class QuestionCorrectEvent implements RewardEvent {
  const QuestionCorrectEvent({required this.questionId, required this.result, required this.newStreak});
  

 final  String questionId;
 final  ScoreResult result;
 final  int newStreak;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCorrectEventCopyWith<QuestionCorrectEvent> get copyWith => _$QuestionCorrectEventCopyWithImpl<QuestionCorrectEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionCorrectEvent&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.result, result) || other.result == result)&&(identical(other.newStreak, newStreak) || other.newStreak == newStreak));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,result,newStreak);

@override
String toString() {
  return 'RewardEvent.questionCorrect(questionId: $questionId, result: $result, newStreak: $newStreak)';
}


}

/// @nodoc
abstract mixin class $QuestionCorrectEventCopyWith<$Res> implements $RewardEventCopyWith<$Res> {
  factory $QuestionCorrectEventCopyWith(QuestionCorrectEvent value, $Res Function(QuestionCorrectEvent) _then) = _$QuestionCorrectEventCopyWithImpl;
@useResult
$Res call({
 String questionId, ScoreResult result, int newStreak
});


$ScoreResultCopyWith<$Res> get result;

}
/// @nodoc
class _$QuestionCorrectEventCopyWithImpl<$Res>
    implements $QuestionCorrectEventCopyWith<$Res> {
  _$QuestionCorrectEventCopyWithImpl(this._self, this._then);

  final QuestionCorrectEvent _self;
  final $Res Function(QuestionCorrectEvent) _then;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? result = null,Object? newStreak = null,}) {
  return _then(QuestionCorrectEvent(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ScoreResult,newStreak: null == newStreak ? _self.newStreak : newStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreResultCopyWith<$Res> get result {
  
  return $ScoreResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class QuestionIncorrectEvent implements RewardEvent {
  const QuestionIncorrectEvent({required this.questionId, required this.streakResetTo});
  

 final  String questionId;
 final  int streakResetTo;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionIncorrectEventCopyWith<QuestionIncorrectEvent> get copyWith => _$QuestionIncorrectEventCopyWithImpl<QuestionIncorrectEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionIncorrectEvent&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.streakResetTo, streakResetTo) || other.streakResetTo == streakResetTo));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,streakResetTo);

@override
String toString() {
  return 'RewardEvent.questionIncorrect(questionId: $questionId, streakResetTo: $streakResetTo)';
}


}

/// @nodoc
abstract mixin class $QuestionIncorrectEventCopyWith<$Res> implements $RewardEventCopyWith<$Res> {
  factory $QuestionIncorrectEventCopyWith(QuestionIncorrectEvent value, $Res Function(QuestionIncorrectEvent) _then) = _$QuestionIncorrectEventCopyWithImpl;
@useResult
$Res call({
 String questionId, int streakResetTo
});




}
/// @nodoc
class _$QuestionIncorrectEventCopyWithImpl<$Res>
    implements $QuestionIncorrectEventCopyWith<$Res> {
  _$QuestionIncorrectEventCopyWithImpl(this._self, this._then);

  final QuestionIncorrectEvent _self;
  final $Res Function(QuestionIncorrectEvent) _then;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? streakResetTo = null,}) {
  return _then(QuestionIncorrectEvent(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,streakResetTo: null == streakResetTo ? _self.streakResetTo : streakResetTo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class QuestionTimedOutEvent implements RewardEvent {
  const QuestionTimedOutEvent({required this.questionId, required this.streakResetTo});
  

 final  String questionId;
 final  int streakResetTo;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionTimedOutEventCopyWith<QuestionTimedOutEvent> get copyWith => _$QuestionTimedOutEventCopyWithImpl<QuestionTimedOutEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionTimedOutEvent&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.streakResetTo, streakResetTo) || other.streakResetTo == streakResetTo));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,streakResetTo);

@override
String toString() {
  return 'RewardEvent.questionTimedOut(questionId: $questionId, streakResetTo: $streakResetTo)';
}


}

/// @nodoc
abstract mixin class $QuestionTimedOutEventCopyWith<$Res> implements $RewardEventCopyWith<$Res> {
  factory $QuestionTimedOutEventCopyWith(QuestionTimedOutEvent value, $Res Function(QuestionTimedOutEvent) _then) = _$QuestionTimedOutEventCopyWithImpl;
@useResult
$Res call({
 String questionId, int streakResetTo
});




}
/// @nodoc
class _$QuestionTimedOutEventCopyWithImpl<$Res>
    implements $QuestionTimedOutEventCopyWith<$Res> {
  _$QuestionTimedOutEventCopyWithImpl(this._self, this._then);

  final QuestionTimedOutEvent _self;
  final $Res Function(QuestionTimedOutEvent) _then;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? streakResetTo = null,}) {
  return _then(QuestionTimedOutEvent(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,streakResetTo: null == streakResetTo ? _self.streakResetTo : streakResetTo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class QuizCompletedEvent implements RewardEvent {
  const QuizCompletedEvent({required this.finalScore, required this.totalXp, required this.perfectStreak, required this.accuracy});
  

 final  int finalScore;
 final  int totalXp;
 final  int perfectStreak;
 final  double accuracy;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizCompletedEventCopyWith<QuizCompletedEvent> get copyWith => _$QuizCompletedEventCopyWithImpl<QuizCompletedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizCompletedEvent&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.perfectStreak, perfectStreak) || other.perfectStreak == perfectStreak)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}


@override
int get hashCode => Object.hash(runtimeType,finalScore,totalXp,perfectStreak,accuracy);

@override
String toString() {
  return 'RewardEvent.quizCompleted(finalScore: $finalScore, totalXp: $totalXp, perfectStreak: $perfectStreak, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class $QuizCompletedEventCopyWith<$Res> implements $RewardEventCopyWith<$Res> {
  factory $QuizCompletedEventCopyWith(QuizCompletedEvent value, $Res Function(QuizCompletedEvent) _then) = _$QuizCompletedEventCopyWithImpl;
@useResult
$Res call({
 int finalScore, int totalXp, int perfectStreak, double accuracy
});




}
/// @nodoc
class _$QuizCompletedEventCopyWithImpl<$Res>
    implements $QuizCompletedEventCopyWith<$Res> {
  _$QuizCompletedEventCopyWithImpl(this._self, this._then);

  final QuizCompletedEvent _self;
  final $Res Function(QuizCompletedEvent) _then;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? finalScore = null,Object? totalXp = null,Object? perfectStreak = null,Object? accuracy = null,}) {
  return _then(QuizCompletedEvent(
finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,perfectStreak: null == perfectStreak ? _self.perfectStreak : perfectStreak // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
