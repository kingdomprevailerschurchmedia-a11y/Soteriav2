import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/player_presence.dart';
import '../presentation/providers/presence_providers.dart';
import '../presentation/widgets/presence/competitive_player_card.dart';
import '../presentation/widgets/presence/player_presence_indicator.dart';
import '../presentation/widgets/presence/presence_label.dart';
import 'presence_fixtures.dart';

class PresencePreviews {
  static Widget indicators() {
    return Scaffold(
      appBar: AppBar(title: const Text('Presence Indicators')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _row('ONLINE', PresenceFixtures.online('u1')),
            _row('IN MATCH', PresenceFixtures.inMatch('u2', 'm1')),
            _row('RECENTLY ACTIVE', PresenceFixtures.recentlyActive('u3')),
            _row('OFFLINE', PresenceFixtures.offline('u4')),
          ],
        ),
      ),
    );
  }

  static Widget playerCard() {
    return Scaffold(
      appBar: AppBar(title: const Text('Competitive Player Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _card('me', PresenceFixtures.online('me')),
            const SizedBox(height: 12),
            _card('rival_alex', PresenceFixtures.inMatch('rival_alex', 'm1')),
          ],
        ),
      ),
    );
  }

  static Widget _row(String label, PlayerPresence presence) {
    return ProviderScope(
      overrides: [
        playerPresenceProvider(presence.userId).overrideWith((ref) => Stream.value(presence)),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            PlayerPresenceIndicator(userId: presence.userId),
            const SizedBox(width: 12),
            Text(label),
            const Spacer(),
            PresenceLabel(userId: presence.userId),
          ],
        ),
      ),
    );
  }

  static Widget _card(String userId, PlayerPresence presence) {
    return ProviderScope(
      overrides: [
        playerPresenceProvider(userId).overrideWith((ref) => Stream.value(presence)),
      ],
      child: CompetitivePlayerCard(userId: userId),
    );
  }
}
