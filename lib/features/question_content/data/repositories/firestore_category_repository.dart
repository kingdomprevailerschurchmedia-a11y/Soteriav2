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
    
    if (snapshot.docs.isEmpty) {
      // Return defaults if database is empty to prevent empty UI
      return _getDefaultCategories();
    }

    return snapshot.docs
        .map((doc) => TaxonomyMapper.fromCategoryDto(
            CategoryDto.fromJson({'id': doc.id, ...doc.data()})))
        .toList();
  }

  List<Category> _getDefaultCategories() {
    final defaults = [
      {'id': 'science', 'name': 'Science', 'icon': 'science', 'displayOrder': 1, 'description': 'Biology, Physics, Chemistry and more'},
      {'id': 'technology', 'name': 'Technology', 'icon': 'cloud', 'displayOrder': 2, 'description': 'Computers, AI, and Gadgets'},
      {'id': 'business', 'name': 'Business', 'icon': 'business', 'displayOrder': 3, 'description': 'Economics, Management and Startups'},
      {'id': 'programming', 'name': 'Programming', 'icon': 'code', 'displayOrder': 4, 'description': 'Software development and algorithms'},
      {'id': 'history', 'name': 'History', 'icon': 'history', 'displayOrder': 5, 'description': 'Ancient and modern world events'},
      {'id': 'mathematics', 'name': 'Mathematics', 'icon': 'calculate', 'displayOrder': 6, 'description': 'Algebra, Geometry and Calculus'},
      {'id': 'general_knowledge', 'name': 'General Knowledge', 'icon': 'category', 'displayOrder': 7, 'description': 'Facts from around the world'},
      {'id': 'arts', 'name': 'Arts', 'icon': 'palette', 'displayOrder': 8, 'description': 'Painting, Music and Literature'},
      {'id': 'sports', 'name': 'Sports', 'icon': 'sports_basketball', 'displayOrder': 9, 'description': 'Athletics, Football and Games'},
      {'id': 'law', 'name': 'Law', 'icon': 'gavel', 'displayOrder': 10, 'description': 'Legal systems, statutes and constitutional law'},
      {'id': 'design', 'name': 'Design', 'icon': 'brush', 'displayOrder': 11, 'description': 'Graphic design, architecture and user experience'},
      {'id': 'finance', 'name': 'Finance', 'icon': 'payments', 'displayOrder': 12, 'description': 'Markets, investments and personal finance'},
      {'id': 'medicine', 'name': 'Medicine', 'icon': 'medical_services', 'displayOrder': 13, 'description': 'Anatomy, healthcare and medical breakthroughs'},
      {'id': 'geography', 'name': 'Geography', 'icon': 'public', 'displayOrder': 14, 'description': 'World maps, climates and cultures'},
      {'id': 'languages', 'name': 'Languages', 'icon': 'language', 'displayOrder': 15, 'description': 'Linguistics, grammar and world tongues'},
      {'id': 'literature', 'name': 'Literature', 'icon': 'menu_book', 'displayOrder': 16, 'description': 'Classic novels, poetry and authors'},
      {'id': 'psychology', 'name': 'Psychology', 'icon': 'psychology', 'displayOrder': 17, 'description': 'Human behavior, mind and mental health'},
      {'id': 'engineering', 'name': 'Engineering', 'icon': 'engineering', 'displayOrder': 18, 'description': 'Mechanics, structures and innovations'},
      {'id': 'current_affairs', 'name': 'Current Affairs', 'icon': 'newspaper', 'displayOrder': 19, 'description': 'Recent news and global events'},
    ];

    return defaults.map((data) => Category(
      id: data['id'] as String,
      name: data['name'] as String,
      icon: data['icon'] as String,
      displayOrder: data['displayOrder'] as int,
      description: data['description'] as String,
      slug: (data['name'] as String).toLowerCase().replaceAll(' ', '_'),
    )).toList();
  }

  @override
  Future<void> seedDefaultCategories() async {
    try {
      final defaults = _getDefaultCategories();
      for (final category in defaults) {
        final doc = await _database.collection('categories').doc(category.id).get();
        if (doc.exists) continue;

        final dto = TaxonomyMapper.toCategoryDto(category);
        final data = dto.toJson();
        data.remove('id');
        data['active'] = true;
        data['createdAt'] = DateTime.now().toIso8601String();
        await _database.collection('categories').doc(category.id).set(data);
      }
    } catch (e) {
      // Catch permission errors or other seeding failures gracefully
      print('Category seeding skipped or failed: $e');
    }
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
