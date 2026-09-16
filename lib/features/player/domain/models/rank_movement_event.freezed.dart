// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_movement_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankMovementEvent {

 String get id; String get userId; String? get seasonId; int get previousPosition; int get currentPosition; int get positionDelta; String get previousRank; String get currentRank; int get rankPoints; RankMovementType get type; DateTime get timestamp; String? get sourceId;
/// Create a copy of RankMovementEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankMovementEventCopyWith<RankMovementEvent> get copyWith => _$RankMovementEventCopyWithImpl<RankMovementEvent>(this as RankMovementEvent, _$identity);

  /// Serializes this RankMovementEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankMovementEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.previousPosition, previousPosition) || other.previousPosition == previousPosition)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.positionDelta, positionDelta) || other.positionDelta == positionDelta)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,seasonId,previousPosition,currentPosition,positionDelta,previousRank,currentRank,rankPoints,type,timestamp,sourceId);

@override
String toString() {
  return 'RankMovementEvent(id: $id, userId: $userId, seasonId: $seasonId, previousPosition: $previousPosition, currentPosition: $currentPosition, positionDelta: $positionDelta, previousRank: $previousRank, currentRank: $currentRank, rankPoints: $rankPoints, type: $type, timestamp: $timestamp, sourceId: $sourceId)';
}


}

/// @nodoc
abstract mixin class $RankMovementEventCopyWith<$Res>  {
  factory $RankMovementEventCopyWith(RankMovementEvent value, $Res Function(RankMovementEvent) _then) = _$RankMovementEventCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String? seasonId, int previousPosition, int currentPosition, int positionDelta, String previousRank, String currentRank, int rankPoints, RankMovementType type, DateTime timestamp, String? sourceId
});




}
/// @nodoc
class _$RankMovementEventCopyWithImpl<$Res>
    implements $RankMovementEventCopyWith<$Res> {
  _$RankMovementEventCopyWithImpl(this._self, this._then);

  final RankMovementEvent _self;
  final $Res Function(RankMovementEvent) _then;

/// Create a copy of RankMovementEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? seasonId = freezed,Object? previousPosition = null,Object? currentPosition = null,Object? positionDelta = null,Object? previousRank = null,Object? currentRank = null,Object? rankPoints = null,Object? type = null,Object? timestamp = null,Object? sourceId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,previousPosition: null == previousPosition ? _self.previousPosition : previousPosition // ignore: cast_nullable_to_non_nullable
as int,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as int,positionDelta: null == positionDelta ? _self.positionDelta : positionDelta // ignore: cast_nullable_to_non_nullable
as int,previousRank: null == previousRank ? _self.previousRank : previousRank // ignore: cast_nullable_to_non_nullable
as String,currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RankMovementType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RankMovementEvent].
extension RankMovementEventPatterns on RankMovementEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankMovementEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankMovementEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankMovementEvent value)  $default,){
final _that = this;
switch (_that) {
case _RankMovementEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankMovementEvent value)?  $default,){
final _that = this;
switch (_that) {
case _RankMovementEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String? seasonId,  int previousPosition,  int currentPosition,  int positionDelta,  String previousRank,  String currentRank,  int rankPoints,  RankMovementType type,  DateTime timestamp,  String? sourceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankMovementEvent() when $default != null:
return $default(_that.id,_that.userId,_that.seasonId,_that.previousPosition,_that.currentPosition,_that.positionDelta,_that.previousRank,_that.currentRank,_that.rankPoints,_that.type,_that.timestamp,_that.sourceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String? seasonId,  int previousPosition,  int currentPosition,  int positionDelta,  String previousRank,  String currentRank,  int rankPoints,  RankMovementType type,  DateTime timestamp,  String? sourceId)  $default,) {final _that = this;
switch (_that) {
case _RankMovementEvent():
return $default(_that.id,_that.userId,_that.seasonId,_that.previousPosition,_that.currentPosition,_that.positionDelta,_that.previousRank,_that.currentRank,_that.rankPoints,_that.type,_that.timestamp,_that.sourceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String? seasonId,  int previousPosition,  int currentPosition,  int positionDelta,  String previousRank,  String currentRank,  int rankPoints,  RankMovementType type,  DateTime timestamp,  String? sourceId)?  $default,) {final _that = this;
switch (_that) {
case _RankMovementEvent() when $default != null:
return $default(_that.id,_that.userId,_that.seasonId,_that.previousPosition,_that.currentPosition,_that.positionDelta,_that.previousRank,_that.currentRank,_that.rankPoints,_that.type,_that.timestamp,_that.sourceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankMovementEvent implements RankMovementEvent {
  const _RankMovementEvent({required this.id, required this.userId, this.seasonId, required this.previousPosition, required this.currentPosition, required this.positionDelta, required this.previousRank, required this.currentRank, required this.rankPoints, required this.type, required this.timestamp, this.sourceId});
  factory _RankMovementEvent.fromJson(Map<String, dynamic> json) => _$RankMovementEventFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String? seasonId;
@override final  int previousPosition;
@override final  int currentPosition;
@override final  int positionDelta;
@override final  String previousRank;
@override final  String currentRank;
@override final  int rankPoints;
@override final  RankMovementType type;
@override final  DateTime timestamp;
@override final  String? sourceId;

/// Create a copy of RankMovementEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankMovementEventCopyWith<_RankMovementEvent> get copyWith => __$RankMovementEventCopyWithImpl<_RankMovementEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankMovementEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankMovementEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.previousPosition, previousPosition) || other.previousPosition == previousPosition)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.positionDelta, positionDelta) || other.positionDelta == positionDelta)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.rankPoints, rankPoints) || other.rankPoints == rankPoints)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,seasonId,previousPosition,currentPosition,positionDelta,previousRank,currentRank,rankPoints,type,timestamp,sourceId);

@override
String toString() {
  return 'RankMovementEvent(id: $id, userId: $userId, seasonId: $seasonId, previousPosition: $previousPosition, currentPosition: $currentPosition, positionDelta: $positionDelta, previousRank: $previousRank, currentRank: $currentRank, rankPoints: $rankPoints, type: $type, timestamp: $timestamp, sourceId: $sourceId)';
}


}

/// @nodoc
abstract mixin class _$RankMovementEventCopyWith<$Res> implements $RankMovementEventCopyWith<$Res> {
  factory _$RankMovementEventCopyWith(_RankMovementEvent value, $Res Function(_RankMovementEvent) _then) = __$RankMovementEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String? seasonId, int previousPosition, int currentPosition, int positionDelta, String previousRank, String currentRank, int rankPoints, RankMovementType type, DateTime timestamp, String? sourceId
});




}
/// @nodoc
class __$RankMovementEventCopyWithImpl<$Res>
    implements _$RankMovementEventCopyWith<$Res> {
  __$RankMovementEventCopyWithImpl(this._self, this._then);

  final _RankMovementEvent _self;
  final $Res Function(_RankMovementEvent) _then;

/// Create a copy of RankMovementEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? seasonId = freezed,Object? previousPosition = null,Object? currentPosition = null,Object? positionDelta = null,Object? previousRank = null,Object? currentRank = null,Object? rankPoints = null,Object? type = null,Object? timestamp = null,Object? sourceId = freezed,}) {
  return _then(_RankMovementEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,previousPosition: null == previousPosition ? _self.previousPosition : previousPosition // ignore: cast_nullable_to_non_nullable
as int,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as int,positionDelta: null == positionDelta ? _self.positionDelta : positionDelta // ignore: cast_nullable_to_non_nullable
as int,previousRank: null == previousRank ? _self.previousRank : previousRank // ignore: cast_nullable_to_non_nullable
as String,currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,rankPoints: null == rankPoints ? _self.rankPoints : rankPoints // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RankMovementType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
