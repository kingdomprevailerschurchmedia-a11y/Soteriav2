import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_streak.dart';
import '../../domain/models/momentum.dart';
import '../../domain/repositories/streak_repository.dart';
import '../../data/repositories/firebase_streak_repository.dart';
import '../../domain/services/competitive_streak_engine.dart';
import '../../domain/services/competitive_streak_service.dart';
import '../../../auth/providers/auth_providers.dart';

final streakRepositoryProvider = Provider<StreakRepository>((ref) {
  return FirebaseStreakRepository(FirebaseFirestore.instance);
});

final streakEngineProvider = Provider<CompetitiveStreakEngine>((ref) {
  return CompetitiveStreakEngine();
});

final streakServiceProvider = Provider<CompetitiveStreakService>((ref) {
  return CompetitiveStreakService(
    ref.watch(streakRepositoryProvider),
    ref.watch(streakEngineProvider),
  );
});

final currentWinStreakProvider = StreamProvider<CompetitiveStreak?>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value(null);
  return ref.watch(streakRepositoryProvider).watchWinStreak(userId);
});

final currentMomentumProvider = StreamProvider<CompetitiveMomentum?>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value(null);
  return ref.watch(streakRepositoryProvider).watchMomentum(userId);
});
