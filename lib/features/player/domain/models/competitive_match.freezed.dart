// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveMatch {

 CompetitiveResult get result; RankChange? get rankChange; QuizResult? get quizResult;
/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveMatchCopyWith<CompetitiveMatch> get copyWith => _$CompetitiveMatchCopyWithImpl<CompetitiveMatch>(this as CompetitiveMatch, _$identity);

  /// Serializes this CompetitiveMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveMatch&&(identical(other.result, result) || other.result == result)&&(identical(other.rankChange, rankChange) || other.rankChange == rankChange)&&(identical(other.quizResult, quizResult) || other.quizResult == quizResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,rankChange,quizResult);

@override
String toString() {
  return 'CompetitiveMatch(result: $result, rankChange: $rankChange, quizResult: $quizResult)';
}


}

/// @nodoc
abstract mixin class $CompetitiveMatchCopyWith<$Res>  {
  factory $CompetitiveMatchCopyWith(CompetitiveMatch value, $Res Function(CompetitiveMatch) _then) = _$CompetitiveMatchCopyWithImpl;
@useResult
$Res call({
 CompetitiveResult result, RankChange? rankChange, QuizResult? quizResult
});


$CompetitiveResultCopyWith<$Res> get result;$RankChangeCopyWith<$Res>? get rankChange;$QuizResultCopyWith<$Res>? get quizResult;

}
/// @nodoc
class _$CompetitiveMatchCopyWithImpl<$Res>
    implements $CompetitiveMatchCopyWith<$Res> {
  _$CompetitiveMatchCopyWithImpl(this._self, this._then);

  final CompetitiveMatch _self;
  final $Res Function(CompetitiveMatch) _then;

/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? rankChange = freezed,Object? quizResult = freezed,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as CompetitiveResult,rankChange: freezed == rankChange ? _self.rankChange : rankChange // ignore: cast_nullable_to_non_nullable
as RankChange?,quizResult: freezed == quizResult ? _self.quizResult : quizResult // ignore: cast_nullable_to_non_nullable
as QuizResult?,
  ));
}
/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitiveResultCopyWith<$Res> get result {
  
  return $CompetitiveResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankChangeCopyWith<$Res>? get rankChange {
    if (_self.rankChange == null) {
    return null;
  }

  return $RankChangeCopyWith<$Res>(_self.rankChange!, (value) {
    return _then(_self.copyWith(rankChange: value));
  });
}/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizResultCopyWith<$Res>? get quizResult {
    if (_self.quizResult == null) {
    return null;
  }

  return $QuizResultCopyWith<$Res>(_self.quizResult!, (value) {
    return _then(_self.copyWith(quizResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetitiveMatch].
extension CompetitiveMatchPatterns on CompetitiveMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveMatch value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveMatch value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CompetitiveResult result,  RankChange? rankChange,  QuizResult? quizResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveMatch() when $default != null:
return $default(_that.result,_that.rankChange,_that.quizResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CompetitiveResult result,  RankChange? rankChange,  QuizResult? quizResult)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMatch():
return $default(_that.result,_that.rankChange,_that.quizResult);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CompetitiveResult result,  RankChange? rankChange,  QuizResult? quizResult)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMatch() when $default != null:
return $default(_that.result,_that.rankChange,_that.quizResult);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveMatch implements CompetitiveMatch {
  const _CompetitiveMatch({required this.result, this.rankChange, this.quizResult});
  factory _CompetitiveMatch.fromJson(Map<String, dynamic> json) => _$CompetitiveMatchFromJson(json);

@override final  CompetitiveResult result;
@override final  RankChange? rankChange;
@override final  QuizResult? quizResult;

/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveMatchCopyWith<_CompetitiveMatch> get copyWith => __$CompetitiveMatchCopyWithImpl<_CompetitiveMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveMatch&&(identical(other.result, result) || other.result == result)&&(identical(other.rankChange, rankChange) || other.rankChange == rankChange)&&(identical(other.quizResult, quizResult) || other.quizResult == quizResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,rankChange,quizResult);

@override
String toString() {
  return 'CompetitiveMatch(result: $result, rankChange: $rankChange, quizResult: $quizResult)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveMatchCopyWith<$Res> implements $CompetitiveMatchCopyWith<$Res> {
  factory _$CompetitiveMatchCopyWith(_CompetitiveMatch value, $Res Function(_CompetitiveMatch) _then) = __$CompetitiveMatchCopyWithImpl;
@override @useResult
$Res call({
 CompetitiveResult result, RankChange? rankChange, QuizResult? quizResult
});


@override $CompetitiveResultCopyWith<$Res> get result;@override $RankChangeCopyWith<$Res>? get rankChange;@override $QuizResultCopyWith<$Res>? get quizResult;

}
/// @nodoc
class __$CompetitiveMatchCopyWithImpl<$Res>
    implements _$CompetitiveMatchCopyWith<$Res> {
  __$CompetitiveMatchCopyWithImpl(this._self, this._then);

  final _CompetitiveMatch _self;
  final $Res Function(_CompetitiveMatch) _then;

/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? rankChange = freezed,Object? quizResult = freezed,}) {
  return _then(_CompetitiveMatch(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as CompetitiveResult,rankChange: freezed == rankChange ? _self.rankChange : rankChange // ignore: cast_nullable_to_non_nullable
as RankChange?,quizResult: freezed == quizResult ? _self.quizResult : quizResult // ignore: cast_nullable_to_non_nullable
as QuizResult?,
  ));
}

/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitiveResultCopyWith<$Res> get result {
  
  return $CompetitiveResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankChangeCopyWith<$Res>? get rankChange {
    if (_self.rankChange == null) {
    return null;
  }

  return $RankChangeCopyWith<$Res>(_self.rankChange!, (value) {
    return _then(_self.copyWith(rankChange: value));
  });
}/// Create a copy of CompetitiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizResultCopyWith<$Res>? get quizResult {
    if (_self.quizResult == null) {
    return null;
  }

  return $QuizResultCopyWith<$Res>(_self.quizResult!, (value) {
    return _then(_self.copyWith(quizResult: value));
  });
}
}

// dart format on
