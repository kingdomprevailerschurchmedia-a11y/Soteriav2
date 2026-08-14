import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';
import '../providers/event_providers.dart';
import '../../domain/models/event_participation.dart';

class EventHistoryScreen extends ConsumerWidget {
  const EventHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(eventHistoryProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'EVENT HISTORY',
          style: context.titleMedium.copyWith(
            letterSpacing: 2,
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
        child: historyAsync.when(
          data: (history) => history.isEmpty
              ? const Center(
                  child: SoteriaEmptyState(
                    title: 'NO HISTORY',
                    subtitle: 'Participate in events to see them here.',
                    icon: Icons.history,
                  ),
                )
              : _buildList(context, history),
          loading: () => const Center(child: SoteriaLoader()),
          error: (e, st) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<EventParticipation> history) {
    return ListView.builder(
      padding: EdgeInsets.only(top: kToolbarHeight + SoteriaSpacing.xl),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return _HistoryItem(participation: item);
      },
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final EventParticipation participation;

  const _HistoryItem({required this.participation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        SoteriaSpacing.lg,
        0,
        SoteriaSpacing.lg,
        SoteriaSpacing.md,
      ),
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event #${participation.eventId.substring(0, 4)}',
                style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
              if (participation.completedAt != null)
                Text(
                  participation.completedAt!.toString().substring(0, 10),
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${participation.score}',
                style: context.headlineSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (participation.rank != null)
                Text(
                  'Rank #${participation.rank}',
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
