import '../entities/category.dart';
import '../entities/subcategory.dart';
import '../entities/topic.dart';

abstract interface class CategoryRepository {
  Future<List<Category>> getCategories();
  Stream<List<Category>> watchCategories();
  Future<Category?> getCategoryById(String id);

  Future<List<Subcategory>> getSubcategories(String categoryId);
  Stream<List<Subcategory>> watchSubcategories(String categoryId);
  Future<Subcategory?> getSubcategoryById(String id);

  Future<List<Topic>> getTopics(String subcategoryId);
  Stream<List<Topic>> watchTopics(String subcategoryId);
  Future<Topic?> getTopicById(String id);

  /// Seeds the initial set of categories if none exist.
  Future<void> seedDefaultCategories();
}
