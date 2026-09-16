// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matchmaking_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VersusLobbyState {

 Category? get category; List<String> get categoryIds; Difficulty get difficulty; int get questionCount; List<Category> get categories; bool get isLoading; String? get error; bool get useInterests; String? get validationError;
/// Create a copy of VersusLobbyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersusLobbyStateCopyWith<VersusLobbyState> get copyWith => _$VersusLobbyStateCopyWithImpl<VersusLobbyState>(this as VersusLobbyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VersusLobbyState&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.useInterests, useInterests) || other.useInterests == useInterests)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(categoryIds),difficulty,questionCount,const DeepCollectionEquality().hash(categories),isLoading,error,useInterests,validationError);

@override
String toString() {
  return 'VersusLobbyState(category: $category, categoryIds: $categoryIds, difficulty: $difficulty, questionCount: $questionCount, categories: $categories, isLoading: $isLoading, error: $error, useInterests: $useInterests, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class $VersusLobbyStateCopyWith<$Res>  {
  factory $VersusLobbyStateCopyWith(VersusLobbyState value, $Res Function(VersusLobbyState) _then) = _$VersusLobbyStateCopyWithImpl;
@useResult
$Res call({
 Category? category, List<String> categoryIds, Difficulty difficulty, int questionCount, List<Category> categories, bool isLoading, String? error, bool useInterests, String? validationError
});


$CategoryCopyWith<$Res>? get category;

}
/// @nodoc
class _$VersusLobbyStateCopyWithImpl<$Res>
    implements $VersusLobbyStateCopyWith<$Res> {
  _$VersusLobbyStateCopyWithImpl(this._self, this._then);

  final VersusLobbyState _self;
  final $Res Function(VersusLobbyState) _then;

/// Create a copy of VersusLobbyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? categoryIds = null,Object? difficulty = null,Object? questionCount = null,Object? categories = null,Object? isLoading = null,Object? error = freezed,Object? useInterests = null,Object? validationError = freezed,}) {
  return _then(_self.copyWith(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category?,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,useInterests: null == useInterests ? _self.useInterests : useInterests // ignore: cast_nullable_to_non_nullable
as bool,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of VersusLobbyState
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


/// Adds pattern-matching-related methods to [VersusLobbyState].
extension VersusLobbyStatePatterns on VersusLobbyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VersusLobbyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VersusLobbyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VersusLobbyState value)  $default,){
final _that = this;
switch (_that) {
case _VersusLobbyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VersusLobbyState value)?  $default,){
final _that = this;
switch (_that) {
case _VersusLobbyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Category? category,  List<String> categoryIds,  Difficulty difficulty,  int questionCount,  List<Category> categories,  bool isLoading,  String? error,  bool useInterests,  String? validationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VersusLobbyState() when $default != null:
return $default(_that.category,_that.categoryIds,_that.difficulty,_that.questionCount,_that.categories,_that.isLoading,_that.error,_that.useInterests,_that.validationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Category? category,  List<String> categoryIds,  Difficulty difficulty,  int questionCount,  List<Category> categories,  bool isLoading,  String? error,  bool useInterests,  String? validationError)  $default,) {final _that = this;
switch (_that) {
case _VersusLobbyState():
return $default(_that.category,_that.categoryIds,_that.difficulty,_that.questionCount,_that.categories,_that.isLoading,_that.error,_that.useInterests,_that.validationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Category? category,  List<String> categoryIds,  Difficulty difficulty,  int questionCount,  List<Category> categories,  bool isLoading,  String? error,  bool useInterests,  String? validationError)?  $default,) {final _that = this;
switch (_that) {
case _VersusLobbyState() when $default != null:
return $default(_that.category,_that.categoryIds,_that.difficulty,_that.questionCount,_that.categories,_that.isLoading,_that.error,_that.useInterests,_that.validationError);case _:
  return null;

}
}

}

/// @nodoc


class _VersusLobbyState implements VersusLobbyState {
  const _VersusLobbyState({this.category, final  List<String> categoryIds = const [], this.difficulty = Difficulty.medium, this.questionCount = 10, final  List<Category> categories = const [], this.isLoading = false, this.error, this.useInterests = false, this.validationError}): _categoryIds = categoryIds,_categories = categories;
  

@override final  Category? category;
 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

@override@JsonKey() final  Difficulty difficulty;
@override@JsonKey() final  int questionCount;
 final  List<Category> _categories;
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override@JsonKey() final  bool useInterests;
@override final  String? validationError;

/// Create a copy of VersusLobbyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VersusLobbyStateCopyWith<_VersusLobbyState> get copyWith => __$VersusLobbyStateCopyWithImpl<_VersusLobbyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VersusLobbyState&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.useInterests, useInterests) || other.useInterests == useInterests)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(_categoryIds),difficulty,questionCount,const DeepCollectionEquality().hash(_categories),isLoading,error,useInterests,validationError);

@override
String toString() {
  return 'VersusLobbyState(category: $category, categoryIds: $categoryIds, difficulty: $difficulty, questionCount: $questionCount, categories: $categories, isLoading: $isLoading, error: $error, useInterests: $useInterests, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class _$VersusLobbyStateCopyWith<$Res> implements $VersusLobbyStateCopyWith<$Res> {
  factory _$VersusLobbyStateCopyWith(_VersusLobbyState value, $Res Function(_VersusLobbyState) _then) = __$VersusLobbyStateCopyWithImpl;
@override @useResult
$Res call({
 Category? category, List<String> categoryIds, Difficulty difficulty, int questionCount, List<Category> categories, bool isLoading, String? error, bool useInterests, String? validationError
});


@override $CategoryCopyWith<$Res>? get category;

}
/// @nodoc
class __$VersusLobbyStateCopyWithImpl<$Res>
    implements _$VersusLobbyStateCopyWith<$Res> {
  __$VersusLobbyStateCopyWithImpl(this._self, this._then);

  final _VersusLobbyState _self;
  final $Res Function(_VersusLobbyState) _then;

/// Create a copy of VersusLobbyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? categoryIds = null,Object? difficulty = null,Object? questionCount = null,Object? categories = null,Object? isLoading = null,Object? error = freezed,Object? useInterests = null,Object? validationError = freezed,}) {
  return _then(_VersusLobbyState(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category?,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,useInterests: null == useInterests ? _self.useInterests : useInterests // ignore: cast_nullable_to_non_nullable
as bool,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of VersusLobbyState
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
