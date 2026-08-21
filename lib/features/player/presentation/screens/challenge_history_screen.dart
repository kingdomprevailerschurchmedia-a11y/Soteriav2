import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../providers/challenge_providers.dart';
import '../../domain/models/competitive_challenge.dart';
import '../providers/public_profile_providers.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:intl/intl.dart';

class ChallengeHistoryScreen extends ConsumerWidget {
  const ChallengeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(challengeHistoryProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('CHALLENGE HISTORY'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: historyAsync.when(
        data: (challenges) {
          if (challenges.isEmpty) {
            return const Center(child: Text('No challenge history found.'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(SoteriaSpacing.md),
            itemCount: challenges.length,
            itemBuilder: (context, index) => _ChallengeHistoryCard(challenge: challenges[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _ChallengeHistoryCard extends ConsumerWidget {
  final CompetitiveChallenge challenge;

  const _ChallengeHistoryCard({required this.challenge});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Current user can be challenger or challenged
    final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
    final otherUserId = challenge.challengerId == currentUserId ? challenge.challengedPlayerId : challenge.challengerId;
    final profileAsync = ref.watch(publicProfileProvider(otherUserId));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Row(
          children: [
            profileAsync.when(
              data: (profile) => SoteriaAvatar(
                avatar: AvatarCatalog().getById(profile?.avatarId ?? 'socrates'),
                size: 48,
                imageUrl: profile?.photoUrl,
              ),
              loading: () => const SizedBox(width: 48, height: 48, child: CircularProgressIndicator()),
              error: (_, _) => const Icon(Icons.error, size: 48),
            ),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatChallengeTitle(challenge),
                    style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('MMM d, yyyy').format(challenge.createdAt),
                    style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                  ),
                ],
              ),
            ),
            _buildStatusBadge(challenge),
          ],
        ),
      ),
    );
  }

  String _formatChallengeTitle(CompetitiveChallenge challenge) {
    switch (challenge.type) {
      case ChallengeType.matchWins: return 'First to ${challenge.target.toInt()} wins';
      case ChallengeType.matchScore: return 'Highest score challenge';
      default: return 'Competitive Challenge';
    }
  }

  Widget _buildStatusBadge(CompetitiveChallenge challenge) {
    Color color;
    String text = challenge.status.name.toUpperCase();

    switch (challenge.status) {
      case ChallengeStatus.completed:
        color = SoteriaColors.success;
        break;
      case ChallengeStatus.declined:
      case ChallengeStatus.expired:
      case ChallengeStatus.cancelled:
        color = SoteriaColors.error;
        break;
      default:
        color = SoteriaColors.muted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
