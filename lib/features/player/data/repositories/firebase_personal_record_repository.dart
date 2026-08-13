import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_personal_record.dart';
import '../../domain/repositories/personal_record_repository.dart';

class FirebasePersonalRecordRepository implements PersonalRecordRepository {
  final FirebaseFirestore _firestore;

  FirebasePersonalRecordRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _recordsCollection(String userId) =>
      _firestore.collection('users').doc(userId).collection('personal_records');

  @override
  Future<List<CompetitivePersonalRecord>> getCareerRecords(String userId) async {
    final snapshot = await _recordsCollection(userId)
        .where('isCareerRecord', isEqualTo: true)
        .get();
    
    return snapshot.docs
        .map((doc) => CompetitivePersonalRecord.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<CompetitivePersonalRecord>> getSeasonRecords(
    String userId,
    String seasonId,
  ) async {
    final snapshot = await _recordsCollection(userId)
        .where('seasonId', isEqualTo: seasonId)
        .get();
    
    return snapshot.docs
        .map((doc) => CompetitivePersonalRecord.fromJson(doc.data()))
        .toList();
  }

  @override
  Stream<List<CompetitivePersonalRecord>> watchPersonalRecords(String userId) {
    return _recordsCollection(userId)
        .orderBy('achievedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CompetitivePersonalRecord.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<void> updateRecord(CompetitivePersonalRecord record) async {
    // We use a specific ID based on type and mode for career records to allow easy updates/replacement
    // For season records, we might want to include seasonId in the ID
    final docId = record.isCareerRecord 
        ? 'career_${record.type.name}${record.mode != null ? "_${record.mode}" : ""}'
        : 'season_${record.seasonId}_${record.type.name}${record.mode != null ? "_${record.mode}" : ""}';

    await _recordsCollection(record.userId).doc(docId).set(record.toJson());
  }
}
