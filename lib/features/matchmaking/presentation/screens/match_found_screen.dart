import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../../../player/providers/player_providers.dart';
import '../providers/matchmaking_providers.dart';
import '../domain/models/matchmaking_status.dart';

class MatchFoundScreen extends ConsumerWidget {
  const MatchFoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(matchmakingSessionProvider);
    final player = ref.watch(currentPlayerProvider);

    ref.listen(matchmakingSessionProvider, (prev, next) {
      final session = next.value;
      if (session?.status == MatchmakingStatus.matched && session?.matchId != null) {
        context.pushReplacement('/app/versus/${session!.matchId}');
      } else if (session?.status == MatchmakingStatus.cancelled) {
        context.pop();
      }
    });

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: SoteriaColors.background,
        body: sessionAsync.when(
          data: (session) {
            if (session == null || session.opponentId == null) {
              return const Center(child: Text('Waiting for data...'));
            }

            final opponentAsync = ref.watch(publicProfileProvider(session.opponentId!));

            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(gradient: SoteriaColors.backgroundGradient),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: SoteriaSpacing.xxl),
                    Text(
                      'MATCH FOUND',
                      style: context.displaySmall.copyWith(
                        fontWeight: FontWeight.w900,
                        color: SoteriaColors.gold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _PlayerCard(
                          name: player?.displayName ?? 'You',
                          rank: session.rankSnapshot['rankName'] ?? 'Bronze',
                          tier: session.rankSnapshot['tier'] ?? 'III',
                          photoUrl: player?.photoUrl,
                          isReady: session.isReady,
                        ),
                        Text(
                          'VS',
                          style: context.headlineMedium.copyWith(
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        opponentAsync.when(
                          data: (opp) => _PlayerCard(
                            name: opp?.displayName ?? 'Opponent',
                            rank: opp?.currentRank ?? 'Bronze',
                            tier: opp?.rankTier ?? 'III',
                            photoUrl: opp?.photoUrl,
                            isReady: session.opponentReady,
                          ),
                          loading: () => const CircularProgressIndicator(),
                          error: (_, __) => const _PlayerCard(
                            name: '???',
                            rank: 'Unknown',
                            tier: '',
                            isReady: false,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.all(SoteriaSpacing.xl),
                      child: Column(
                        children: [
                          _MatchRules(config: session.configuration),
                          SizedBox(height: SoteriaSpacing.xxl),
                          SoteriaButton.primary(
                            label: session.isReady ? 'READY' : 'I\'M READY',
                            isLoading: session.isReady && !session.opponentReady,
                            onPressed: session.isReady 
                              ? null 
                              : () => ref.read(matchmakingControllerProvider.notifier).confirmReady(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final String name;
  final String rank;
  final String tier;
  final String? photoUrl;
  final bool isReady;

  const _PlayerCard({
    required this.name,
    required this.rank,
    required this.tier,
    this.photoUrl,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            SoteriaAvatar(
              imageUrl: photoUrl,
              size: 80,
              showGlow: isReady,
            ),
            if (isReady)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: SoteriaColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        Text(
          name,
          style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '$rank $tier'.toUpperCase(),
          style: context.labelSmall.copyWith(color: SoteriaColors.gold),
        ),
      ],
    );
  }
}

class _MatchRules extends StatelessWidget {
  final Map<String, dynamic> config;
  const _MatchRules({required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _RuleItem(label: 'CATEGORY', value: config['categoryName'] ?? 'General'),
          _RuleItem(label: 'QUESTIONS', value: '${config['questionCount'] ?? 10}'),
          _RuleItem(label: 'DIFFICULTY', value: config['difficulty']?.toUpperCase() ?? 'MEDIUM'),
        ],
      ),
    );
  }
}

class _RuleItem extends StatelessWidget {
  final String label;
  final String value;
  const _RuleItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontSize: 8)),
        Text(value, style: context.bodySmall.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
