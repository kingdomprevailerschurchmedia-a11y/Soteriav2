import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_season.dart';
import '../../domain/repositories/season_repository.dart';

class FirebaseSeasonRepository implements SeasonRepository {
  final FirebaseFirestore _firestore;

  FirebaseSeasonRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _seasonsCollection =>
      _firestore.collection('seasons');

  @override
  Future<CompetitiveSeason?> getCurrentSeason() async {
    final snapshot = await _seasonsCollection
        .where('isCurrent', isEqualTo: true)
        .where('isVisible', isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return CompetitiveSeason.fromJson(snapshot.docs.first.data());
  }

  @override
  Future<CompetitiveSeason?> getUpcomingSeason() async {
    final snapshot = await _seasonsCollection
        .where('status', isEqualTo: SeasonStatus.upcoming.name)
        .where('isVisible', isEqualTo: true)
        .orderBy('startAt', descending: false)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return CompetitiveSeason.fromJson(snapshot.docs.first.data());
  }

  @override
  Future<CompetitiveSeason?> getSeason(String seasonId) async {
    final doc = await _seasonsCollection.doc(seasonId).get();
    if (!doc.exists) return null;
    return CompetitiveSeason.fromJson(doc.data()!);
  }

  @override
  Stream<CompetitiveSeason?> watchCurrentSeason() {
    return _seasonsCollection
        .where('isCurrent', isEqualTo: true)
        .where('isVisible', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          return CompetitiveSeason.fromJson(snapshot.docs.first.data());
        });
  }

  @override
  Future<List<CompetitiveSeason>> getSeasonHistory({int limit = 10}) async {
    final snapshot = await _seasonsCollection
        .where(
          'status',
          whereIn: [SeasonStatus.completed.name, SeasonStatus.archived.name],
        )
        .orderBy('endAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => CompetitiveSeason.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<CompetitiveSeason>> getSeasons() async {
    final snapshot = await _seasonsCollection
        .where('isVisible', isEqualTo: true)
        .orderBy('seasonNumber', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => CompetitiveSeason.fromJson(doc.data()))
        .toList();
  }
}
