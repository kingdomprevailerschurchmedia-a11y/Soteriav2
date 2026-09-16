// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Wallet {

 String get userId; int get coins; int get tokens; int get lifetimeCoinsEarned; int get lifetimeCoinsSpent; int get lifetimeTokensEarned; int get lifetimeTokensSpent; bool get isPro; DateTime? get proExpiresAt; String? get lastTransactionId; DateTime? get updatedAt;
/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletCopyWith<Wallet> get copyWith => _$WalletCopyWithImpl<Wallet>(this as Wallet, _$identity);

  /// Serializes this Wallet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Wallet&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.lifetimeCoinsEarned, lifetimeCoinsEarned) || other.lifetimeCoinsEarned == lifetimeCoinsEarned)&&(identical(other.lifetimeCoinsSpent, lifetimeCoinsSpent) || other.lifetimeCoinsSpent == lifetimeCoinsSpent)&&(identical(other.lifetimeTokensEarned, lifetimeTokensEarned) || other.lifetimeTokensEarned == lifetimeTokensEarned)&&(identical(other.lifetimeTokensSpent, lifetimeTokensSpent) || other.lifetimeTokensSpent == lifetimeTokensSpent)&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.proExpiresAt, proExpiresAt) || other.proExpiresAt == proExpiresAt)&&(identical(other.lastTransactionId, lastTransactionId) || other.lastTransactionId == lastTransactionId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,coins,tokens,lifetimeCoinsEarned,lifetimeCoinsSpent,lifetimeTokensEarned,lifetimeTokensSpent,isPro,proExpiresAt,lastTransactionId,updatedAt);

@override
String toString() {
  return 'Wallet(userId: $userId, coins: $coins, tokens: $tokens, lifetimeCoinsEarned: $lifetimeCoinsEarned, lifetimeCoinsSpent: $lifetimeCoinsSpent, lifetimeTokensEarned: $lifetimeTokensEarned, lifetimeTokensSpent: $lifetimeTokensSpent, isPro: $isPro, proExpiresAt: $proExpiresAt, lastTransactionId: $lastTransactionId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WalletCopyWith<$Res>  {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) _then) = _$WalletCopyWithImpl;
@useResult
$Res call({
 String userId, int coins, int tokens, int lifetimeCoinsEarned, int lifetimeCoinsSpent, int lifetimeTokensEarned, int lifetimeTokensSpent, bool isPro, DateTime? proExpiresAt, String? lastTransactionId, DateTime? updatedAt
});




}
/// @nodoc
class _$WalletCopyWithImpl<$Res>
    implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._self, this._then);

  final Wallet _self;
  final $Res Function(Wallet) _then;

/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? coins = null,Object? tokens = null,Object? lifetimeCoinsEarned = null,Object? lifetimeCoinsSpent = null,Object? lifetimeTokensEarned = null,Object? lifetimeTokensSpent = null,Object? isPro = null,Object? proExpiresAt = freezed,Object? lastTransactionId = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as int,lifetimeCoinsEarned: null == lifetimeCoinsEarned ? _self.lifetimeCoinsEarned : lifetimeCoinsEarned // ignore: cast_nullable_to_non_nullable
as int,lifetimeCoinsSpent: null == lifetimeCoinsSpent ? _self.lifetimeCoinsSpent : lifetimeCoinsSpent // ignore: cast_nullable_to_non_nullable
as int,lifetimeTokensEarned: null == lifetimeTokensEarned ? _self.lifetimeTokensEarned : lifetimeTokensEarned // ignore: cast_nullable_to_non_nullable
as int,lifetimeTokensSpent: null == lifetimeTokensSpent ? _self.lifetimeTokensSpent : lifetimeTokensSpent // ignore: cast_nullable_to_non_nullable
as int,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,proExpiresAt: freezed == proExpiresAt ? _self.proExpiresAt : proExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastTransactionId: freezed == lastTransactionId ? _self.lastTransactionId : lastTransactionId // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Wallet].
extension WalletPatterns on Wallet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Wallet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Wallet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Wallet value)  $default,){
final _that = this;
switch (_that) {
case _Wallet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Wallet value)?  $default,){
final _that = this;
switch (_that) {
case _Wallet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int coins,  int tokens,  int lifetimeCoinsEarned,  int lifetimeCoinsSpent,  int lifetimeTokensEarned,  int lifetimeTokensSpent,  bool isPro,  DateTime? proExpiresAt,  String? lastTransactionId,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Wallet() when $default != null:
return $default(_that.userId,_that.coins,_that.tokens,_that.lifetimeCoinsEarned,_that.lifetimeCoinsSpent,_that.lifetimeTokensEarned,_that.lifetimeTokensSpent,_that.isPro,_that.proExpiresAt,_that.lastTransactionId,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int coins,  int tokens,  int lifetimeCoinsEarned,  int lifetimeCoinsSpent,  int lifetimeTokensEarned,  int lifetimeTokensSpent,  bool isPro,  DateTime? proExpiresAt,  String? lastTransactionId,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Wallet():
return $default(_that.userId,_that.coins,_that.tokens,_that.lifetimeCoinsEarned,_that.lifetimeCoinsSpent,_that.lifetimeTokensEarned,_that.lifetimeTokensSpent,_that.isPro,_that.proExpiresAt,_that.lastTransactionId,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int coins,  int tokens,  int lifetimeCoinsEarned,  int lifetimeCoinsSpent,  int lifetimeTokensEarned,  int lifetimeTokensSpent,  bool isPro,  DateTime? proExpiresAt,  String? lastTransactionId,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Wallet() when $default != null:
return $default(_that.userId,_that.coins,_that.tokens,_that.lifetimeCoinsEarned,_that.lifetimeCoinsSpent,_that.lifetimeTokensEarned,_that.lifetimeTokensSpent,_that.isPro,_that.proExpiresAt,_that.lastTransactionId,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Wallet extends Wallet {
  const _Wallet({required this.userId, this.coins = 0, this.tokens = 0, this.lifetimeCoinsEarned = 0, this.lifetimeCoinsSpent = 0, this.lifetimeTokensEarned = 0, this.lifetimeTokensSpent = 0, this.isPro = false, this.proExpiresAt, this.lastTransactionId, this.updatedAt}): super._();
  factory _Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

@override final  String userId;
@override@JsonKey() final  int coins;
@override@JsonKey() final  int tokens;
@override@JsonKey() final  int lifetimeCoinsEarned;
@override@JsonKey() final  int lifetimeCoinsSpent;
@override@JsonKey() final  int lifetimeTokensEarned;
@override@JsonKey() final  int lifetimeTokensSpent;
@override@JsonKey() final  bool isPro;
@override final  DateTime? proExpiresAt;
@override final  String? lastTransactionId;
@override final  DateTime? updatedAt;

/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletCopyWith<_Wallet> get copyWith => __$WalletCopyWithImpl<_Wallet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Wallet&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.lifetimeCoinsEarned, lifetimeCoinsEarned) || other.lifetimeCoinsEarned == lifetimeCoinsEarned)&&(identical(other.lifetimeCoinsSpent, lifetimeCoinsSpent) || other.lifetimeCoinsSpent == lifetimeCoinsSpent)&&(identical(other.lifetimeTokensEarned, lifetimeTokensEarned) || other.lifetimeTokensEarned == lifetimeTokensEarned)&&(identical(other.lifetimeTokensSpent, lifetimeTokensSpent) || other.lifetimeTokensSpent == lifetimeTokensSpent)&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.proExpiresAt, proExpiresAt) || other.proExpiresAt == proExpiresAt)&&(identical(other.lastTransactionId, lastTransactionId) || other.lastTransactionId == lastTransactionId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,coins,tokens,lifetimeCoinsEarned,lifetimeCoinsSpent,lifetimeTokensEarned,lifetimeTokensSpent,isPro,proExpiresAt,lastTransactionId,updatedAt);

@override
String toString() {
  return 'Wallet(userId: $userId, coins: $coins, tokens: $tokens, lifetimeCoinsEarned: $lifetimeCoinsEarned, lifetimeCoinsSpent: $lifetimeCoinsSpent, lifetimeTokensEarned: $lifetimeTokensEarned, lifetimeTokensSpent: $lifetimeTokensSpent, isPro: $isPro, proExpiresAt: $proExpiresAt, lastTransactionId: $lastTransactionId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WalletCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$WalletCopyWith(_Wallet value, $Res Function(_Wallet) _then) = __$WalletCopyWithImpl;
@override @useResult
$Res call({
 String userId, int coins, int tokens, int lifetimeCoinsEarned, int lifetimeCoinsSpent, int lifetimeTokensEarned, int lifetimeTokensSpent, bool isPro, DateTime? proExpiresAt, String? lastTransactionId, DateTime? updatedAt
});




}
/// @nodoc
class __$WalletCopyWithImpl<$Res>
    implements _$WalletCopyWith<$Res> {
  __$WalletCopyWithImpl(this._self, this._then);

  final _Wallet _self;
  final $Res Function(_Wallet) _then;

/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? coins = null,Object? tokens = null,Object? lifetimeCoinsEarned = null,Object? lifetimeCoinsSpent = null,Object? lifetimeTokensEarned = null,Object? lifetimeTokensSpent = null,Object? isPro = null,Object? proExpiresAt = freezed,Object? lastTransactionId = freezed,Object? updatedAt = freezed,}) {
  return _then(_Wallet(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as int,lifetimeCoinsEarned: null == lifetimeCoinsEarned ? _self.lifetimeCoinsEarned : lifetimeCoinsEarned // ignore: cast_nullable_to_non_nullable
as int,lifetimeCoinsSpent: null == lifetimeCoinsSpent ? _self.lifetimeCoinsSpent : lifetimeCoinsSpent // ignore: cast_nullable_to_non_nullable
as int,lifetimeTokensEarned: null == lifetimeTokensEarned ? _self.lifetimeTokensEarned : lifetimeTokensEarned // ignore: cast_nullable_to_non_nullable
as int,lifetimeTokensSpent: null == lifetimeTokensSpent ? _self.lifetimeTokensSpent : lifetimeTokensSpent // ignore: cast_nullable_to_non_nullable
as int,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,proExpiresAt: freezed == proExpiresAt ? _self.proExpiresAt : proExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastTransactionId: freezed == lastTransactionId ? _self.lastTransactionId : lastTransactionId // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
