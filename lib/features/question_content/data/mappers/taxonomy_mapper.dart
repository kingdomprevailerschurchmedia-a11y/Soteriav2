import '../models/category_dto.dart';
import '../models/subcategory_dto.dart';
import '../models/topic_dto.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/subcategory.dart';
import '../../domain/entities/topic.dart';

class TaxonomyMapper {
  static Category fromCategoryDto(CategoryDto dto) {
    return Category(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      slug: dto.slug,
      icon: dto.icon,
      image: dto.image,
      displayOrder: dto.displayOrder,
      active: dto.active,
      featured: dto.featured,
      minLevel: dto.minLevel,
      isPremium: dto.isPremium,
      tags: dto.tags,
      questionCount: dto.questionCount,
      metadata: dto.metadata,
      createdAt: dto.createdAt != null ? DateTime.parse(dto.createdAt!) : null,
      updatedAt: dto.updatedAt != null ? DateTime.parse(dto.updatedAt!) : null,
    );
  }

  static CategoryDto toCategoryDto(Category entity) {
    return CategoryDto(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      slug: entity.slug,
      icon: entity.icon,
      image: entity.image,
      displayOrder: entity.displayOrder,
      active: entity.active,
      featured: entity.featured,
      minLevel: entity.minLevel,
      isPremium: entity.isPremium,
      tags: entity.tags,
      questionCount: entity.questionCount,
      metadata: entity.metadata,
      createdAt: entity.createdAt?.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
    );
  }

  static Subcategory fromSubcategoryDto(SubcategoryDto dto) {
    return Subcategory(
      id: dto.id,
      categoryId: dto.categoryId,
      name: dto.name,
      description: dto.description,
      slug: dto.slug,
      displayOrder: dto.displayOrder,
      active: dto.active,
      metadata: dto.metadata,
      createdAt: dto.createdAt != null ? DateTime.parse(dto.createdAt!) : null,
      updatedAt: dto.updatedAt != null ? DateTime.parse(dto.updatedAt!) : null,
    );
  }

  static SubcategoryDto toSubcategoryDto(Subcategory entity) {
    return SubcategoryDto(
      id: entity.id,
      categoryId: entity.categoryId,
      name: entity.name,
      description: entity.description,
      slug: entity.slug,
      displayOrder: entity.displayOrder,
      active: entity.active,
      metadata: entity.metadata,
      createdAt: entity.createdAt?.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
    );
  }

  static Topic fromTopicDto(TopicDto dto) {
    return Topic(
      id: dto.id,
      subcategoryId: dto.subcategoryId,
      name: dto.name,
      description: dto.description,
      slug: dto.slug,
      displayOrder: dto.displayOrder,
      active: dto.active,
      metadata: dto.metadata,
      createdAt: dto.createdAt != null ? DateTime.parse(dto.createdAt!) : null,
      updatedAt: dto.updatedAt != null ? DateTime.parse(dto.updatedAt!) : null,
    );
  }

  static TopicDto toTopicDto(Topic entity) {
    return TopicDto(
      id: entity.id,
      subcategoryId: entity.subcategoryId,
      name: entity.name,
      description: entity.description,
      slug: entity.slug,
      displayOrder: entity.displayOrder,
      active: entity.active,
      metadata: entity.metadata,
      createdAt: entity.createdAt?.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
    );
  }
}
