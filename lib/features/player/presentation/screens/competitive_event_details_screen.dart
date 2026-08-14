import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import '../providers/event_providers.dart';
import '../../domain/models/live_event.dart';
import '../../domain/models/event_participation.dart';
import '../widgets/event/event_status_badge.dart';
import '../widgets/event/event_countdown.dart';
import '../widgets/event/event_reward_card.dart';

class CompetitiveEventDetailsScreen extends ConsumerWidget {
  final String eventId;

  const CompetitiveEventDetailsScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailsProvider(eventId));
    final participationAsync = ref.watch(eventParticipationProvider(eventId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: eventAsync.when(
          data: (event) => event == null
              ? const Center(child: Text('Event not found'))
              : _buildContent(context, ref, event, participationAsync.value),
          loading: () => const Center(child: SoteriaLoader()),
          error: (e, st) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    LiveEvent event,
    EventParticipation? participation,
  ) {
    final xp = event.rewardConfiguration['xp'] as int? ?? 0;
    final coins = event.rewardConfiguration['coins'] as int? ?? 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(context, event),

          Padding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event.title.toUpperCase(),
                        style: context.headlineMedium.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    EventStatusBadge(status: event.status),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.sm),
                if (event.status == LiveEventStatus.live || event.status == LiveEventStatus.ending)
                  EventCountdown(targetDate: event.endAt, label: 'Ends in')
                else if (event.status == LiveEventStatus.upcoming)
                  EventCountdown(targetDate: event.startAt, label: 'Starts in'),
                
                SizedBox(height: SoteriaSpacing.lg),
                Text(
                  event.description,
                  style: context.bodyLarge.copyWith(color: SoteriaColors.textSecondary),
                ),
                SizedBox(height: SoteriaSpacing.xl),

                // Rules
                _buildSectionHeader(context, 'RULES'),
                SizedBox(height: SoteriaSpacing.md),
                ...event.rules.map((rule) => _buildRuleRow(context, rule)),
                SizedBox(height: SoteriaSpacing.xl),

                // Rewards
                EventRewardCard(xp: xp, coins: coins),
                SizedBox(height: SoteriaSpacing.xl),

                // CTA
                _buildCTA(context, ref, event, participation),
                
                SizedBox(height: SoteriaSpacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LiveEvent event) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withOpacity(0.1),
        image: const DecorationImage(
           image: AssetImage('assets/images/challenge.png'),
           fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              SoteriaColors.backgroundMid2.withOpacity(0.8),
            ],
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.emoji_events,
            size: 64,
            color: SoteriaColors.gold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: context.labelLarge.copyWith(
        color: SoteriaColors.muted,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRuleRow(BuildContext context, String rule) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 18, color: SoteriaColors.primary),
          SizedBox(width: SoteriaSpacing.sm),
          Expanded(child: Text(rule, style: context.bodyMedium)),
        ],
      ),
    );
  }

  Widget _buildCTA(
    BuildContext context,
    WidgetRef ref,
    LiveEvent event,
    EventParticipation? participation,
  ) {
    if (participation?.status == ParticipationStatus.completed) {
      return SoteriaButton.secondary(
        label: 'VIEW RESULTS',
        onPressed: () => context.push('/app/events/result/${event.eventId}?score=${participation!.score}'),
        isFullWidth: true,
      );
    }

    if (participation?.status == ParticipationStatus.joined || 
        participation?.status == ParticipationStatus.inProgress) {
      return SoteriaButton.primary(
        label: 'START CHALLENGE',
        onPressed: () => context.push('/app/events/play/${event.eventId}'),
        isFullWidth: true,
      );
    }

    switch (event.status) {
      case LiveEventStatus.live:
      case LiveEventStatus.ending:
        return SoteriaButton.primary(
          label: 'JOIN EVENT',
          onPressed: () => ref.read(eventControllerProvider.notifier).joinEvent(event.eventId),
          isFullWidth: true,
        );
      case LiveEventStatus.upcoming:
        return SoteriaButton.secondary(
          label: 'SET REMINDER',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reminder set!')),
            );
          },
          isFullWidth: true,
        );
      case LiveEventStatus.locked:
        return SoteriaButton.secondary(
          label: 'LOCKED',
          onPressed: null,
          isFullWidth: true,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
