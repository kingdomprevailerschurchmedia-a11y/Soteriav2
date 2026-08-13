import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/features/player/domain/models/public_competitive_profile.dart';
import 'package:soteria/features/player/presentation/providers/challenge_lobby_providers.dart';
import 'package:soteria/features/player/presentation/providers/challenge_providers.dart';
import 'challenge_config_selectors.dart';

class ChallengePlayerSheet extends ConsumerWidget {
  final PublicCompetitiveProfile profile;

  const ChallengePlayerSheet({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeLobbyProvider(profile.userId));
    final controllerAsync = ref.watch(challengeControllerProvider);

    return Container(
      decoration: BoxDecoration(
        color: SoteriaColors.backgroundTopLeft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.xl,
        SoteriaSpacing.md,
        SoteriaSpacing.xl,
        SoteriaSpacing.xl + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _buildOpponentHeader(context),
          SizedBox(height: SoteriaSpacing.xl),
          ChallengeCategorySelector(userId: profile.userId),
          SizedBox(height: SoteriaSpacing.lg),
          ChallengeDifficultySelector(userId: profile.userId),
          SizedBox(height: SoteriaSpacing.xl),
          _buildQuestionCountSelector(context, ref),
          SizedBox(height: SoteriaSpacing.xxl),
          if (controllerAsync.hasError)
            Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
              child: Text(
                controllerAsync.error.toString(),
                style: context.bodySmall.copyWith(color: SoteriaColors.error),
              ),
            ),
          SoteriaButton.primary(
            label: 'SEND CHALLENGE',
            isLoading: controllerAsync.isLoading,
            onPressed: state.category != null
                ? () async {
                    await ref
                        .read(challengeLobbyProvider(profile.userId).notifier)
                        .sendChallenge();
                    if (context.mounted) {
                      Navigator.pop(context);
                      _showSuccessSnackBar(context);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildOpponentHeader(BuildContext context) {
    return Row(
      children: [
        SoteriaAvatar(
          avatar: AvatarCatalog().getById(profile.avatarId),
          size: 56,
        ),
        SizedBox(width: SoteriaSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHALLENGE ${profile.displayName.toUpperCase()}',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '1v1 Versus Match',
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCountSelector(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(challengeLobbyProvider(profile.userId)).questionCount;
    final counts = [5, 10, 15, 20];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUESTIONS',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: counts.map((count) {
            final isSelected = selected == count;
            return GestureDetector(
              onTap: () => ref
                  .read(challengeLobbyProvider(profile.userId).notifier)
                  .updateQuestionCount(count),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? SoteriaColors.primary
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected ? SoteriaColors.primary : Colors.transparent,
                  ),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Challenge sent to ${profile.displayName}!'),
        backgroundColor: SoteriaColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
