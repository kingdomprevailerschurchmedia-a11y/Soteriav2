// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerProfile {

 String get uid; String get displayName; String get username; String get email; String get photoUrl; String get selectedAvatarId;// Progression
 int get level; int get xp;/// Authoritative balance has moved to the [Wallet] model.
/// Use [currentWalletProvider] or [walletServiceProvider] instead.
/// This field is kept for backward compatibility during migration.
@Deprecated('Use Wallet model instead for authoritative coin balance') int get coins; int get withdrawableCoins; String? get lastCoinTransactionId; String? get lastXpTransactionId; String? get lastRankTransactionId;// Stats
 int get currentStreak; int get highestStreak; int get lastStreakMilestoneCelebrated; int get totalQuestionsAnswered; int get correctAnswers; double get accuracy;// Match History
 int get gamesPlayed; int get gamesWon; int get practiceSessions; int get dailyPracticeSessionsPlayed;@TimestampConverter() DateTime? get lastPracticeSessionDate; int get proSessions; int get dailyProSessionsPlayed;@TimestampConverter() DateTime? get lastProSessionDate; int get versusMatches; int get tournamentMatches;// Customization & Metadata
 List<String> get favoriteCategories; String get preferredLanguage; String get avatarFrame; List<String> get badges; List<String> get achievements; String? get equippedTitleId; List<String> get featuredBadgeIds; bool get allowVersusChallenges; String get role;// user, moderator, admin
 String get accountStatus;// active, suspended, deleted
@TimestampConverter() DateTime? get lastDailyRewardClaim; int get registrationOrder;@RequiredTimestampConverter() DateTime get createdAt;@RequiredTimestampConverter() DateTime get lastLogin;@RequiredTimestampConverter() DateTime get updatedAt; Map<String, dynamic> get settings; int get version;
/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<PlayerProfile> get copyWith => _$PlayerProfileCopyWithImpl<PlayerProfile>(this as PlayerProfile, _$identity);

  /// Serializes this PlayerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.selectedAvatarId, selectedAvatarId) || other.selectedAvatarId == selectedAvatarId)&&(identical(other.level, level) || other.level == level)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.withdrawableCoins, withdrawableCoins) || other.withdrawableCoins == withdrawableCoins)&&(identical(other.lastCoinTransactionId, lastCoinTransactionId) || other.lastCoinTransactionId == lastCoinTransactionId)&&(identical(other.lastXpTransactionId, lastXpTransactionId) || other.lastXpTransactionId == lastXpTransactionId)&&(identical(other.lastRankTransactionId, lastRankTransactionId) || other.lastRankTransactionId == lastRankTransactionId)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.highestStreak, highestStreak) || other.highestStreak == highestStreak)&&(identical(other.lastStreakMilestoneCelebrated, lastStreakMilestoneCelebrated) || other.lastStreakMilestoneCelebrated == lastStreakMilestoneCelebrated)&&(identical(other.totalQuestionsAnswered, totalQuestionsAnswered) || other.totalQuestionsAnswered == totalQuestionsAnswered)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.practiceSessions, practiceSessions) || other.practiceSessions == practiceSessions)&&(identical(other.dailyPracticeSessionsPlayed, dailyPracticeSessionsPlayed) || other.dailyPracticeSessionsPlayed == dailyPracticeSessionsPlayed)&&(identical(other.lastPracticeSessionDate, lastPracticeSessionDate) || other.lastPracticeSessionDate == lastPracticeSessionDate)&&(identical(other.proSessions, proSessions) || other.proSessions == proSessions)&&(identical(other.dailyProSessionsPlayed, dailyProSessionsPlayed) || other.dailyProSessionsPlayed == dailyProSessionsPlayed)&&(identical(other.lastProSessionDate, lastProSessionDate) || other.lastProSessionDate == lastProSessionDate)&&(identical(other.versusMatches, versusMatches) || other.versusMatches == versusMatches)&&(identical(other.tournamentMatches, tournamentMatches) || other.tournamentMatches == tournamentMatches)&&const DeepCollectionEquality().equals(other.favoriteCategories, favoriteCategories)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.avatarFrame, avatarFrame) || other.avatarFrame == avatarFrame)&&const DeepCollectionEquality().equals(other.badges, badges)&&const DeepCollectionEquality().equals(other.achievements, achievements)&&(identical(other.equippedTitleId, equippedTitleId) || other.equippedTitleId == equippedTitleId)&&const DeepCollectionEquality().equals(other.featuredBadgeIds, featuredBadgeIds)&&(identical(other.allowVersusChallenges, allowVersusChallenges) || other.allowVersusChallenges == allowVersusChallenges)&&(identical(other.role, role) || other.role == role)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.lastDailyRewardClaim, lastDailyRewardClaim) || other.lastDailyRewardClaim == lastDailyRewardClaim)&&(identical(other.registrationOrder, registrationOrder) || other.registrationOrder == registrationOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,displayName,username,email,photoUrl,selectedAvatarId,level,xp,coins,withdrawableCoins,lastCoinTransactionId,lastXpTransactionId,lastRankTransactionId,currentStreak,highestStreak,lastStreakMilestoneCelebrated,totalQuestionsAnswered,correctAnswers,accuracy,gamesPlayed,gamesWon,practiceSessions,dailyPracticeSessionsPlayed,lastPracticeSessionDate,proSessions,dailyProSessionsPlayed,lastProSessionDate,versusMatches,tournamentMatches,const DeepCollectionEquality().hash(favoriteCategories),preferredLanguage,avatarFrame,const DeepCollectionEquality().hash(badges),const DeepCollectionEquality().hash(achievements),equippedTitleId,const DeepCollectionEquality().hash(featuredBadgeIds),allowVersusChallenges,role,accountStatus,lastDailyRewardClaim,registrationOrder,createdAt,lastLogin,updatedAt,const DeepCollectionEquality().hash(settings),version]);

@override
String toString() {
  return 'PlayerProfile(uid: $uid, displayName: $displayName, username: $username, email: $email, photoUrl: $photoUrl, selectedAvatarId: $selectedAvatarId, level: $level, xp: $xp, coins: $coins, withdrawableCoins: $withdrawableCoins, lastCoinTransactionId: $lastCoinTransactionId, lastXpTransactionId: $lastXpTransactionId, lastRankTransactionId: $lastRankTransactionId, currentStreak: $currentStreak, highestStreak: $highestStreak, lastStreakMilestoneCelebrated: $lastStreakMilestoneCelebrated, totalQuestionsAnswered: $totalQuestionsAnswered, correctAnswers: $correctAnswers, accuracy: $accuracy, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, practiceSessions: $practiceSessions, dailyPracticeSessionsPlayed: $dailyPracticeSessionsPlayed, lastPracticeSessionDate: $lastPracticeSessionDate, proSessions: $proSessions, dailyProSessionsPlayed: $dailyProSessionsPlayed, lastProSessionDate: $lastProSessionDate, versusMatches: $versusMatches, tournamentMatches: $tournamentMatches, favoriteCategories: $favoriteCategories, preferredLanguage: $preferredLanguage, avatarFrame: $avatarFrame, badges: $badges, achievements: $achievements, equippedTitleId: $equippedTitleId, featuredBadgeIds: $featuredBadgeIds, allowVersusChallenges: $allowVersusChallenges, role: $role, accountStatus: $accountStatus, lastDailyRewardClaim: $lastDailyRewardClaim, registrationOrder: $registrationOrder, createdAt: $createdAt, lastLogin: $lastLogin, updatedAt: $updatedAt, settings: $settings, version: $version)';
}


}

/// @nodoc
abstract mixin class $PlayerProfileCopyWith<$Res>  {
  factory $PlayerProfileCopyWith(PlayerProfile value, $Res Function(PlayerProfile) _then) = _$PlayerProfileCopyWithImpl;
@useResult
$Res call({
 String uid, String displayName, String username, String email, String photoUrl, String selectedAvatarId, int level, int xp,@Deprecated('Use Wallet model instead for authoritative coin balance') int coins, int withdrawableCoins, String? lastCoinTransactionId, String? lastXpTransactionId, String? lastRankTransactionId, int currentStreak, int highestStreak, int lastStreakMilestoneCelebrated, int totalQuestionsAnswered, int correctAnswers, double accuracy, int gamesPlayed, int gamesWon, int practiceSessions, int dailyPracticeSessionsPlayed,@TimestampConverter() DateTime? lastPracticeSessionDate, int proSessions, int dailyProSessionsPlayed,@TimestampConverter() DateTime? lastProSessionDate, int versusMatches, int tournamentMatches, List<String> favoriteCategories, String preferredLanguage, String avatarFrame, List<String> badges, List<String> achievements, String? equippedTitleId, List<String> featuredBadgeIds, bool allowVersusChallenges, String role, String accountStatus,@TimestampConverter() DateTime? lastDailyRewardClaim, int registrationOrder,@RequiredTimestampConverter() DateTime createdAt,@RequiredTimestampConverter() DateTime lastLogin,@RequiredTimestampConverter() DateTime updatedAt, Map<String, dynamic> settings, int version
});




}
/// @nodoc
class _$PlayerProfileCopyWithImpl<$Res>
    implements $PlayerProfileCopyWith<$Res> {
  _$PlayerProfileCopyWithImpl(this._self, this._then);

  final PlayerProfile _self;
  final $Res Function(PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? displayName = null,Object? username = null,Object? email = null,Object? photoUrl = null,Object? selectedAvatarId = null,Object? level = null,Object? xp = null,Object? coins = null,Object? withdrawableCoins = null,Object? lastCoinTransactionId = freezed,Object? lastXpTransactionId = freezed,Object? lastRankTransactionId = freezed,Object? currentStreak = null,Object? highestStreak = null,Object? lastStreakMilestoneCelebrated = null,Object? totalQuestionsAnswered = null,Object? correctAnswers = null,Object? accuracy = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? practiceSessions = null,Object? dailyPracticeSessionsPlayed = null,Object? lastPracticeSessionDate = freezed,Object? proSessions = null,Object? dailyProSessionsPlayed = null,Object? lastProSessionDate = freezed,Object? versusMatches = null,Object? tournamentMatches = null,Object? favoriteCategories = null,Object? preferredLanguage = null,Object? avatarFrame = null,Object? badges = null,Object? achievements = null,Object? equippedTitleId = freezed,Object? featuredBadgeIds = null,Object? allowVersusChallenges = null,Object? role = null,Object? accountStatus = null,Object? lastDailyRewardClaim = freezed,Object? registrationOrder = null,Object? createdAt = null,Object? lastLogin = null,Object? updatedAt = null,Object? settings = null,Object? version = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,selectedAvatarId: null == selectedAvatarId ? _self.selectedAvatarId : selectedAvatarId // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,withdrawableCoins: null == withdrawableCoins ? _self.withdrawableCoins : withdrawableCoins // ignore: cast_nullable_to_non_nullable
as int,lastCoinTransactionId: freezed == lastCoinTransactionId ? _self.lastCoinTransactionId : lastCoinTransactionId // ignore: cast_nullable_to_non_nullable
as String?,lastXpTransactionId: freezed == lastXpTransactionId ? _self.lastXpTransactionId : lastXpTransactionId // ignore: cast_nullable_to_non_nullable
as String?,lastRankTransactionId: freezed == lastRankTransactionId ? _self.lastRankTransactionId : lastRankTransactionId // ignore: cast_nullable_to_non_nullable
as String?,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,highestStreak: null == highestStreak ? _self.highestStreak : highestStreak // ignore: cast_nullable_to_non_nullable
as int,lastStreakMilestoneCelebrated: null == lastStreakMilestoneCelebrated ? _self.lastStreakMilestoneCelebrated : lastStreakMilestoneCelebrated // ignore: cast_nullable_to_non_nullable
as int,totalQuestionsAnswered: null == totalQuestionsAnswered ? _self.totalQuestionsAnswered : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,practiceSessions: null == practiceSessions ? _self.practiceSessions : practiceSessions // ignore: cast_nullable_to_non_nullable
as int,dailyPracticeSessionsPlayed: null == dailyPracticeSessionsPlayed ? _self.dailyPracticeSessionsPlayed : dailyPracticeSessionsPlayed // ignore: cast_nullable_to_non_nullable
as int,lastPracticeSessionDate: freezed == lastPracticeSessionDate ? _self.lastPracticeSessionDate : lastPracticeSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,proSessions: null == proSessions ? _self.proSessions : proSessions // ignore: cast_nullable_to_non_nullable
as int,dailyProSessionsPlayed: null == dailyProSessionsPlayed ? _self.dailyProSessionsPlayed : dailyProSessionsPlayed // ignore: cast_nullable_to_non_nullable
as int,lastProSessionDate: freezed == lastProSessionDate ? _self.lastProSessionDate : lastProSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,versusMatches: null == versusMatches ? _self.versusMatches : versusMatches // ignore: cast_nullable_to_non_nullable
as int,tournamentMatches: null == tournamentMatches ? _self.tournamentMatches : tournamentMatches // ignore: cast_nullable_to_non_nullable
as int,favoriteCategories: null == favoriteCategories ? _self.favoriteCategories : favoriteCategories // ignore: cast_nullable_to_non_nullable
as List<String>,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,avatarFrame: null == avatarFrame ? _self.avatarFrame : avatarFrame // ignore: cast_nullable_to_non_nullable
as String,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>,equippedTitleId: freezed == equippedTitleId ? _self.equippedTitleId : equippedTitleId // ignore: cast_nullable_to_non_nullable
as String?,featuredBadgeIds: null == featuredBadgeIds ? _self.featuredBadgeIds : featuredBadgeIds // ignore: cast_nullable_to_non_nullable
as List<String>,allowVersusChallenges: null == allowVersusChallenges ? _self.allowVersusChallenges : allowVersusChallenges // ignore: cast_nullable_to_non_nullable
as bool,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,accountStatus: null == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as String,lastDailyRewardClaim: freezed == lastDailyRewardClaim ? _self.lastDailyRewardClaim : lastDailyRewardClaim // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationOrder: null == registrationOrder ? _self.registrationOrder : registrationOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLogin: null == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerProfile].
extension PlayerProfilePatterns on PlayerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerProfile value)  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String displayName,  String username,  String email,  String photoUrl,  String selectedAvatarId,  int level,  int xp, @Deprecated('Use Wallet model instead for authoritative coin balance')  int coins,  int withdrawableCoins,  String? lastCoinTransactionId,  String? lastXpTransactionId,  String? lastRankTransactionId,  int currentStreak,  int highestStreak,  int lastStreakMilestoneCelebrated,  int totalQuestionsAnswered,  int correctAnswers,  double accuracy,  int gamesPlayed,  int gamesWon,  int practiceSessions,  int dailyPracticeSessionsPlayed, @TimestampConverter()  DateTime? lastPracticeSessionDate,  int proSessions,  int dailyProSessionsPlayed, @TimestampConverter()  DateTime? lastProSessionDate,  int versusMatches,  int tournamentMatches,  List<String> favoriteCategories,  String preferredLanguage,  String avatarFrame,  List<String> badges,  List<String> achievements,  String? equippedTitleId,  List<String> featuredBadgeIds,  bool allowVersusChallenges,  String role,  String accountStatus, @TimestampConverter()  DateTime? lastDailyRewardClaim,  int registrationOrder, @RequiredTimestampConverter()  DateTime createdAt, @RequiredTimestampConverter()  DateTime lastLogin, @RequiredTimestampConverter()  DateTime updatedAt,  Map<String, dynamic> settings,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.uid,_that.displayName,_that.username,_that.email,_that.photoUrl,_that.selectedAvatarId,_that.level,_that.xp,_that.coins,_that.withdrawableCoins,_that.lastCoinTransactionId,_that.lastXpTransactionId,_that.lastRankTransactionId,_that.currentStreak,_that.highestStreak,_that.lastStreakMilestoneCelebrated,_that.totalQuestionsAnswered,_that.correctAnswers,_that.accuracy,_that.gamesPlayed,_that.gamesWon,_that.practiceSessions,_that.dailyPracticeSessionsPlayed,_that.lastPracticeSessionDate,_that.proSessions,_that.dailyProSessionsPlayed,_that.lastProSessionDate,_that.versusMatches,_that.tournamentMatches,_that.favoriteCategories,_that.preferredLanguage,_that.avatarFrame,_that.badges,_that.achievements,_that.equippedTitleId,_that.featuredBadgeIds,_that.allowVersusChallenges,_that.role,_that.accountStatus,_that.lastDailyRewardClaim,_that.registrationOrder,_that.createdAt,_that.lastLogin,_that.updatedAt,_that.settings,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String displayName,  String username,  String email,  String photoUrl,  String selectedAvatarId,  int level,  int xp, @Deprecated('Use Wallet model instead for authoritative coin balance')  int coins,  int withdrawableCoins,  String? lastCoinTransactionId,  String? lastXpTransactionId,  String? lastRankTransactionId,  int currentStreak,  int highestStreak,  int lastStreakMilestoneCelebrated,  int totalQuestionsAnswered,  int correctAnswers,  double accuracy,  int gamesPlayed,  int gamesWon,  int practiceSessions,  int dailyPracticeSessionsPlayed, @TimestampConverter()  DateTime? lastPracticeSessionDate,  int proSessions,  int dailyProSessionsPlayed, @TimestampConverter()  DateTime? lastProSessionDate,  int versusMatches,  int tournamentMatches,  List<String> favoriteCategories,  String preferredLanguage,  String avatarFrame,  List<String> badges,  List<String> achievements,  String? equippedTitleId,  List<String> featuredBadgeIds,  bool allowVersusChallenges,  String role,  String accountStatus, @TimestampConverter()  DateTime? lastDailyRewardClaim,  int registrationOrder, @RequiredTimestampConverter()  DateTime createdAt, @RequiredTimestampConverter()  DateTime lastLogin, @RequiredTimestampConverter()  DateTime updatedAt,  Map<String, dynamic> settings,  int version)  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile():
return $default(_that.uid,_that.displayName,_that.username,_that.email,_that.photoUrl,_that.selectedAvatarId,_that.level,_that.xp,_that.coins,_that.withdrawableCoins,_that.lastCoinTransactionId,_that.lastXpTransactionId,_that.lastRankTransactionId,_that.currentStreak,_that.highestStreak,_that.lastStreakMilestoneCelebrated,_that.totalQuestionsAnswered,_that.correctAnswers,_that.accuracy,_that.gamesPlayed,_that.gamesWon,_that.practiceSessions,_that.dailyPracticeSessionsPlayed,_that.lastPracticeSessionDate,_that.proSessions,_that.dailyProSessionsPlayed,_that.lastProSessionDate,_that.versusMatches,_that.tournamentMatches,_that.favoriteCategories,_that.preferredLanguage,_that.avatarFrame,_that.badges,_that.achievements,_that.equippedTitleId,_that.featuredBadgeIds,_that.allowVersusChallenges,_that.role,_that.accountStatus,_that.lastDailyRewardClaim,_that.registrationOrder,_that.createdAt,_that.lastLogin,_that.updatedAt,_that.settings,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String displayName,  String username,  String email,  String photoUrl,  String selectedAvatarId,  int level,  int xp, @Deprecated('Use Wallet model instead for authoritative coin balance')  int coins,  int withdrawableCoins,  String? lastCoinTransactionId,  String? lastXpTransactionId,  String? lastRankTransactionId,  int currentStreak,  int highestStreak,  int lastStreakMilestoneCelebrated,  int totalQuestionsAnswered,  int correctAnswers,  double accuracy,  int gamesPlayed,  int gamesWon,  int practiceSessions,  int dailyPracticeSessionsPlayed, @TimestampConverter()  DateTime? lastPracticeSessionDate,  int proSessions,  int dailyProSessionsPlayed, @TimestampConverter()  DateTime? lastProSessionDate,  int versusMatches,  int tournamentMatches,  List<String> favoriteCategories,  String preferredLanguage,  String avatarFrame,  List<String> badges,  List<String> achievements,  String? equippedTitleId,  List<String> featuredBadgeIds,  bool allowVersusChallenges,  String role,  String accountStatus, @TimestampConverter()  DateTime? lastDailyRewardClaim,  int registrationOrder, @RequiredTimestampConverter()  DateTime createdAt, @RequiredTimestampConverter()  DateTime lastLogin, @RequiredTimestampConverter()  DateTime updatedAt,  Map<String, dynamic> settings,  int version)?  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.uid,_that.displayName,_that.username,_that.email,_that.photoUrl,_that.selectedAvatarId,_that.level,_that.xp,_that.coins,_that.withdrawableCoins,_that.lastCoinTransactionId,_that.lastXpTransactionId,_that.lastRankTransactionId,_that.currentStreak,_that.highestStreak,_that.lastStreakMilestoneCelebrated,_that.totalQuestionsAnswered,_that.correctAnswers,_that.accuracy,_that.gamesPlayed,_that.gamesWon,_that.practiceSessions,_that.dailyPracticeSessionsPlayed,_that.lastPracticeSessionDate,_that.proSessions,_that.dailyProSessionsPlayed,_that.lastProSessionDate,_that.versusMatches,_that.tournamentMatches,_that.favoriteCategories,_that.preferredLanguage,_that.avatarFrame,_that.badges,_that.achievements,_that.equippedTitleId,_that.featuredBadgeIds,_that.allowVersusChallenges,_that.role,_that.accountStatus,_that.lastDailyRewardClaim,_that.registrationOrder,_that.createdAt,_that.lastLogin,_that.updatedAt,_that.settings,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerProfile extends PlayerProfile {
  const _PlayerProfile({required this.uid, required this.displayName, this.username = '', required this.email, this.photoUrl = '', this.selectedAvatarId = 'socrates', this.level = 1, this.xp = 0, @Deprecated('Use Wallet model instead for authoritative coin balance') this.coins = 0, this.withdrawableCoins = 0, this.lastCoinTransactionId, this.lastXpTransactionId, this.lastRankTransactionId, this.currentStreak = 0, this.highestStreak = 0, this.lastStreakMilestoneCelebrated = 0, this.totalQuestionsAnswered = 0, this.correctAnswers = 0, this.accuracy = 0.0, this.gamesPlayed = 0, this.gamesWon = 0, this.practiceSessions = 0, this.dailyPracticeSessionsPlayed = 0, @TimestampConverter() this.lastPracticeSessionDate, this.proSessions = 0, this.dailyProSessionsPlayed = 0, @TimestampConverter() this.lastProSessionDate, this.versusMatches = 0, this.tournamentMatches = 0, final  List<String> favoriteCategories = const [], this.preferredLanguage = 'en', this.avatarFrame = 'default', final  List<String> badges = const [], final  List<String> achievements = const [], this.equippedTitleId, final  List<String> featuredBadgeIds = const [], this.allowVersusChallenges = true, this.role = 'user', this.accountStatus = 'active', @TimestampConverter() this.lastDailyRewardClaim, this.registrationOrder = 0, @RequiredTimestampConverter() required this.createdAt, @RequiredTimestampConverter() required this.lastLogin, @RequiredTimestampConverter() required this.updatedAt, final  Map<String, dynamic> settings = const {}, this.version = 1}): _favoriteCategories = favoriteCategories,_badges = badges,_achievements = achievements,_featuredBadgeIds = featuredBadgeIds,_settings = settings,super._();
  factory _PlayerProfile.fromJson(Map<String, dynamic> json) => _$PlayerProfileFromJson(json);

@override final  String uid;
@override final  String displayName;
@override@JsonKey() final  String username;
@override final  String email;
@override@JsonKey() final  String photoUrl;
@override@JsonKey() final  String selectedAvatarId;
// Progression
@override@JsonKey() final  int level;
@override@JsonKey() final  int xp;
/// Authoritative balance has moved to the [Wallet] model.
/// Use [currentWalletProvider] or [walletServiceProvider] instead.
/// This field is kept for backward compatibility during migration.
@override@JsonKey()@Deprecated('Use Wallet model instead for authoritative coin balance') final  int coins;
@override@JsonKey() final  int withdrawableCoins;
@override final  String? lastCoinTransactionId;
@override final  String? lastXpTransactionId;
@override final  String? lastRankTransactionId;
// Stats
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int highestStreak;
@override@JsonKey() final  int lastStreakMilestoneCelebrated;
@override@JsonKey() final  int totalQuestionsAnswered;
@override@JsonKey() final  int correctAnswers;
@override@JsonKey() final  double accuracy;
// Match History
@override@JsonKey() final  int gamesPlayed;
@override@JsonKey() final  int gamesWon;
@override@JsonKey() final  int practiceSessions;
@override@JsonKey() final  int dailyPracticeSessionsPlayed;
@override@TimestampConverter() final  DateTime? lastPracticeSessionDate;
@override@JsonKey() final  int proSessions;
@override@JsonKey() final  int dailyProSessionsPlayed;
@override@TimestampConverter() final  DateTime? lastProSessionDate;
@override@JsonKey() final  int versusMatches;
@override@JsonKey() final  int tournamentMatches;
// Customization & Metadata
 final  List<String> _favoriteCategories;
// Customization & Metadata
@override@JsonKey() List<String> get favoriteCategories {
  if (_favoriteCategories is EqualUnmodifiableListView) return _favoriteCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteCategories);
}

@override@JsonKey() final  String preferredLanguage;
@override@JsonKey() final  String avatarFrame;
 final  List<String> _badges;
@override@JsonKey() List<String> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

 final  List<String> _achievements;
@override@JsonKey() List<String> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}

@override final  String? equippedTitleId;
 final  List<String> _featuredBadgeIds;
@override@JsonKey() List<String> get featuredBadgeIds {
  if (_featuredBadgeIds is EqualUnmodifiableListView) return _featuredBadgeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredBadgeIds);
}

@override@JsonKey() final  bool allowVersusChallenges;
@override@JsonKey() final  String role;
// user, moderator, admin
@override@JsonKey() final  String accountStatus;
// active, suspended, deleted
@override@TimestampConverter() final  DateTime? lastDailyRewardClaim;
@override@JsonKey() final  int registrationOrder;
@override@RequiredTimestampConverter() final  DateTime createdAt;
@override@RequiredTimestampConverter() final  DateTime lastLogin;
@override@RequiredTimestampConverter() final  DateTime updatedAt;
 final  Map<String, dynamic> _settings;
@override@JsonKey() Map<String, dynamic> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}

@override@JsonKey() final  int version;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerProfileCopyWith<_PlayerProfile> get copyWith => __$PlayerProfileCopyWithImpl<_PlayerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.selectedAvatarId, selectedAvatarId) || other.selectedAvatarId == selectedAvatarId)&&(identical(other.level, level) || other.level == level)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.withdrawableCoins, withdrawableCoins) || other.withdrawableCoins == withdrawableCoins)&&(identical(other.lastCoinTransactionId, lastCoinTransactionId) || other.lastCoinTransactionId == lastCoinTransactionId)&&(identical(other.lastXpTransactionId, lastXpTransactionId) || other.lastXpTransactionId == lastXpTransactionId)&&(identical(other.lastRankTransactionId, lastRankTransactionId) || other.lastRankTransactionId == lastRankTransactionId)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.highestStreak, highestStreak) || other.highestStreak == highestStreak)&&(identical(other.lastStreakMilestoneCelebrated, lastStreakMilestoneCelebrated) || other.lastStreakMilestoneCelebrated == lastStreakMilestoneCelebrated)&&(identical(other.totalQuestionsAnswered, totalQuestionsAnswered) || other.totalQuestionsAnswered == totalQuestionsAnswered)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.practiceSessions, practiceSessions) || other.practiceSessions == practiceSessions)&&(identical(other.dailyPracticeSessionsPlayed, dailyPracticeSessionsPlayed) || other.dailyPracticeSessionsPlayed == dailyPracticeSessionsPlayed)&&(identical(other.lastPracticeSessionDate, lastPracticeSessionDate) || other.lastPracticeSessionDate == lastPracticeSessionDate)&&(identical(other.proSessions, proSessions) || other.proSessions == proSessions)&&(identical(other.dailyProSessionsPlayed, dailyProSessionsPlayed) || other.dailyProSessionsPlayed == dailyProSessionsPlayed)&&(identical(other.lastProSessionDate, lastProSessionDate) || other.lastProSessionDate == lastProSessionDate)&&(identical(other.versusMatches, versusMatches) || other.versusMatches == versusMatches)&&(identical(other.tournamentMatches, tournamentMatches) || other.tournamentMatches == tournamentMatches)&&const DeepCollectionEquality().equals(other._favoriteCategories, _favoriteCategories)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.avatarFrame, avatarFrame) || other.avatarFrame == avatarFrame)&&const DeepCollectionEquality().equals(other._badges, _badges)&&const DeepCollectionEquality().equals(other._achievements, _achievements)&&(identical(other.equippedTitleId, equippedTitleId) || other.equippedTitleId == equippedTitleId)&&const DeepCollectionEquality().equals(other._featuredBadgeIds, _featuredBadgeIds)&&(identical(other.allowVersusChallenges, allowVersusChallenges) || other.allowVersusChallenges == allowVersusChallenges)&&(identical(other.role, role) || other.role == role)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.lastDailyRewardClaim, lastDailyRewardClaim) || other.lastDailyRewardClaim == lastDailyRewardClaim)&&(identical(other.registrationOrder, registrationOrder) || other.registrationOrder == registrationOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._settings, _settings)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,displayName,username,email,photoUrl,selectedAvatarId,level,xp,coins,withdrawableCoins,lastCoinTransactionId,lastXpTransactionId,lastRankTransactionId,currentStreak,highestStreak,lastStreakMilestoneCelebrated,totalQuestionsAnswered,correctAnswers,accuracy,gamesPlayed,gamesWon,practiceSessions,dailyPracticeSessionsPlayed,lastPracticeSessionDate,proSessions,dailyProSessionsPlayed,lastProSessionDate,versusMatches,tournamentMatches,const DeepCollectionEquality().hash(_favoriteCategories),preferredLanguage,avatarFrame,const DeepCollectionEquality().hash(_badges),const DeepCollectionEquality().hash(_achievements),equippedTitleId,const DeepCollectionEquality().hash(_featuredBadgeIds),allowVersusChallenges,role,accountStatus,lastDailyRewardClaim,registrationOrder,createdAt,lastLogin,updatedAt,const DeepCollectionEquality().hash(_settings),version]);

@override
String toString() {
  return 'PlayerProfile(uid: $uid, displayName: $displayName, username: $username, email: $email, photoUrl: $photoUrl, selectedAvatarId: $selectedAvatarId, level: $level, xp: $xp, coins: $coins, withdrawableCoins: $withdrawableCoins, lastCoinTransactionId: $lastCoinTransactionId, lastXpTransactionId: $lastXpTransactionId, lastRankTransactionId: $lastRankTransactionId, currentStreak: $currentStreak, highestStreak: $highestStreak, lastStreakMilestoneCelebrated: $lastStreakMilestoneCelebrated, totalQuestionsAnswered: $totalQuestionsAnswered, correctAnswers: $correctAnswers, accuracy: $accuracy, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, practiceSessions: $practiceSessions, dailyPracticeSessionsPlayed: $dailyPracticeSessionsPlayed, lastPracticeSessionDate: $lastPracticeSessionDate, proSessions: $proSessions, dailyProSessionsPlayed: $dailyProSessionsPlayed, lastProSessionDate: $lastProSessionDate, versusMatches: $versusMatches, tournamentMatches: $tournamentMatches, favoriteCategories: $favoriteCategories, preferredLanguage: $preferredLanguage, avatarFrame: $avatarFrame, badges: $badges, achievements: $achievements, equippedTitleId: $equippedTitleId, featuredBadgeIds: $featuredBadgeIds, allowVersusChallenges: $allowVersusChallenges, role: $role, accountStatus: $accountStatus, lastDailyRewardClaim: $lastDailyRewardClaim, registrationOrder: $registrationOrder, createdAt: $createdAt, lastLogin: $lastLogin, updatedAt: $updatedAt, settings: $settings, version: $version)';
}


}

/// @nodoc
abstract mixin class _$PlayerProfileCopyWith<$Res> implements $PlayerProfileCopyWith<$Res> {
  factory _$PlayerProfileCopyWith(_PlayerProfile value, $Res Function(_PlayerProfile) _then) = __$PlayerProfileCopyWithImpl;
@override @useResult
$Res call({
 String uid, String displayName, String username, String email, String photoUrl, String selectedAvatarId, int level, int xp,@Deprecated('Use Wallet model instead for authoritative coin balance') int coins, int withdrawableCoins, String? lastCoinTransactionId, String? lastXpTransactionId, String? lastRankTransactionId, int currentStreak, int highestStreak, int lastStreakMilestoneCelebrated, int totalQuestionsAnswered, int correctAnswers, double accuracy, int gamesPlayed, int gamesWon, int practiceSessions, int dailyPracticeSessionsPlayed,@TimestampConverter() DateTime? lastPracticeSessionDate, int proSessions, int dailyProSessionsPlayed,@TimestampConverter() DateTime? lastProSessionDate, int versusMatches, int tournamentMatches, List<String> favoriteCategories, String preferredLanguage, String avatarFrame, List<String> badges, List<String> achievements, String? equippedTitleId, List<String> featuredBadgeIds, bool allowVersusChallenges, String role, String accountStatus,@TimestampConverter() DateTime? lastDailyRewardClaim, int registrationOrder,@RequiredTimestampConverter() DateTime createdAt,@RequiredTimestampConverter() DateTime lastLogin,@RequiredTimestampConverter() DateTime updatedAt, Map<String, dynamic> settings, int version
});




}
/// @nodoc
class __$PlayerProfileCopyWithImpl<$Res>
    implements _$PlayerProfileCopyWith<$Res> {
  __$PlayerProfileCopyWithImpl(this._self, this._then);

  final _PlayerProfile _self;
  final $Res Function(_PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? displayName = null,Object? username = null,Object? email = null,Object? photoUrl = null,Object? selectedAvatarId = null,Object? level = null,Object? xp = null,Object? coins = null,Object? withdrawableCoins = null,Object? lastCoinTransactionId = freezed,Object? lastXpTransactionId = freezed,Object? lastRankTransactionId = freezed,Object? currentStreak = null,Object? highestStreak = null,Object? lastStreakMilestoneCelebrated = null,Object? totalQuestionsAnswered = null,Object? correctAnswers = null,Object? accuracy = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? practiceSessions = null,Object? dailyPracticeSessionsPlayed = null,Object? lastPracticeSessionDate = freezed,Object? proSessions = null,Object? dailyProSessionsPlayed = null,Object? lastProSessionDate = freezed,Object? versusMatches = null,Object? tournamentMatches = null,Object? favoriteCategories = null,Object? preferredLanguage = null,Object? avatarFrame = null,Object? badges = null,Object? achievements = null,Object? equippedTitleId = freezed,Object? featuredBadgeIds = null,Object? allowVersusChallenges = null,Object? role = null,Object? accountStatus = null,Object? lastDailyRewardClaim = freezed,Object? registrationOrder = null,Object? createdAt = null,Object? lastLogin = null,Object? updatedAt = null,Object? settings = null,Object? version = null,}) {
  return _then(_PlayerProfile(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,selectedAvatarId: null == selectedAvatarId ? _self.selectedAvatarId : selectedAvatarId // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,withdrawableCoins: null == withdrawableCoins ? _self.withdrawableCoins : withdrawableCoins // ignore: cast_nullable_to_non_nullable
as int,lastCoinTransactionId: freezed == lastCoinTransactionId ? _self.lastCoinTransactionId : lastCoinTransactionId // ignore: cast_nullable_to_non_nullable
as String?,lastXpTransactionId: freezed == lastXpTransactionId ? _self.lastXpTransactionId : lastXpTransactionId // ignore: cast_nullable_to_non_nullable
as String?,lastRankTransactionId: freezed == lastRankTransactionId ? _self.lastRankTransactionId : lastRankTransactionId // ignore: cast_nullable_to_non_nullable
as String?,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,highestStreak: null == highestStreak ? _self.highestStreak : highestStreak // ignore: cast_nullable_to_non_nullable
as int,lastStreakMilestoneCelebrated: null == lastStreakMilestoneCelebrated ? _self.lastStreakMilestoneCelebrated : lastStreakMilestoneCelebrated // ignore: cast_nullable_to_non_nullable
as int,totalQuestionsAnswered: null == totalQuestionsAnswered ? _self.totalQuestionsAnswered : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,practiceSessions: null == practiceSessions ? _self.practiceSessions : practiceSessions // ignore: cast_nullable_to_non_nullable
as int,dailyPracticeSessionsPlayed: null == dailyPracticeSessionsPlayed ? _self.dailyPracticeSessionsPlayed : dailyPracticeSessionsPlayed // ignore: cast_nullable_to_non_nullable
as int,lastPracticeSessionDate: freezed == lastPracticeSessionDate ? _self.lastPracticeSessionDate : lastPracticeSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,proSessions: null == proSessions ? _self.proSessions : proSessions // ignore: cast_nullable_to_non_nullable
as int,dailyProSessionsPlayed: null == dailyProSessionsPlayed ? _self.dailyProSessionsPlayed : dailyProSessionsPlayed // ignore: cast_nullable_to_non_nullable
as int,lastProSessionDate: freezed == lastProSessionDate ? _self.lastProSessionDate : lastProSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,versusMatches: null == versusMatches ? _self.versusMatches : versusMatches // ignore: cast_nullable_to_non_nullable
as int,tournamentMatches: null == tournamentMatches ? _self.tournamentMatches : tournamentMatches // ignore: cast_nullable_to_non_nullable
as int,favoriteCategories: null == favoriteCategories ? _self._favoriteCategories : favoriteCategories // ignore: cast_nullable_to_non_nullable
as List<String>,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,avatarFrame: null == avatarFrame ? _self.avatarFrame : avatarFrame // ignore: cast_nullable_to_non_nullable
as String,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>,equippedTitleId: freezed == equippedTitleId ? _self.equippedTitleId : equippedTitleId // ignore: cast_nullable_to_non_nullable
as String?,featuredBadgeIds: null == featuredBadgeIds ? _self._featuredBadgeIds : featuredBadgeIds // ignore: cast_nullable_to_non_nullable
as List<String>,allowVersusChallenges: null == allowVersusChallenges ? _self.allowVersusChallenges : allowVersusChallenges // ignore: cast_nullable_to_non_nullable
as bool,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,accountStatus: null == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as String,lastDailyRewardClaim: freezed == lastDailyRewardClaim ? _self.lastDailyRewardClaim : lastDailyRewardClaim // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationOrder: null == registrationOrder ? _self.registrationOrder : registrationOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLogin: null == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
