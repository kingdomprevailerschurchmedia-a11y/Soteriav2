import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/components/soteria_back_button.dart';
import 'package:soteria/core/design_system/components/soteria_state_views.dart';
import 'package:soteria/features/tournaments/domain/models/tournament.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_status.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_details_provider.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_registration_provider.dart';
import 'package:soteria/features/tournaments/presentation/widgets/prize_pool_card.dart';
import 'package:soteria/features/tournaments/presentation/widgets/registration_action_box.dart';
import 'package:soteria/features/tournaments/presentation/widgets/tournament_countdown_widget.dart';

class TournamentDetailsScreen extends ConsumerWidget {
  final String tournamentId;

  const TournamentDetailsScreen({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentAsync = ref.watch(tournamentDetailsProvider(tournamentId));
    final isRegisteredAsync = ref.watch(
      isRegisteredForTournamentProvider(tournamentId),
    );
    final registrationAsync = ref.watch(tournamentRegistrationProvider);

    return tournamentAsync.when(
      data: (tournament) {
        if (tournament == null) {
          return const SafeGradientScaffold(
            body: SoteriaEmptyView(
              title: 'NOT FOUND',
              message: 'This tournament no longer exists or was cancelled.',
              icon: Icons.search_off_rounded,
            ),
          );
        }
        final t = tournament;
        return SafeGradientScaffold(
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _buildAppBar(context, t.bannerUrl, t.name),
                  SliverPadding(
                    padding: EdgeInsets.all(SoteriaSpacing.lg),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildCountdown(t),
                        SizedBox(height: SoteriaSpacing.xl),
                        _buildDescription(context, t.description),
                        SizedBox(height: SoteriaSpacing.xl),
                        _buildRules(context, t.rules),
                        SizedBox(height: SoteriaSpacing.xl),
                        _buildPrizePool(t.prizePool),
                        SizedBox(height: 120.h), // Space for action box
                      ]),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(SoteriaSpacing.lg),
                  child: RegistrationActionBox(
                    status: t.status,
                    isRegistered: isRegisteredAsync.value ?? false,
                    isLoading: registrationAsync.isLoading,
                    onAction: () {
                      final isRegistered = isRegisteredAsync.value ?? false;
                      if ((t.status == TournamentStatus.live ||
                              t.status == TournamentStatus.startingSoon) &&
                          isRegistered) {
                        context.push(
                          SoteriaRoutes.tournamentLobby.replaceAll(
                            ':id',
                            tournamentId,
                          ),
                        );
                      } else {
                        ref
                            .read(tournamentRegistrationProvider.notifier)
                            .toggleRegistration(tournamentId, isRegistered);
                      }
                    },
                  ),
                ),
              ),
              if (registrationAsync.hasError)
                _buildErrorOverlay(context, registrationAsync.error.toString()),
            ],
          ),
        );
      },
      loading: () => const SafeGradientScaffold(body: SoteriaLoadingView()),
      error: (err, stack) => SafeGradientScaffold(
        body: SoteriaEmptyView(
          title: 'SYNC ERROR',
          message: 'Unable to load tournament details. Please try again.',
          icon: Icons.sync_problem_rounded,
          actionLabel: 'RETRY',
          onAction: () =>
              ref.invalidate(tournamentDetailsProvider(tournamentId)),
        ),
      ),
    );
  }

  Widget _buildErrorOverlay(BuildContext context, String message) {
    return Positioned(
      top: 100.h,
      left: SoteriaSpacing.lg,
      right: SoteriaSpacing.lg,
      child: SoteriaBadge(
        label: 'REGISTRATION FAILED: $message',
        variant: SoteriaBadgeVariant.error,
        icon: Icons.warning_rounded,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String bannerUrl, String title) {
    return SliverAppBar(
      expandedHeight: 250.h,
      pinned: true,
      backgroundColor: SoteriaColors.backgroundBottomRight,
      leadingWidth: 60,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Center(child: SoteriaBackButton()),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(bannerUrl, fit: BoxFit.cover),
        title: Text(title, style: context.titleMedium),
      ),
    );
  }

  Widget _buildCountdown(Tournament tournament) {
    return TournamentCountdownWidget(
      targetDate: tournament.startTime,
      label: 'Tournament Starts In',
    );
  }

  Widget _buildDescription(BuildContext context, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT',
          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Text(description, style: context.bodyMedium),
      ],
    );
  }

  Widget _buildRules(BuildContext context, List<String> rules) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RULES',
          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        ...rules.map(
          (rule) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: context.bodyMedium),
                Expanded(child: Text(rule, style: context.bodyMedium)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrizePool(double amount) {
    return PrizePoolCard(
      totalPrizePool: amount,
      distribution: [
        PrizeDistribution(
          rank: '1st Place',
          amount: amount * 0.5,
          percentage: 50,
        ),
        PrizeDistribution(
          rank: '2nd Place',
          amount: amount * 0.3,
          percentage: 30,
        ),
        PrizeDistribution(
          rank: '3rd Place',
          amount: amount * 0.2,
          percentage: 20,
        ),
      ],
    );
  }
}
