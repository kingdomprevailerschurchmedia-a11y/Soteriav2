import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../../core/avatar/data/avatar_catalog.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/public_competitive_profile.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';
import 'package:soteria/features/social/domain/models/relationship_status.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import '../competitive_rank_badge.dart';
import '../identity/competitive_title_widget.dart';

class PlayerSearchResultCard extends ConsumerWidget {
  final PublicCompetitiveProfile profile;
  final VoidCallback onTap;

  const PlayerSearchResultCard({
    super.key,
    required this.profile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationshipStatus = ref.watch(relationshipStatusProvider(profile.userId));
    final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
    final isMe = currentUserId == profile.userId;

    return SoteriaCard(
      onTap: onTap,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      margin: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              SoteriaAvatar(
                avatar: AvatarCatalog().getById(profile.avatarId),
                size: 48,
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.displayName,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (profile.equippedTitle != null) ...[
                      SizedBox(height: SoteriaSpacing.xs),
                      CompetitiveTitleWidget(title: profile.equippedTitle!),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CompetitiveRankBadge(
                    rankName: profile.currentRank,
                    tierId: profile.rankTier.toLowerCase(),
                    size: RankBadgeSize.small,
                  ),
                  SizedBox(height: SoteriaSpacing.xs),
                  Text(
                    '${profile.rankPoints} RP',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (!isMe) ...[
            SizedBox(height: SoteriaSpacing.md),
            _SocialActions(
              status: relationshipStatus.maybeWhen(
                data: (status) => status,
                orElse: () => RelationshipStatus.none,
              ),
              userId: profile.userId,
            ),
          ],
        ],
      ),
    );
  }
}

class _SocialActions extends ConsumerWidget {
  final RelationshipStatus status;
  final String userId;

  const _SocialActions({
    required this.status,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(socialControllerProvider.notifier);
    final currentUserId = ref.read(authRepositoryProvider).currentUserId ?? '';

    switch (status) {
      case RelationshipStatus.none:
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => controller.sendRequest(userId),
            icon: const Icon(Icons.person_add_rounded, size: 18),
            label: const Text('ADD FRIEND'),
          ),
        );
      case RelationshipStatus.requestSent:
        final requestId = '${currentUserId}_$userId';
        return Row(
          children: [
            Expanded(
              child: Text(
                'Request Sent',
                style: context.labelMedium.copyWith(color: SoteriaColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () => controller.cancelRequest(requestId, userId),
              child: const Text('CANCEL'),
            ),
          ],
        );
      case RelationshipStatus.requestReceived:
        final requestId = '${userId}_$currentUserId';
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.acceptRequest(requestId, userId),
                child: const Text('ACCEPT'),
              ),
            ),
            SizedBox(width: SoteriaSpacing.sm),
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.declineRequest(requestId, userId),
                child: const Text('DECLINE'),
              ),
            ),
          ],
        );
      case RelationshipStatus.friends:
        return Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: SoteriaColors.success, size: 18),
            SizedBox(width: SoteriaSpacing.xs),
            Text(
              'Friends',
              style: context.labelMedium.copyWith(color: SoteriaColors.success),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => controller.removeFriend(userId),
              child: Text('REMOVE', style: TextStyle(color: SoteriaColors.error)),
            ),
          ],
        );
      case RelationshipStatus.blocked:
        return Text('You have blocked this player', style: context.labelMedium);
      case RelationshipStatus.blockedBy:
        return const SizedBox.shrink();
    }
  }
}
