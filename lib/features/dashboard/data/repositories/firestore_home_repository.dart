import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/models/dashboard_state.dart';

class FirestoreHomeRepository implements HomeRepository {
  FirestoreHomeRepository({required IDatabaseService database})
      : _database = database;

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

      return snapshot.docs.map((doc) => doc.data()['message'] as String).toList();
    } catch (e) {
      // Fallback to empty or a specific error message if needed
      return [];
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
    } catch (e) {
      return null;
    }
  }
}
