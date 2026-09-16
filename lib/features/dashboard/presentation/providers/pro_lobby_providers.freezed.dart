// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pro_lobby_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProLobbyState implements DiagnosticableTreeMixin {

 bool get isLoading; bool get isStarting; String? get error; ProSessionConfig get config; bool get isOffline; ProModeAccessResult get access; List<Category> get categories; bool get isFreeEntry; int get remainingFreeGames;
/// Create a copy of ProLobbyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProLobbyStateCopyWith<ProLobbyState> get copyWith => _$ProLobbyStateCopyWithImpl<ProLobbyState>(this as ProLobbyState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ProLobbyState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isStarting', isStarting))..add(DiagnosticsProperty('error', error))..add(DiagnosticsProperty('config', config))..add(DiagnosticsProperty('isOffline', isOffline))..add(DiagnosticsProperty('access', access))..add(DiagnosticsProperty('categories', categories))..add(DiagnosticsProperty('isFreeEntry', isFreeEntry))..add(DiagnosticsProperty('remainingFreeGames', remainingFreeGames));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProLobbyState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isStarting, isStarting) || other.isStarting == isStarting)&&(identical(other.error, error) || other.error == error)&&(identical(other.config, config) || other.config == config)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.access, access) || other.access == access)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.isFreeEntry, isFreeEntry) || other.isFreeEntry == isFreeEntry)&&(identical(other.remainingFreeGames, remainingFreeGames) || other.remainingFreeGames == remainingFreeGames));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isStarting,error,config,isOffline,access,const DeepCollectionEquality().hash(categories),isFreeEntry,remainingFreeGames);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ProLobbyState(isLoading: $isLoading, isStarting: $isStarting, error: $error, config: $config, isOffline: $isOffline, access: $access, categories: $categories, isFreeEntry: $isFreeEntry, remainingFreeGames: $remainingFreeGames)';
}


}

/// @nodoc
abstract mixin class $ProLobbyStateCopyWith<$Res>  {
  factory $ProLobbyStateCopyWith(ProLobbyState value, $Res Function(ProLobbyState) _then) = _$ProLobbyStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isStarting, String? error, ProSessionConfig config, bool isOffline, ProModeAccessResult access, List<Category> categories, bool isFreeEntry, int remainingFreeGames
});




}
/// @nodoc
class _$ProLobbyStateCopyWithImpl<$Res>
    implements $ProLobbyStateCopyWith<$Res> {
  _$ProLobbyStateCopyWithImpl(this._self, this._then);

  final ProLobbyState _self;
  final $Res Function(ProLobbyState) _then;

/// Create a copy of ProLobbyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isStarting = null,Object? error = freezed,Object? config = null,Object? isOffline = null,Object? access = null,Object? categories = null,Object? isFreeEntry = null,Object? remainingFreeGames = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isStarting: null == isStarting ? _self.isStarting : isStarting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ProSessionConfig,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,access: null == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as ProModeAccessResult,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,isFreeEntry: null == isFreeEntry ? _self.isFreeEntry : isFreeEntry // ignore: cast_nullable_to_non_nullable
as bool,remainingFreeGames: null == remainingFreeGames ? _self.remainingFreeGames : remainingFreeGames // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProLobbyState].
extension ProLobbyStatePatterns on ProLobbyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProLobbyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProLobbyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProLobbyState value)  $default,){
final _that = this;
switch (_that) {
case _ProLobbyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProLobbyState value)?  $default,){
final _that = this;
switch (_that) {
case _ProLobbyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isStarting,  String? error,  ProSessionConfig config,  bool isOffline,  ProModeAccessResult access,  List<Category> categories,  bool isFreeEntry,  int remainingFreeGames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProLobbyState() when $default != null:
return $default(_that.isLoading,_that.isStarting,_that.error,_that.config,_that.isOffline,_that.access,_that.categories,_that.isFreeEntry,_that.remainingFreeGames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isStarting,  String? error,  ProSessionConfig config,  bool isOffline,  ProModeAccessResult access,  List<Category> categories,  bool isFreeEntry,  int remainingFreeGames)  $default,) {final _that = this;
switch (_that) {
case _ProLobbyState():
return $default(_that.isLoading,_that.isStarting,_that.error,_that.config,_that.isOffline,_that.access,_that.categories,_that.isFreeEntry,_that.remainingFreeGames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isStarting,  String? error,  ProSessionConfig config,  bool isOffline,  ProModeAccessResult access,  List<Category> categories,  bool isFreeEntry,  int remainingFreeGames)?  $default,) {final _that = this;
switch (_that) {
case _ProLobbyState() when $default != null:
return $default(_that.isLoading,_that.isStarting,_that.error,_that.config,_that.isOffline,_that.access,_that.categories,_that.isFreeEntry,_that.remainingFreeGames);case _:
  return null;

}
}

}

/// @nodoc


class _ProLobbyState extends ProLobbyState with DiagnosticableTreeMixin {
  const _ProLobbyState({this.isLoading = false, this.isStarting = false, this.error, this.config = const ProSessionConfig(), this.isOffline = false, this.access = const ProModeAccessResult.loading(), final  List<Category> categories = const [], this.isFreeEntry = false, this.remainingFreeGames = 0}): _categories = categories,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isStarting;
@override final  String? error;
@override@JsonKey() final  ProSessionConfig config;
@override@JsonKey() final  bool isOffline;
@override@JsonKey() final  ProModeAccessResult access;
 final  List<Category> _categories;
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  bool isFreeEntry;
@override@JsonKey() final  int remainingFreeGames;

/// Create a copy of ProLobbyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProLobbyStateCopyWith<_ProLobbyState> get copyWith => __$ProLobbyStateCopyWithImpl<_ProLobbyState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ProLobbyState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isStarting', isStarting))..add(DiagnosticsProperty('error', error))..add(DiagnosticsProperty('config', config))..add(DiagnosticsProperty('isOffline', isOffline))..add(DiagnosticsProperty('access', access))..add(DiagnosticsProperty('categories', categories))..add(DiagnosticsProperty('isFreeEntry', isFreeEntry))..add(DiagnosticsProperty('remainingFreeGames', remainingFreeGames));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProLobbyState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isStarting, isStarting) || other.isStarting == isStarting)&&(identical(other.error, error) || other.error == error)&&(identical(other.config, config) || other.config == config)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.access, access) || other.access == access)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.isFreeEntry, isFreeEntry) || other.isFreeEntry == isFreeEntry)&&(identical(other.remainingFreeGames, remainingFreeGames) || other.remainingFreeGames == remainingFreeGames));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isStarting,error,config,isOffline,access,const DeepCollectionEquality().hash(_categories),isFreeEntry,remainingFreeGames);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ProLobbyState(isLoading: $isLoading, isStarting: $isStarting, error: $error, config: $config, isOffline: $isOffline, access: $access, categories: $categories, isFreeEntry: $isFreeEntry, remainingFreeGames: $remainingFreeGames)';
}


}

/// @nodoc
abstract mixin class _$ProLobbyStateCopyWith<$Res> implements $ProLobbyStateCopyWith<$Res> {
  factory _$ProLobbyStateCopyWith(_ProLobbyState value, $Res Function(_ProLobbyState) _then) = __$ProLobbyStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isStarting, String? error, ProSessionConfig config, bool isOffline, ProModeAccessResult access, List<Category> categories, bool isFreeEntry, int remainingFreeGames
});




}
/// @nodoc
class __$ProLobbyStateCopyWithImpl<$Res>
    implements _$ProLobbyStateCopyWith<$Res> {
  __$ProLobbyStateCopyWithImpl(this._self, this._then);

  final _ProLobbyState _self;
  final $Res Function(_ProLobbyState) _then;

/// Create a copy of ProLobbyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isStarting = null,Object? error = freezed,Object? config = null,Object? isOffline = null,Object? access = null,Object? categories = null,Object? isFreeEntry = null,Object? remainingFreeGames = null,}) {
  return _then(_ProLobbyState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isStarting: null == isStarting ? _self.isStarting : isStarting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ProSessionConfig,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,access: null == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as ProModeAccessResult,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,isFreeEntry: null == isFreeEntry ? _self.isFreeEntry : isFreeEntry // ignore: cast_nullable_to_non_nullable
as bool,remainingFreeGames: null == remainingFreeGames ? _self.remainingFreeGames : remainingFreeGames // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
