import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/widgets/presence/recent_opponents_section.dart';
import '../presentation/widgets/presence/recent_opponents_list.dart';
import '../presentation/widgets/presence/recent_opponent_card.dart';
import '../presentation/providers/match_history_providers.dart';
import 'presence_fixtures.dart';

class RematchPreviews {
  static Widget recentSection() {
    return ProviderScope(
      overrides: [
        recentOpponentsProvider.overrideWith((ref) => const AsyncValue.data(['u1', 'u2', 'u3'])),
      ],
      child: const Scaffold(
        body: Center(
          child: RecentOpponentsSection(),
        ),
      ),
    );
  }

  static Widget recentList() {
    return ProviderScope(
      overrides: [
        recentOpponentsProvider.overrideWith((ref) => const AsyncValue.data(['u1', 'u2', 'u3'])),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Recent Opponents')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: RecentOpponentsList(),
        ),
      ),
    );
  }

  static Widget opponentCard() {
    return ProviderScope(
      overrides: [
        // profile already handled by publicProfileProvider mock if available
      ],
      child: const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: RecentOpponentCard(userId: 'u1'),
          ),
        ),
      ),
    );
  }
}
