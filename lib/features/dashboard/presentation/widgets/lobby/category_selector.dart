import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/widgets/glass_surface.dart';
import '../../providers/practice_lobby_providers.dart';
import '../../../../question_content/domain/entities/category.dart';

class CategorySelector extends ConsumerWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(practiceLobbyProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT CATEGORY',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              final isSelected = state.config.categoryIds.contains(category.id);

              return _CategoryCard(
                category: category,
                isSelected: isSelected,
                onTap: () => ref
                    .read(practiceLobbyProvider.notifier)
                    .toggleCategory(category.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 120.w,
        margin: EdgeInsets.only(right: SoteriaSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? SoteriaColors.primary
                : Colors.white.withValues(alpha: 0.1),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: SoteriaColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: GlassSurface(
            opacity: isSelected ? 0.15 : 0.05,
            child: Padding(
              padding: EdgeInsets.all(SoteriaSpacing.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIcon(category.icon),
                    color: isSelected ? SoteriaColors.primary : Colors.white70,
                    size: 24.sp,
                  ),
                  SizedBox(height: SoteriaSpacing.xs),
                  Text(
                    category.name,
                    style: context.bodySmall.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 11.sp,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'security':
        return Icons.security_rounded;
      case 'cloud':
        return Icons.cloud_rounded;
      case 'code':
        return Icons.code_rounded;
      case 'network':
        return Icons.router_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}
