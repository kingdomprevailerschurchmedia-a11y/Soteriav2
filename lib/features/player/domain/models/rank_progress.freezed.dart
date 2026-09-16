// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankProgress {

 String get currentRank; int get currentRP; int get minimumRP; int get maximumRP; double get progressPercentage; String? get nextRank; int? get rpToNextRank; bool get isMaxRank; bool get isUnranked; RankTier get tier; int get division;
/// Create a copy of RankProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankProgressCopyWith<RankProgress> get copyWith => _$RankProgressCopyWithImpl<RankProgress>(this as RankProgress, _$identity);

  /// Serializes this RankProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankProgress&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.currentRP, currentRP) || other.currentRP == currentRP)&&(identical(other.minimumRP, minimumRP) || other.minimumRP == minimumRP)&&(identical(other.maximumRP, maximumRP) || other.maximumRP == maximumRP)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage)&&(identical(other.nextRank, nextRank) || other.nextRank == nextRank)&&(identical(other.rpToNextRank, rpToNextRank) || other.rpToNextRank == rpToNextRank)&&(identical(other.isMaxRank, isMaxRank) || other.isMaxRank == isMaxRank)&&(identical(other.isUnranked, isUnranked) || other.isUnranked == isUnranked)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.division, division) || other.division == division));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentRank,currentRP,minimumRP,maximumRP,progressPercentage,nextRank,rpToNextRank,isMaxRank,isUnranked,tier,division);

@override
String toString() {
  return 'RankProgress(currentRank: $currentRank, currentRP: $currentRP, minimumRP: $minimumRP, maximumRP: $maximumRP, progressPercentage: $progressPercentage, nextRank: $nextRank, rpToNextRank: $rpToNextRank, isMaxRank: $isMaxRank, isUnranked: $isUnranked, tier: $tier, division: $division)';
}


}

/// @nodoc
abstract mixin class $RankProgressCopyWith<$Res>  {
  factory $RankProgressCopyWith(RankProgress value, $Res Function(RankProgress) _then) = _$RankProgressCopyWithImpl;
@useResult
$Res call({
 String currentRank, int currentRP, int minimumRP, int maximumRP, double progressPercentage, String? nextRank, int? rpToNextRank, bool isMaxRank, bool isUnranked, RankTier tier, int division
});


$RankTierCopyWith<$Res> get tier;

}
/// @nodoc
class _$RankProgressCopyWithImpl<$Res>
    implements $RankProgressCopyWith<$Res> {
  _$RankProgressCopyWithImpl(this._self, this._then);

  final RankProgress _self;
  final $Res Function(RankProgress) _then;

/// Create a copy of RankProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentRank = null,Object? currentRP = null,Object? minimumRP = null,Object? maximumRP = null,Object? progressPercentage = null,Object? nextRank = freezed,Object? rpToNextRank = freezed,Object? isMaxRank = null,Object? isUnranked = null,Object? tier = null,Object? division = null,}) {
  return _then(_self.copyWith(
currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,currentRP: null == currentRP ? _self.currentRP : currentRP // ignore: cast_nullable_to_non_nullable
as int,minimumRP: null == minimumRP ? _self.minimumRP : minimumRP // ignore: cast_nullable_to_non_nullable
as int,maximumRP: null == maximumRP ? _self.maximumRP : maximumRP // ignore: cast_nullable_to_non_nullable
as int,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as double,nextRank: freezed == nextRank ? _self.nextRank : nextRank // ignore: cast_nullable_to_non_nullable
as String?,rpToNextRank: freezed == rpToNextRank ? _self.rpToNextRank : rpToNextRank // ignore: cast_nullable_to_non_nullable
as int?,isMaxRank: null == isMaxRank ? _self.isMaxRank : isMaxRank // ignore: cast_nullable_to_non_nullable
as bool,isUnranked: null == isUnranked ? _self.isUnranked : isUnranked // ignore: cast_nullable_to_non_nullable
as bool,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as RankTier,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of RankProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankTierCopyWith<$Res> get tier {
  
  return $RankTierCopyWith<$Res>(_self.tier, (value) {
    return _then(_self.copyWith(tier: value));
  });
}
}


/// Adds pattern-matching-related methods to [RankProgress].
extension RankProgressPatterns on RankProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankProgress value)  $default,){
final _that = this;
switch (_that) {
case _RankProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankProgress value)?  $default,){
final _that = this;
switch (_that) {
case _RankProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currentRank,  int currentRP,  int minimumRP,  int maximumRP,  double progressPercentage,  String? nextRank,  int? rpToNextRank,  bool isMaxRank,  bool isUnranked,  RankTier tier,  int division)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankProgress() when $default != null:
return $default(_that.currentRank,_that.currentRP,_that.minimumRP,_that.maximumRP,_that.progressPercentage,_that.nextRank,_that.rpToNextRank,_that.isMaxRank,_that.isUnranked,_that.tier,_that.division);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currentRank,  int currentRP,  int minimumRP,  int maximumRP,  double progressPercentage,  String? nextRank,  int? rpToNextRank,  bool isMaxRank,  bool isUnranked,  RankTier tier,  int division)  $default,) {final _that = this;
switch (_that) {
case _RankProgress():
return $default(_that.currentRank,_that.currentRP,_that.minimumRP,_that.maximumRP,_that.progressPercentage,_that.nextRank,_that.rpToNextRank,_that.isMaxRank,_that.isUnranked,_that.tier,_that.division);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currentRank,  int currentRP,  int minimumRP,  int maximumRP,  double progressPercentage,  String? nextRank,  int? rpToNextRank,  bool isMaxRank,  bool isUnranked,  RankTier tier,  int division)?  $default,) {final _that = this;
switch (_that) {
case _RankProgress() when $default != null:
return $default(_that.currentRank,_that.currentRP,_that.minimumRP,_that.maximumRP,_that.progressPercentage,_that.nextRank,_that.rpToNextRank,_that.isMaxRank,_that.isUnranked,_that.tier,_that.division);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankProgress implements RankProgress {
  const _RankProgress({required this.currentRank, required this.currentRP, required this.minimumRP, required this.maximumRP, required this.progressPercentage, this.nextRank, this.rpToNextRank, this.isMaxRank = false, this.isUnranked = false, required this.tier, required this.division});
  factory _RankProgress.fromJson(Map<String, dynamic> json) => _$RankProgressFromJson(json);

@override final  String currentRank;
@override final  int currentRP;
@override final  int minimumRP;
@override final  int maximumRP;
@override final  double progressPercentage;
@override final  String? nextRank;
@override final  int? rpToNextRank;
@override@JsonKey() final  bool isMaxRank;
@override@JsonKey() final  bool isUnranked;
@override final  RankTier tier;
@override final  int division;

/// Create a copy of RankProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankProgressCopyWith<_RankProgress> get copyWith => __$RankProgressCopyWithImpl<_RankProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankProgress&&(identical(other.currentRank, currentRank) || other.currentRank == currentRank)&&(identical(other.currentRP, currentRP) || other.currentRP == currentRP)&&(identical(other.minimumRP, minimumRP) || other.minimumRP == minimumRP)&&(identical(other.maximumRP, maximumRP) || other.maximumRP == maximumRP)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage)&&(identical(other.nextRank, nextRank) || other.nextRank == nextRank)&&(identical(other.rpToNextRank, rpToNextRank) || other.rpToNextRank == rpToNextRank)&&(identical(other.isMaxRank, isMaxRank) || other.isMaxRank == isMaxRank)&&(identical(other.isUnranked, isUnranked) || other.isUnranked == isUnranked)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.division, division) || other.division == division));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentRank,currentRP,minimumRP,maximumRP,progressPercentage,nextRank,rpToNextRank,isMaxRank,isUnranked,tier,division);

@override
String toString() {
  return 'RankProgress(currentRank: $currentRank, currentRP: $currentRP, minimumRP: $minimumRP, maximumRP: $maximumRP, progressPercentage: $progressPercentage, nextRank: $nextRank, rpToNextRank: $rpToNextRank, isMaxRank: $isMaxRank, isUnranked: $isUnranked, tier: $tier, division: $division)';
}


}

/// @nodoc
abstract mixin class _$RankProgressCopyWith<$Res> implements $RankProgressCopyWith<$Res> {
  factory _$RankProgressCopyWith(_RankProgress value, $Res Function(_RankProgress) _then) = __$RankProgressCopyWithImpl;
@override @useResult
$Res call({
 String currentRank, int currentRP, int minimumRP, int maximumRP, double progressPercentage, String? nextRank, int? rpToNextRank, bool isMaxRank, bool isUnranked, RankTier tier, int division
});


@override $RankTierCopyWith<$Res> get tier;

}
/// @nodoc
class __$RankProgressCopyWithImpl<$Res>
    implements _$RankProgressCopyWith<$Res> {
  __$RankProgressCopyWithImpl(this._self, this._then);

  final _RankProgress _self;
  final $Res Function(_RankProgress) _then;

/// Create a copy of RankProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentRank = null,Object? currentRP = null,Object? minimumRP = null,Object? maximumRP = null,Object? progressPercentage = null,Object? nextRank = freezed,Object? rpToNextRank = freezed,Object? isMaxRank = null,Object? isUnranked = null,Object? tier = null,Object? division = null,}) {
  return _then(_RankProgress(
currentRank: null == currentRank ? _self.currentRank : currentRank // ignore: cast_nullable_to_non_nullable
as String,currentRP: null == currentRP ? _self.currentRP : currentRP // ignore: cast_nullable_to_non_nullable
as int,minimumRP: null == minimumRP ? _self.minimumRP : minimumRP // ignore: cast_nullable_to_non_nullable
as int,maximumRP: null == maximumRP ? _self.maximumRP : maximumRP // ignore: cast_nullable_to_non_nullable
as int,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as double,nextRank: freezed == nextRank ? _self.nextRank : nextRank // ignore: cast_nullable_to_non_nullable
as String?,rpToNextRank: freezed == rpToNextRank ? _self.rpToNextRank : rpToNextRank // ignore: cast_nullable_to_non_nullable
as int?,isMaxRank: null == isMaxRank ? _self.isMaxRank : isMaxRank // ignore: cast_nullable_to_non_nullable
as bool,isUnranked: null == isUnranked ? _self.isUnranked : isUnranked // ignore: cast_nullable_to_non_nullable
as bool,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as RankTier,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RankProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankTierCopyWith<$Res> get tier {
  
  return $RankTierCopyWith<$Res>(_self.tier, (value) {
    return _then(_self.copyWith(tier: value));
  });
}
}

// dart format on
