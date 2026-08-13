import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/features/player/domain/models/competitive_challenge.dart';
import 'package:soteria/features/player/presentation/widgets/competitive_rank_badge.dart';
import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';
import 'package:soteria/features/player/presentation/providers/challenge_providers.dart';

class OutgoingChallengeCard extends ConsumerWidget {
  final CompetitiveChallenge challenge;

  const OutgoingChallengeCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(challenge.challengedPlayerId));

    return SoteriaCard(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Column(
        children: [
          profileAsync.when(
            data: (profile) => profile != null
                ? _buildProfileInfo(context, profile)
                : const Text('Unknown Rival'),
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text('Error loading rival'),
          ),
          const Divider(height: 32, color: Colors.white10),
          _buildStatusInfo(context),
          if (challenge.status == ChallengeStatus.pending) ...[
            const SizedBox(height: 16),
            _buildActions(context, ref),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, dynamic profile) {
    return Row(
      children: [
        SoteriaAvatar(
          avatar: AvatarCatalog().getById(profile.avatarId),
          size: 48,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.displayName,
                style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'PENDING ACCEPTANCE',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 1),
              ),
            ],
          ),
        ),
        CompetitiveRankBadge(
          rankName: profile.currentRank,
          tierId: profile.rankTier.toLowerCase(),
          size: RankBadgeSize.small,
        ),
      ],
    );
  }

  Widget _buildStatusInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusBadge(challenge.status),
        Text(
          'Expires in ${_getTimeRemaining()}',
          style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(ChallengeStatus status) {
    Color color;
    switch (status) {
      case ChallengeStatus.pending: color = SoteriaColors.warning; break;
      case ChallengeStatus.accepted: color = SoteriaColors.success; break;
      case ChallengeStatus.declined: color = SoteriaColors.error; break;
      case ChallengeStatus.expired: color = SoteriaColors.muted; break;
      default: color = SoteriaColors.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => ref.read(challengeControllerProvider.notifier).cancelChallenge(challenge.challengeId),
        style: OutlinedButton.styleFrom(foregroundColor: SoteriaColors.error),
        child: const Text('CANCEL CHALLENGE'),
      ),
    );
  }

  String _getTimeRemaining() {
    final diff = challenge.expiresAt.difference(DateTime.now());
    if (diff.isNegative) return 'Expired';
    if (diff.inHours > 0) return '${diff.inHours}h';
    return '${diff.inMinutes}m';
  }
}
