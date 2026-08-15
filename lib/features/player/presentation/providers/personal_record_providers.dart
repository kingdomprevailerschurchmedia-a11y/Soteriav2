import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../data/repositories/firebase_personal_record_repository.dart';
import '../../domain/models/competitive_personal_record.dart';
import '../../domain/repositories/personal_record_repository.dart';
import '../../domain/services/personal_record_service.dart';
import '../../../auth/providers/auth_providers.dart';
import 'season_providers.dart';

final personalRecordRepositoryProvider = Provider<PersonalRecordRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirebasePersonalRecordRepository(firestore);
});

final personalRecordServiceProvider = Provider<PersonalRecordService>((ref) {
  final repository = ref.watch(personalRecordRepositoryProvider);
  return PersonalRecordService(repository);
});

final personalRecordsProvider = StreamProvider.family<List<CompetitivePersonalRecord>, String>((ref, userId) {
  final repository = ref.watch(personalRecordRepositoryProvider);
  return repository.watchPersonalRecords(userId);
});

final currentUserPersonalRecordsProvider = StreamProvider<List<CompetitivePersonalRecord>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  final repository = ref.watch(personalRecordRepositoryProvider);
  return repository.watchPersonalRecords(userId);
});

final careerRecordsProvider = Provider<AsyncValue<List<CompetitivePersonalRecord>>>((ref) {
  final recordsAsync = ref.watch(currentUserPersonalRecordsProvider);
  return recordsAsync.whenData((records) => records.where((r) => r.isCareerRecord).toList());
});

final seasonRecordsProvider = Provider.family<AsyncValue<List<CompetitivePersonalRecord>>, String>((ref, seasonId) {
  final recordsAsync = ref.watch(currentUserPersonalRecordsProvider);
  return recordsAsync.whenData((records) => records.where((r) => r.seasonId == seasonId).toList());
});

final currentSeasonRecordsProvider = Provider<AsyncValue<List<CompetitivePersonalRecord>>>((ref) {
  final currentSeasonAsync = ref.watch(currentSeasonProvider);
  return currentSeasonAsync.when(
    data: (season) {
      if (season == null) return const AsyncValue.data([]);
      return ref.watch(seasonRecordsProvider(season.seasonId));
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

final recentRecordsProvider = Provider<AsyncValue<List<CompetitivePersonalRecord>>>((ref) {
  final recordsAsync = ref.watch(currentUserPersonalRecordsProvider);
  return recordsAsync.whenData((records) {
    // Return records achieved in the last 7 days, sorted by achievedAt
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return records.where((r) => r.achievedAt.isAfter(weekAgo)).toList();
  });
});
