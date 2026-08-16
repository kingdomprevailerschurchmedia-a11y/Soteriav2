import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/identity/models/user_profile.dart';
import '../../domain/models/player_profile.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../domain/repositories/player_progression_repository.dart';
import '../models/player_profile_dto.dart';
import '../models/public_profile_dto.dart';
import '../../domain/models/public_competitive_profile.dart';
import '../../domain/models/competitive_statistics.dart';

class FirestoreProfileRepository implements ProfileRepository {
  final FirebaseFirestore _firestore;
  final LeaderboardRepository _leaderboardRepository;
  final PlayerProgressionRepository _progressionRepository;

  FirestoreProfileRepository(
    this._firestore,
    this._leaderboardRepository,
    this._progressionRepository,
  );

  @override
  Future<bool> checkUsernameAvailability(String username) async {
    final doc = await _firestore.collection('usernames').doc(username.toLowerCase()).get();
    return !doc.exists;
  }

  @override
  Future<void> updateProfile({
    required String userId,
    required UserProfile userProfile,
    required PlayerProfile playerProfile,
    String? oldUsername,
  }) async {
    await _firestore.runTransaction((transaction) async {
      // 1. Username reservation
      final newUsername = userProfile.username.toLowerCase();
      if (oldUsername != null && oldUsername.toLowerCase() != newUsername) {
        final usernameDoc = _firestore.collection('usernames').doc(newUsername);
        final snapshot = await transaction.get(usernameDoc);
        if (snapshot.exists) {
          throw Exception('Username already taken');
        }
        
        // Remove old and add new
        transaction.delete(_firestore.collection('usernames').doc(oldUsername.toLowerCase()));
        transaction.set(usernameDoc, {
          'userId': userId,
          'username': userProfile.username,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else if (oldUsername == null) {
         // Initial reservation if not already there (e.g. legacy users)
         transaction.set(_firestore.collection('usernames').doc(newUsername), {
          'userId': userId,
          'username': userProfile.username,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      // 2. User Profile
      transaction.set(
        _firestore.collection('user_profiles').doc(userId),
        userProfile.toMap(),
        SetOptions(merge: true),
      );

      // 3. Player Profile
      transaction.set(
        _firestore.collection('users').doc(userId),
        PlayerProfileDto.toFirestore(playerProfile)..remove('createdAt'),
        SetOptions(merge: true),
      );

      // 4. Public Profile
      final progressionDoc = _firestore.collection('player_progression').doc(userId);
      final progressionSnapshot = await transaction.get(progressionDoc);
      
      if (progressionSnapshot.exists) {
        final progression = PlayerProgression.fromJson(progressionSnapshot.data()!);
        
        final publicProfile = PublicCompetitiveProfile(
          userId: userId,
          displayName: userProfile.displayName,
          username: userProfile.username,
          avatarId: userProfile.selectedAvatarId,
          photoUrl: userProfile.avatarUrl,
          currentRank: progression.currentRank,
          rankTier: progression.currentRankTier,
          rankPoints: progression.rankPoints,
          division: _parseDivision(progression.currentRank),
          careerHighlights: CareerStatistics(
            gamesPlayed: playerProfile.gamesPlayed,
            gamesWon: playerProfile.gamesWon,
            gamesLost: playerProfile.gamesPlayed - playerProfile.gamesWon,
            winRate: playerProfile.gamesPlayed > 0 ? playerProfile.gamesWon / playerProfile.gamesPlayed : 0.0,
            totalQuestionsAnswered: playerProfile.totalQuestionsAnswered,
            correctAnswers: playerProfile.correctAnswers,
            accuracy: playerProfile.accuracy,
            currentStreak: playerProfile.currentStreak,
            highestStreak: playerProfile.highestStreak,
            bestRank: 'Unranked',
            peakPosition: 0,
            seasonsPlayed: 0,
          ),
          updatedAt: DateTime.now(),
        );

        transaction.set(
          _firestore.collection('public_profiles').doc(userId),
          PublicProfileDto.toFirestore(publicProfile),
          SetOptions(merge: true),
        );

        // 5. Leaderboard Sync
        await _leaderboardRepository.syncLeaderboardEntry(
          profile: playerProfile,
          progression: progression,
          transaction: transaction,
        );
      }
    });
  }

  int _parseDivision(String rankString) {
    if (rankString == 'Unranked' || rankString == 'Elite') return 0;
    final parts = rankString.split(' ');
    if (parts.length < 2) return 0;
    switch (parts[1]) {
      case 'I': return 1;
      case 'II': return 2;
      case 'III': return 3;
      default: return 0;
    }
  }
}
