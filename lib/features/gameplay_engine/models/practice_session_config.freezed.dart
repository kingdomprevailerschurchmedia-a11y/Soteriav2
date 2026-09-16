// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_session_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PracticeSessionConfig {

 Category? get category; List<String> get categoryIds; Difficulty get difficulty; int get questionCount; bool get timerEnabled; String get practiceType;// standard, focus, marathon
 bool get useInterests;
/// Create a copy of PracticeSessionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeSessionConfigCopyWith<PracticeSessionConfig> get copyWith => _$PracticeSessionConfigCopyWithImpl<PracticeSessionConfig>(this as PracticeSessionConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeSessionConfig&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.timerEnabled, timerEnabled) || other.timerEnabled == timerEnabled)&&(identical(other.practiceType, practiceType) || other.practiceType == practiceType)&&(identical(other.useInterests, useInterests) || other.useInterests == useInterests));
}


@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(categoryIds),difficulty,questionCount,timerEnabled,practiceType,useInterests);

@override
String toString() {
  return 'PracticeSessionConfig(category: $category, categoryIds: $categoryIds, difficulty: $difficulty, questionCount: $questionCount, timerEnabled: $timerEnabled, practiceType: $practiceType, useInterests: $useInterests)';
}


}

/// @nodoc
abstract mixin class $PracticeSessionConfigCopyWith<$Res>  {
  factory $PracticeSessionConfigCopyWith(PracticeSessionConfig value, $Res Function(PracticeSessionConfig) _then) = _$PracticeSessionConfigCopyWithImpl;
@useResult
$Res call({
 Category? category, List<String> categoryIds, Difficulty difficulty, int questionCount, bool timerEnabled, String practiceType, bool useInterests
});


$CategoryCopyWith<$Res>? get category;

}
/// @nodoc
class _$PracticeSessionConfigCopyWithImpl<$Res>
    implements $PracticeSessionConfigCopyWith<$Res> {
  _$PracticeSessionConfigCopyWithImpl(this._self, this._then);

  final PracticeSessionConfig _self;
  final $Res Function(PracticeSessionConfig) _then;

/// Create a copy of PracticeSessionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? categoryIds = null,Object? difficulty = null,Object? questionCount = null,Object? timerEnabled = null,Object? practiceType = null,Object? useInterests = null,}) {
  return _then(_self.copyWith(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category?,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,timerEnabled: null == timerEnabled ? _self.timerEnabled : timerEnabled // ignore: cast_nullable_to_non_nullable
as bool,practiceType: null == practiceType ? _self.practiceType : practiceType // ignore: cast_nullable_to_non_nullable
as String,useInterests: null == useInterests ? _self.useInterests : useInterests // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PracticeSessionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeSessionConfig].
extension PracticeSessionConfigPatterns on PracticeSessionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeSessionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeSessionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeSessionConfig value)  $default,){
final _that = this;
switch (_that) {
case _PracticeSessionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeSessionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeSessionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Category? category,  List<String> categoryIds,  Difficulty difficulty,  int questionCount,  bool timerEnabled,  String practiceType,  bool useInterests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeSessionConfig() when $default != null:
return $default(_that.category,_that.categoryIds,_that.difficulty,_that.questionCount,_that.timerEnabled,_that.practiceType,_that.useInterests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Category? category,  List<String> categoryIds,  Difficulty difficulty,  int questionCount,  bool timerEnabled,  String practiceType,  bool useInterests)  $default,) {final _that = this;
switch (_that) {
case _PracticeSessionConfig():
return $default(_that.category,_that.categoryIds,_that.difficulty,_that.questionCount,_that.timerEnabled,_that.practiceType,_that.useInterests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Category? category,  List<String> categoryIds,  Difficulty difficulty,  int questionCount,  bool timerEnabled,  String practiceType,  bool useInterests)?  $default,) {final _that = this;
switch (_that) {
case _PracticeSessionConfig() when $default != null:
return $default(_that.category,_that.categoryIds,_that.difficulty,_that.questionCount,_that.timerEnabled,_that.practiceType,_that.useInterests);case _:
  return null;

}
}

}

/// @nodoc


class _PracticeSessionConfig extends PracticeSessionConfig {
  const _PracticeSessionConfig({this.category, final  List<String> categoryIds = const [], this.difficulty = Difficulty.medium, this.questionCount = 10, this.timerEnabled = true, this.practiceType = 'standard', this.useInterests = true}): _categoryIds = categoryIds,super._();
  

@override final  Category? category;
 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

@override@JsonKey() final  Difficulty difficulty;
@override@JsonKey() final  int questionCount;
@override@JsonKey() final  bool timerEnabled;
@override@JsonKey() final  String practiceType;
// standard, focus, marathon
@override@JsonKey() final  bool useInterests;

/// Create a copy of PracticeSessionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeSessionConfigCopyWith<_PracticeSessionConfig> get copyWith => __$PracticeSessionConfigCopyWithImpl<_PracticeSessionConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeSessionConfig&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.timerEnabled, timerEnabled) || other.timerEnabled == timerEnabled)&&(identical(other.practiceType, practiceType) || other.practiceType == practiceType)&&(identical(other.useInterests, useInterests) || other.useInterests == useInterests));
}


@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(_categoryIds),difficulty,questionCount,timerEnabled,practiceType,useInterests);

@override
String toString() {
  return 'PracticeSessionConfig(category: $category, categoryIds: $categoryIds, difficulty: $difficulty, questionCount: $questionCount, timerEnabled: $timerEnabled, practiceType: $practiceType, useInterests: $useInterests)';
}


}

/// @nodoc
abstract mixin class _$PracticeSessionConfigCopyWith<$Res> implements $PracticeSessionConfigCopyWith<$Res> {
  factory _$PracticeSessionConfigCopyWith(_PracticeSessionConfig value, $Res Function(_PracticeSessionConfig) _then) = __$PracticeSessionConfigCopyWithImpl;
@override @useResult
$Res call({
 Category? category, List<String> categoryIds, Difficulty difficulty, int questionCount, bool timerEnabled, String practiceType, bool useInterests
});


@override $CategoryCopyWith<$Res>? get category;

}
/// @nodoc
class __$PracticeSessionConfigCopyWithImpl<$Res>
    implements _$PracticeSessionConfigCopyWith<$Res> {
  __$PracticeSessionConfigCopyWithImpl(this._self, this._then);

  final _PracticeSessionConfig _self;
  final $Res Function(_PracticeSessionConfig) _then;

/// Create a copy of PracticeSessionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? categoryIds = null,Object? difficulty = null,Object? questionCount = null,Object? timerEnabled = null,Object? practiceType = null,Object? useInterests = null,}) {
  return _then(_PracticeSessionConfig(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category?,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,timerEnabled: null == timerEnabled ? _self.timerEnabled : timerEnabled // ignore: cast_nullable_to_non_nullable
as bool,practiceType: null == practiceType ? _self.practiceType : practiceType // ignore: cast_nullable_to_non_nullable
as String,useInterests: null == useInterests ? _self.useInterests : useInterests // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PracticeSessionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}

// dart format on
