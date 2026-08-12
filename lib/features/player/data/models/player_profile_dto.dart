import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/player_profile.dart';

class PlayerProfileDto {
  static PlayerProfile fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return PlayerProfile(
      uid: doc.id,
      displayName: data['displayName'] as String? ?? 'Scholar',
      email: data['email'] as String? ?? '',
      photoUrl: data['photoUrl'] as String? ?? '',
      selectedAvatarId: data['selectedAvatarId'] as String? ?? 'socrates',
      level: data['level'] as int? ?? 1,
      xp: data['xp'] as int? ?? 0,
      coins: data['coins'] as int? ?? 0,
      currentStreak: data['currentStreak'] as int? ?? 0,
      highestStreak: data['highestStreak'] as int? ?? 0,
      totalQuestionsAnswered: data['totalQuestionsAnswered'] as int? ?? 0,
      correctAnswers: data['correctAnswers'] as int? ?? 0,
      accuracy: (data['accuracy'] ?? 0.0).toDouble(),
      gamesPlayed: data['gamesPlayed'] as int? ?? 0,
      gamesWon: data['gamesWon'] as int? ?? 0,
      practiceSessions: data['practiceSessions'] as int? ?? 0,
      proSessions: data['proSessions'] as int? ?? 0,
      versusMatches: data['versusMatches'] as int? ?? 0,
      tournamentMatches: data['tournamentMatches'] as int? ?? 0,
      favoriteCategories: List<String>.from(data['favoriteCategories'] ?? []),
      preferredLanguage: data['preferredLanguage'] as String? ?? 'en',
      avatarFrame: data['avatarFrame'] as String? ?? 'default',
      badges: List<String>.from(data['badges'] ?? []),
      achievements: List<String>.from(data['achievements'] ?? []),
      role: data['role'] as String? ?? 'user',
      accountStatus: data['accountStatus'] as String? ?? 'active',
      createdAt: _parseDate(data['createdAt']),
      lastLogin: _parseDate(data['lastLogin']),
      updatedAt: _parseDate(data['updatedAt']),
      settings: data['settings'] as Map<String, dynamic>? ?? {},
      version: data['version'] as int? ?? 1,
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
      'versusMatches': profile.versusMatches,
      'tournamentMatches': profile.tournamentMatches,
      'favoriteCategories': profile.favoriteCategories,
      'preferredLanguage': profile.preferredLanguage,
      'avatarFrame': profile.avatarFrame,
      'badges': profile.badges,
      'achievements': profile.achievements,
      'role': profile.role,
      'accountStatus': profile.accountStatus,
      'createdAt': Timestamp.fromDate(profile.createdAt),
      'lastLogin': Timestamp.fromDate(profile.lastLogin),
      'updatedAt': Timestamp.fromDate(profile.updatedAt),
      'settings': profile.settings,
      'version': profile.version,
    };
  }
}
