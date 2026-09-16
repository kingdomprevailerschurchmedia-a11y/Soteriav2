// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_streak.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveStreak {

 String get userId; StreakType get type; int get current; int get best; int get seasonBest; DateTime get startedAt; DateTime get lastQualifiedAt; String? get seasonId; StreakStatus get status; DateTime get updatedAt;
/// Create a copy of CompetitiveStreak
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveStreakCopyWith<CompetitiveStreak> get copyWith => _$CompetitiveStreakCopyWithImpl<CompetitiveStreak>(this as CompetitiveStreak, _$identity);

  /// Serializes this CompetitiveStreak to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveStreak&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.current, current) || other.current == current)&&(identical(other.best, best) || other.best == best)&&(identical(other.seasonBest, seasonBest) || other.seasonBest == seasonBest)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastQualifiedAt, lastQualifiedAt) || other.lastQualifiedAt == lastQualifiedAt)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,type,current,best,seasonBest,startedAt,lastQualifiedAt,seasonId,status,updatedAt);

@override
String toString() {
  return 'CompetitiveStreak(userId: $userId, type: $type, current: $current, best: $best, seasonBest: $seasonBest, startedAt: $startedAt, lastQualifiedAt: $lastQualifiedAt, seasonId: $seasonId, status: $status, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CompetitiveStreakCopyWith<$Res>  {
  factory $CompetitiveStreakCopyWith(CompetitiveStreak value, $Res Function(CompetitiveStreak) _then) = _$CompetitiveStreakCopyWithImpl;
@useResult
$Res call({
 String userId, StreakType type, int current, int best, int seasonBest, DateTime startedAt, DateTime lastQualifiedAt, String? seasonId, StreakStatus status, DateTime updatedAt
});




}
/// @nodoc
class _$CompetitiveStreakCopyWithImpl<$Res>
    implements $CompetitiveStreakCopyWith<$Res> {
  _$CompetitiveStreakCopyWithImpl(this._self, this._then);

  final CompetitiveStreak _self;
  final $Res Function(CompetitiveStreak) _then;

/// Create a copy of CompetitiveStreak
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? type = null,Object? current = null,Object? best = null,Object? seasonBest = null,Object? startedAt = null,Object? lastQualifiedAt = null,Object? seasonId = freezed,Object? status = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StreakType,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,best: null == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as int,seasonBest: null == seasonBest ? _self.seasonBest : seasonBest // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastQualifiedAt: null == lastQualifiedAt ? _self.lastQualifiedAt : lastQualifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StreakStatus,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveStreak].
extension CompetitiveStreakPatterns on CompetitiveStreak {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveStreak value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveStreak() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveStreak value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveStreak():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveStreak value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveStreak() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  StreakType type,  int current,  int best,  int seasonBest,  DateTime startedAt,  DateTime lastQualifiedAt,  String? seasonId,  StreakStatus status,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveStreak() when $default != null:
return $default(_that.userId,_that.type,_that.current,_that.best,_that.seasonBest,_that.startedAt,_that.lastQualifiedAt,_that.seasonId,_that.status,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  StreakType type,  int current,  int best,  int seasonBest,  DateTime startedAt,  DateTime lastQualifiedAt,  String? seasonId,  StreakStatus status,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveStreak():
return $default(_that.userId,_that.type,_that.current,_that.best,_that.seasonBest,_that.startedAt,_that.lastQualifiedAt,_that.seasonId,_that.status,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  StreakType type,  int current,  int best,  int seasonBest,  DateTime startedAt,  DateTime lastQualifiedAt,  String? seasonId,  StreakStatus status,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveStreak() when $default != null:
return $default(_that.userId,_that.type,_that.current,_that.best,_that.seasonBest,_that.startedAt,_that.lastQualifiedAt,_that.seasonId,_that.status,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveStreak implements CompetitiveStreak {
  const _CompetitiveStreak({required this.userId, required this.type, required this.current, required this.best, required this.seasonBest, required this.startedAt, required this.lastQualifiedAt, this.seasonId, this.status = StreakStatus.active, required this.updatedAt});
  factory _CompetitiveStreak.fromJson(Map<String, dynamic> json) => _$CompetitiveStreakFromJson(json);

@override final  String userId;
@override final  StreakType type;
@override final  int current;
@override final  int best;
@override final  int seasonBest;
@override final  DateTime startedAt;
@override final  DateTime lastQualifiedAt;
@override final  String? seasonId;
@override@JsonKey() final  StreakStatus status;
@override final  DateTime updatedAt;

/// Create a copy of CompetitiveStreak
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveStreakCopyWith<_CompetitiveStreak> get copyWith => __$CompetitiveStreakCopyWithImpl<_CompetitiveStreak>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveStreakToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveStreak&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.current, current) || other.current == current)&&(identical(other.best, best) || other.best == best)&&(identical(other.seasonBest, seasonBest) || other.seasonBest == seasonBest)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastQualifiedAt, lastQualifiedAt) || other.lastQualifiedAt == lastQualifiedAt)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,type,current,best,seasonBest,startedAt,lastQualifiedAt,seasonId,status,updatedAt);

@override
String toString() {
  return 'CompetitiveStreak(userId: $userId, type: $type, current: $current, best: $best, seasonBest: $seasonBest, startedAt: $startedAt, lastQualifiedAt: $lastQualifiedAt, seasonId: $seasonId, status: $status, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveStreakCopyWith<$Res> implements $CompetitiveStreakCopyWith<$Res> {
  factory _$CompetitiveStreakCopyWith(_CompetitiveStreak value, $Res Function(_CompetitiveStreak) _then) = __$CompetitiveStreakCopyWithImpl;
@override @useResult
$Res call({
 String userId, StreakType type, int current, int best, int seasonBest, DateTime startedAt, DateTime lastQualifiedAt, String? seasonId, StreakStatus status, DateTime updatedAt
});




}
/// @nodoc
class __$CompetitiveStreakCopyWithImpl<$Res>
    implements _$CompetitiveStreakCopyWith<$Res> {
  __$CompetitiveStreakCopyWithImpl(this._self, this._then);

  final _CompetitiveStreak _self;
  final $Res Function(_CompetitiveStreak) _then;

/// Create a copy of CompetitiveStreak
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? type = null,Object? current = null,Object? best = null,Object? seasonBest = null,Object? startedAt = null,Object? lastQualifiedAt = null,Object? seasonId = freezed,Object? status = null,Object? updatedAt = null,}) {
  return _then(_CompetitiveStreak(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StreakType,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,best: null == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as int,seasonBest: null == seasonBest ? _self.seasonBest : seasonBest // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastQualifiedAt: null == lastQualifiedAt ? _self.lastQualifiedAt : lastQualifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StreakStatus,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
