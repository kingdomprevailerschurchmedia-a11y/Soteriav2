import '../models/competitive_title.dart';
import '../models/competitive_badge.dart';

abstract interface class IdentityRepository {
  Future<List<CompetitiveTitle>> getTitleDefinitions();
  Future<List<CompetitiveBadge>> getBadgeDefinitions();
  
  Future<CompetitiveTitle?> getTitle(String titleId);
  Future<CompetitiveBadge?> getBadge(String badgeId);
}
