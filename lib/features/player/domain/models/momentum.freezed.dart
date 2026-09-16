// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'momentum.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveMomentum {

 String get userId; MomentumState get state; String get reason; double get intensity;// 0.0 to 1.0
 DateTime get updatedAt; List<String> get recentSignals;
/// Create a copy of CompetitiveMomentum
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveMomentumCopyWith<CompetitiveMomentum> get copyWith => _$CompetitiveMomentumCopyWithImpl<CompetitiveMomentum>(this as CompetitiveMomentum, _$identity);

  /// Serializes this CompetitiveMomentum to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveMomentum&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.state, state) || other.state == state)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.recentSignals, recentSignals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,state,reason,intensity,updatedAt,const DeepCollectionEquality().hash(recentSignals));

@override
String toString() {
  return 'CompetitiveMomentum(userId: $userId, state: $state, reason: $reason, intensity: $intensity, updatedAt: $updatedAt, recentSignals: $recentSignals)';
}


}

/// @nodoc
abstract mixin class $CompetitiveMomentumCopyWith<$Res>  {
  factory $CompetitiveMomentumCopyWith(CompetitiveMomentum value, $Res Function(CompetitiveMomentum) _then) = _$CompetitiveMomentumCopyWithImpl;
@useResult
$Res call({
 String userId, MomentumState state, String reason, double intensity, DateTime updatedAt, List<String> recentSignals
});




}
/// @nodoc
class _$CompetitiveMomentumCopyWithImpl<$Res>
    implements $CompetitiveMomentumCopyWith<$Res> {
  _$CompetitiveMomentumCopyWithImpl(this._self, this._then);

  final CompetitiveMomentum _self;
  final $Res Function(CompetitiveMomentum) _then;

/// Create a copy of CompetitiveMomentum
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? state = null,Object? reason = null,Object? intensity = null,Object? updatedAt = null,Object? recentSignals = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as MomentumState,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,recentSignals: null == recentSignals ? _self.recentSignals : recentSignals // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveMomentum].
extension CompetitiveMomentumPatterns on CompetitiveMomentum {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveMomentum value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveMomentum() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveMomentum value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMomentum():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveMomentum value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveMomentum() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  MomentumState state,  String reason,  double intensity,  DateTime updatedAt,  List<String> recentSignals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveMomentum() when $default != null:
return $default(_that.userId,_that.state,_that.reason,_that.intensity,_that.updatedAt,_that.recentSignals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  MomentumState state,  String reason,  double intensity,  DateTime updatedAt,  List<String> recentSignals)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMomentum():
return $default(_that.userId,_that.state,_that.reason,_that.intensity,_that.updatedAt,_that.recentSignals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  MomentumState state,  String reason,  double intensity,  DateTime updatedAt,  List<String> recentSignals)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveMomentum() when $default != null:
return $default(_that.userId,_that.state,_that.reason,_that.intensity,_that.updatedAt,_that.recentSignals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveMomentum implements CompetitiveMomentum {
  const _CompetitiveMomentum({required this.userId, required this.state, required this.reason, required this.intensity, required this.updatedAt, final  List<String> recentSignals = const []}): _recentSignals = recentSignals;
  factory _CompetitiveMomentum.fromJson(Map<String, dynamic> json) => _$CompetitiveMomentumFromJson(json);

@override final  String userId;
@override final  MomentumState state;
@override final  String reason;
@override final  double intensity;
// 0.0 to 1.0
@override final  DateTime updatedAt;
 final  List<String> _recentSignals;
@override@JsonKey() List<String> get recentSignals {
  if (_recentSignals is EqualUnmodifiableListView) return _recentSignals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSignals);
}


/// Create a copy of CompetitiveMomentum
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveMomentumCopyWith<_CompetitiveMomentum> get copyWith => __$CompetitiveMomentumCopyWithImpl<_CompetitiveMomentum>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveMomentumToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveMomentum&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.state, state) || other.state == state)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._recentSignals, _recentSignals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,state,reason,intensity,updatedAt,const DeepCollectionEquality().hash(_recentSignals));

@override
String toString() {
  return 'CompetitiveMomentum(userId: $userId, state: $state, reason: $reason, intensity: $intensity, updatedAt: $updatedAt, recentSignals: $recentSignals)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveMomentumCopyWith<$Res> implements $CompetitiveMomentumCopyWith<$Res> {
  factory _$CompetitiveMomentumCopyWith(_CompetitiveMomentum value, $Res Function(_CompetitiveMomentum) _then) = __$CompetitiveMomentumCopyWithImpl;
@override @useResult
$Res call({
 String userId, MomentumState state, String reason, double intensity, DateTime updatedAt, List<String> recentSignals
});




}
/// @nodoc
class __$CompetitiveMomentumCopyWithImpl<$Res>
    implements _$CompetitiveMomentumCopyWith<$Res> {
  __$CompetitiveMomentumCopyWithImpl(this._self, this._then);

  final _CompetitiveMomentum _self;
  final $Res Function(_CompetitiveMomentum) _then;

/// Create a copy of CompetitiveMomentum
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? state = null,Object? reason = null,Object? intensity = null,Object? updatedAt = null,Object? recentSignals = null,}) {
  return _then(_CompetitiveMomentum(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as MomentumState,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,recentSignals: null == recentSignals ? _self._recentSignals : recentSignals // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
