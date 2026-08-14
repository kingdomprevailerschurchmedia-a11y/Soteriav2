import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import '../providers/event_providers.dart';
import '../providers/leaderboard_providers.dart';
import '../widgets/leaderboard_row.dart';
import '../widgets/leaderboard/player_leaderboard_position_card.dart';

class EventLeaderboardScreen extends ConsumerWidget {
  final String eventId;

  const EventLeaderboardScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(eventLeaderboardProvider(eventId));
    final session = ref.watch(sessionProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'EVENT LEADERBOARD',
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
        child: leaderboardAsync.when(
          data: (entries) => _buildList(context, entries, session.uid),
          loading: () => const Center(child: SoteriaLoader()),
          error: (e, st) => Center(child: Text('Error: $e')),
        ),
      ),
      bottomNavigationBar: _buildBottomCard(ref, session.uid),
    );
  }

  Widget _buildList(BuildContext context, List<dynamic> entries, String? currentUserId) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: kToolbarHeight + SoteriaSpacing.xl,
        bottom: 100,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) => LeaderboardRow(
        entry: entries[index],
        isCurrentUser: entries[index].userId == currentUserId,
      ),
    );
  }

  Widget _buildBottomCard(WidgetRef ref, String? currentUserId) {
    if (currentUserId == null) return const SizedBox.shrink();
    
    final entryAsync = ref.watch(playerLeaderboardEntryProvider);
    final totalPlayersAsync = ref.watch(leaderboardTotalPlayersProvider);

    return entryAsync.when(
      data: (entry) => entry == null
          ? const SizedBox.shrink()
          : PlayerLeaderboardPositionCard(
              entry: entry,
              totalPlayers: totalPlayersAsync.value ?? 100,
              delta: 0,
            ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
