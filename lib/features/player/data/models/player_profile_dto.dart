import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/player_profile.dart';
import '../../../personalization/utils/personalization_bridge.dart';

class PlayerProfileDto {
  static PlayerProfile fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return PlayerProfile(
      uid: doc.id,
      displayName: data['displayName'] as String? ?? 'Scholar',
      username: data['username'] as String? ?? 'scholar',
      email: data['email'] as String? ?? '',
      photoUrl: data['photoUrl'] as String? ?? '',
      selectedAvatarId: data['selectedAvatarId'] as String? ?? 'socrates',
      level: (data['level'] as num?)?.toInt() ?? 1,
      xp: (data['xp'] as num?)?.toInt() ?? 0,
      coins: (data['coins'] as num?)?.toInt() ?? 0,
      currentStreak: (data['currentStreak'] as num?)?.toInt() ?? 0,
      highestStreak: (data['highestStreak'] as num?)?.toInt() ?? 0,
      totalQuestionsAnswered: (data['totalQuestionsAnswered'] as num?)?.toInt() ?? 0,
      correctAnswers: (data['correctAnswers'] as num?)?.toInt() ?? 0,
      accuracy: (data['accuracy'] as num? ?? 0.0).toDouble(),
      gamesPlayed: (data['gamesPlayed'] as num?)?.toInt() ?? 0,
      gamesWon: (data['gamesWon'] as num?)?.toInt() ?? 0,
      practiceSessions: (data['practiceSessions'] as num?)?.toInt() ?? 0,
      dailyPracticeSessionsPlayed: (data['dailyPracticeSessionsPlayed'] as num?)?.toInt() ?? 0,
      lastPracticeSessionDate: data['lastPracticeSessionDate'] != null ? _parseDate(data['lastPracticeSessionDate']) : null,
      proSessions: (data['proSessions'] as num?)?.toInt() ?? 0,
      dailyProSessionsPlayed: (data['dailyProSessionsPlayed'] as num?)?.toInt() ?? 0,
      lastProSessionDate: data['lastProSessionDate'] != null ? _parseDate(data['lastProSessionDate']) : null,
      versusMatches: (data['versusMatches'] as num?)?.toInt() ?? 0,
      tournamentMatches: (data['tournamentMatches'] as num?)?.toInt() ?? 0,
      favoriteCategories: (data['favoriteCategories'] as List<dynamic>? ?? [])
          .map((cat) => PersonalizationBridge.normalizeCategoryId(cat as String))
          .toList(),
      preferredLanguage: data['preferredLanguage'] as String? ?? 'en',
      avatarFrame: data['avatarFrame'] as String? ?? 'default',
      badges: List<String>.from(data['badges'] ?? []),
      achievements: List<String>.from(data['achievements'] ?? []),
      equippedTitleId: data['equippedTitleId'] as String?,
      featuredBadgeIds: List<String>.from(data['featuredBadgeIds'] ?? []),
      role: data['role'] as String? ?? 'user',
      accountStatus: data['accountStatus'] as String? ?? 'active',
      registrationOrder: (data['registrationOrder'] as num?)?.toInt() ?? 0,
      lastDailyRewardClaim: data['lastDailyRewardClaim'] != null ? _parseDate(data['lastDailyRewardClaim']) : null,
      createdAt: _parseDate(data['createdAt']),
      lastLogin: _parseDate(data['lastLogin']),
      updatedAt: _parseDate(data['updatedAt']),
      settings: data['settings'] as Map<String, dynamic>? ?? {},
      version: (data['version'] as num?)?.toInt() ?? 1,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  static Map<String, dynamic> toFirestore(PlayerProfile profile) {
    return {
      'displayName': profile.displayName,
      'username': profile.username,
      'email': profile.email,
      'photoUrl': profile.photoUrl,
      'selectedAvatarId': profile.selectedAvatarId,
      'level': profile.level,
      'xp': profile.xp,
      'coins': profile.coins,
      'currentStreak': profile.currentStreak,
      'highestStreak': profile.highestStreak,
      'totalQuestionsAnswered': profile.totalQuestionsAnswered,
      'correctAnswers': profile.correctAnswers,
      'accuracy': profile.accuracy,
      'gamesPlayed': profile.gamesPlayed,
      'gamesWon': profile.gamesWon,
      'practiceSessions': profile.practiceSessions,
      'proSessions': profile.proSessions,
      'dailyProSessionsPlayed': profile.dailyProSessionsPlayed,
      'lastProSessionDate': profile.lastProSessionDate != null ? Timestamp.fromDate(profile.lastProSessionDate!) : null,
      'versusMatches': profile.versusMatches,
      'tournamentMatches': profile.tournamentMatches,
      'practiceSessions': profile.practiceSessions,
      'dailyPracticeSessionsPlayed': profile.dailyPracticeSessionsPlayed,
      'lastPracticeSessionDate': profile.lastPracticeSessionDate != null ? Timestamp.fromDate(profile.lastPracticeSessionDate!) : null,
      'favoriteCategories': profile.favoriteCategories,
      'preferredLanguage': profile.preferredLanguage,
      'avatarFrame': profile.avatarFrame,
      'badges': profile.badges,
      'achievements': profile.achievements,
      'equippedTitleId': profile.equippedTitleId,
      'featuredBadgeIds': profile.featuredBadgeIds,
      'role': profile.role,
      'accountStatus': profile.accountStatus,
      'registrationOrder': profile.registrationOrder,
      'lastDailyRewardClaim': profile.lastDailyRewardClaim != null ? Timestamp.fromDate(profile.lastDailyRewardClaim!) : null,
      'createdAt': Timestamp.fromDate(profile.createdAt),
      'lastLogin': Timestamp.fromDate(profile.lastLogin),
      'updatedAt': Timestamp.fromDate(profile.updatedAt),
      'settings': profile.settings,
      'version': profile.version,
    };
  }
}
