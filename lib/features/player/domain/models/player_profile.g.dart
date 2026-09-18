// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerProfile _$PlayerProfileFromJson(Map<String, dynamic> json) =>
    _PlayerProfile(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String? ?? '',
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      selectedAvatarId: json['selectedAvatarId'] as String? ?? 'socrates',
      level: (json['level'] as num?)?.toInt() ?? 1,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      coins: (json['coins'] as num?)?.toInt() ?? 0,
      withdrawableCoins: (json['withdrawableCoins'] as num?)?.toInt() ?? 0,
      lastCoinTransactionId: json['lastCoinTransactionId'] as String?,
      lastXpTransactionId: json['lastXpTransactionId'] as String?,
      lastRankTransactionId: json['lastRankTransactionId'] as String?,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      highestStreak: (json['highestStreak'] as num?)?.toInt() ?? 0,
      lastStreakMilestoneCelebrated:
          (json['lastStreakMilestoneCelebrated'] as num?)?.toInt() ?? 0,
      totalQuestionsAnswered:
          (json['totalQuestionsAnswered'] as num?)?.toInt() ?? 0,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
      gamesWon: (json['gamesWon'] as num?)?.toInt() ?? 0,
      practiceSessions: (json['practiceSessions'] as num?)?.toInt() ?? 0,
      dailyPracticeSessionsPlayed:
          (json['dailyPracticeSessionsPlayed'] as num?)?.toInt() ?? 0,
      lastPracticeSessionDate: const TimestampConverter().fromJson(
        json['lastPracticeSessionDate'],
      ),
      proSessions: (json['proSessions'] as num?)?.toInt() ?? 0,
      dailyProSessionsPlayed:
          (json['dailyProSessionsPlayed'] as num?)?.toInt() ?? 0,
      lastProSessionDate: const TimestampConverter().fromJson(
        json['lastProSessionDate'],
      ),
      versusMatches: (json['versusMatches'] as num?)?.toInt() ?? 0,
      tournamentMatches: (json['tournamentMatches'] as num?)?.toInt() ?? 0,
      favoriteCategories:
          (json['favoriteCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
      avatarFrame: json['avatarFrame'] as String? ?? 'default',
      badges:
          (json['badges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      equippedTitleId: json['equippedTitleId'] as String?,
      featuredBadgeIds:
          (json['featuredBadgeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      allowVersusChallenges: json['allowVersusChallenges'] as bool? ?? true,
      role: json['role'] as String? ?? 'user',
      accountStatus: json['accountStatus'] as String? ?? 'active',
      lastDailyRewardClaim: const TimestampConverter().fromJson(
        json['lastDailyRewardClaim'],
      ),
      registrationOrder: (json['registrationOrder'] as num?)?.toInt() ?? 0,
      createdAt: const RequiredTimestampConverter().fromJson(json['createdAt']),
      lastLogin: const RequiredTimestampConverter().fromJson(json['lastLogin']),
      updatedAt: const RequiredTimestampConverter().fromJson(json['updatedAt']),
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$PlayerProfileToJson(
  _PlayerProfile instance,
) => <String, dynamic>{
  'uid': instance.uid,
  'displayName': instance.displayName,
  'username': instance.username,
  'email': instance.email,
  'photoUrl': instance.photoUrl,
  'selectedAvatarId': instance.selectedAvatarId,
  'level': instance.level,
  'xp': instance.xp,
  'coins': instance.coins,
  'withdrawableCoins': instance.withdrawableCoins,
  'lastCoinTransactionId': instance.lastCoinTransactionId,
  'lastXpTransactionId': instance.lastXpTransactionId,
  'lastRankTransactionId': instance.lastRankTransactionId,
  'currentStreak': instance.currentStreak,
  'highestStreak': instance.highestStreak,
  'lastStreakMilestoneCelebrated': instance.lastStreakMilestoneCelebrated,
  'totalQuestionsAnswered': instance.totalQuestionsAnswered,
  'correctAnswers': instance.correctAnswers,
  'accuracy': instance.accuracy,
  'gamesPlayed': instance.gamesPlayed,
  'gamesWon': instance.gamesWon,
  'practiceSessions': instance.practiceSessions,
  'dailyPracticeSessionsPlayed': instance.dailyPracticeSessionsPlayed,
  'lastPracticeSessionDate': const TimestampConverter().toJson(
    instance.lastPracticeSessionDate,
  ),
  'proSessions': instance.proSessions,
  'dailyProSessionsPlayed': instance.dailyProSessionsPlayed,
  'lastProSessionDate': const TimestampConverter().toJson(
    instance.lastProSessionDate,
  ),
  'versusMatches': instance.versusMatches,
  'tournamentMatches': instance.tournamentMatches,
  'favoriteCategories': instance.favoriteCategories,
  'preferredLanguage': instance.preferredLanguage,
  'avatarFrame': instance.avatarFrame,
  'badges': instance.badges,
  'achievements': instance.achievements,
  'equippedTitleId': instance.equippedTitleId,
  'featuredBadgeIds': instance.featuredBadgeIds,
  'allowVersusChallenges': instance.allowVersusChallenges,
  'role': instance.role,
  'accountStatus': instance.accountStatus,
  'lastDailyRewardClaim': const TimestampConverter().toJson(
    instance.lastDailyRewardClaim,
  ),
  'registrationOrder': instance.registrationOrder,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'lastLogin': const RequiredTimestampConverter().toJson(instance.lastLogin),
  'updatedAt': const RequiredTimestampConverter().toJson(instance.updatedAt),
  'settings': instance.settings,
  'version': instance.version,
};
