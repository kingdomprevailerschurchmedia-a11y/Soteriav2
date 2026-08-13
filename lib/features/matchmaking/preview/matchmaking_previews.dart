import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/matchmaking_session.dart';
import '../domain/models/matchmaking_status.dart';
import '../presentation/providers/matchmaking_providers.dart';
import '../presentation/screens/matchmaking_screen.dart';
import '../presentation/screens/match_found_screen.dart';
import '../presentation/screens/versus_lobby_screen.dart';
import '../../../player/preview/public_profile_preview.dart';

class MatchmakingPreviews {
  static Widget lobby() => const VersusLobbyScreen();

  static Widget searching() => ProviderScope(
    overrides: [
      matchmakingSessionIdProvider.overrideWith((ref) => 'mock_session'),
      matchmakingSessionProvider.overrideWith((ref) => Stream.value(
        MatchmakingSession(
          sessionId: 'mock_session',
          userId: 'me',
          status: MatchmakingStatus.searching,
          queuedAt: DateTime.now().subtract(const Duration(seconds: 15)),
        ),
      )),
      queueTimerProvider.overrideWith((ref) => Stream.value(15)),
    ],
    child: const MatchmakingScreen(),
  );

  static Widget matchFound({bool meReady = false, bool oppReady = false}) => ProviderScope(
    overrides: [
      matchmakingSessionIdProvider.overrideWith((ref) => 'mock_session'),
      matchmakingSessionProvider.overrideWith((ref) => Stream.value(
        MatchmakingSession(
          sessionId: 'mock_session',
          userId: 'me',
          opponentId: 'rival_1',
          status: MatchmakingStatus.matchFound,
          queuedAt: DateTime.now().subtract(const Duration(seconds: 30)),
          matchedAt: DateTime.now(),
          configuration: {'categoryName': 'Cloud Computing', 'questionCount': 10, 'difficulty': 'Hard'},
          rankSnapshot: {'rankName': 'Gold', 'tier': 'II'},
          isReady: meReady,
          opponentReady: oppReady,
        ),
      )),
      publicProfileProvider('rival_1').overrideWith((ref) => Future.value(PublicProfilePreviews.mockEliteProfile())),
    ],
    child: const MatchFoundScreen(),
  );
}
