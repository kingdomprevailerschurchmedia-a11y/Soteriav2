import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

class FirestoreCategoryRepository implements CategoryRepository {
  final IDatabaseService _database;

  FirestoreCategoryRepository(this._database);

  @override
  Future<List<Category>> getCategories() async {
    final snapshot = await _database.collection('categories').get();
    return snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList();
  }

  @override
  Stream<List<Category>> watchCategories() {
    return _database.collection('categories').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Category.fromJson(doc.data()))
              .toList(),
        );
  }
}
