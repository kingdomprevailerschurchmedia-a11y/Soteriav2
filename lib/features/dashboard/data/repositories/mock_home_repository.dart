import '../../domain/models/dashboard_state.dart';
import '../../domain/repositories/home_repository.dart';

class MockHomeRepository implements HomeRepository {
  @override
  Future<List<String>> getAnnouncements() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      'Welcome to Soteria Early Access!',
      'Tournament: Regional Finals starts in 2 days.',
      'Double XP Weekend is now live!',
    ];
  }

  @override
  Future<DailyChallenge> getDailyChallenge() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return const DailyChallenge(
      title: 'Logic Master',
      description: 'Answer 10 Logic questions correctly.',
      xpReward: 250,
      completionPercentage: 0.4,
    );
  }
}
