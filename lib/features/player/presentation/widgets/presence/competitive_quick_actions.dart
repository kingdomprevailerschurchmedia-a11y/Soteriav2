import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/features/player/domain/models/player_presence.dart';
import 'package:soteria/features/player/domain/models/competitive_challenge.dart';
import 'package:soteria/features/player/domain/models/public_competitive_profile.dart';
import 'package:soteria/features/player/presentation/providers/presence_providers.dart';
import 'package:soteria/features/player/presentation/providers/challenge_providers.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'package:soteria/features/social/domain/models/relationship_status.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';
import 'package:soteria/features/matchmaking/presentation/providers/match_result_providers.dart';

class CompetitiveQuickActions extends ConsumerWidget {
  final String userId;
  final PublicCompetitiveProfile profile;

  const CompetitiveQuickActions({
    super.key,
    required this.userId,
    required this.profile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenceAsync = ref.watch(playerPresenceProvider(userId));
    final relationshipAsync = ref.watch(relationshipStatusProvider(userId));
    final isRecent = ref.watch(isRecentOpponentProvider(userId));
    final incomingChallenges = ref.watch(incomingChallengesProvider).value ?? [];
    final outgoingChallenges = ref.watch(outgoingChallengesProvider).value ?? [];

    final incoming = incomingChallenges.where((c) => c.challengerId == userId && c.isPending).firstOrNull;
    final outgoing = outgoingChallenges.where((c) => c.challengedPlayerId == userId && c.isPending).firstOrNull;

    final relationship = relationshipAsync.value ?? RelationshipStatus.none;

    if (relationship == RelationshipStatus.blocked || relationship == RelationshipStatus.blockedBy) {
      return const SizedBox.shrink();
    }

    return presenceAsync.when(
      data: (presence) {
        if (presence?.status == PresenceStatus.offline && !isRecent) {
           return _buildChallengeButton(context);
        }

        if (incoming != null) {
          return _buildAcceptDecline(context, ref, incoming);
        }

        if (outgoing != null) {
          return _buildCancelButton(context, ref, outgoing);
        }

        if (presence?.status == PresenceStatus.inMatch) {
           return _buildInMatchState(context);
        }

        if (isRecent) {
           return _buildRematchButton(context, ref);
        }

        return _buildChallengeButton(context);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => _buildChallengeButton(context),
    );
  }

  Widget _buildChallengeButton(BuildContext context) {
    return SoteriaButton.primary(
      label: 'CHALLENGE',
      onPressed: () => _showChallengeSheet(context),
    );
  }

  Widget _buildRematchButton(BuildContext context, WidgetRef ref) {
    final controllerAsync = ref.watch(rematchControllerProvider);
    
    return SoteriaButton.primary(
      label: controllerAsync.isLoading ? 'REQUESTING...' : 'REMATCH',
      onPressed: controllerAsync.isLoading 
        ? null 
        : () {
            _showChallengeSheet(context);
          },
    );
  }

  Widget _buildAcceptDecline(BuildContext context, WidgetRef ref, CompetitiveChallenge challenge) {
    final controllerAsync = ref.watch(challengeControllerProvider);

    return Row(
      children: [
        Expanded(
          child: SoteriaButton.secondary(
            label: 'ACCEPT',
            onPressed: controllerAsync.isLoading 
              ? null 
              : () => ref.read(challengeControllerProvider.notifier).acceptChallenge(challenge.challengeId),
          ),
        ),
        SizedBox(width: SoteriaSpacing.sm),
        SoteriaButton.outline(
          label: 'DECLINE',
          onPressed: controllerAsync.isLoading 
            ? null 
            : () => ref.read(challengeControllerProvider.notifier).declineChallenge(challenge.challengeId),
        ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context, WidgetRef ref, CompetitiveChallenge challenge) {
    return SoteriaButton.outline(
      label: 'CANCEL OUTGOING',
      onPressed: () => ref.read(challengeControllerProvider.notifier).cancelChallenge(challenge.challengeId),
    );
  }

  Widget _buildInMatchState(BuildContext context) {
    return SoteriaButton.outline(
      label: 'IN MATCH',
      onPressed: null,
    );
  }

  void _showChallengeSheet(BuildContext context) {
    context.push('/app/challenges/create?opponentId=$userId');
  }
}
