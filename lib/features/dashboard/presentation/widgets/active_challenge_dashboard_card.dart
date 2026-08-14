import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../player/domain/models/competitive_challenge.dart';
import '../../../player/presentation/providers/challenge_providers.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../../../auth/providers/auth_providers.dart';

class ActiveChallengeDashboardCard extends ConsumerWidget {
  const ActiveChallengeDashboardCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(activeChallengesProvider);

    return challengesAsync.when(
      data: (challenges) {
        if (challenges.isEmpty) return const SizedBox.shrink();
        
        final challenge = challenges.first; // Just show one on the dashboard
        return _ChallengeCard(challenge: challenge);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _ChallengeCard extends ConsumerWidget {
  final CompetitiveChallenge challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
    final otherUserId = challenge.challengerId == currentUserId ? challenge.challengedPlayerId : challenge.challengerId;
    final profileAsync = ref.watch(publicProfileProvider(otherUserId));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md, vertical: SoteriaSpacing.sm),
      child: GlassSurface(
        borderRadius: BorderRadius.circular(16.r),
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: SoteriaColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.bolt, color: Colors.white, size: 16),
                ),
                SizedBox(width: SoteriaSpacing.sm),
                Text('ACTIVE CHALLENGE', style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 1.5)),
                const Spacer(),
                Text(
                  _getTimeLeft(challenge.expiresAt),
                  style: context.labelSmall.copyWith(color: SoteriaColors.warning),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            Row(
              children: [
                profileAsync.when(
                  data: (profile) => SoteriaAvatar(
                    avatar: AvatarCatalog().getById(profile?.avatarId ?? 'socrates'),
                    size: 40,
                    imageUrl: profile?.photoUrl,
                  ),
                  loading: () => const SizedBox(width: 40, height: 40, child: CircularProgressIndicator()),
                  error: (_, __) => const Icon(Icons.error),
                ),
                SizedBox(width: SoteriaSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VS ${challenge.challengerId == currentUserId ? " Jordan" : " Alex"}', // Mock display name for now if profile not loaded
                        style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${challenge.challengerProgress.toInt()} - ${challenge.opponentProgress.toInt()} in progress',
                        style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context.push('/challenges/${challenge.challengeId}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: const Text('VIEW'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeLeft(DateTime expiresAt) {
    final diff = expiresAt.difference(DateTime.now());
    if (diff.inHours > 0) return '${diff.inHours}h LEFT';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m LEFT';
    return 'EXPIRED';
  }
}
