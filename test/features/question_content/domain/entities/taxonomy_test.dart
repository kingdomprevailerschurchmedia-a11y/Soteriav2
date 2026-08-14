import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';
import 'package:soteria/features/question_content/domain/entities/subcategory.dart';
import 'package:soteria/features/question_content/domain/entities/topic.dart';

void main() {
  group('Taxonomy Entities', () {
    test('Category equality', () {
      final c1 = Category(
        id: '1',
        name: 'Science',
        description: 'Desc',
        slug: 'science',
        icon: 'icon',
      );
      final c2 = Category(
        id: '1',
        name: 'Science',
        description: 'Desc',
        slug: 'science',
        icon: 'icon',
      );
      expect(c1, equals(c2));
    });

    test('Subcategory equality', () {
      final s1 = Subcategory(
        id: '1',
        categoryId: 'cat1',
        name: 'Biology',
        description: 'Desc',
        slug: 'biology',
      );
      final s2 = Subcategory(
        id: '1',
        categoryId: 'cat1',
        name: 'Biology',
        description: 'Desc',
        slug: 'biology',
      );
      expect(s1, equals(s2));
    });

    test('Topic equality', () {
      final t1 = Topic(
        id: '1',
        subcategoryId: 'sub1',
        name: 'Genetics',
        description: 'Desc',
        slug: 'genetics',
      );
      final t2 = Topic(
        id: '1',
        subcategoryId: 'sub1',
        name: 'Genetics',
        description: 'Desc',
        slug: 'genetics',
      );
      expect(t1, equals(t2));
    });

    test('Category copyWith works', () {
      final c1 = Category(
        id: '1',
        name: 'Science',
        description: 'Desc',
        slug: 'science',
        icon: 'icon',
      );
      final c2 = c1.copyWith(name: 'New Science');
      expect(c2.name, 'New Science');
      expect(c2.id, '1');
    });
  });
}
