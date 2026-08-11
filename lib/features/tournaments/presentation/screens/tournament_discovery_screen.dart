import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/config/soteria_breakpoints.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/components/soteria_state_views.dart';
import 'package:soteria/features/tournaments/domain/models/tournament.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_status.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_discovery_provider.dart';
import 'package:soteria/features/tournaments/presentation/widgets/tournament_card.dart';

class TournamentDiscoveryScreen extends ConsumerWidget {
  const TournamentDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentsAsync = ref.watch(tournamentDiscoveryProvider);

    return SafeGradientScaffold(
      body: tournamentsAsync.when(
        data: (tournaments) {
          if (tournaments.isEmpty) {
            return const SoteriaEmptyView(
              title: 'NO TOURNAMENTS',
              message: 'Check back later for new events.',
              icon: Icons.event_busy_rounded,
            );
          }
          return _buildContent(context, tournaments);
        },
        loading: () => const SoteriaLoadingView(),
        error: (err, stack) => SoteriaEmptyView(
          title: 'LOAD FAILED',
          message: 'Failed to synchronize tournaments: $err',
          icon: Icons.error_outline_rounded,
          actionLabel: 'RETRY',
          onAction: () => ref.invalidate(tournamentDiscoveryProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Tournament> tournaments) {
    final live = tournaments
        .where((t) => t.status == TournamentStatus.live)
        .toList();
    final registrationOpen = tournaments
        .where((t) => t.status == TournamentStatus.registrationOpen)
        .toList();
    final upcoming = tournaments
        .where((t) => t.status == TournamentStatus.upcoming)
        .toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.h,
          floating: false,
          pinned: true,
          leading: const BackButton(),
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Tournaments', style: context.titleLarge),
            background: _FeaturedTournament(
              tournament: tournaments.isNotEmpty ? tournaments.first : null,
            ),
          ),
        ),
        if (live.isNotEmpty) ...[
          _SectionHeader(title: 'LIVE NOW'),
          _TournamentList(tournaments: live),
        ],
        if (registrationOpen.isNotEmpty) ...[
          _SectionHeader(title: 'REGISTRATION OPEN'),
          _TournamentList(tournaments: registrationOpen),
        ],
        if (upcoming.isNotEmpty) ...[
          _SectionHeader(title: 'UPCOMING'),
          _TournamentList(tournaments: upcoming),
        ],
        SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxl + 100.h)),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.lg,
        SoteriaSpacing.xl,
        SoteriaSpacing.lg,
        SoteriaSpacing.md,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(
          title,
          style: context.labelSmall.copyWith(
            color: Colors.white70,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TournamentList extends StatelessWidget {
  final List<Tournament> tournaments;
  const _TournamentList({required this.tournaments});

  @override
  Widget build(BuildContext context) {
    final bool isTablet =
        MediaQuery.of(context).size.width >= SoteriaBreakpoints.tablet;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      sliver: isTablet
          ? SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: SoteriaSpacing.md,
                mainAxisSpacing: SoteriaSpacing.md,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => TournamentCard(
                  tournament: tournaments[index],
                  onTap: () => context.push(
                    SoteriaRoutes.tournamentDetails.replaceAll(
                      ':id',
                      tournaments[index].id,
                    ),
                  ),
                ),
                childCount: tournaments.length,
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                  child: TournamentCard(
                    tournament: tournaments[index],
                    onTap: () => context.push(
                      SoteriaRoutes.tournamentDetails.replaceAll(
                        ':id',
                        tournaments[index].id,
                      ),
                    ),
                  ),
                ),
                childCount: tournaments.length,
              ),
            ),
    );
  }
}

class _FeaturedTournament extends StatelessWidget {
  final Tournament? tournament;
  const _FeaturedTournament({this.tournament});

  @override
  Widget build(BuildContext context) {
    if (tournament == null) return const SizedBox.shrink();
    return Image.network(tournament!.bannerUrl, fit: BoxFit.cover);
  }
}
