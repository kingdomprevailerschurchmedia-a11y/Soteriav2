// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_match_replay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompetitiveMatchReplay {

 CompetitiveMatchResult get result; List<Question> get questions;
/// Create a copy of CompetitiveMatchReplay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveMatchReplayCopyWith<CompetitiveMatchReplay> get copyWith => _$CompetitiveMatchReplayCopyWithImpl<CompetitiveMatchReplay>(this as CompetitiveMatchReplay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveMatchReplay&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other.questions, questions));
}


@override
int get hashCode => Object.hash(runtimeType,result,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'CompetitiveMatchReplay(result: $result, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $CompetitiveMatchReplayCopyWith<$Res>  {
  factory $CompetitiveMatchReplayCopyWith(CompetitiveMatchReplay value, $Res Function(CompetitiveMatchReplay) _then) = _$CompetitiveMatchReplayCopyWithImpl;
@useResult
$Res call({
 CompetitiveMatchResult result, List<Question> questions
});


$CompetitiveMatchResultCopyWith<$Res> get result;

}
/// @nodoc
class _$CompetitiveMatchReplayCopyWithImpl<$Res>
    implements $CompetitiveMatchReplayCopyWith<$Res> {
  _$CompetitiveMatchReplayCopyWithImpl(this._self, this._then);

  final CompetitiveMatchReplay _self;
  final $Res Function(CompetitiveMatchReplay) _then;

/// Create a copy of CompetitiveMatchReplay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? questions = null,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as CompetitiveMatchResult,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}
/// Create a copy of CompetitiveMatchReplay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitiveMatchResultCopyWith<$Res> get result {
  
  return $CompetitiveMatchResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetitiveMatchReplay].
extension CompetitiveMatchReplayPatterns on CompetitiveMatchReplay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveMatchReplay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveMatchReplay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveMatchReplay value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMatchReplay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveMatchReplay value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMatchReplay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CompetitiveMatchResult result,  List<Question> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveMatchReplay() when $default != null:
return $default(_that.result,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CompetitiveMatchResult result,  List<Question> questions)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMatchReplay():
return $default(_that.result,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CompetitiveMatchResult result,  List<Question> questions)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMatchReplay() when $default != null:
return $default(_that.result,_that.questions);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitiveMatchReplay implements CompetitiveMatchReplay {
  const _CompetitiveMatchReplay({required this.result, required final  List<Question> questions}): _questions = questions;
  

@override final  CompetitiveMatchResult result;
 final  List<Question> _questions;
@override List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of CompetitiveMatchReplay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveMatchReplayCopyWith<_CompetitiveMatchReplay> get copyWith => __$CompetitiveMatchReplayCopyWithImpl<_CompetitiveMatchReplay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveMatchReplay&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other._questions, _questions));
}


@override
int get hashCode => Object.hash(runtimeType,result,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'CompetitiveMatchReplay(result: $result, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveMatchReplayCopyWith<$Res> implements $CompetitiveMatchReplayCopyWith<$Res> {
  factory _$CompetitiveMatchReplayCopyWith(_CompetitiveMatchReplay value, $Res Function(_CompetitiveMatchReplay) _then) = __$CompetitiveMatchReplayCopyWithImpl;
@override @useResult
$Res call({
 CompetitiveMatchResult result, List<Question> questions
});


@override $CompetitiveMatchResultCopyWith<$Res> get result;

}
/// @nodoc
class __$CompetitiveMatchReplayCopyWithImpl<$Res>
    implements _$CompetitiveMatchReplayCopyWith<$Res> {
  __$CompetitiveMatchReplayCopyWithImpl(this._self, this._then);

  final _CompetitiveMatchReplay _self;
  final $Res Function(_CompetitiveMatchReplay) _then;

/// Create a copy of CompetitiveMatchReplay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? questions = null,}) {
  return _then(_CompetitiveMatchReplay(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as CompetitiveMatchResult,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}

/// Create a copy of CompetitiveMatchReplay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitiveMatchResultCopyWith<$Res> get result {
  
  return $CompetitiveMatchResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
