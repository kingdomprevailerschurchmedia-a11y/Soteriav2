import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../../../player/presentation/screens/public_competitive_profile_screen.dart';
import '../../../player/presentation/widgets/competitive_rank_badge.dart';
import '../providers/social_providers.dart';
import '../providers/rivalry_providers.dart';
import '../widgets/rivalry_card.dart';
import 'friend_requests_screen.dart';
import 'head_to_head_screen.dart';

class FriendsScreen extends ConsumerWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendsProvider);
    final incomingRequests = ref.watch(incomingRequestsProvider).value ?? [];
    final topRivalriesAsync = ref.watch(topRivalriesProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('FRIENDS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard_rounded),
            onPressed: () => Navigator.pushNamed(context, '/app/leaderboard'), // This will show the FRIENDS tab if we logic it
          ),
          IconButton(
            icon: const Icon(Icons.person_add_rounded),
            onPressed: () => _showSearch(context),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          if (incomingRequests.isNotEmpty)
            SliverToBoxAdapter(child: _buildRequestsBanner(context, incomingRequests.length)),
          
          SliverToBoxAdapter(
            child: topRivalriesAsync.when(
              data: (rivalries) {
                if (rivalries.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.all(SoteriaSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOP RIVAL',
                        style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2),
                      ),
                      SizedBox(height: SoteriaSpacing.sm),
                      RivalryCard(rivalry: rivalries.first),
                    ],
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
            sliver: SliverToBoxAdapter(
              child: Text(
                'YOUR FRIENDS',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2),
              ),
            ),
          ),

          friendsAsync.when(
            data: (friends) {
              if (friends.isEmpty) return SliverFillRemaining(child: _buildEmptyState(context));
              return SliverPadding(
                padding: EdgeInsets.all(SoteriaSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final friendship = friends[index];
                      final otherUserId = friendship.userIds.firstWhere(
                        (id) => id != ref.read(authRepositoryProvider).currentUserId,
                      );
                      return _FriendListTile(userId: otherUserId);
                    },
                    childCount: friends.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator(color: SoteriaColors.primary))),
            error: (err, _) => SliverFillRemaining(child: Center(child: Text('Error: $err'))),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsBanner(BuildContext context, int count) {
    return Container(
      margin: EdgeInsets.all(SoteriaSpacing.md),
      child: Material(
        color: SoteriaColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        child: ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FriendRequestsScreen())),
          leading: const Icon(Icons.people_rounded, color: SoteriaColors.primary),
          title: Text('$count Friend Requests', style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.chevron_right_rounded, color: SoteriaColors.primary),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline_rounded, size: 64.w, color: SoteriaColors.muted.withValues(alpha: 0.3)),
          SizedBox(height: SoteriaSpacing.md),
          Text('You haven\'t added any rivals yet.', style: context.bodyMedium.copyWith(color: SoteriaColors.muted)),
          SizedBox(height: SoteriaSpacing.lg),
          SoteriaButton.secondary(
            label: 'FIND COMPETITORS',
            onPressed: () => _showSearch(context),
          ),
        ],
      ),
    );
  }

  void _showSearch(BuildContext context) {
    // Navigate to player search screen (already exists in features/player)
    context.push('/player/search'); 
  }
}

class _FriendListTile extends ConsumerWidget {
  final String userId;
  const _FriendListTile({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(userId));

    return profileAsync.when(
      data: (profile) {
        if (profile == null) return const SizedBox.shrink();
        return Card(
          margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
          color: SoteriaColors.surface.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: ListTile(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PublicCompetitiveProfileScreen(userId: userId))),
            leading: SoteriaAvatar(
              avatar: AvatarCatalog().getById(profile.avatarId),
              size: 48,
              imageUrl: profile.photoUrl,
            ),
            title: Text(profile.displayName, style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                CompetitiveRankBadge(rankName: profile.currentRank, tierId: profile.rankTier.toLowerCase(), size: RankBadgeSize.small),
                SizedBox(width: SoteriaSpacing.xs),
                Text('${profile.rankPoints} RP', style: context.labelSmall.copyWith(color: SoteriaColors.gold)),
              ],
            ),
            trailing: SoteriaButton.outline(
              label: 'CHALLENGE',
              size: SoteriaButtonSize.sm,
              isFullWidth: false,
              onPressed: () {
                // Open challenge sheet
              },
            ),
          ),
        );
      },
      loading: () => const SizedBox(height: 72, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
