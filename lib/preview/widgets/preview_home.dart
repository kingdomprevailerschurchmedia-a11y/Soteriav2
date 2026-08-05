import 'package:flutter/material.dart';
import '../../../core/design_system/colors/soteria_colors.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../core/design_system/typography/soteria_typography.dart';
import '../registry/preview_registry.dart';
import '../models/preview_category.dart';
import '../models/preview_item.dart';
import 'preview_detail_screen.dart';

class PreviewHomeScreen extends StatefulWidget {
  const PreviewHomeScreen({super.key});

  @override
  State<PreviewHomeScreen> createState() => _PreviewHomeScreenState();
}

class _PreviewHomeScreenState extends State<PreviewHomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final registry = PreviewRegistry.instance;
    final results = _searchQuery.isEmpty
        ? registry.items
        : registry.search(_searchQuery);

    return Scaffold(
      backgroundColor: SoteriaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SOTERIA PREVIEW',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.lg,
              vertical: SoteriaSpacing.sm,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Previews...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          if (_searchQuery.isEmpty)
            ...PreviewCategory.values.map((cat) {
              final items = registry.getByCategory(cat);
              if (items.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }

              return SliverPadding(
                padding: EdgeInsets.all(SoteriaSpacing.lg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _CategoryHeader(category: cat),
                    ...items.map((item) => _PreviewListTile(item: item)),
                  ]),
                ),
              );
            })
          else
            SliverPadding(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _PreviewListTile(item: results[index]),
                  childCount: results.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final PreviewCategory category;
  const _CategoryHeader({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
      child: Row(
        children: [
          Icon(category.icon, size: 16, color: SoteriaColors.muted),
          SizedBox(width: SoteriaSpacing.sm),
          Text(
            category.label.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewListTile extends StatelessWidget {
  final PreviewItem item;
  const _PreviewListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        item.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        item.description,
        style: context.bodySmall.copyWith(color: SoteriaColors.muted),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PreviewDetailScreen(item: item),
        ),
      ),
    );
  }
}
