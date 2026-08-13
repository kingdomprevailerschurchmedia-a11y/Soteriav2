import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/presentation/providers/identity_providers.dart';
import 'package:soteria/features/player/presentation/widgets/identity/identity_showcase_header.dart';
import 'package:soteria/features/player/presentation/widgets/identity/featured_badges_row.dart';
import 'package:soteria/features/player/presentation/widgets/identity/title_selection_sheet.dart';
import 'package:soteria/features/player/presentation/widgets/identity/badge_customization_sheet.dart';
import 'package:soteria/features/player/presentation/providers/activity_providers.dart';
import 'package:soteria/features/player/domain/models/competitive_activity_event.dart';
import 'package:soteria/features/player/domain/models/competitive_event.dart';
import 'package:soteria/features/player/domain/models/competitive_identity.dart';
import 'package:soteria/features/player/presentation/widgets/profile/statistic_card.dart';

class CompetitiveShowcaseScreen extends ConsumerWidget {
  const CompetitiveShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identityAsync = ref.watch(competitiveIdentityProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('COMPETITIVE IDENTITY'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: identityAsync.when(
        data: (identity) => identity != null
            ? _buildContent(context, ref, identity)
            : const Center(child: Text('No Identity Data')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    CompetitiveIdentity identity,
  ) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaFadeIn(
          child: IdentityShowcaseHeader(identity: identity),
        ),
        SizedBox(height: SoteriaSpacing.xxl),
        
        _buildSectionHeader(context, 'FEATURED BADGES', onAction: () => _showBadgeCustomization(context, ref, identity)),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          child: FeaturedBadgesRow(
            badges: identity.featuredBadges,
            maxBadges: 5,
          ),
        ),
        
        SizedBox(height: SoteriaSpacing.xxl),
        _buildSectionHeader(context, 'RECENT HIGHLIGHTS'),
        SizedBox(height: SoteriaSpacing.md),
        _buildHighlightsSection(context, ref),
        
        SizedBox(height: SoteriaSpacing.xxl),
        _buildSectionHeader(context, 'CAREER STATS'),
        SizedBox(height: SoteriaSpacing.md),
        _buildHighlightsGrid(context, identity),
        
        SizedBox(height: SoteriaSpacing.xxl),
        _buildSectionHeader(context, 'ACTIVE TITLE', onAction: () => _showTitleSelection(context, ref, identity)),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          onTap: () => _showTitleSelection(context, ref, identity),
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          child: Row(
            children: [
              Icon(Icons.title_rounded, color: SoteriaColors.secondary, size: 24.sp),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      identity.equippedTitle?.name ?? 'NO TITLE EQUIPPED',
                      style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      identity.equippedTitle?.description ?? 'Complete achievements to earn titles.',
                      style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                    ),
                  ],
                ),
              ),
              Icon(Icons.edit_rounded, color: SoteriaColors.muted, size: 16.sp),
            ],
          ),
        ),
        
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {VoidCallback? onAction}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w900,
          ),
        ),
        if (onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: SoteriaColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'CUSTOMIZE',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHighlightsSection(BuildContext context, WidgetRef ref) {
    final highlightsAsync = ref.watch(activityHighlightsProvider);

    return highlightsAsync.when(
      data: (highlights) {
        if (highlights.isEmpty) {
          return SoteriaCard(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(SoteriaSpacing.lg),
                child: Text(
                  'No recent highlights yet. Keep competing!',
                  style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
                ),
              ),
            ),
          );
        }

        return Column(
          children: highlights.take(3).map((event) => Padding(
            padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
            child: SoteriaCard(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _getHighlightColor(event.type).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getHighlightIcon(event.type),
                      color: _getHighlightColor(event.type),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: SoteriaSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          event.description,
                          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  IconData _getHighlightIcon(CompetitiveEventType type) {
    switch (type) {
      case CompetitiveEventType.rankPromoted:
        return Icons.trending_up_rounded;
      case CompetitiveEventType.milestoneCompleted:
      case CompetitiveEventType.achievementUnlocked:
        return Icons.emoji_events_rounded;
      case CompetitiveEventType.streakReached:
        return Icons.local_fire_department_rounded;
      case CompetitiveEventType.tournamentResult:
        return Icons.emoji_events_rounded;
      case CompetitiveEventType.personalBest:
        return Icons.auto_awesome_rounded;
      default:
        return Icons.stars_rounded;
    }
  }

  Color _getHighlightColor(CompetitiveEventType type) {
    switch (type) {
      case CompetitiveEventType.rankPromoted:
        return SoteriaColors.secondary;
      case CompetitiveEventType.milestoneCompleted:
      case CompetitiveEventType.achievementUnlocked:
        return SoteriaColors.gold;
      case CompetitiveEventType.streakReached:
        return SoteriaColors.error;
      case CompetitiveEventType.personalBest:
        return SoteriaColors.xpColor;
      default:
        return SoteriaColors.primary;
    }
  }

  Widget _buildHighlightsGrid(BuildContext context, CompetitiveIdentity identity) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.0,
      mainAxisSpacing: SoteriaSpacing.md,
      crossAxisSpacing: SoteriaSpacing.md,
      children: [
        StatisticCard(
          label: 'Peak Rank',
          value: (identity.profile.settings['peakRank'] as String?) ?? 'UNRANKED',
          icon: Icons.auto_awesome_rounded,
          color: SoteriaColors.gold,
        ),
        StatisticCard(
          label: 'Best Position',
          value: identity.profile.settings['peakPosition'] != null 
              ? '#${identity.profile.settings['peakPosition']}' 
              : 'N/A',
          icon: Icons.public_rounded,
          color: SoteriaColors.xpColor,
        ),
        StatisticCard(
          label: 'Win Streak',
          value: identity.profile.highestStreak.toString(),
          icon: Icons.local_fire_department_rounded,
          color: SoteriaColors.error,
        ),
        StatisticCard(
          label: 'Tournaments',
          value: identity.profile.tournamentMatches.toString(),
          icon: Icons.emoji_events_rounded,
          color: SoteriaColors.secondary,
        ),
      ],
    );
  }

  void _showTitleSelection(BuildContext context, WidgetRef ref, CompetitiveIdentity identity) {
    TitleSelectionSheet.show(
      context,
      ownedTitles: identity.allOwnedTitles,
      currentlyEquippedId: identity.equippedTitle?.id,
    );
  }

  void _showBadgeCustomization(BuildContext context, WidgetRef ref, CompetitiveIdentity identity) {
    BadgeCustomizationSheet.show(
      context,
      ownedBadges: identity.allOwnedBadges,
      initialFeaturedIds: identity.profile.featuredBadgeIds,
    );
  }
}
