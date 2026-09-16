// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionResult {

 String get questionId; int get questionNumber; String get questionText; QuestionOutcome get outcome; String? get selectedOptionId; String? get selectedOptionText; List<String> get correctOptionIds; String get correctOptionText; Duration get responseTime; int get scoreEarned; String? get categoryId; GameMode? get mode; Difficulty? get difficulty; String? get explanation; String? get questionVersion;
/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionResultCopyWith<QuestionResult> get copyWith => _$QuestionResultCopyWithImpl<QuestionResult>(this as QuestionResult, _$identity);

  /// Serializes this QuestionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionResult&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionNumber, questionNumber) || other.questionNumber == questionNumber)&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.selectedOptionId, selectedOptionId) || other.selectedOptionId == selectedOptionId)&&(identical(other.selectedOptionText, selectedOptionText) || other.selectedOptionText == selectedOptionText)&&const DeepCollectionEquality().equals(other.correctOptionIds, correctOptionIds)&&(identical(other.correctOptionText, correctOptionText) || other.correctOptionText == correctOptionText)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.scoreEarned, scoreEarned) || other.scoreEarned == scoreEarned)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.questionVersion, questionVersion) || other.questionVersion == questionVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,questionNumber,questionText,outcome,selectedOptionId,selectedOptionText,const DeepCollectionEquality().hash(correctOptionIds),correctOptionText,responseTime,scoreEarned,categoryId,mode,difficulty,explanation,questionVersion);

@override
String toString() {
  return 'QuestionResult(questionId: $questionId, questionNumber: $questionNumber, questionText: $questionText, outcome: $outcome, selectedOptionId: $selectedOptionId, selectedOptionText: $selectedOptionText, correctOptionIds: $correctOptionIds, correctOptionText: $correctOptionText, responseTime: $responseTime, scoreEarned: $scoreEarned, categoryId: $categoryId, mode: $mode, difficulty: $difficulty, explanation: $explanation, questionVersion: $questionVersion)';
}


}

/// @nodoc
abstract mixin class $QuestionResultCopyWith<$Res>  {
  factory $QuestionResultCopyWith(QuestionResult value, $Res Function(QuestionResult) _then) = _$QuestionResultCopyWithImpl;
@useResult
$Res call({
 String questionId, int questionNumber, String questionText, QuestionOutcome outcome, String? selectedOptionId, String? selectedOptionText, List<String> correctOptionIds, String correctOptionText, Duration responseTime, int scoreEarned, String? categoryId, GameMode? mode, Difficulty? difficulty, String? explanation, String? questionVersion
});




}
/// @nodoc
class _$QuestionResultCopyWithImpl<$Res>
    implements $QuestionResultCopyWith<$Res> {
  _$QuestionResultCopyWithImpl(this._self, this._then);

  final QuestionResult _self;
  final $Res Function(QuestionResult) _then;

/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? questionNumber = null,Object? questionText = null,Object? outcome = null,Object? selectedOptionId = freezed,Object? selectedOptionText = freezed,Object? correctOptionIds = null,Object? correctOptionText = null,Object? responseTime = null,Object? scoreEarned = null,Object? categoryId = freezed,Object? mode = freezed,Object? difficulty = freezed,Object? explanation = freezed,Object? questionVersion = freezed,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionNumber: null == questionNumber ? _self.questionNumber : questionNumber // ignore: cast_nullable_to_non_nullable
as int,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as QuestionOutcome,selectedOptionId: freezed == selectedOptionId ? _self.selectedOptionId : selectedOptionId // ignore: cast_nullable_to_non_nullable
as String?,selectedOptionText: freezed == selectedOptionText ? _self.selectedOptionText : selectedOptionText // ignore: cast_nullable_to_non_nullable
as String?,correctOptionIds: null == correctOptionIds ? _self.correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,correctOptionText: null == correctOptionText ? _self.correctOptionText : correctOptionText // ignore: cast_nullable_to_non_nullable
as String,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,scoreEarned: null == scoreEarned ? _self.scoreEarned : scoreEarned // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,questionVersion: freezed == questionVersion ? _self.questionVersion : questionVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionResult].
extension QuestionResultPatterns on QuestionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionResult value)  $default,){
final _that = this;
switch (_that) {
case _QuestionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionResult value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  int questionNumber,  String questionText,  QuestionOutcome outcome,  String? selectedOptionId,  String? selectedOptionText,  List<String> correctOptionIds,  String correctOptionText,  Duration responseTime,  int scoreEarned,  String? categoryId,  GameMode? mode,  Difficulty? difficulty,  String? explanation,  String? questionVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
return $default(_that.questionId,_that.questionNumber,_that.questionText,_that.outcome,_that.selectedOptionId,_that.selectedOptionText,_that.correctOptionIds,_that.correctOptionText,_that.responseTime,_that.scoreEarned,_that.categoryId,_that.mode,_that.difficulty,_that.explanation,_that.questionVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  int questionNumber,  String questionText,  QuestionOutcome outcome,  String? selectedOptionId,  String? selectedOptionText,  List<String> correctOptionIds,  String correctOptionText,  Duration responseTime,  int scoreEarned,  String? categoryId,  GameMode? mode,  Difficulty? difficulty,  String? explanation,  String? questionVersion)  $default,) {final _that = this;
switch (_that) {
case _QuestionResult():
return $default(_that.questionId,_that.questionNumber,_that.questionText,_that.outcome,_that.selectedOptionId,_that.selectedOptionText,_that.correctOptionIds,_that.correctOptionText,_that.responseTime,_that.scoreEarned,_that.categoryId,_that.mode,_that.difficulty,_that.explanation,_that.questionVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  int questionNumber,  String questionText,  QuestionOutcome outcome,  String? selectedOptionId,  String? selectedOptionText,  List<String> correctOptionIds,  String correctOptionText,  Duration responseTime,  int scoreEarned,  String? categoryId,  GameMode? mode,  Difficulty? difficulty,  String? explanation,  String? questionVersion)?  $default,) {final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
return $default(_that.questionId,_that.questionNumber,_that.questionText,_that.outcome,_that.selectedOptionId,_that.selectedOptionText,_that.correctOptionIds,_that.correctOptionText,_that.responseTime,_that.scoreEarned,_that.categoryId,_that.mode,_that.difficulty,_that.explanation,_that.questionVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionResult implements QuestionResult {
  const _QuestionResult({required this.questionId, required this.questionNumber, required this.questionText, required this.outcome, this.selectedOptionId, this.selectedOptionText, required final  List<String> correctOptionIds, required this.correctOptionText, required this.responseTime, required this.scoreEarned, this.categoryId, this.mode, this.difficulty, this.explanation, this.questionVersion}): _correctOptionIds = correctOptionIds;
  factory _QuestionResult.fromJson(Map<String, dynamic> json) => _$QuestionResultFromJson(json);

@override final  String questionId;
@override final  int questionNumber;
@override final  String questionText;
@override final  QuestionOutcome outcome;
@override final  String? selectedOptionId;
@override final  String? selectedOptionText;
 final  List<String> _correctOptionIds;
@override List<String> get correctOptionIds {
  if (_correctOptionIds is EqualUnmodifiableListView) return _correctOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctOptionIds);
}

@override final  String correctOptionText;
@override final  Duration responseTime;
@override final  int scoreEarned;
@override final  String? categoryId;
@override final  GameMode? mode;
@override final  Difficulty? difficulty;
@override final  String? explanation;
@override final  String? questionVersion;

/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionResultCopyWith<_QuestionResult> get copyWith => __$QuestionResultCopyWithImpl<_QuestionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionResult&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionNumber, questionNumber) || other.questionNumber == questionNumber)&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.selectedOptionId, selectedOptionId) || other.selectedOptionId == selectedOptionId)&&(identical(other.selectedOptionText, selectedOptionText) || other.selectedOptionText == selectedOptionText)&&const DeepCollectionEquality().equals(other._correctOptionIds, _correctOptionIds)&&(identical(other.correctOptionText, correctOptionText) || other.correctOptionText == correctOptionText)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.scoreEarned, scoreEarned) || other.scoreEarned == scoreEarned)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.questionVersion, questionVersion) || other.questionVersion == questionVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,questionNumber,questionText,outcome,selectedOptionId,selectedOptionText,const DeepCollectionEquality().hash(_correctOptionIds),correctOptionText,responseTime,scoreEarned,categoryId,mode,difficulty,explanation,questionVersion);

@override
String toString() {
  return 'QuestionResult(questionId: $questionId, questionNumber: $questionNumber, questionText: $questionText, outcome: $outcome, selectedOptionId: $selectedOptionId, selectedOptionText: $selectedOptionText, correctOptionIds: $correctOptionIds, correctOptionText: $correctOptionText, responseTime: $responseTime, scoreEarned: $scoreEarned, categoryId: $categoryId, mode: $mode, difficulty: $difficulty, explanation: $explanation, questionVersion: $questionVersion)';
}


}

/// @nodoc
abstract mixin class _$QuestionResultCopyWith<$Res> implements $QuestionResultCopyWith<$Res> {
  factory _$QuestionResultCopyWith(_QuestionResult value, $Res Function(_QuestionResult) _then) = __$QuestionResultCopyWithImpl;
@override @useResult
$Res call({
 String questionId, int questionNumber, String questionText, QuestionOutcome outcome, String? selectedOptionId, String? selectedOptionText, List<String> correctOptionIds, String correctOptionText, Duration responseTime, int scoreEarned, String? categoryId, GameMode? mode, Difficulty? difficulty, String? explanation, String? questionVersion
});




}
/// @nodoc
class __$QuestionResultCopyWithImpl<$Res>
    implements _$QuestionResultCopyWith<$Res> {
  __$QuestionResultCopyWithImpl(this._self, this._then);

  final _QuestionResult _self;
  final $Res Function(_QuestionResult) _then;

/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? questionNumber = null,Object? questionText = null,Object? outcome = null,Object? selectedOptionId = freezed,Object? selectedOptionText = freezed,Object? correctOptionIds = null,Object? correctOptionText = null,Object? responseTime = null,Object? scoreEarned = null,Object? categoryId = freezed,Object? mode = freezed,Object? difficulty = freezed,Object? explanation = freezed,Object? questionVersion = freezed,}) {
  return _then(_QuestionResult(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionNumber: null == questionNumber ? _self.questionNumber : questionNumber // ignore: cast_nullable_to_non_nullable
as int,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as QuestionOutcome,selectedOptionId: freezed == selectedOptionId ? _self.selectedOptionId : selectedOptionId // ignore: cast_nullable_to_non_nullable
as String?,selectedOptionText: freezed == selectedOptionText ? _self.selectedOptionText : selectedOptionText // ignore: cast_nullable_to_non_nullable
as String?,correctOptionIds: null == correctOptionIds ? _self._correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,correctOptionText: null == correctOptionText ? _self.correctOptionText : correctOptionText // ignore: cast_nullable_to_non_nullable
as String,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,scoreEarned: null == scoreEarned ? _self.scoreEarned : scoreEarned // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,questionVersion: freezed == questionVersion ? _self.questionVersion : questionVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
