// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerAnswer {

 String get questionId; List<String> get selectedOptionIds; bool get isCorrect; Duration get responseTime; DateTime get timestamp; bool get isSkipped; bool get isTimedOut;
/// Create a copy of PlayerAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerAnswerCopyWith<PlayerAnswer> get copyWith => _$PlayerAnswerCopyWithImpl<PlayerAnswer>(this as PlayerAnswer, _$identity);

  /// Serializes this PlayerAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other.selectedOptionIds, selectedOptionIds)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isTimedOut, isTimedOut) || other.isTimedOut == isTimedOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,const DeepCollectionEquality().hash(selectedOptionIds),isCorrect,responseTime,timestamp,isSkipped,isTimedOut);

@override
String toString() {
  return 'PlayerAnswer(questionId: $questionId, selectedOptionIds: $selectedOptionIds, isCorrect: $isCorrect, responseTime: $responseTime, timestamp: $timestamp, isSkipped: $isSkipped, isTimedOut: $isTimedOut)';
}


}

/// @nodoc
abstract mixin class $PlayerAnswerCopyWith<$Res>  {
  factory $PlayerAnswerCopyWith(PlayerAnswer value, $Res Function(PlayerAnswer) _then) = _$PlayerAnswerCopyWithImpl;
@useResult
$Res call({
 String questionId, List<String> selectedOptionIds, bool isCorrect, Duration responseTime, DateTime timestamp, bool isSkipped, bool isTimedOut
});




}
/// @nodoc
class _$PlayerAnswerCopyWithImpl<$Res>
    implements $PlayerAnswerCopyWith<$Res> {
  _$PlayerAnswerCopyWithImpl(this._self, this._then);

  final PlayerAnswer _self;
  final $Res Function(PlayerAnswer) _then;

/// Create a copy of PlayerAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? selectedOptionIds = null,Object? isCorrect = null,Object? responseTime = null,Object? timestamp = null,Object? isSkipped = null,Object? isTimedOut = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,selectedOptionIds: null == selectedOptionIds ? _self.selectedOptionIds : selectedOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,isTimedOut: null == isTimedOut ? _self.isTimedOut : isTimedOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerAnswer].
extension PlayerAnswerPatterns on PlayerAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerAnswer value)  $default,){
final _that = this;
switch (_that) {
case _PlayerAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  List<String> selectedOptionIds,  bool isCorrect,  Duration responseTime,  DateTime timestamp,  bool isSkipped,  bool isTimedOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerAnswer() when $default != null:
return $default(_that.questionId,_that.selectedOptionIds,_that.isCorrect,_that.responseTime,_that.timestamp,_that.isSkipped,_that.isTimedOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  List<String> selectedOptionIds,  bool isCorrect,  Duration responseTime,  DateTime timestamp,  bool isSkipped,  bool isTimedOut)  $default,) {final _that = this;
switch (_that) {
case _PlayerAnswer():
return $default(_that.questionId,_that.selectedOptionIds,_that.isCorrect,_that.responseTime,_that.timestamp,_that.isSkipped,_that.isTimedOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  List<String> selectedOptionIds,  bool isCorrect,  Duration responseTime,  DateTime timestamp,  bool isSkipped,  bool isTimedOut)?  $default,) {final _that = this;
switch (_that) {
case _PlayerAnswer() when $default != null:
return $default(_that.questionId,_that.selectedOptionIds,_that.isCorrect,_that.responseTime,_that.timestamp,_that.isSkipped,_that.isTimedOut);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerAnswer implements PlayerAnswer {
  const _PlayerAnswer({required this.questionId, required final  List<String> selectedOptionIds, required this.isCorrect, required this.responseTime, required this.timestamp, this.isSkipped = false, this.isTimedOut = false}): _selectedOptionIds = selectedOptionIds;
  factory _PlayerAnswer.fromJson(Map<String, dynamic> json) => _$PlayerAnswerFromJson(json);

@override final  String questionId;
 final  List<String> _selectedOptionIds;
@override List<String> get selectedOptionIds {
  if (_selectedOptionIds is EqualUnmodifiableListView) return _selectedOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedOptionIds);
}

@override final  bool isCorrect;
@override final  Duration responseTime;
@override final  DateTime timestamp;
@override@JsonKey() final  bool isSkipped;
@override@JsonKey() final  bool isTimedOut;

/// Create a copy of PlayerAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerAnswerCopyWith<_PlayerAnswer> get copyWith => __$PlayerAnswerCopyWithImpl<_PlayerAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other._selectedOptionIds, _selectedOptionIds)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isTimedOut, isTimedOut) || other.isTimedOut == isTimedOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,const DeepCollectionEquality().hash(_selectedOptionIds),isCorrect,responseTime,timestamp,isSkipped,isTimedOut);

@override
String toString() {
  return 'PlayerAnswer(questionId: $questionId, selectedOptionIds: $selectedOptionIds, isCorrect: $isCorrect, responseTime: $responseTime, timestamp: $timestamp, isSkipped: $isSkipped, isTimedOut: $isTimedOut)';
}


}

/// @nodoc
abstract mixin class _$PlayerAnswerCopyWith<$Res> implements $PlayerAnswerCopyWith<$Res> {
  factory _$PlayerAnswerCopyWith(_PlayerAnswer value, $Res Function(_PlayerAnswer) _then) = __$PlayerAnswerCopyWithImpl;
@override @useResult
$Res call({
 String questionId, List<String> selectedOptionIds, bool isCorrect, Duration responseTime, DateTime timestamp, bool isSkipped, bool isTimedOut
});




}
/// @nodoc
class __$PlayerAnswerCopyWithImpl<$Res>
    implements _$PlayerAnswerCopyWith<$Res> {
  __$PlayerAnswerCopyWithImpl(this._self, this._then);

  final _PlayerAnswer _self;
  final $Res Function(_PlayerAnswer) _then;

/// Create a copy of PlayerAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? selectedOptionIds = null,Object? isCorrect = null,Object? responseTime = null,Object? timestamp = null,Object? isSkipped = null,Object? isTimedOut = null,}) {
  return _then(_PlayerAnswer(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,selectedOptionIds: null == selectedOptionIds ? _self._selectedOptionIds : selectedOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,isTimedOut: null == isTimedOut ? _self.isTimedOut : isTimedOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
