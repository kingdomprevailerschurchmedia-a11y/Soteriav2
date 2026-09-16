// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_rivalry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerRivalry {

 String get rivalryId; String get userId; String get rivalId; int get matchesPlayed; int get wins; int get losses; int get draws; DateTime get lastMatchAt; CompetitiveOutcome? get lastOutcome; List<CompetitiveOutcome> get recentForm;
/// Create a copy of PlayerRivalry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerRivalryCopyWith<PlayerRivalry> get copyWith => _$PlayerRivalryCopyWithImpl<PlayerRivalry>(this as PlayerRivalry, _$identity);

  /// Serializes this PlayerRivalry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerRivalry&&(identical(other.rivalryId, rivalryId) || other.rivalryId == rivalryId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rivalId, rivalId) || other.rivalId == rivalId)&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.lastMatchAt, lastMatchAt) || other.lastMatchAt == lastMatchAt)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome)&&const DeepCollectionEquality().equals(other.recentForm, recentForm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rivalryId,userId,rivalId,matchesPlayed,wins,losses,draws,lastMatchAt,lastOutcome,const DeepCollectionEquality().hash(recentForm));

@override
String toString() {
  return 'PlayerRivalry(rivalryId: $rivalryId, userId: $userId, rivalId: $rivalId, matchesPlayed: $matchesPlayed, wins: $wins, losses: $losses, draws: $draws, lastMatchAt: $lastMatchAt, lastOutcome: $lastOutcome, recentForm: $recentForm)';
}


}

/// @nodoc
abstract mixin class $PlayerRivalryCopyWith<$Res>  {
  factory $PlayerRivalryCopyWith(PlayerRivalry value, $Res Function(PlayerRivalry) _then) = _$PlayerRivalryCopyWithImpl;
@useResult
$Res call({
 String rivalryId, String userId, String rivalId, int matchesPlayed, int wins, int losses, int draws, DateTime lastMatchAt, CompetitiveOutcome? lastOutcome, List<CompetitiveOutcome> recentForm
});




}
/// @nodoc
class _$PlayerRivalryCopyWithImpl<$Res>
    implements $PlayerRivalryCopyWith<$Res> {
  _$PlayerRivalryCopyWithImpl(this._self, this._then);

  final PlayerRivalry _self;
  final $Res Function(PlayerRivalry) _then;

/// Create a copy of PlayerRivalry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rivalryId = null,Object? userId = null,Object? rivalId = null,Object? matchesPlayed = null,Object? wins = null,Object? losses = null,Object? draws = null,Object? lastMatchAt = null,Object? lastOutcome = freezed,Object? recentForm = null,}) {
  return _then(_self.copyWith(
rivalryId: null == rivalryId ? _self.rivalryId : rivalryId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rivalId: null == rivalId ? _self.rivalId : rivalId // ignore: cast_nullable_to_non_nullable
as String,matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,lastMatchAt: null == lastMatchAt ? _self.lastMatchAt : lastMatchAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as CompetitiveOutcome?,recentForm: null == recentForm ? _self.recentForm : recentForm // ignore: cast_nullable_to_non_nullable
as List<CompetitiveOutcome>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerRivalry].
extension PlayerRivalryPatterns on PlayerRivalry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerRivalry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerRivalry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerRivalry value)  $default,){
final _that = this;
switch (_that) {
case _PlayerRivalry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerRivalry value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerRivalry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rivalryId,  String userId,  String rivalId,  int matchesPlayed,  int wins,  int losses,  int draws,  DateTime lastMatchAt,  CompetitiveOutcome? lastOutcome,  List<CompetitiveOutcome> recentForm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerRivalry() when $default != null:
return $default(_that.rivalryId,_that.userId,_that.rivalId,_that.matchesPlayed,_that.wins,_that.losses,_that.draws,_that.lastMatchAt,_that.lastOutcome,_that.recentForm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rivalryId,  String userId,  String rivalId,  int matchesPlayed,  int wins,  int losses,  int draws,  DateTime lastMatchAt,  CompetitiveOutcome? lastOutcome,  List<CompetitiveOutcome> recentForm)  $default,) {final _that = this;
switch (_that) {
case _PlayerRivalry():
return $default(_that.rivalryId,_that.userId,_that.rivalId,_that.matchesPlayed,_that.wins,_that.losses,_that.draws,_that.lastMatchAt,_that.lastOutcome,_that.recentForm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rivalryId,  String userId,  String rivalId,  int matchesPlayed,  int wins,  int losses,  int draws,  DateTime lastMatchAt,  CompetitiveOutcome? lastOutcome,  List<CompetitiveOutcome> recentForm)?  $default,) {final _that = this;
switch (_that) {
case _PlayerRivalry() when $default != null:
return $default(_that.rivalryId,_that.userId,_that.rivalId,_that.matchesPlayed,_that.wins,_that.losses,_that.draws,_that.lastMatchAt,_that.lastOutcome,_that.recentForm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerRivalry implements PlayerRivalry {
  const _PlayerRivalry({required this.rivalryId, required this.userId, required this.rivalId, required this.matchesPlayed, required this.wins, required this.losses, required this.draws, required this.lastMatchAt, this.lastOutcome, final  List<CompetitiveOutcome> recentForm = const []}): _recentForm = recentForm;
  factory _PlayerRivalry.fromJson(Map<String, dynamic> json) => _$PlayerRivalryFromJson(json);

@override final  String rivalryId;
@override final  String userId;
@override final  String rivalId;
@override final  int matchesPlayed;
@override final  int wins;
@override final  int losses;
@override final  int draws;
@override final  DateTime lastMatchAt;
@override final  CompetitiveOutcome? lastOutcome;
 final  List<CompetitiveOutcome> _recentForm;
@override@JsonKey() List<CompetitiveOutcome> get recentForm {
  if (_recentForm is EqualUnmodifiableListView) return _recentForm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentForm);
}


/// Create a copy of PlayerRivalry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerRivalryCopyWith<_PlayerRivalry> get copyWith => __$PlayerRivalryCopyWithImpl<_PlayerRivalry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerRivalryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerRivalry&&(identical(other.rivalryId, rivalryId) || other.rivalryId == rivalryId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rivalId, rivalId) || other.rivalId == rivalId)&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.lastMatchAt, lastMatchAt) || other.lastMatchAt == lastMatchAt)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome)&&const DeepCollectionEquality().equals(other._recentForm, _recentForm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rivalryId,userId,rivalId,matchesPlayed,wins,losses,draws,lastMatchAt,lastOutcome,const DeepCollectionEquality().hash(_recentForm));

@override
String toString() {
  return 'PlayerRivalry(rivalryId: $rivalryId, userId: $userId, rivalId: $rivalId, matchesPlayed: $matchesPlayed, wins: $wins, losses: $losses, draws: $draws, lastMatchAt: $lastMatchAt, lastOutcome: $lastOutcome, recentForm: $recentForm)';
}


}

/// @nodoc
abstract mixin class _$PlayerRivalryCopyWith<$Res> implements $PlayerRivalryCopyWith<$Res> {
  factory _$PlayerRivalryCopyWith(_PlayerRivalry value, $Res Function(_PlayerRivalry) _then) = __$PlayerRivalryCopyWithImpl;
@override @useResult
$Res call({
 String rivalryId, String userId, String rivalId, int matchesPlayed, int wins, int losses, int draws, DateTime lastMatchAt, CompetitiveOutcome? lastOutcome, List<CompetitiveOutcome> recentForm
});




}
/// @nodoc
class __$PlayerRivalryCopyWithImpl<$Res>
    implements _$PlayerRivalryCopyWith<$Res> {
  __$PlayerRivalryCopyWithImpl(this._self, this._then);

  final _PlayerRivalry _self;
  final $Res Function(_PlayerRivalry) _then;

/// Create a copy of PlayerRivalry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rivalryId = null,Object? userId = null,Object? rivalId = null,Object? matchesPlayed = null,Object? wins = null,Object? losses = null,Object? draws = null,Object? lastMatchAt = null,Object? lastOutcome = freezed,Object? recentForm = null,}) {
  return _then(_PlayerRivalry(
rivalryId: null == rivalryId ? _self.rivalryId : rivalryId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rivalId: null == rivalId ? _self.rivalId : rivalId // ignore: cast_nullable_to_non_nullable
as String,matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,lastMatchAt: null == lastMatchAt ? _self.lastMatchAt : lastMatchAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as CompetitiveOutcome?,recentForm: null == recentForm ? _self._recentForm : recentForm // ignore: cast_nullable_to_non_nullable
as List<CompetitiveOutcome>,
  ));
}


}

// dart format on
