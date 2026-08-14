import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../../../player/providers/player_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../gameplay_engine/models/versus_match.dart';
import '../providers/match_lifecycle_providers.dart';

class MatchReadyView extends ConsumerWidget {
  final VersusMatch match;
  const MatchReadyView({super.key, required this.match});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
    final isPlayerA = match.playerAId == currentUserId;
    final opponentId = isPlayerA ? match.playerBId : match.playerAId;
    final amIReady = isPlayerA ? match.playerAReady : match.playerBReady;
    final isOpponentReady = isPlayerA ? match.playerBReady : match.playerAReady;

    final opponentAsync = ref.watch(publicProfileProvider(opponentId));

    return Scaffold(
      backgroundColor: SoteriaColors.background,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: SoteriaColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: SoteriaSpacing.xxl),
              Text(
                'PREPARE FOR BATTLE',
                style: context.headlineSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ReadyPlayerCard(
                    label: 'YOU',
                    isReady: amIReady,
                    photoUrl: ref.watch(currentPlayerProvider)?.photoUrl,
                  ),
                  Text(
                    'VS',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  opponentAsync.when(
                    data: (opp) => _ReadyPlayerCard(
                      label: opp?.displayName.toUpperCase() ?? 'OPPONENT',
                      isReady: isOpponentReady,
                      photoUrl: opp?.photoUrl,
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const _ReadyPlayerCard(label: '???', isReady: false),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(SoteriaSpacing.xl),
                child: Column(
                  children: [
                    _MatchInfo(config: match.configuration),
                    SizedBox(height: SoteriaSpacing.xxl),
                    SoteriaButton.primary(
                      label: amIReady ? 'WAITING FOR OPPONENT...' : 'I\'M READY',
                      onPressed: amIReady 
                        ? null 
                        : () => ref.read(matchLifecycleControllerProvider.notifier).setReady(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadyPlayerCard extends StatelessWidget {
  final String label;
  final bool isReady;
  final String? photoUrl;

  const _ReadyPlayerCard({
    required this.label,
    required this.isReady,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            SoteriaAvatar(imageUrl: photoUrl, size: 80, showGlow: isReady),
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
          label,
          style: context.labelSmall.copyWith(
            color: isReady ? SoteriaColors.success : SoteriaColors.muted,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _MatchInfo extends StatelessWidget {
  final Map<String, dynamic> config;
  const _MatchInfo({required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Text(
            config['categoryName'] ?? 'General Knowledge',
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SoteriaSpacing.xs),
          Text(
            '${config['questionCount'] ?? 10} Questions • ${config['difficulty'] ?? 'Medium'}',
            style: context.labelSmall.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }
}
