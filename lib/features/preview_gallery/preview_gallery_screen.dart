import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import 'package:soteria/features/preview_gallery/models/gallery_item.dart';
import 'package:soteria/features/preview_gallery/providers/gallery_providers.dart';

class PreviewGalleryScreen extends ConsumerWidget {
  const PreviewGalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeGradientScaffold(
      body: CustomScrollView(
        slivers: [
          _GalleryAppBar(),
          _GalleryStatsSection(),
          _RecentItemsSection(),
          _FavoritesSection(),
          _GalleryGridHeader(),
          _GalleryItemsGrid(),
          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxlStatic)),
        ],
      ),
    );
  }
}

class _GalleryAppBar extends ConsumerWidget {
  const _GalleryAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: 250.h,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Design System', style: context.displayMedium.copyWith(color: SoteriaColors.gold)),
                SizedBox(height: SoteriaSpacing.sm),
                SoteriaTextField(
                  hintText: 'Search components, tokens, screens...',
                  prefixIcon: Icons.search_rounded,
                  onChanged: (val) => ref.read(gallerySearchQueryProvider.notifier).update(val),
                ),
                SizedBox(height: SoteriaSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GalleryStatsSection extends ConsumerWidget {
  const _GalleryStatsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allItems = ref.watch(galleryItemsProvider);
    final components = allItems.where((i) => i.category == GalleryCategory.components).length;
    final screens = allItems.where((i) => i.category == GalleryCategory.screens).length;
    final tokens = allItems.where((i) => i.category == GalleryCategory.designSystem).length;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _StatItem(label: 'Components', value: components.toString()),
            _StatItem(label: 'Screens', value: screens.toString()),
            _StatItem(label: 'Tokens', value: tokens.toString()),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
        Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, color: SoteriaColors.muted, letterSpacing: 1.0)),
      ],
    );
  }
}

class _RecentItemsSection extends ConsumerWidget {
  const _RecentItemsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recents = ref.watch(galleryRecentProvider);
    if (recents.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

    final allItems = ref.watch(galleryItemsProvider);
    final recentItems = allItems.where((item) => recents.contains(item.route)).toList();

    return SliverToBoxAdapter(
      child: RepaintBoundary(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'RECENTLY VIEWED'),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                itemCount: recentItems.length,
                itemBuilder: (context, index) => _RecentCard(item: recentItems[index]),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _FavoritesSection extends ConsumerWidget {
  const _FavoritesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(galleryFavoritesProvider);
    if (favorites.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

    final allItems = ref.watch(galleryItemsProvider);
    final favoriteItems = allItems.where((item) => favorites.contains(item.route)).toList();

    return SliverToBoxAdapter(
      child: RepaintBoundary(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'FAVORITES'),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) => _FavoriteCard(item: favoriteItems[index]),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _GalleryGridHeader extends ConsumerWidget {
  const _GalleryGridHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(gallerySearchQueryProvider.select((q) => q.isNotEmpty));
    return SliverToBoxAdapter(
      child: _SectionHeader(title: isSearching ? 'SEARCH RESULTS' : 'EXPLORE CATEGORIES'),
    );
  }
}

class _GalleryItemsGrid extends ConsumerWidget {
  const _GalleryItemsGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredItems = ref.watch(filteredGalleryItemsProvider);

    return SliverPadding(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.15,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _GalleryItemCard(item: filteredItems[index]),
          childCount: filteredItems.length,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: SoteriaColors.muted, letterSpacing: 2.0),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final GalleryItem item;
  const _FavoriteCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(item.route),
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: SoteriaSpacing.md),
        decoration: BoxDecoration(
          color: SoteriaColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: SoteriaColors.gold, size: 32),
            SizedBox(height: SoteriaSpacing.sm),
            Text(item.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  final GalleryItem item;
  const _RecentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(item.route),
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: SoteriaSpacing.md),
        decoration: BoxDecoration(
          color: SoteriaColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
        child: Row(
          children: [
            Icon(item.icon, color: SoteriaColors.primary, size: 20),
            SizedBox(width: SoteriaSpacing.sm),
            Expanded(
              child: Text(
                item.title, 
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryItemCard extends ConsumerWidget {
  final GalleryItem item;
  const _GalleryItemCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(galleryFavoritesProvider.select((f) => f.contains(item.route)));

    return GestureDetector(
      onTap: () {
        ref.read(galleryRecentProvider.notifier).add(item.route);
        context.push(item.route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: SoteriaColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(item.icon, color: SoteriaColors.primary, size: 24.w),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    size: 18.w,
                    color: isFavorite ? SoteriaColors.gold : SoteriaColors.muted,
                  ),
                  onPressed: () => ref.read(galleryFavoritesProvider.notifier).toggle(item.route),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title, 
                  style: context.titleLarge.copyWith(
                    fontSize: 14.sp,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  item.description,
                  style: context.bodySmall.copyWith(
                    fontSize: 10.sp,
                    color: SoteriaColors.textSecondary.withValues(alpha: 0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
