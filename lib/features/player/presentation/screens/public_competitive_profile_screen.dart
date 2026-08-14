import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../providers/public_profile_providers.dart';
import '../widgets/profile/statistic_card.dart';
import '../widgets/competitive_rank_badge.dart';
import '../widgets/presence/player_presence_indicator.dart';
import '../widgets/presence/presence_label.dart';
import '../widgets/presence/competitive_quick_actions.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../widgets/identity/competitive_title_widget.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../social/domain/models/relationship_status.dart';
import '../../../social/presentation/providers/social_providers.dart';
import '../../domain/models/public_competitive_profile.dart';
import '../widgets/challenge/challenge_player_sheet.dart';

class PublicCompetitiveProfileScreen extends ConsumerWidget {
  final String userId;

  const PublicCompetitiveProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(userId));
    final relationshipAsync = ref.watch(relationshipStatusProvider(userId));
    final currentUserId = ref.watch(authRepositoryProvider).currentUserId;

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Competitor Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) return _buildNotFound(context);
          return _buildContent(context, ref, profile, currentUserId, relationshipAsync.value ?? RelationshipStatus.none);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: SoteriaColors.primary),
        ),
        error: (error, _) => _buildError(context, error.toString()),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, PublicCompetitiveProfile profile, String? currentUserId, RelationshipStatus relationship) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      children: [
        SizedBox(height: SoteriaSpacing.md),
        _buildHeader(context, ref, profile, currentUserId, relationship),
        SizedBox(height: SoteriaSpacing.lg),
        _buildStatsGrid(context, profile),
        SizedBox(height: SoteriaSpacing.lg),
        _buildCareerHighlights(context, profile),
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, PublicCompetitiveProfile profile, String? currentUserId, RelationshipStatus relationship) {
    return SoteriaSlideUp(
      child: Container(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        decoration: BoxDecoration(
          color: SoteriaColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SoteriaAvatar(
                  avatar: AvatarCatalog().getById(profile.avatarId),
                  size: 80,
                  imageUrl: profile.photoUrl,
                ),
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: PlayerPresenceIndicator(userId: userId, size: 20),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              profile.displayName,
              style: context.headlineSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            if (profile.equippedTitle != null) ...[
              SizedBox(height: SoteriaSpacing.xs),
              CompetitiveTitleWidget(title: profile.equippedTitle!),
            ],
            SizedBox(height: SoteriaSpacing.xs),
            PresenceLabel(userId: userId),
            SizedBox(height: SoteriaSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CompetitiveRankBadge(
                  rankName: profile.currentRank,
                  tierId: profile.rankTier.toLowerCase(),
                  size: RankBadgeSize.large,
                ),
                SizedBox(width: SoteriaSpacing.lg),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${profile.rankPoints} RP',
                      style: context.titleMedium.copyWith(
                        color: SoteriaColors.gold,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'DIVISION ${profile.division}',
                      style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                    ),
                  ],
                ),
              ],
            ),
            if (profile.featuredBadges.isNotEmpty) ...[
              SizedBox(height: SoteriaSpacing.lg),
              _buildFeaturedBadges(profile.featuredBadges),
            ],
            if (currentUserId != userId) ...[
              SizedBox(height: SoteriaSpacing.xl),
              _buildActions(context, ref, relationship, profile),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, RelationshipStatus relationship, PublicCompetitiveProfile profile) {
    return Column(
      children: [
        CompetitiveQuickActions(userId: userId, profile: profile),
        SizedBox(height: SoteriaSpacing.md),
        _buildRelationshipButton(context, ref, relationship),
      ],
    );
  }

  Widget _buildRelationshipButton(BuildContext context, WidgetRef ref, RelationshipStatus relationship) {
    switch (relationship) {
      case RelationshipStatus.none:
        return Expanded(
          child: SoteriaButton.secondary(
            label: 'ADD FRIEND',
            onPressed: () => ref.read(socialControllerProvider.notifier).sendRequest(userId),
          ),
        );
      case RelationshipStatus.requestSent:
        return Expanded(
          child: SoteriaButton.outline(
            label: 'PENDING',
            onPressed: null, // Could add cancel logic
          ),
        );
      case RelationshipStatus.requestReceived:
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: SoteriaButton.secondary(
                  label: 'ACCEPT',
                  onPressed: () => _handleAcceptRequest(ref),
                ),
              ),
              SizedBox(width: SoteriaSpacing.sm),
              IconButton(
                icon: const Icon(Icons.close_rounded, color: SoteriaColors.error),
                onPressed: () => _handleDeclineRequest(ref),
              ),
            ],
          ),
        );
      case RelationshipStatus.friends:
        return Expanded(
          child: SoteriaButton.outline(
            label: 'REMOVE',
            onPressed: () => _showRemoveFriendDialog(context, ref),
          ),
        );
      case RelationshipStatus.blocked:
        return Expanded(
          child: SoteriaButton.outline(
            label: 'UNBLOCK',
            onPressed: () {},
          ),
        );
      case RelationshipStatus.blockedBy:
        return const SizedBox.shrink();
    }
  }

  void _handleAcceptRequest(WidgetRef ref) {
    final requests = ref.read(incomingRequestsProvider).value ?? [];
    final request = requests.where((r) => r.senderId == userId).firstOrNull;
    if (request != null) {
      ref.read(socialControllerProvider.notifier).acceptRequest(request.id, userId);
    }
  }

  void _handleDeclineRequest(WidgetRef ref) {
    final requests = ref.read(incomingRequestsProvider).value ?? [];
    final request = requests.where((r) => r.senderId == userId).firstOrNull;
    if (request != null) {
      ref.read(socialControllerProvider.notifier).declineRequest(request.id, userId);
    }
  }

  void _showRemoveFriendDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Friend'),
        content: const Text('Are you sure you want to remove this friend?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              ref.read(socialControllerProvider.notifier).removeFriend(userId);
              Navigator.pop(context);
            },
            child: const Text('REMOVE', style: TextStyle(color: SoteriaColors.error)),
          ),
        ],
      ),
    );
  }


  void _showChallengeSheet(BuildContext context, PublicCompetitiveProfile profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChallengePlayerSheet(profile: profile),
    );
  }

  Widget _buildFeaturedBadges(List<dynamic> badges) {
    return Wrap(
      spacing: SoteriaSpacing.sm,
      children: badges.map((badge) {
        return Tooltip(
          message: badge.name,
          child: Image.asset(
            badge.iconAsset,
            width: 32.w,
            height: 32.w,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatsGrid(BuildContext context, PublicCompetitiveProfile profile) {
    final stats = profile.careerHighlights;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.6,
      mainAxisSpacing: SoteriaSpacing.md,
      crossAxisSpacing: SoteriaSpacing.md,
      children: [
        StatisticCard(
          label: 'Matches',
          value: stats.gamesPlayed.toString(),
          icon: Icons.sports_esports_rounded,
        ),
        StatisticCard(
          label: 'Wins',
          value: stats.gamesWon.toString(),
          icon: Icons.emoji_events_rounded,
          color: SoteriaColors.success,
        ),
        StatisticCard(
          label: 'Win Rate',
          value: '${(stats.winRate * 100).toInt()}%',
          icon: Icons.star_rounded,
          color: SoteriaColors.primary,
        ),
        StatisticCard(
          label: 'Accuracy',
          value: '${(stats.accuracy * 100).toInt()}%',
          icon: Icons.track_changes_rounded,
          color: SoteriaColors.warning,
        ),
      ],
    );
  }

  Widget _buildCareerHighlights(BuildContext context, PublicCompetitiveProfile profile) {
    final stats = profile.careerHighlights;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CAREER HIGHLIGHTS',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        _buildHighlightItem(context, 'Best Rank', stats.bestRank, Icons.military_tech_rounded),
        _buildHighlightItem(context, 'Peak Position', '#${stats.peakPosition}', Icons.trending_up_rounded),
        _buildHighlightItem(context, 'Highest Streak', '${stats.highestStreak} WINS', Icons.whatshot_rounded),
      ],
    );
  }

  Widget _buildHighlightItem(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: SoteriaColors.muted, size: 20.w),
          SizedBox(width: SoteriaSpacing.md),
          Text(label, style: context.bodyMedium.copyWith(color: SoteriaColors.muted)),
          const Spacer(),
          Text(
            value,
            style: context.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: SoteriaColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Text('Competitor not found.', style: context.bodyMedium),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Center(
      child: Text('Error: $error', style: context.bodyMedium.copyWith(color: SoteriaColors.error)),
    );
  }
}
