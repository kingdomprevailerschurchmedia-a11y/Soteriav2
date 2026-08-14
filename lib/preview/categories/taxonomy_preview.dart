import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/design_system/colors/soteria_colors.dart';
import '../../core/design_system/spacing/soteria_spacing.dart';
import '../../core/design_system/typography/soteria_typography.dart';
import '../../core/widgets/glass_surface.dart';
import '../../features/question_content/data/seed/taxonomy_seed_data.dart';
import '../../features/question_content/domain/entities/category.dart';
import '../../features/question_content/domain/entities/subcategory.dart';
import '../../features/question_content/domain/entities/topic.dart';

class TaxonomyPreview extends StatelessWidget {
  const TaxonomyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090514),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Taxonomy Preview',
          style: context.titleLarge.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(title: 'Categories'),
            SizedBox(height: SoteriaSpacing.md),
            _CategoryList(categories: TaxonomySeedData.categories),
            SizedBox(height: SoteriaSpacing.xl),
            _SectionHeader(title: 'Subcategories (Science)'),
            SizedBox(height: SoteriaSpacing.md),
            _SubcategoryList(
              subcategories: TaxonomySeedData.subcategories
                  .where((s) => s.categoryId == 'science')
                  .toList(),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            _SectionHeader(title: 'Topics (Biology)'),
            SizedBox(height: SoteriaSpacing.md),
            _TopicList(
              topics: TaxonomySeedData.topics
                  .where((t) => t.subcategoryId == 'biology')
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.headlineSmall.copyWith(
        color: SoteriaColors.gold,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<Category> categories;
  const _CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(category: category);
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      borderRadius: BorderRadius.circular(20.r),
      opacity: 0.05,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF7C4DFF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _getIcon(category.icon),
                color: const Color(0xFF7C4DFF),
                size: 24.w,
              ),
            ),
            const Spacer(),
            Text(
              category.name,
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              category.description,
              style: context.bodySmall.copyWith(
                color: SoteriaColors.muted,
                fontSize: 10.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String iconKey) {
    switch (iconKey) {
      case 'brain':
        return Icons.psychology_outlined;
      case 'calculate':
        return Icons.calculate_outlined;
      case 'science':
        return Icons.science_outlined;
      case 'computer':
        return Icons.computer_rounded;
      case 'history':
        return Icons.account_balance_outlined;
      case 'public':
        return Icons.public;
      case 'business':
        return Icons.business_center_outlined;
      case 'menu_book':
        return Icons.menu_book_outlined;
      case 'sports_basketball':
        return Icons.sports_basketball_outlined;
      case 'newspaper':
        return Icons.newspaper_rounded;
      default:
        return Icons.category_outlined;
    }
  }
}

class _SubcategoryList extends StatelessWidget {
  final List<Subcategory> subcategories;
  const _SubcategoryList({required this.subcategories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subcategories.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final sub = subcategories[index];
        return GlassSurface(
          borderRadius: BorderRadius.circular(12.r),
          opacity: 0.03,
          child: ListTile(
            title: Text(
              sub.name,
              style: context.titleSmall.copyWith(color: Colors.white),
            ),
            subtitle: Text(
              sub.description,
              style: context.bodySmall.copyWith(color: SoteriaColors.muted),
            ),
            trailing: const Icon(Icons.chevron_right, color: SoteriaColors.muted),
          ),
        );
      },
    );
  }
}

class _TopicList extends StatelessWidget {
  final List<Topic> topics;
  const _TopicList({required this.topics});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: topics.map((topic) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Text(
            topic.name,
            style: context.labelSmall.copyWith(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
