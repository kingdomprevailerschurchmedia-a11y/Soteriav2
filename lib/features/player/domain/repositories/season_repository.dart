import '../models/competitive_season.dart';

abstract class SeasonRepository {
  Future<CompetitiveSeason?> getCurrentSeason();
  Future<CompetitiveSeason?> getUpcomingSeason();
  Future<CompetitiveSeason?> getSeason(String seasonId);
  Stream<CompetitiveSeason?> watchCurrentSeason();
  Future<List<CompetitiveSeason>> getSeasonHistory({int limit = 10});
  Future<List<CompetitiveSeason>> getSeasons();
}
