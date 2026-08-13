import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_challenge.dart';
import '../presentation/providers/challenge_providers.dart';
import '../presentation/screens/challenge_center_screen.dart';
import '../presentation/widgets/challenge/challenge_player_sheet.dart';
import 'public_profile_preview.dart';
import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';

class ChallengePreviewWrapper extends StatelessWidget {
  final List<CompetitiveChallenge> incoming;
  final List<CompetitiveChallenge> outgoing;

  const ChallengePreviewWrapper({
    super.key,
    this.incoming = const [],
    this.outgoing = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        incomingChallengesProvider.overrideWith((ref) => Stream.value(incoming)),
        outgoingChallengesProvider.overrideWith((ref) => Stream.value(outgoing)),
      ],
      child: const ChallengeCenterScreen(),
    );
  }
}

class ChallengePreviews {
  static List<CompetitiveChallenge> mockIncoming() {
    return [
      CompetitiveChallenge(
        challengeId: 'c1',
        challengerId: 'rival1',
        challengedPlayerId: 'me',
        status: ChallengeStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        expiresAt: DateTime.now().add(const Duration(hours: 23)),
        configuration: {'categoryName': 'Security', 'questionCount': 10},
      ),
    ];
  }

  static List<CompetitiveChallenge> mockOutgoing() {
    return [
      CompetitiveChallenge(
        challengeId: 'c2',
        challengerId: 'me',
        challengedPlayerId: 'rival2',
        status: ChallengeStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        expiresAt: DateTime.now().add(const Duration(hours: 23, minutes: 30)),
        configuration: {'categoryName': 'Cloud', 'questionCount': 15},
      ),
    ];
  }

  static Widget center() => ChallengePreviewWrapper(
        incoming: mockIncoming(),
        outgoing: mockOutgoing(),
      );

  static Widget empty() => const ChallengePreviewWrapper();

  static Widget sheet() => ProviderScope(
    overrides: [
      publicProfileProvider(PublicProfilePreviews.mockEliteProfile().userId).overrideWith((ref) => PublicProfilePreviews.mockEliteProfile()),
    ],
    child: Scaffold(
      body: Center(
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => ChallengePlayerSheet(profile: PublicProfilePreviews.mockEliteProfile()),
            ),
            child: const Text('Show Challenge Sheet'),
          ),
        ),
      ),
    ),
  );
}
