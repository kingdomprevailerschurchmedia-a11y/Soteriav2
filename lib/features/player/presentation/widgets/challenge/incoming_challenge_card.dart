import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/features/player/domain/models/competitive_challenge.dart';
import '../presence/player_presence_indicator.dart';
import '../competitive_rank_badge.dart';
import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';
import 'package:soteria/features/player/presentation/providers/challenge_providers.dart';

class IncomingChallengeCard extends ConsumerWidget {
  final CompetitiveChallenge challenge;

  const IncomingChallengeCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(challenge.challengerId));

    return SoteriaCard(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Column(
        children: [
          profileAsync.when(
            data: (profile) => profile != null
                ? _buildProfileInfo(context, profile)
                : const Text('Unknown Challenger'),
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text('Error loading challenger'),
          ),
          const Divider(height: 32, color: Colors.white10),
          _buildRulesInfo(context),
          const SizedBox(height: 16),
          _buildActions(context, ref),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, dynamic profile) {
    return Row(
      children: [
        Stack(
          children: [
            SoteriaAvatar(
              avatar: AvatarCatalog().getById(profile.avatarId),
              size: 48,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: PlayerPresenceIndicator(userId: challenge.challengerId, size: 12),
            ),
          ],
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
                'WANTS TO COMPETE',
                style: context.labelSmall.copyWith(color: SoteriaColors.primary, letterSpacing: 1),
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

  Widget _buildRulesInfo(BuildContext context) {
    final config = challenge.configuration;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfoItem(context, 'MODE', '1v1 Versus'),
        _buildInfoItem(context, 'CATEGORY', config['categoryName'] ?? 'General'),
        _buildInfoItem(context, 'QUESTIONS', '${config['questionCount'] ?? 10}'),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontSize: 8)),
        Text(value, style: context.bodySmall.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    final controllerAsync = ref.watch(challengeControllerProvider);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: controllerAsync.isLoading 
              ? null 
              : () => ref.read(challengeControllerProvider.notifier).declineChallenge(challenge.challengeId),
            style: OutlinedButton.styleFrom(foregroundColor: SoteriaColors.muted),
            child: const Text('DECLINE'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: controllerAsync.isLoading 
              ? null 
              : () => ref.read(challengeControllerProvider.notifier).acceptChallenge(challenge.challengeId),
            style: ElevatedButton.styleFrom(backgroundColor: SoteriaColors.primary),
            child: const Text('ACCEPT'),
          ),
        ),
      ],
    );
  }
}
