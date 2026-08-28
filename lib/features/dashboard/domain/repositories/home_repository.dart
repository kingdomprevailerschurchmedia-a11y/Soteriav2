import '../models/dashboard_state.dart';

abstract interface class HomeRepository {
  Future<List<String>> getAnnouncements();
  Stream<List<String>> getAnnouncementsStream();
  Future<DailyChallenge?> getDailyChallenge();
  Stream<DailyChallenge?> getDailyChallengeStream();
}
