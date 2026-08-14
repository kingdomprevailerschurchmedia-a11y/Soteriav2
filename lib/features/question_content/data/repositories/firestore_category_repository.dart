import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/subcategory.dart';
import '../../domain/entities/topic.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_dto.dart';
import '../models/subcategory_dto.dart';
import '../models/topic_dto.dart';
import '../mappers/taxonomy_mapper.dart';

class FirestoreCategoryRepository implements CategoryRepository {
  final IDatabaseService _database;

  FirestoreCategoryRepository(this._database);

  @override
  Future<List<Category>> getCategories() async {
    final snapshot = await _database
        .collection('categories')
        .where('active', isEqualTo: true)
        .orderBy('displayOrder')
        .get();
    return snapshot.docs
        .map((doc) => TaxonomyMapper.fromCategoryDto(
            CategoryDto.fromJson({'id': doc.id, ...doc.data()})))
        .toList();
  }

  @override
  Stream<List<Category>> watchCategories() {
    return _database
        .collection('categories')
        .where('active', isEqualTo: true)
        .orderBy('displayOrder')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaxonomyMapper.fromCategoryDto(
                  CategoryDto.fromJson({'id': doc.id, ...doc.data()})))
              .toList(),
        );
  }

  @override
  Future<Category?> getCategoryById(String id) async {
    final doc = await _database.collection('categories').doc(id).get();
    if (!doc.exists) return null;
    return TaxonomyMapper.fromCategoryDto(
        CategoryDto.fromJson({'id': doc.id, ...doc.data()!}));
  }

  @override
  Future<List<Subcategory>> getSubcategories(String categoryId) async {
    final snapshot = await _database
        .collection('subcategories')
        .where('categoryId', isEqualTo: categoryId)
        .where('active', isEqualTo: true)
        .orderBy('displayOrder')
        .get();
    return snapshot.docs
        .map((doc) => TaxonomyMapper.fromSubcategoryDto(
            SubcategoryDto.fromJson({'id': doc.id, ...doc.data()})))
        .toList();
  }

  @override
  Stream<List<Subcategory>> watchSubcategories(String categoryId) {
    return _database
        .collection('subcategories')
        .where('categoryId', isEqualTo: categoryId)
        .where('active', isEqualTo: true)
        .orderBy('displayOrder')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaxonomyMapper.fromSubcategoryDto(
                  SubcategoryDto.fromJson({'id': doc.id, ...doc.data()})))
              .toList(),
        );
  }

  @override
  Future<Subcategory?> getSubcategoryById(String id) async {
    final doc = await _database.collection('subcategories').doc(id).get();
    if (!doc.exists) return null;
    return TaxonomyMapper.fromSubcategoryDto(
        SubcategoryDto.fromJson({'id': doc.id, ...doc.data()!}));
  }

  @override
  Future<List<Topic>> getTopics(String subcategoryId) async {
    final snapshot = await _database
        .collection('topics')
        .where('subcategoryId', isEqualTo: subcategoryId)
        .where('active', isEqualTo: true)
        .orderBy('displayOrder')
        .get();
    return snapshot.docs
        .map((doc) => TaxonomyMapper.fromTopicDto(
            TopicDto.fromJson({'id': doc.id, ...doc.data()})))
        .toList();
  }

  @override
  Stream<List<Topic>> watchTopics(String subcategoryId) {
    return _database
        .collection('topics')
        .where('subcategoryId', isEqualTo: subcategoryId)
        .where('active', isEqualTo: true)
        .orderBy('displayOrder')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaxonomyMapper.fromTopicDto(
                  TopicDto.fromJson({'id': doc.id, ...doc.data()})))
              .toList(),
        );
  }

  @override
  Future<Topic?> getTopicById(String id) async {
    final doc = await _database.collection('topics').doc(id).get();
    if (!doc.exists) return null;
    return TaxonomyMapper.fromTopicDto(
        TopicDto.fromJson({'id': doc.id, ...doc.data()!}));
  }
}
