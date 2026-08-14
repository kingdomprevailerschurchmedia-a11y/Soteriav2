import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';
import '../providers/live_event_providers.dart';
import '../../domain/models/live_event.dart';
import '../widgets/live_event_card.dart';

class LiveEventsScreen extends ConsumerWidget {
  const LiveEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeEventsAsync = ref.watch(activeLiveEventsProvider);
    final upcomingEventsAsync = ref.watch(upcomingLiveEventsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'LIVE EVENTS',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: kToolbarHeight + SoteriaSpacing.xl),
            ),
            
            // Active Events
            activeEventsAsync.when(
              data: (events) => events.isEmpty
                  ? const SliverToBoxAdapter(child: SizedBox.shrink())
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: SoteriaSpacing.lg),
                            child: LiveEventCard(
                              event: events[index],
                              onTap: () => _navigateToDetails(context, events[index].eventId),
                            ),
                          ),
                          childCount: events.length,
                        ),
                      ),
                    ),
              loading: () => const SliverToBoxAdapter(child: Center(child: SoteriaLoader())),
              error: (error, _) => SliverToBoxAdapter(child: Center(child: Text('Error: $error'))),
            ),

            // Section Header: Upcoming
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(SoteriaSpacing.lg, SoteriaSpacing.md, SoteriaSpacing.lg, SoteriaSpacing.md),
                child: Text(
                  'UPCOMING',
                  style: context.labelMedium.copyWith(
                    color: SoteriaColors.muted,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Upcoming Events
            upcomingEventsAsync.when(
              data: (events) => events.isEmpty
                  ? const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: SoteriaEmptyState(
                            title: 'NO UPCOMING EVENTS',
                            subtitle: 'Check back soon for new competitive challenges.',
                            icon: Icons.event_note_rounded,
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: SoteriaSpacing.lg),
                            child: LiveEventCard(
                              event: events[index],
                              onTap: () => _navigateToDetails(context, events[index].eventId),
                            ),
                          ),
                          childCount: events.length,
                        ),
                      ),
                    ),
              loading: () => const SliverToBoxAdapter(child: Center(child: SoteriaLoader())),
              error: (error, _) => SliverToBoxAdapter(child: Center(child: Text('Error: $error'))),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String eventId) {
    // Navigation logic
  }
}
