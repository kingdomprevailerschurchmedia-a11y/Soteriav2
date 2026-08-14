import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';
import '../providers/event_providers.dart';
import '../../domain/models/live_event.dart';
import '../widgets/event/competitive_event_card.dart';

class CompetitiveEventsScreen extends ConsumerWidget {
  const CompetitiveEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(competitiveEventsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'COMPETITIVE EVENTS',
          style: context.titleMedium.copyWith(
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: eventsAsync.when(
          data: (events) => _buildContent(context, events),
          loading: () => const Center(child: SoteriaLoader()),
          error: (e, st) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<LiveEvent> events) {
    final liveEvents = events
        .where((e) => e.status == LiveEventStatus.live || e.status == LiveEventStatus.ending)
        .toList();
    final upcomingEvents = events
        .where((e) => e.status == LiveEventStatus.upcoming)
        .toList();
    final completedEvents = events
        .where((e) => e.status == LiveEventStatus.ended)
        .toList();

    if (events.isEmpty) {
      return const Center(
        child: SoteriaEmptyState(
          title: 'NO EVENTS',
          subtitle: 'Check back soon for new challenges.',
          icon: Icons.emoji_events,
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: kToolbarHeight + SoteriaSpacing.xl),
        ),
        if (liveEvents.isNotEmpty) ...[
          _buildSectionHeader(context, 'LIVE NOW'),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => CompetitiveEventCard(
                  event: liveEvents[index],
                  onTap: () =>
                      _navigateToDetails(context, liveEvents[index].eventId),
                ),
                childCount: liveEvents.length,
              ),
            ),
          ),
        ],
        if (upcomingEvents.isNotEmpty) ...[
          _buildSectionHeader(context, 'UPCOMING'),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => CompetitiveEventCard(
                  event: upcomingEvents[index],
                  onTap: () =>
                      _navigateToDetails(context, upcomingEvents[index].eventId),
                ),
                childCount: upcomingEvents.length,
              ),
            ),
          ),
        ],
        if (completedEvents.isNotEmpty) ...[
          _buildSectionHeader(context, 'COMPLETED'),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => CompetitiveEventCard(
                  event: completedEvents[index],
                  onTap: () =>
                      _navigateToDetails(context, completedEvents[index].eventId),
                ),
                childCount: completedEvents.length,
              ),
            ),
          ),
        ],
        SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxl)),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SoteriaSpacing.lg,
          SoteriaSpacing.md,
          SoteriaSpacing.lg,
          SoteriaSpacing.sm,
        ),
        child: Text(
          title,
          style: context.labelMedium.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String eventId) {
    context.push('/app/events/details/$eventId');
  }
}
