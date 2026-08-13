import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/public_competitive_profile.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';

void main() {
  group('PublicCompetitiveProfile', () {
    test('should create a valid profile from JSON', () {
      final json = {
        'userId': 'user123',
        'displayName': 'Champion',
        'avatarId': 'socrates',
        'currentRank': 'Gold',
        'rankTier': 'Gold',
        'rankPoints': 1500,
        'division': 2,
        'careerHighlights': {
          'gamesPlayed': 100,
          'gamesWon': 60,
          'gamesLost': 40,
          'winRate': 0.6,
          'totalQuestionsAnswered': 1000,
          'correctAnswers': 800,
          'accuracy': 0.8,
          'currentStreak': 5,
          'highestStreak': 12,
          'bestRank': 'Platinum',
          'peakPosition': 42,
          'seasonsPlayed': 3,
        },
        'updatedAt': DateTime.now().toIso8601String(),
        'schemaVersion': 1,
      };

      final profile = PublicCompetitiveProfile.fromJson(json);

      expect(profile.userId, 'user123');
      expect(profile.displayName, 'Champion');
      expect(profile.careerHighlights.winRate, 0.6);
    });

    test('should maintain immutability and support copyWith', () {
      final profile = PublicCompetitiveProfile(
        userId: '1',
        displayName: 'A',
        avatarId: 'v',
        currentRank: 'R',
        rankTier: 'T',
        rankPoints: 100,
        division: 1,
        careerHighlights: const CareerStatistics(
          gamesPlayed: 0,
          gamesWon: 0,
          gamesLost: 0,
          winRate: 0,
          totalQuestionsAnswered: 0,
          correctAnswers: 0,
          accuracy: 0,
          currentStreak: 0,
          highestStreak: 0,
          bestRank: 'None',
          peakPosition: 0,
          seasonsPlayed: 0,
        ),
        updatedAt: DateTime.now(),
      );

      final updated = profile.copyWith(displayName: 'B');
      expect(updated.displayName, 'B');
      expect(profile.displayName, 'A');
    });
  });
}
