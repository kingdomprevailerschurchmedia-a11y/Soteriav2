import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../domain/repositories/category_repository.dart';
import '../../data/repositories/firestore_category_repository.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return FirestoreCategoryRepository(
    ref.watch(firestoreDatabaseServiceProvider),
  );
});
