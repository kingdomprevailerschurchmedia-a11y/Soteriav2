import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/domain/repositories/competitive_history_repository.dart';
import 'package:soteria/features/player/presentation/providers/history_providers.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_session.dart';

@GenerateNiceMocks([MockSpec<CompetitiveHistoryRepository>()])
import 'competitive_history_isolation_test.mocks.dart';

void main() {
  late MockCompetitiveHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCompetitiveHistoryRepository();
  });

  test('should clear history when user switches', () async {
    final container = ProviderContainer(
      overrides: [
        competitiveHistoryRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);

    // User A
    final userA = const UserSession(
      uid: 'user_A',
      status: SessionStatus.authenticated,
    );
    
    final resultA = SeasonResult(
      seasonId: 's1',
      userId: 'user_A',
      seasonName: 'A1',
      seasonNumber: 1,
      finalPosition: 1,
      finalRankPoints: 100,
      finalTier: 'G',
      finalDivision: 1,
      previousTier: 'S',
      previousDivision: 1,
      rankChange: 10,
      completedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(mockRepository.watchSeasonHistory('user_A'))
        .thenAnswer((_) => Stream.value([resultA]));
    when(mockRepository.getLatestSeasonResult('user_A'))
        .thenAnswer((_) async => resultA);
    when(mockRepository.getBestSeasonResult('user_A'))
        .thenAnswer((_) async => resultA);

    final completerA = Completer<CompetitiveHistory>();
    container.listen<AsyncValue<CompetitiveHistory>>(
      competitiveHistorySummaryProvider, 
      (prev, next) {
        if (next is AsyncData<CompetitiveHistory> && next.value.userId == 'user_A') {
          if (!completerA.isCompleted) completerA.complete(next.value);
        }
      },
      fireImmediately: true,
    );

    container.read(sessionProvider.notifier).setSession(userA);
    final historyA = await completerA.future.timeout(const Duration(seconds: 2));
    expect(historyA.userId, 'user_A');

    // Logout
    container
        .read(sessionProvider.notifier)
        .setSession(const UserSession(status: SessionStatus.guest));

    // User B
    final userB = const UserSession(
      uid: 'user_B',
      status: SessionStatus.authenticated,
    );
    
    final resultB = SeasonResult(
      seasonId: 's2',
      userId: 'user_B',
      seasonName: 'B1',
      seasonNumber: 2,
      finalPosition: 2,
      finalRankPoints: 200,
      finalTier: 'P',
      finalDivision: 1,
      previousTier: 'G',
      previousDivision: 1,
      rankChange: 20,
      completedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(mockRepository.watchSeasonHistory('user_B'))
        .thenAnswer((_) => Stream.value([resultB]));
    when(mockRepository.getLatestSeasonResult('user_B'))
        .thenAnswer((_) async => resultB);
    when(mockRepository.getBestSeasonResult('user_B'))
        .thenAnswer((_) async => resultB);

    final completerB = Completer<CompetitiveHistory>();
    container.listen<AsyncValue<CompetitiveHistory>>(
      competitiveHistorySummaryProvider, 
      (prev, next) {
        if (next is AsyncData<CompetitiveHistory> && next.value.userId == 'user_B') {
          if (!completerB.isCompleted) completerB.complete(next.value);
        }
      },
      fireImmediately: true,
    );

    container.read(sessionProvider.notifier).setSession(userB);

    final historyB = await completerB.future.timeout(const Duration(seconds: 2));
    expect(historyB.userId, 'user_B');
    expect(historyB.results.first.userId, 'user_B');
  });
}
