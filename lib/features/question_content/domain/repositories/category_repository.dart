import '../entities/category.dart';

abstract interface class CategoryRepository {
  Future<List<Category>> getCategories();
  Stream<List<Category>> watchCategories();
}
