// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_analytics_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionAnalyticsEvent {

 String get eventId;// Deterministic: sessionId_questionId
 String get userId; String get questionId; String get version; String get categoryId; Difficulty get difficulty; QuestionOutcome get outcome; Duration get responseTime; GameMode get mode; DateTime get timestamp;
/// Create a copy of QuestionAnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionAnalyticsEventCopyWith<QuestionAnalyticsEvent> get copyWith => _$QuestionAnalyticsEventCopyWithImpl<QuestionAnalyticsEvent>(this as QuestionAnalyticsEvent, _$identity);

  /// Serializes this QuestionAnalyticsEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionAnalyticsEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.version, version) || other.version == version)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,userId,questionId,version,categoryId,difficulty,outcome,responseTime,mode,timestamp);

@override
String toString() {
  return 'QuestionAnalyticsEvent(eventId: $eventId, userId: $userId, questionId: $questionId, version: $version, categoryId: $categoryId, difficulty: $difficulty, outcome: $outcome, responseTime: $responseTime, mode: $mode, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $QuestionAnalyticsEventCopyWith<$Res>  {
  factory $QuestionAnalyticsEventCopyWith(QuestionAnalyticsEvent value, $Res Function(QuestionAnalyticsEvent) _then) = _$QuestionAnalyticsEventCopyWithImpl;
@useResult
$Res call({
 String eventId, String userId, String questionId, String version, String categoryId, Difficulty difficulty, QuestionOutcome outcome, Duration responseTime, GameMode mode, DateTime timestamp
});




}
/// @nodoc
class _$QuestionAnalyticsEventCopyWithImpl<$Res>
    implements $QuestionAnalyticsEventCopyWith<$Res> {
  _$QuestionAnalyticsEventCopyWithImpl(this._self, this._then);

  final QuestionAnalyticsEvent _self;
  final $Res Function(QuestionAnalyticsEvent) _then;

/// Create a copy of QuestionAnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? userId = null,Object? questionId = null,Object? version = null,Object? categoryId = null,Object? difficulty = null,Object? outcome = null,Object? responseTime = null,Object? mode = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as QuestionOutcome,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionAnalyticsEvent].
extension QuestionAnalyticsEventPatterns on QuestionAnalyticsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionAnalyticsEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionAnalyticsEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionAnalyticsEvent value)  $default,){
final _that = this;
switch (_that) {
case _QuestionAnalyticsEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionAnalyticsEvent value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionAnalyticsEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String userId,  String questionId,  String version,  String categoryId,  Difficulty difficulty,  QuestionOutcome outcome,  Duration responseTime,  GameMode mode,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionAnalyticsEvent() when $default != null:
return $default(_that.eventId,_that.userId,_that.questionId,_that.version,_that.categoryId,_that.difficulty,_that.outcome,_that.responseTime,_that.mode,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String userId,  String questionId,  String version,  String categoryId,  Difficulty difficulty,  QuestionOutcome outcome,  Duration responseTime,  GameMode mode,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _QuestionAnalyticsEvent():
return $default(_that.eventId,_that.userId,_that.questionId,_that.version,_that.categoryId,_that.difficulty,_that.outcome,_that.responseTime,_that.mode,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String userId,  String questionId,  String version,  String categoryId,  Difficulty difficulty,  QuestionOutcome outcome,  Duration responseTime,  GameMode mode,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _QuestionAnalyticsEvent() when $default != null:
return $default(_that.eventId,_that.userId,_that.questionId,_that.version,_that.categoryId,_that.difficulty,_that.outcome,_that.responseTime,_that.mode,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionAnalyticsEvent implements QuestionAnalyticsEvent {
  const _QuestionAnalyticsEvent({required this.eventId, required this.userId, required this.questionId, required this.version, required this.categoryId, required this.difficulty, required this.outcome, required this.responseTime, required this.mode, required this.timestamp});
  factory _QuestionAnalyticsEvent.fromJson(Map<String, dynamic> json) => _$QuestionAnalyticsEventFromJson(json);

@override final  String eventId;
// Deterministic: sessionId_questionId
@override final  String userId;
@override final  String questionId;
@override final  String version;
@override final  String categoryId;
@override final  Difficulty difficulty;
@override final  QuestionOutcome outcome;
@override final  Duration responseTime;
@override final  GameMode mode;
@override final  DateTime timestamp;

/// Create a copy of QuestionAnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionAnalyticsEventCopyWith<_QuestionAnalyticsEvent> get copyWith => __$QuestionAnalyticsEventCopyWithImpl<_QuestionAnalyticsEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionAnalyticsEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionAnalyticsEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.version, version) || other.version == version)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,userId,questionId,version,categoryId,difficulty,outcome,responseTime,mode,timestamp);

@override
String toString() {
  return 'QuestionAnalyticsEvent(eventId: $eventId, userId: $userId, questionId: $questionId, version: $version, categoryId: $categoryId, difficulty: $difficulty, outcome: $outcome, responseTime: $responseTime, mode: $mode, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$QuestionAnalyticsEventCopyWith<$Res> implements $QuestionAnalyticsEventCopyWith<$Res> {
  factory _$QuestionAnalyticsEventCopyWith(_QuestionAnalyticsEvent value, $Res Function(_QuestionAnalyticsEvent) _then) = __$QuestionAnalyticsEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String userId, String questionId, String version, String categoryId, Difficulty difficulty, QuestionOutcome outcome, Duration responseTime, GameMode mode, DateTime timestamp
});




}
/// @nodoc
class __$QuestionAnalyticsEventCopyWithImpl<$Res>
    implements _$QuestionAnalyticsEventCopyWith<$Res> {
  __$QuestionAnalyticsEventCopyWithImpl(this._self, this._then);

  final _QuestionAnalyticsEvent _self;
  final $Res Function(_QuestionAnalyticsEvent) _then;

/// Create a copy of QuestionAnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? userId = null,Object? questionId = null,Object? version = null,Object? categoryId = null,Object? difficulty = null,Object? outcome = null,Object? responseTime = null,Object? mode = null,Object? timestamp = null,}) {
  return _then(_QuestionAnalyticsEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as QuestionOutcome,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as Duration,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
