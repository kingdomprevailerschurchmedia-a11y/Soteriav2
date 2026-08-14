import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/question_content/domain/selection/selection_models.dart';
import 'package:soteria/features/question_content/presentation/providers/selection_providers.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/providers/player_providers.dart';

class PersonalizationPreview extends ConsumerWidget {
  const PersonalizationPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeGradientScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Personalization & Selection'),
            backgroundColor: Colors.transparent,
            floating: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSection(
                  context,
                  'Profile: Single Interest (Science)',
                  _PersonalizedSelectionList(
                    profileOverride: _createMockProfile(['science']),
                  ),
                ),
                _buildSection(
                  context,
                  'Profile: Multiple Interests (Science + Technology)',
                  _PersonalizedSelectionList(
                    profileOverride: _createMockProfile(['science', 'technology']),
                  ),
                ),
                _buildSection(
                  context,
                  'Profile: No Interests (Fallback to General Knowledge)',
                  _PersonalizedSelectionList(
                    profileOverride: _createMockProfile([]),
                  ),
                ),
                _buildSection(
                  context,
                  'Request: Explicit Category (Business)',
                  _PersonalizedSelectionList(
                    requestOverride: const QuestionSelectionRequest(
                      categoryIds: ['business'],
                      questionCount: 5,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.titleMedium.copyWith(color: SoteriaColors.gold),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white10),
          ),
          child: child,
        ),
        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }

  PlayerProfile _createMockProfile(List<String> categories) {
    return PlayerProfile(
      uid: 'mock-user',
      displayName: 'Mock Explorer',
      email: 'mock@soteria.app',
      favoriteCategories: categories,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class _PersonalizedSelectionList extends ConsumerWidget {
  const _PersonalizedSelectionList({
    this.profileOverride,
    this.requestOverride,
  });

  final PlayerProfile? profileOverride;
  final QuestionSelectionRequest? requestOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = requestOverride ?? const QuestionSelectionRequest(questionCount: 5);
    
    return ProviderScope(
      overrides: [
        if (profileOverride != null)
          currentPlayerStreamProvider.overrideWith((ref) => Stream.value(profileOverride)),
      ],
      child: Consumer(
        builder: (context, ref, child) {
          final selectionAsync = ref.watch(personalizedQuestionSelectionProvider(request));

          return selectionAsync.when(
            data: (result) => _buildList(context, result),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, QuestionSelectionResult result) {
    if (result.questions.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, color: Colors.white24, size: 48),
            SizedBox(height: 16.h),
            Text(
              result.status == SelectionStatus.insufficientContent 
                  ? 'Insufficient Content' 
                  : 'Empty Selection',
              style: context.bodyMedium.copyWith(color: Colors.white38),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      itemCount: result.questions.length,
      itemBuilder: (context, index) {
        final q = result.questions[index];
        return Card(
          color: Colors.white.withValues(alpha: 0.05),
          margin: EdgeInsets.only(bottom: 8.h),
          child: ListTile(
            dense: true,
            title: Text(
              q.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodySmall.copyWith(color: Colors.white),
            ),
            subtitle: Text(
              '${q.categoryId.toUpperCase()} • ${q.difficulty.name}',
              style: context.labelSmall.copyWith(color: Colors.white38),
            ),
          ),
        );
      },
    );
  }
}
