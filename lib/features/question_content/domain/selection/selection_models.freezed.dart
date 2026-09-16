// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selection_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionSelectionRequest {

 List<String> get categoryIds; List<String> get subcategoryIds; List<String> get topicIds; Difficulty? get difficulty; int get questionCount; Set<String> get excludedQuestionIds; GameMode? get mode; String? get language; bool get usePersonalization;
/// Create a copy of QuestionSelectionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionSelectionRequestCopyWith<QuestionSelectionRequest> get copyWith => _$QuestionSelectionRequestCopyWithImpl<QuestionSelectionRequest>(this as QuestionSelectionRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionSelectionRequest&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&const DeepCollectionEquality().equals(other.subcategoryIds, subcategoryIds)&&const DeepCollectionEquality().equals(other.topicIds, topicIds)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other.excludedQuestionIds, excludedQuestionIds)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.language, language) || other.language == language)&&(identical(other.usePersonalization, usePersonalization) || other.usePersonalization == usePersonalization));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categoryIds),const DeepCollectionEquality().hash(subcategoryIds),const DeepCollectionEquality().hash(topicIds),difficulty,questionCount,const DeepCollectionEquality().hash(excludedQuestionIds),mode,language,usePersonalization);

@override
String toString() {
  return 'QuestionSelectionRequest(categoryIds: $categoryIds, subcategoryIds: $subcategoryIds, topicIds: $topicIds, difficulty: $difficulty, questionCount: $questionCount, excludedQuestionIds: $excludedQuestionIds, mode: $mode, language: $language, usePersonalization: $usePersonalization)';
}


}

/// @nodoc
abstract mixin class $QuestionSelectionRequestCopyWith<$Res>  {
  factory $QuestionSelectionRequestCopyWith(QuestionSelectionRequest value, $Res Function(QuestionSelectionRequest) _then) = _$QuestionSelectionRequestCopyWithImpl;
@useResult
$Res call({
 List<String> categoryIds, List<String> subcategoryIds, List<String> topicIds, Difficulty? difficulty, int questionCount, Set<String> excludedQuestionIds, GameMode? mode, String? language, bool usePersonalization
});




}
/// @nodoc
class _$QuestionSelectionRequestCopyWithImpl<$Res>
    implements $QuestionSelectionRequestCopyWith<$Res> {
  _$QuestionSelectionRequestCopyWithImpl(this._self, this._then);

  final QuestionSelectionRequest _self;
  final $Res Function(QuestionSelectionRequest) _then;

/// Create a copy of QuestionSelectionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryIds = null,Object? subcategoryIds = null,Object? topicIds = null,Object? difficulty = freezed,Object? questionCount = null,Object? excludedQuestionIds = null,Object? mode = freezed,Object? language = freezed,Object? usePersonalization = null,}) {
  return _then(_self.copyWith(
categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,subcategoryIds: null == subcategoryIds ? _self.subcategoryIds : subcategoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,topicIds: null == topicIds ? _self.topicIds : topicIds // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,excludedQuestionIds: null == excludedQuestionIds ? _self.excludedQuestionIds : excludedQuestionIds // ignore: cast_nullable_to_non_nullable
as Set<String>,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,usePersonalization: null == usePersonalization ? _self.usePersonalization : usePersonalization // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionSelectionRequest].
extension QuestionSelectionRequestPatterns on QuestionSelectionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionSelectionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionSelectionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionSelectionRequest value)  $default,){
final _that = this;
switch (_that) {
case _QuestionSelectionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionSelectionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionSelectionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> categoryIds,  List<String> subcategoryIds,  List<String> topicIds,  Difficulty? difficulty,  int questionCount,  Set<String> excludedQuestionIds,  GameMode? mode,  String? language,  bool usePersonalization)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionSelectionRequest() when $default != null:
return $default(_that.categoryIds,_that.subcategoryIds,_that.topicIds,_that.difficulty,_that.questionCount,_that.excludedQuestionIds,_that.mode,_that.language,_that.usePersonalization);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> categoryIds,  List<String> subcategoryIds,  List<String> topicIds,  Difficulty? difficulty,  int questionCount,  Set<String> excludedQuestionIds,  GameMode? mode,  String? language,  bool usePersonalization)  $default,) {final _that = this;
switch (_that) {
case _QuestionSelectionRequest():
return $default(_that.categoryIds,_that.subcategoryIds,_that.topicIds,_that.difficulty,_that.questionCount,_that.excludedQuestionIds,_that.mode,_that.language,_that.usePersonalization);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> categoryIds,  List<String> subcategoryIds,  List<String> topicIds,  Difficulty? difficulty,  int questionCount,  Set<String> excludedQuestionIds,  GameMode? mode,  String? language,  bool usePersonalization)?  $default,) {final _that = this;
switch (_that) {
case _QuestionSelectionRequest() when $default != null:
return $default(_that.categoryIds,_that.subcategoryIds,_that.topicIds,_that.difficulty,_that.questionCount,_that.excludedQuestionIds,_that.mode,_that.language,_that.usePersonalization);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionSelectionRequest implements QuestionSelectionRequest {
  const _QuestionSelectionRequest({final  List<String> categoryIds = const [], final  List<String> subcategoryIds = const [], final  List<String> topicIds = const [], this.difficulty, this.questionCount = 10, final  Set<String> excludedQuestionIds = const {}, this.mode, this.language, this.usePersonalization = false}): _categoryIds = categoryIds,_subcategoryIds = subcategoryIds,_topicIds = topicIds,_excludedQuestionIds = excludedQuestionIds;
  

 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

 final  List<String> _subcategoryIds;
@override@JsonKey() List<String> get subcategoryIds {
  if (_subcategoryIds is EqualUnmodifiableListView) return _subcategoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subcategoryIds);
}

 final  List<String> _topicIds;
@override@JsonKey() List<String> get topicIds {
  if (_topicIds is EqualUnmodifiableListView) return _topicIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topicIds);
}

@override final  Difficulty? difficulty;
@override@JsonKey() final  int questionCount;
 final  Set<String> _excludedQuestionIds;
@override@JsonKey() Set<String> get excludedQuestionIds {
  if (_excludedQuestionIds is EqualUnmodifiableSetView) return _excludedQuestionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_excludedQuestionIds);
}

@override final  GameMode? mode;
@override final  String? language;
@override@JsonKey() final  bool usePersonalization;

/// Create a copy of QuestionSelectionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionSelectionRequestCopyWith<_QuestionSelectionRequest> get copyWith => __$QuestionSelectionRequestCopyWithImpl<_QuestionSelectionRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionSelectionRequest&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&const DeepCollectionEquality().equals(other._subcategoryIds, _subcategoryIds)&&const DeepCollectionEquality().equals(other._topicIds, _topicIds)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other._excludedQuestionIds, _excludedQuestionIds)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.language, language) || other.language == language)&&(identical(other.usePersonalization, usePersonalization) || other.usePersonalization == usePersonalization));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categoryIds),const DeepCollectionEquality().hash(_subcategoryIds),const DeepCollectionEquality().hash(_topicIds),difficulty,questionCount,const DeepCollectionEquality().hash(_excludedQuestionIds),mode,language,usePersonalization);

@override
String toString() {
  return 'QuestionSelectionRequest(categoryIds: $categoryIds, subcategoryIds: $subcategoryIds, topicIds: $topicIds, difficulty: $difficulty, questionCount: $questionCount, excludedQuestionIds: $excludedQuestionIds, mode: $mode, language: $language, usePersonalization: $usePersonalization)';
}


}

/// @nodoc
abstract mixin class _$QuestionSelectionRequestCopyWith<$Res> implements $QuestionSelectionRequestCopyWith<$Res> {
  factory _$QuestionSelectionRequestCopyWith(_QuestionSelectionRequest value, $Res Function(_QuestionSelectionRequest) _then) = __$QuestionSelectionRequestCopyWithImpl;
@override @useResult
$Res call({
 List<String> categoryIds, List<String> subcategoryIds, List<String> topicIds, Difficulty? difficulty, int questionCount, Set<String> excludedQuestionIds, GameMode? mode, String? language, bool usePersonalization
});




}
/// @nodoc
class __$QuestionSelectionRequestCopyWithImpl<$Res>
    implements _$QuestionSelectionRequestCopyWith<$Res> {
  __$QuestionSelectionRequestCopyWithImpl(this._self, this._then);

  final _QuestionSelectionRequest _self;
  final $Res Function(_QuestionSelectionRequest) _then;

/// Create a copy of QuestionSelectionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryIds = null,Object? subcategoryIds = null,Object? topicIds = null,Object? difficulty = freezed,Object? questionCount = null,Object? excludedQuestionIds = null,Object? mode = freezed,Object? language = freezed,Object? usePersonalization = null,}) {
  return _then(_QuestionSelectionRequest(
categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,subcategoryIds: null == subcategoryIds ? _self._subcategoryIds : subcategoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,topicIds: null == topicIds ? _self._topicIds : topicIds // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,excludedQuestionIds: null == excludedQuestionIds ? _self._excludedQuestionIds : excludedQuestionIds // ignore: cast_nullable_to_non_nullable
as Set<String>,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,usePersonalization: null == usePersonalization ? _self.usePersonalization : usePersonalization // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$QuestionSelectionResult {

 List<Question> get questions; SelectionStatus get status; Map<String, dynamic> get metadata;
/// Create a copy of QuestionSelectionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionSelectionResultCopyWith<QuestionSelectionResult> get copyWith => _$QuestionSelectionResultCopyWithImpl<QuestionSelectionResult>(this as QuestionSelectionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionSelectionResult&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(questions),status,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'QuestionSelectionResult(questions: $questions, status: $status, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $QuestionSelectionResultCopyWith<$Res>  {
  factory $QuestionSelectionResultCopyWith(QuestionSelectionResult value, $Res Function(QuestionSelectionResult) _then) = _$QuestionSelectionResultCopyWithImpl;
@useResult
$Res call({
 List<Question> questions, SelectionStatus status, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$QuestionSelectionResultCopyWithImpl<$Res>
    implements $QuestionSelectionResultCopyWith<$Res> {
  _$QuestionSelectionResultCopyWithImpl(this._self, this._then);

  final QuestionSelectionResult _self;
  final $Res Function(QuestionSelectionResult) _then;

/// Create a copy of QuestionSelectionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questions = null,Object? status = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SelectionStatus,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionSelectionResult].
extension QuestionSelectionResultPatterns on QuestionSelectionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionSelectionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionSelectionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionSelectionResult value)  $default,){
final _that = this;
switch (_that) {
case _QuestionSelectionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionSelectionResult value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionSelectionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Question> questions,  SelectionStatus status,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionSelectionResult() when $default != null:
return $default(_that.questions,_that.status,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Question> questions,  SelectionStatus status,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _QuestionSelectionResult():
return $default(_that.questions,_that.status,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Question> questions,  SelectionStatus status,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _QuestionSelectionResult() when $default != null:
return $default(_that.questions,_that.status,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionSelectionResult implements QuestionSelectionResult {
  const _QuestionSelectionResult({required final  List<Question> questions, required this.status, final  Map<String, dynamic> metadata = const {}}): _questions = questions,_metadata = metadata;
  

 final  List<Question> _questions;
@override List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  SelectionStatus status;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of QuestionSelectionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionSelectionResultCopyWith<_QuestionSelectionResult> get copyWith => __$QuestionSelectionResultCopyWithImpl<_QuestionSelectionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionSelectionResult&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_questions),status,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'QuestionSelectionResult(questions: $questions, status: $status, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$QuestionSelectionResultCopyWith<$Res> implements $QuestionSelectionResultCopyWith<$Res> {
  factory _$QuestionSelectionResultCopyWith(_QuestionSelectionResult value, $Res Function(_QuestionSelectionResult) _then) = __$QuestionSelectionResultCopyWithImpl;
@override @useResult
$Res call({
 List<Question> questions, SelectionStatus status, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$QuestionSelectionResultCopyWithImpl<$Res>
    implements _$QuestionSelectionResultCopyWith<$Res> {
  __$QuestionSelectionResultCopyWithImpl(this._self, this._then);

  final _QuestionSelectionResult _self;
  final $Res Function(_QuestionSelectionResult) _then;

/// Create a copy of QuestionSelectionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questions = null,Object? status = null,Object? metadata = null,}) {
  return _then(_QuestionSelectionResult(
questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SelectionStatus,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
