import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import '../../player/providers/player_providers.dart';
import '../services/auth_coordinator.dart';
import '../../notifications/widgets/competitive_notification_overlay.dart';

class AuthenticatedShellScreen extends ConsumerWidget {
  const AuthenticatedShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerAsync = ref.watch(currentPlayerStreamProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: SoteriaColors.backgroundGradient,
            ),
            child: playerAsync.when(
              data: (player) => _buildContent(context, ref, player),
              loading: () => const Center(child: SoteriaLoader()),
              error: (error, _) =>
                  Center(child: Text('Error loading profile: $error')),
            ),
          ),
          const CompetitiveNotificationOverlay(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, dynamic player) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.verified_user_rounded,
              size: 80,
              color: SoteriaColors.primary,
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Text(
              'WELCOME, ${player?.displayName.toUpperCase() ?? 'SCHOLAR'}',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                letterSpacing: 4,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'LEVEL ${player?.level ?? 1} | ${player?.coins ?? 0} COINS',
              style: context.bodyMedium.copyWith(
                color: SoteriaColors.gold,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Text(
                'This is a temporary landing page for the authenticated experience. The full Home Dashboard will be implemented in Epic 4.',
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(color: Colors.white70),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            ElevatedButton(
              onPressed: () => ref.read(authCoordinatorProvider).signOut(),
              style: ElevatedButton.styleFrom(
                backgroundColor: SoteriaColors.error.withValues(alpha: 0.1),
                foregroundColor: SoteriaColors.error,
                side: const BorderSide(color: SoteriaColors.error),
                padding: EdgeInsets.symmetric(
                  horizontal: SoteriaSpacing.xl,
                  vertical: SoteriaSpacing.md,
                ),
              ),
              child: const Text('SIGN OUT'),
            ),
          ],
        ),
      ),
    );
  }
}
