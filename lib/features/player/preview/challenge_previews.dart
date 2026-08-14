import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_challenge.dart';
import '../presentation/screens/challenge_center_screen.dart';
import '../presentation/screens/create_challenge_screen.dart';
import '../presentation/screens/challenge_history_screen.dart';
import '../presentation/providers/challenge_providers.dart';
import 'challenge_fixtures.dart';

class ChallengePreviews {
  static Widget center() {
    return _wrapper(
      const ChallengeCenterScreen(),
      incoming: [ChallengeFixtures.pendingChallenge()],
      outgoing: [ChallengeFixtures.activeChallenge()],
    );
  }

  static Widget create() {
    return _wrapper(
      const CreateChallengeScreen(),
    );
  }

  static Widget history() {
    return _wrapper(
      const ChallengeHistoryScreen(),
    );
  }

  static Widget sheet() {
    return _wrapper(
      const CreateChallengeScreen(), // Or the actual sheet if it's a separate widget
    );
  }

  static Widget _wrapper(
    Widget child, {
    List<CompetitiveChallenge>? incoming,
    List<CompetitiveChallenge>? outgoing,
  }) {
    return ProviderScope(
      overrides: [
        incomingChallengesProvider.overrideWith((ref) => Stream.value(incoming ?? [])),
        outgoingChallengesProvider.overrideWith((ref) => Stream.value(outgoing ?? [])),
        // Add other overrides if needed
      ],
      child: child,
    );
  }
}
