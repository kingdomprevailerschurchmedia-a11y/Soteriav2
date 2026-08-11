import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/leaderboard_entry.dart';
import '../domain/models/competitive_season.dart';
import '../domain/repositories/leaderboard_repository.dart';
import '../presentation/providers/leaderboard_providers.dart';
import '../presentation/providers/season_providers.dart';
import '../presentation/screens/leaderboard_screen.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../../../core/identity/models/user_session.dart';
import '../../../../core/services/time_service.dart';

class LeaderboardPreviewWrapper extends StatelessWidget {
  final List<LeaderboardEntry> mockEntries;
  final LeaderboardEntry? playerEntry;

  const LeaderboardPreviewWrapper({
    super.key,
    required this.mockEntries,
    this.playerEntry,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return ProviderScope(
      overrides: [
        sessionProvider.overrideWith(() => SessionMock()),
        leaderboardControllerProvider.overrideWith(
          (ref) => LeaderboardControllerMock(mockEntries),
        ),
        playerLeaderboardEntryProvider.overrideWith(
          (ref) => Future.value(playerEntry),
        ),
        currentSeasonProvider.overrideWith((ref) => Stream.value(
          CompetitiveSeason(
            seasonId: 's1',
            name: 'Cyber Sentinel',
            status: SeasonStatus.active,
            startAt: now.subtract(const Duration(days: 10)),
            endAt: now.add(const Duration(days: 20)),
            createdAt: now,
            updatedAt: now,
            seasonNumber: 1,
          ),
        )),
        timeServiceProvider.overrideWithValue(_MockTimeService(now)),
      ],
      child: const LeaderboardScreen(),
    );
  }
}

class _MockTimeService implements TimeService {
  final DateTime _now;
  _MockTimeService(this._now);

  @override
  DateTime now() => _now;
  @override
  DateTime nowUtc() => _now.toUtc();
}

class SessionMock extends SessionNotifier {
  @override
  UserSession build() {
    return const UserSession(uid: 'me', status: SessionStatus.authenticated);
  }
}

class LeaderboardControllerMock extends LeaderboardController {
  LeaderboardControllerMock(List<LeaderboardEntry> entries)
    : super(_MockLeaderboardRepository(), null) {
    state = AsyncValue.data(entries);
  }

  @override
  Future<void> refresh() async {}
}

class _MockLeaderboardRepository implements LeaderboardRepository {
  @override
  Future<List<LeaderboardEntry>> getLeaderboardPage({
    String? seasonId,
    int limit = 50,
    dynamic lastCursor,
  }) async => [];

  @override
  Future<LeaderboardEntry?> getPlayerEntry({
    required String userId,
    String? seasonId,
  }) async => null;

  @override
  Future<List<LeaderboardEntry>> getLeaderboardAroundPlayer({
    required String userId,
    String? seasonId,
    int windowSize = 5,
  }) async => [];

  @override
  Future<int> getPlayerRankPosition({
    required String userId,
    String? seasonId,
  }) async => 0;
}

class LeaderboardPreviews {
  static List<LeaderboardEntry> generateMock(int count) {
    return List.generate(
      count,
      (i) => LeaderboardEntry(
        userId: 'user_$i',
        displayName: 'Scholar ${i + 1}',
        rankPoints: 5000 - (i * 50),
        rankTier: _getTier(5000 - (i * 50)),
        division: (i % 3) + 1,
        position: i + 1,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  static String _getTier(int points) {
    if (points >= 5000) return 'Master';
    if (points >= 3500) return 'Diamond';
    if (points >= 2000) return 'Platinum';
    if (points >= 1000) return 'Gold';
    if (points >= 500) return 'Silver';
    return 'Bronze';
  }

  static Widget topList() => LeaderboardPreviewWrapper(
    mockEntries: generateMock(20),
    playerEntry: generateMock(1)[0].copyWith(position: 1, userId: 'me'),
  );

  static Widget empty() => const LeaderboardPreviewWrapper(mockEntries: []);

  static Widget midRank() {
    final entries = generateMock(10);
    final myEntry = LeaderboardEntry(
      userId: 'me',
      displayName: 'Joseph Ade',
      rankPoints: 1245,
      rankTier: 'Gold',
      division: 2,
      position: 4827,
      lastUpdated: DateTime.now(),
    );
    return LeaderboardPreviewWrapper(
      mockEntries: entries,
      playerEntry: myEntry,
    );
  }
}
