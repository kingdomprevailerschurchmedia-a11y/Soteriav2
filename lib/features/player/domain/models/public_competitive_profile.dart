import 'package:freezed_annotation/freezed_annotation.dart';
import 'competitive_badge.dart';
import 'competitive_title.dart';
import 'competitive_statistics.dart';

part 'public_competitive_profile.freezed.dart';
part 'public_competitive_profile.g.dart';

@freezed
abstract class PublicCompetitiveProfile with _$PublicCompetitiveProfile {
  const factory PublicCompetitiveProfile({
    required String userId,
    required String displayName,
    @Default('') String username,
    required String avatarId,
    String? photoUrl,
    
    // Identity
    required String currentRank,
    required String rankTier,
    required int rankPoints,
    required int division,
    CompetitiveTitle? equippedTitle,
    @Default([]) List<CompetitiveBadge> featuredBadges,
    
    // Career Highlights
    required CareerStatistics careerHighlights,
    
    // Metadata
    required DateTime updatedAt,
    @Default(1) int schemaVersion,
  }) = _PublicCompetitiveProfile;

  factory PublicCompetitiveProfile.fromJson(Map<String, dynamic> json) =>
      _$PublicCompetitiveProfileFromJson(json);
}
