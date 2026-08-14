import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/question_content/presentation/providers/taxonomy_providers.dart';
import 'package:soteria/features/question_content/presentation/providers/category_providers.dart';
import 'package:soteria/features/question_content/domain/repositories/category_repository.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';
import 'package:soteria/features/question_content/domain/entities/subcategory.dart';

import 'taxonomy_integration_test.mocks.dart';

@GenerateMocks([CategoryRepository])
void main() {
  late MockCategoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCategoryRepository();
  });

  group('Taxonomy Integration', () {
    test('categoriesProvider stream data to UI', () async {
      const category = Category(
        id: '1',
        name: 'Science',
        description: 'Desc',
        slug: 'science',
        icon: 'icon',
      );

      when(mockRepository.watchCategories()).thenAnswer(
        (_) => Stream.value([category]),
      );

      final container = ProviderContainer(
        overrides: [
          categoryRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      final categories = await container.read(categoriesProvider.future);
      expect(categories.length, 1);
      expect(categories.first.name, 'Science');
    });

    test('subcategoriesProvider fetches data for category', () async {
      const sub = Subcategory(
        id: '1',
        categoryId: 'cat1',
        name: 'Biology',
        description: 'Desc',
        slug: 'biology',
      );

      when(mockRepository.watchSubcategories('cat1')).thenAnswer(
        (_) => Stream.value([sub]),
      );

      final container = ProviderContainer(
        overrides: [
          categoryRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      final subcategories = await container.read(subcategoriesProvider('cat1').future);
      expect(subcategories.length, 1);
      expect(subcategories.first.name, 'Biology');
    });
  });
}
