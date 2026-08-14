import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/subcategory.dart';
import '../../domain/entities/topic.dart';
import 'category_providers.dart';

/// Provider for watching all active categories.
final categoriesProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchCategories();
});

/// Provider for getting a category by its ID.
final categoryByIdProvider = FutureProvider.family<Category?, String>((ref, id) {
  return ref.watch(categoryRepositoryProvider).getCategoryById(id);
});

/// Provider for watching subcategories of a specific category.
final subcategoriesProvider = StreamProvider.family<List<Subcategory>, String>((ref, categoryId) {
  return ref.watch(categoryRepositoryProvider).watchSubcategories(categoryId);
});

/// Provider for getting a subcategory by its ID.
final subcategoryByIdProvider = FutureProvider.family<Subcategory?, String>((ref, id) {
  return ref.watch(categoryRepositoryProvider).getSubcategoryById(id);
});

/// Provider for watching topics of a specific subcategory.
final topicsProvider = StreamProvider.family<List<Topic>, String>((ref, subcategoryId) {
  return ref.watch(categoryRepositoryProvider).watchTopics(subcategoryId);
});

/// Provider for getting a topic by its ID.
final topicByIdProvider = FutureProvider.family<Topic?, String>((ref, id) {
  return ref.watch(categoryRepositoryProvider).getTopicById(id);
});
