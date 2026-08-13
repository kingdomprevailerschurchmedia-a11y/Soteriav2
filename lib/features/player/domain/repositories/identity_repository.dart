import '../models/competitive_title.dart';
import '../models/competitive_badge.dart';
import '../models/public_competitive_profile.dart';

abstract interface class IdentityRepository {
  Future<List<CompetitiveTitle>> getTitleDefinitions();
  Future<List<CompetitiveBadge>> getBadgeDefinitions();
  
  Future<CompetitiveTitle?> getTitle(String titleId);
  Future<CompetitiveBadge?> getBadge(String badgeId);

  Future<PublicCompetitiveProfile?> getPublicProfile(String userId);
  Future<List<PublicCompetitiveProfile>> searchPlayers(String query, {int limit = 20});
}
