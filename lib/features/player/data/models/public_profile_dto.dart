import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/public_competitive_profile.dart';
import '../../domain/models/competitive_statistics.dart';
import '../../domain/models/competitive_title.dart';
import '../../domain/models/competitive_badge.dart';

class PublicProfileDto {
  static PublicCompetitiveProfile fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return PublicCompetitiveProfile(
      userId: doc.id,
      displayName: data['displayName'] as String? ?? 'Scholar',
      avatarId: data['avatarId'] as String? ?? 'socrates',
      photoUrl: data['photoUrl'] as String?,
      currentRank: data['currentRank'] as String? ?? 'Unranked',
      rankTier: data['rankTier'] as String? ?? 'None',
      rankPoints: data['rankPoints'] as int? ?? 0,
      division: data['division'] as int? ?? 1,
      equippedTitle: data['equippedTitle'] != null
          ? CompetitiveTitle.fromJson(data['equippedTitle'])
          : null,
      featuredBadges: (data['featuredBadges'] as List? ?? [])
          .map((e) => CompetitiveBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
      careerHighlights: data['careerHighlights'] != null
          ? CareerStatistics.fromJson(data['careerHighlights'])
          : CareerStatistics(
              gamesPlayed: 0,
              gamesWon: 0,
              gamesLost: 0,
              winRate: 0.0,
              totalQuestionsAnswered: 0,
              correctAnswers: 0,
              accuracy: 0.0,
              currentStreak: 0,
              highestStreak: 0,
              bestRank: 'Unranked',
              peakPosition: 0,
              seasonsPlayed: 0,
            ),
      updatedAt: _parseDate(data['updatedAt']),
      schemaVersion: data['schemaVersion'] as int? ?? 1,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  static Map<String, dynamic> toFirestore(PublicCompetitiveProfile profile) {
    return {
      'displayName': profile.displayName,
      'displayNameNormalized': profile.displayName.toLowerCase(),
      'avatarId': profile.avatarId,
      'photoUrl': profile.photoUrl,
      'currentRank': profile.currentRank,
      'rankTier': profile.rankTier,
      'rankPoints': profile.rankPoints,
      'division': profile.division,
      'equippedTitle': profile.equippedTitle?.toJson(),
      'featuredBadges': profile.featuredBadges.map((e) => e.toJson()).toList(),
      'careerHighlights': profile.careerHighlights.toJson(),
      'updatedAt': Timestamp.fromDate(profile.updatedAt),
      'schemaVersion': profile.schemaVersion,
    };
  }
}
