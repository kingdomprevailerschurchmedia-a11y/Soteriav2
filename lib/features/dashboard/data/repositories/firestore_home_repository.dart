import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/models/dashboard_state.dart';

class FirestoreHomeRepository implements HomeRepository {
  FirestoreHomeRepository({required this._database  @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
});

  final IDatabaseService _database;

  @override
  Future<List<String>> getAnnouncements() async {
    try {
      final snapshot = await _database
          .collection('announcements')
          .where('active', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();

      return snapshot.docs
          .map((doc) => doc.data()['message'] as String)
          .toList();
      @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
} catch (e) {
      // Fallback to empty or a specific error message if needed
      return [];
      @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
}
    @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
}

  @override
  Stream<List<String>> getAnnouncementsStream() {
    return _database
        .collection('announcements')
        .where('active', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data()['message'] as String)
            .toList());
    @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
}

  @override
  Future<DailyChallenge?> getDailyChallenge() async {
    try {
      final snapshot = await _database
          .collection('daily_challenges')
          .where('active', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
      @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
} catch (e) {
      return null;
      @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
}
    @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
}
  @override
  Stream<DailyChallenge?> getDailyChallengeStream() {
    return _database
        .collection('daily_challenges')
        .where('active', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final data = snapshot.docs.first.data();
      return DailyChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        xpReward: data['xpReward'] ?? 0,
        completionPercentage: (data['completionPercentage'] ?? 0.0).toDouble(),
      );
    });
  }
}
