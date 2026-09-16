// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitive_activity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetitiveActivityEvent {

 String get id; String get userId; CompetitiveEventType get type; String get title; String get description; DateTime get createdAt; String? get seasonId; Map<String, dynamic> get metadata; String? get deepLink; ActivityImportance get importance; String? get icon; ActivityVisibility get visibility;
/// Create a copy of CompetitiveActivityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitiveActivityEventCopyWith<CompetitiveActivityEvent> get copyWith => _$CompetitiveActivityEventCopyWithImpl<CompetitiveActivityEvent>(this as CompetitiveActivityEvent, _$identity);

  /// Serializes this CompetitiveActivityEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitiveActivityEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.visibility, visibility) || other.visibility == visibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,title,description,createdAt,seasonId,const DeepCollectionEquality().hash(metadata),deepLink,importance,icon,visibility);

@override
String toString() {
  return 'CompetitiveActivityEvent(id: $id, userId: $userId, type: $type, title: $title, description: $description, createdAt: $createdAt, seasonId: $seasonId, metadata: $metadata, deepLink: $deepLink, importance: $importance, icon: $icon, visibility: $visibility)';
}


}

/// @nodoc
abstract mixin class $CompetitiveActivityEventCopyWith<$Res>  {
  factory $CompetitiveActivityEventCopyWith(CompetitiveActivityEvent value, $Res Function(CompetitiveActivityEvent) _then) = _$CompetitiveActivityEventCopyWithImpl;
@useResult
$Res call({
 String id, String userId, CompetitiveEventType type, String title, String description, DateTime createdAt, String? seasonId, Map<String, dynamic> metadata, String? deepLink, ActivityImportance importance, String? icon, ActivityVisibility visibility
});




}
/// @nodoc
class _$CompetitiveActivityEventCopyWithImpl<$Res>
    implements $CompetitiveActivityEventCopyWith<$Res> {
  _$CompetitiveActivityEventCopyWithImpl(this._self, this._then);

  final CompetitiveActivityEvent _self;
  final $Res Function(CompetitiveActivityEvent) _then;

/// Create a copy of CompetitiveActivityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? title = null,Object? description = null,Object? createdAt = null,Object? seasonId = freezed,Object? metadata = null,Object? deepLink = freezed,Object? importance = null,Object? icon = freezed,Object? visibility = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CompetitiveEventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,deepLink: freezed == deepLink ? _self.deepLink : deepLink // ignore: cast_nullable_to_non_nullable
as String?,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as ActivityImportance,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ActivityVisibility,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitiveActivityEvent].
extension CompetitiveActivityEventPatterns on CompetitiveActivityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitiveActivityEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitiveActivityEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitiveActivityEvent value)  $default,){
final _that = this;
switch (_that) {
case _CompetitiveActivityEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitiveActivityEvent value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitiveActivityEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  CompetitiveEventType type,  String title,  String description,  DateTime createdAt,  String? seasonId,  Map<String, dynamic> metadata,  String? deepLink,  ActivityImportance importance,  String? icon,  ActivityVisibility visibility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitiveActivityEvent() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.title,_that.description,_that.createdAt,_that.seasonId,_that.metadata,_that.deepLink,_that.importance,_that.icon,_that.visibility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  CompetitiveEventType type,  String title,  String description,  DateTime createdAt,  String? seasonId,  Map<String, dynamic> metadata,  String? deepLink,  ActivityImportance importance,  String? icon,  ActivityVisibility visibility)  $default,) {final _that = this;
switch (_that) {
case _CompetitiveActivityEvent():
return $default(_that.id,_that.userId,_that.type,_that.title,_that.description,_that.createdAt,_that.seasonId,_that.metadata,_that.deepLink,_that.importance,_that.icon,_that.visibility);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  CompetitiveEventType type,  String title,  String description,  DateTime createdAt,  String? seasonId,  Map<String, dynamic> metadata,  String? deepLink,  ActivityImportance importance,  String? icon,  ActivityVisibility visibility)?  $default,) {final _that = this;
switch (_that) {
case _CompetitiveActivityEvent() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.title,_that.description,_that.createdAt,_that.seasonId,_that.metadata,_that.deepLink,_that.importance,_that.icon,_that.visibility);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitiveActivityEvent implements CompetitiveActivityEvent {
  const _CompetitiveActivityEvent({required this.id, required this.userId, required this.type, required this.title, required this.description, required this.createdAt, this.seasonId, final  Map<String, dynamic> metadata = const {}, this.deepLink, this.importance = ActivityImportance.normal, this.icon, this.visibility = ActivityVisibility.public}): _metadata = metadata;
  factory _CompetitiveActivityEvent.fromJson(Map<String, dynamic> json) => _$CompetitiveActivityEventFromJson(json);

@override final  String id;
@override final  String userId;
@override final  CompetitiveEventType type;
@override final  String title;
@override final  String description;
@override final  DateTime createdAt;
@override final  String? seasonId;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  String? deepLink;
@override@JsonKey() final  ActivityImportance importance;
@override final  String? icon;
@override@JsonKey() final  ActivityVisibility visibility;

/// Create a copy of CompetitiveActivityEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitiveActivityEventCopyWith<_CompetitiveActivityEvent> get copyWith => __$CompetitiveActivityEventCopyWithImpl<_CompetitiveActivityEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitiveActivityEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitiveActivityEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.visibility, visibility) || other.visibility == visibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,title,description,createdAt,seasonId,const DeepCollectionEquality().hash(_metadata),deepLink,importance,icon,visibility);

@override
String toString() {
  return 'CompetitiveActivityEvent(id: $id, userId: $userId, type: $type, title: $title, description: $description, createdAt: $createdAt, seasonId: $seasonId, metadata: $metadata, deepLink: $deepLink, importance: $importance, icon: $icon, visibility: $visibility)';
}


}

/// @nodoc
abstract mixin class _$CompetitiveActivityEventCopyWith<$Res> implements $CompetitiveActivityEventCopyWith<$Res> {
  factory _$CompetitiveActivityEventCopyWith(_CompetitiveActivityEvent value, $Res Function(_CompetitiveActivityEvent) _then) = __$CompetitiveActivityEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, CompetitiveEventType type, String title, String description, DateTime createdAt, String? seasonId, Map<String, dynamic> metadata, String? deepLink, ActivityImportance importance, String? icon, ActivityVisibility visibility
});




}
/// @nodoc
class __$CompetitiveActivityEventCopyWithImpl<$Res>
    implements _$CompetitiveActivityEventCopyWith<$Res> {
  __$CompetitiveActivityEventCopyWithImpl(this._self, this._then);

  final _CompetitiveActivityEvent _self;
  final $Res Function(_CompetitiveActivityEvent) _then;

/// Create a copy of CompetitiveActivityEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? title = null,Object? description = null,Object? createdAt = null,Object? seasonId = freezed,Object? metadata = null,Object? deepLink = freezed,Object? importance = null,Object? icon = freezed,Object? visibility = null,}) {
  return _then(_CompetitiveActivityEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CompetitiveEventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,deepLink: freezed == deepLink ? _self.deepLink : deepLink // ignore: cast_nullable_to_non_nullable
as String?,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as ActivityImportance,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ActivityVisibility,
  ));
}


}

// dart format on
