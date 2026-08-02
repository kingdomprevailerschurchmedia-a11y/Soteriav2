import '../models/dashboard_state.dart';

abstract interface class HomeRepository {
  Future<List<String>> getAnnouncements();
  Future<DailyChallenge> getDailyChallenge();
}
