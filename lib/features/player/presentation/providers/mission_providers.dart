import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/data/repositories/firebase_mission_repository.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';
import 'package:soteria/features/player/domain/repositories/mission_repository.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return FirebaseMissionRepository(FirebaseFirestore.instance);
});

final activeMissionsProvider = StreamProvider<List<CompetitiveMission>>((ref) {
  final user = ref.watch(currentPlayerStreamProvider).value;
  if (user == null) return Stream.value([]);
  
  return ref.watch(missionRepositoryProvider).watchActiveMissions(user.uid);
});

final dailyMissionsProvider = Provider<AsyncValue<List<CompetitiveMission>>>((ref) {
  return ref.watch(activeMissionsProvider).whenData((missions) {
    return missions.where((m) => m.definition.period == MissionPeriod.daily).toList();
  });
});

final weeklyMissionsProvider = Provider<AsyncValue<List<CompetitiveMission>>>((ref) {
  return ref.watch(activeMissionsProvider).whenData((missions) {
    return missions.where((m) => m.definition.period == MissionPeriod.weekly).toList();
  });
});

final seasonalMissionsProvider = Provider<AsyncValue<List<CompetitiveMission>>>((ref) {
  return ref.watch(activeMissionsProvider).whenData((missions) {
    return missions.where((m) => m.definition.period == MissionPeriod.seasonal).toList();
  });
});

final missionHistoryProvider = FutureProvider<List<CompetitiveMission>>((ref) async {
  final user = ref.watch(currentPlayerStreamProvider).value;
  if (user == null) return [];
  
  return ref.read(missionRepositoryProvider).getMissionHistory(user.uid);
});
