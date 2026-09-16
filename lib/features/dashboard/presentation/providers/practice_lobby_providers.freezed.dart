// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_lobby_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PracticeLobbyState {

 bool get isLoading; String? get error; List<Category> get categories; PracticeSessionConfig get config; EstimatedRewards? get estimatedRewards; String? get validationError;
/// Create a copy of PracticeLobbyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeLobbyStateCopyWith<PracticeLobbyState> get copyWith => _$PracticeLobbyStateCopyWithImpl<PracticeLobbyState>(this as PracticeLobbyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeLobbyState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.config, config) || other.config == config)&&(identical(other.estimatedRewards, estimatedRewards) || other.estimatedRewards == estimatedRewards)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,const DeepCollectionEquality().hash(categories),config,estimatedRewards,validationError);

@override
String toString() {
  return 'PracticeLobbyState(isLoading: $isLoading, error: $error, categories: $categories, config: $config, estimatedRewards: $estimatedRewards, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class $PracticeLobbyStateCopyWith<$Res>  {
  factory $PracticeLobbyStateCopyWith(PracticeLobbyState value, $Res Function(PracticeLobbyState) _then) = _$PracticeLobbyStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? error, List<Category> categories, PracticeSessionConfig config, EstimatedRewards? estimatedRewards, String? validationError
});


$PracticeSessionConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$PracticeLobbyStateCopyWithImpl<$Res>
    implements $PracticeLobbyStateCopyWith<$Res> {
  _$PracticeLobbyStateCopyWithImpl(this._self, this._then);

  final PracticeLobbyState _self;
  final $Res Function(PracticeLobbyState) _then;

/// Create a copy of PracticeLobbyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,Object? categories = null,Object? config = null,Object? estimatedRewards = freezed,Object? validationError = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PracticeSessionConfig,estimatedRewards: freezed == estimatedRewards ? _self.estimatedRewards : estimatedRewards // ignore: cast_nullable_to_non_nullable
as EstimatedRewards?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PracticeLobbyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeSessionConfigCopyWith<$Res> get config {
  
  return $PracticeSessionConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeLobbyState].
extension PracticeLobbyStatePatterns on PracticeLobbyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeLobbyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeLobbyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeLobbyState value)  $default,){
final _that = this;
switch (_that) {
case _PracticeLobbyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeLobbyState value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeLobbyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  List<Category> categories,  PracticeSessionConfig config,  EstimatedRewards? estimatedRewards,  String? validationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeLobbyState() when $default != null:
return $default(_that.isLoading,_that.error,_that.categories,_that.config,_that.estimatedRewards,_that.validationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  List<Category> categories,  PracticeSessionConfig config,  EstimatedRewards? estimatedRewards,  String? validationError)  $default,) {final _that = this;
switch (_that) {
case _PracticeLobbyState():
return $default(_that.isLoading,_that.error,_that.categories,_that.config,_that.estimatedRewards,_that.validationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? error,  List<Category> categories,  PracticeSessionConfig config,  EstimatedRewards? estimatedRewards,  String? validationError)?  $default,) {final _that = this;
switch (_that) {
case _PracticeLobbyState() when $default != null:
return $default(_that.isLoading,_that.error,_that.categories,_that.config,_that.estimatedRewards,_that.validationError);case _:
  return null;

}
}

}

/// @nodoc


class _PracticeLobbyState implements PracticeLobbyState {
  const _PracticeLobbyState({this.isLoading = false, this.error, final  List<Category> categories = const [], this.config = const PracticeSessionConfig(), this.estimatedRewards, this.validationError}): _categories = categories;
  

@override@JsonKey() final  bool isLoading;
@override final  String? error;
 final  List<Category> _categories;
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  PracticeSessionConfig config;
@override final  EstimatedRewards? estimatedRewards;
@override final  String? validationError;

/// Create a copy of PracticeLobbyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeLobbyStateCopyWith<_PracticeLobbyState> get copyWith => __$PracticeLobbyStateCopyWithImpl<_PracticeLobbyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeLobbyState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.config, config) || other.config == config)&&(identical(other.estimatedRewards, estimatedRewards) || other.estimatedRewards == estimatedRewards)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,const DeepCollectionEquality().hash(_categories),config,estimatedRewards,validationError);

@override
String toString() {
  return 'PracticeLobbyState(isLoading: $isLoading, error: $error, categories: $categories, config: $config, estimatedRewards: $estimatedRewards, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class _$PracticeLobbyStateCopyWith<$Res> implements $PracticeLobbyStateCopyWith<$Res> {
  factory _$PracticeLobbyStateCopyWith(_PracticeLobbyState value, $Res Function(_PracticeLobbyState) _then) = __$PracticeLobbyStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? error, List<Category> categories, PracticeSessionConfig config, EstimatedRewards? estimatedRewards, String? validationError
});


@override $PracticeSessionConfigCopyWith<$Res> get config;

}
/// @nodoc
class __$PracticeLobbyStateCopyWithImpl<$Res>
    implements _$PracticeLobbyStateCopyWith<$Res> {
  __$PracticeLobbyStateCopyWithImpl(this._self, this._then);

  final _PracticeLobbyState _self;
  final $Res Function(_PracticeLobbyState) _then;

/// Create a copy of PracticeLobbyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,Object? categories = null,Object? config = null,Object? estimatedRewards = freezed,Object? validationError = freezed,}) {
  return _then(_PracticeLobbyState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PracticeSessionConfig,estimatedRewards: freezed == estimatedRewards ? _self.estimatedRewards : estimatedRewards // ignore: cast_nullable_to_non_nullable
as EstimatedRewards?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PracticeLobbyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeSessionConfigCopyWith<$Res> get config {
  
  return $PracticeSessionConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
