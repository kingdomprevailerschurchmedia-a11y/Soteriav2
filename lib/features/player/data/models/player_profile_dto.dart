import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/player_profile.dart';

class PlayerProfileDto {
  static PlayerProfile fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PlayerProfile(
      uid: doc.id,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      level: data['level'] ?? 1,
      xp: data['xp'] ?? 0,
      coins: data['coins'] ?? 0,
      currentStreak: data['currentStreak'] ?? 0,
      highestStreak: data['highestStreak'] ?? 0,
      totalQuestionsAnswered: data['totalQuestionsAnswered'] ?? 0,
      correctAnswers: data['correctAnswers'] ?? 0,
      accuracy: (data['accuracy'] ?? 0.0).toDouble(),
      gamesPlayed: data['gamesPlayed'] ?? 0,
      gamesWon: data['gamesWon'] ?? 0,
      practiceSessions: data['practiceSessions'] ?? 0,
      proSessions: data['proSessions'] ?? 0,
      versusMatches: data['versusMatches'] ?? 0,
      tournamentMatches: data['tournamentMatches'] ?? 0,
      favoriteCategories: List<String>.from(data['favoriteCategories'] ?? []),
      preferredLanguage: data['preferredLanguage'] ?? 'en',
      avatarFrame: data['avatarFrame'] ?? 'default',
      badges: List<String>.from(data['badges'] ?? []),
      achievements: List<String>.from(data['achievements'] ?? []),
      role: data['role'] ?? 'user',
      accountStatus: data['accountStatus'] ?? 'active',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLogin: (data['lastLogin'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      settings: data['settings'] ?? {},
      version: data['version'] ?? 1,
    );
  }

  static Map<String, dynamic> toFirestore(PlayerProfile profile) {
    return {
      'displayName': profile.displayName,
      'email': profile.email,
      'photoUrl': profile.photoUrl,
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
