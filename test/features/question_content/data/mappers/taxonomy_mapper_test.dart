import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/question_content/data/mappers/taxonomy_mapper.dart';
import 'package:soteria/features/question_content/data/models/category_dto.dart';
import 'package:soteria/features/question_content/data/models/subcategory_dto.dart';
import 'package:soteria/features/question_content/data/models/topic_dto.dart';

void main() {
  group('TaxonomyMapper', () {
    test('Category mapping', () {
      final dto = CategoryDto(
        id: 'science',
        name: 'Science',
        description: 'Desc',
        slug: 'science',
        icon: 'icon',
        active: true,
        displayOrder: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
      );

      final entity = TaxonomyMapper.fromCategoryDto(dto);
      expect(entity.id, dto.id);
      expect(entity.name, dto.name);
      expect(entity.createdAt, DateTime.parse(dto.createdAt!));

      final backToDto = TaxonomyMapper.toCategoryDto(entity);
      expect(backToDto.id, dto.id);
      expect(backToDto.createdAt, dto.createdAt);
    });

    test('Subcategory mapping', () {
      final dto = SubcategoryDto(
        id: 'biology',
        categoryId: 'science',
        name: 'Biology',
        description: 'Desc',
        slug: 'biology',
      );

      final entity = TaxonomyMapper.fromSubcategoryDto(dto);
      expect(entity.id, dto.id);
      expect(entity.categoryId, dto.categoryId);

      final backToDto = TaxonomyMapper.toSubcategoryDto(entity);
      expect(backToDto.id, dto.id);
    });

    test('Topic mapping', () {
      final dto = TopicDto(
        id: 'genetics',
        subcategoryId: 'biology',
        name: 'Genetics',
        description: 'Desc',
        slug: 'genetics',
      );

      final entity = TaxonomyMapper.fromTopicDto(dto);
      expect(entity.id, dto.id);
      expect(entity.subcategoryId, dto.subcategoryId);

      final backToDto = TaxonomyMapper.toTopicDto(entity);
      expect(backToDto.id, dto.id);
    });
  });
}
