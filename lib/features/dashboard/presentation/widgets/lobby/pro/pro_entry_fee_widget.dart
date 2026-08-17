import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../providers/pro_lobby_providers.dart';

class ProEntryFeeWidget extends ConsumerWidget {
  const ProEntryFeeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(proLobbyProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'ENTRY FEE',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.isFreeEntry) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: SoteriaColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: SoteriaColors.success.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars_rounded, color: SoteriaColors.success, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'FREE ENTRY',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.success,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '(${state.remainingFreeGames} REMAINING)',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else ...[
              const Icon(
                Icons.monetization_on_rounded,
                color: SoteriaColors.gold,
                size: 32,
              ),
              SizedBox(width: SoteriaSpacing.md),
              Text(
                state.config.entryFee.toString(),
                style: context.displayMedium.copyWith(
                  fontWeight: FontWeight.w900,
                  color: state.hasInsufficientCoins
                      ? SoteriaColors.error
                      : SoteriaColors.textPrimary,
                ),
              ),
            ],
          ],
        ),
        if (state.hasInsufficientCoins && !state.isFreeEntry)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'INSUFFICIENT COINS',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
