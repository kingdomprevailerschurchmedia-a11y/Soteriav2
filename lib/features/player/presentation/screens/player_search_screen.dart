import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../providers/public_profile_providers.dart';
import '../widgets/search/player_search_result_card.dart';
import 'public_competitive_profile_screen.dart';

class PlayerSearchScreen extends ConsumerStatefulWidget {
  const PlayerSearchScreen({super.key});

  @override
  ConsumerState<PlayerSearchScreen> createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends ConsumerState<PlayerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        ref.read(playerSearchQueryProvider.notifier).state = query;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResultsAsync = ref.watch(playerSearchProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          style: context.bodyLarge,
          cursorColor: SoteriaColors.primary,
          decoration: InputDecoration(
            hintText: 'Search competitors...',
            hintStyle: context.bodyLarge.copyWith(color: SoteriaColors.muted),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, color: SoteriaColors.muted),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  )
                : null,
          ),
          onChanged: _onSearchChanged,
        ),
      ),
      body: searchResultsAsync.when(
        data: (results) {
          if (_searchController.text.isEmpty) {
            return _buildEmptyState('Find your rivals by name or username.');
          }
          if (results.isEmpty) {
            return _buildEmptyState('No competitors found.');
          }
          return ListView.builder(
            padding: EdgeInsets.all(SoteriaSpacing.md),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final profile = results[index];
              return PlayerSearchResultCard(
                profile: profile,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PublicCompetitiveProfileScreen(userId: profile.userId),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: SoteriaColors.primary),
        ),
        error: (error, _) => _buildErrorState(error.toString()),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 64.w,
            color: SoteriaColors.muted.withValues(alpha: 0.2),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            message,
            style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, color: SoteriaColors.error, size: 48.w),
            SizedBox(height: SoteriaSpacing.md),
            Text('Search failed', style: context.titleMedium),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              'We encountered an error while searching. Please try again.',
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(color: SoteriaColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
