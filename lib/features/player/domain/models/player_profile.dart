import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_profile.freezed.dart';
part 'player_profile.g.dart';

@freezed
abstract class PlayerProfile with _$PlayerProfile {
  const factory PlayerProfile({
    required String uid,
    required String displayName,
    @Default('') String username,
    required String email,
    @Default('') String photoUrl,
    @Default('socrates') String selectedAvatarId,

    // Progression
    @Default(1) int level,
    @Default(0) int xp,
    @Default(0) int coins,

    // Stats
    @Default(0) int currentStreak,
    @Default(0) int highestStreak,
    @Default(0) int lastStreakMilestoneCelebrated,
    @Default(0) int totalQuestionsAnswered,
    @Default(0) int correctAnswers,
    @Default(0.0) double accuracy,

    // Match History
    @Default(0) int gamesPlayed,
    @Default(0) int gamesWon,
    @Default(0) int practiceSessions,
    @Default(0) int proSessions,
    @Default(0) int dailyProSessionsPlayed,
    DateTime? lastProSessionDate,
    @Default(0) int versusMatches,
    @Default(0) int tournamentMatches,

    // Customization & Metadata
    @Default([]) List<String> favoriteCategories,
    @Default('en') String preferredLanguage,
    @Default('default') String avatarFrame,
    @Default([]) List<String> badges,
    @Default([]) List<String> achievements,
    String? equippedTitleId,
    @Default([]) List<String> featuredBadgeIds,
    @Default('user') String role, // user, moderator, admin
    @Default('active') String accountStatus, // active, suspended, deleted

    DateTime? lastDailyRewardClaim,
    @Default(0) int registrationOrder,
    required DateTime createdAt,
    required DateTime lastLogin,
    required DateTime updatedAt,
    @Default({}) Map<String, dynamic> settings,
    @Default(1) int version,
  }) = _PlayerProfile;

  factory PlayerProfile.fromJson(Map<String, dynamic> json) =>
      _$PlayerProfileFromJson(json);
  const PlayerProfile._();

  Map<String, dynamic> toCareerContext() => {
    'uid': uid,
    'displayName': displayName,
    'username': username,
    'level': level,
    'xp': xp,
    'coins': coins,
    'currentStreak': currentStreak,
    'highestStreak': highestStreak,
    'lastStreakMilestoneCelebrated': lastStreakMilestoneCelebrated,
    'totalQuestionsAnswered': totalQuestionsAnswered,
    'correctAnswers': correctAnswers,
    'accuracy': accuracy,
    'gamesPlayed': gamesPlayed,
    'gamesWon': gamesWon,
    'practiceSessions': practiceSessions,
    'proSessions': proSessions,
    'versusMatches': versusMatches,
    'tournamentMatches': tournamentMatches,
    'achievements': achievements,
    'lastDailyRewardClaim': lastDailyRewardClaim,
  };
}
