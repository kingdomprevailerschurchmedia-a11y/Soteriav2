import '../models/competitive_personal_record.dart';

abstract class PersonalRecordRepository {
  Future<List<CompetitivePersonalRecord>> getCareerRecords(String userId);
  Future<List<CompetitivePersonalRecord>> getSeasonRecords(String userId, String seasonId);
  Stream<List<CompetitivePersonalRecord>> watchPersonalRecords(String userId);
  Future<void> updateRecord(CompetitivePersonalRecord record);
}
