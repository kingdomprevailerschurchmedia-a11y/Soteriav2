import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../data/repositories/firebase_live_operations_repository.dart';
import '../../domain/repositories/live_operations_repository.dart';

final liveOperationsRepositoryProvider = Provider<LiveOperationsRepository>((ref) {
  return FirebaseLiveOperationsRepository(ref.watch(remoteConfigServiceProvider));
});

final liveOperationsInitProvider = FutureProvider<void>((ref) async {
  await ref.read(liveOperationsRepositoryProvider).fetchAndActivate();
});
