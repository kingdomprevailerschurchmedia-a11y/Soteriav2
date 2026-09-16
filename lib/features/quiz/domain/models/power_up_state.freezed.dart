// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PowerUpState {

 PowerUpType get type; PowerUpStatus get status; int get remainingUses; Duration get cooldownRemaining; List<PowerUpUsage> get usageHistory;
/// Create a copy of PowerUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PowerUpStateCopyWith<PowerUpState> get copyWith => _$PowerUpStateCopyWithImpl<PowerUpState>(this as PowerUpState, _$identity);

  /// Serializes this PowerUpState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PowerUpState&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.remainingUses, remainingUses) || other.remainingUses == remainingUses)&&(identical(other.cooldownRemaining, cooldownRemaining) || other.cooldownRemaining == cooldownRemaining)&&const DeepCollectionEquality().equals(other.usageHistory, usageHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,status,remainingUses,cooldownRemaining,const DeepCollectionEquality().hash(usageHistory));

@override
String toString() {
  return 'PowerUpState(type: $type, status: $status, remainingUses: $remainingUses, cooldownRemaining: $cooldownRemaining, usageHistory: $usageHistory)';
}


}

/// @nodoc
abstract mixin class $PowerUpStateCopyWith<$Res>  {
  factory $PowerUpStateCopyWith(PowerUpState value, $Res Function(PowerUpState) _then) = _$PowerUpStateCopyWithImpl;
@useResult
$Res call({
 PowerUpType type, PowerUpStatus status, int remainingUses, Duration cooldownRemaining, List<PowerUpUsage> usageHistory
});




}
/// @nodoc
class _$PowerUpStateCopyWithImpl<$Res>
    implements $PowerUpStateCopyWith<$Res> {
  _$PowerUpStateCopyWithImpl(this._self, this._then);

  final PowerUpState _self;
  final $Res Function(PowerUpState) _then;

/// Create a copy of PowerUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? status = null,Object? remainingUses = null,Object? cooldownRemaining = null,Object? usageHistory = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PowerUpType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PowerUpStatus,remainingUses: null == remainingUses ? _self.remainingUses : remainingUses // ignore: cast_nullable_to_non_nullable
as int,cooldownRemaining: null == cooldownRemaining ? _self.cooldownRemaining : cooldownRemaining // ignore: cast_nullable_to_non_nullable
as Duration,usageHistory: null == usageHistory ? _self.usageHistory : usageHistory // ignore: cast_nullable_to_non_nullable
as List<PowerUpUsage>,
  ));
}

}


/// Adds pattern-matching-related methods to [PowerUpState].
extension PowerUpStatePatterns on PowerUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PowerUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PowerUpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PowerUpState value)  $default,){
final _that = this;
switch (_that) {
case _PowerUpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PowerUpState value)?  $default,){
final _that = this;
switch (_that) {
case _PowerUpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PowerUpType type,  PowerUpStatus status,  int remainingUses,  Duration cooldownRemaining,  List<PowerUpUsage> usageHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PowerUpState() when $default != null:
return $default(_that.type,_that.status,_that.remainingUses,_that.cooldownRemaining,_that.usageHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PowerUpType type,  PowerUpStatus status,  int remainingUses,  Duration cooldownRemaining,  List<PowerUpUsage> usageHistory)  $default,) {final _that = this;
switch (_that) {
case _PowerUpState():
return $default(_that.type,_that.status,_that.remainingUses,_that.cooldownRemaining,_that.usageHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PowerUpType type,  PowerUpStatus status,  int remainingUses,  Duration cooldownRemaining,  List<PowerUpUsage> usageHistory)?  $default,) {final _that = this;
switch (_that) {
case _PowerUpState() when $default != null:
return $default(_that.type,_that.status,_that.remainingUses,_that.cooldownRemaining,_that.usageHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PowerUpState implements PowerUpState {
  const _PowerUpState({required this.type, this.status = PowerUpStatus.available, this.remainingUses = 1, this.cooldownRemaining = Duration.zero, final  List<PowerUpUsage> usageHistory = const []}): _usageHistory = usageHistory;
  factory _PowerUpState.fromJson(Map<String, dynamic> json) => _$PowerUpStateFromJson(json);

@override final  PowerUpType type;
@override@JsonKey() final  PowerUpStatus status;
@override@JsonKey() final  int remainingUses;
@override@JsonKey() final  Duration cooldownRemaining;
 final  List<PowerUpUsage> _usageHistory;
@override@JsonKey() List<PowerUpUsage> get usageHistory {
  if (_usageHistory is EqualUnmodifiableListView) return _usageHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_usageHistory);
}


/// Create a copy of PowerUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PowerUpStateCopyWith<_PowerUpState> get copyWith => __$PowerUpStateCopyWithImpl<_PowerUpState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PowerUpStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PowerUpState&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.remainingUses, remainingUses) || other.remainingUses == remainingUses)&&(identical(other.cooldownRemaining, cooldownRemaining) || other.cooldownRemaining == cooldownRemaining)&&const DeepCollectionEquality().equals(other._usageHistory, _usageHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,status,remainingUses,cooldownRemaining,const DeepCollectionEquality().hash(_usageHistory));

@override
String toString() {
  return 'PowerUpState(type: $type, status: $status, remainingUses: $remainingUses, cooldownRemaining: $cooldownRemaining, usageHistory: $usageHistory)';
}


}

/// @nodoc
abstract mixin class _$PowerUpStateCopyWith<$Res> implements $PowerUpStateCopyWith<$Res> {
  factory _$PowerUpStateCopyWith(_PowerUpState value, $Res Function(_PowerUpState) _then) = __$PowerUpStateCopyWithImpl;
@override @useResult
$Res call({
 PowerUpType type, PowerUpStatus status, int remainingUses, Duration cooldownRemaining, List<PowerUpUsage> usageHistory
});




}
/// @nodoc
class __$PowerUpStateCopyWithImpl<$Res>
    implements _$PowerUpStateCopyWith<$Res> {
  __$PowerUpStateCopyWithImpl(this._self, this._then);

  final _PowerUpState _self;
  final $Res Function(_PowerUpState) _then;

/// Create a copy of PowerUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? status = null,Object? remainingUses = null,Object? cooldownRemaining = null,Object? usageHistory = null,}) {
  return _then(_PowerUpState(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PowerUpType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PowerUpStatus,remainingUses: null == remainingUses ? _self.remainingUses : remainingUses // ignore: cast_nullable_to_non_nullable
as int,cooldownRemaining: null == cooldownRemaining ? _self.cooldownRemaining : cooldownRemaining // ignore: cast_nullable_to_non_nullable
as Duration,usageHistory: null == usageHistory ? _self._usageHistory : usageHistory // ignore: cast_nullable_to_non_nullable
as List<PowerUpUsage>,
  ));
}


}

// dart format on
