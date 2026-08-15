import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../gameplay_engine/providers/gameplay_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../domain/repositories/practice_result_repository.dart';
import '../../data/repositories/firestore_practice_result_repository.dart';
import '../../domain/models/practice_result.dart';
import '../../domain/models/practice_history.dart';

final practiceResultRepositoryProvider = Provider<PracticeResultRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FirestorePracticeResultRepository(firestore);
});

final practiceHistoryListProvider = FutureProvider<List<PracticeResult>>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return [];
  
  final repository = ref.watch(practiceResultRepositoryProvider);
  return repository.getRecentResults(userId, limit: 20);
});

final practiceHistoryProvider = FutureProvider<PracticeHistory>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return PracticeHistory.empty();
  
  final results = await ref.watch(practiceHistoryListProvider.future);
  return PracticeHistory.fromResults(results);
});
