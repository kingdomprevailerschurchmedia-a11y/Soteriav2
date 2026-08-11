import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/domain/models/competitive_season.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/presentation/providers/history_providers.dart';
import 'package:soteria/features/player/presentation/providers/season_providers.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';
import 'package:soteria/features/player/presentation/screens/competitive_history_screen.dart';
import 'package:soteria/features/player/presentation/widgets/season_result_card.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/services/time_service.dart';

void main() {
  Widget createTestWidget({
    List<SeasonResult> results = const [],
    SeasonResult? latest,
    SeasonResult? best,
    CompetitiveSeason? currentSeason,
    PlayerProgression? progression,
  }) {
    final now = DateTime.now();
    return ProviderScope(
      overrides: [
        sessionProvider.overrideWith(() => SessionMock()),
        seasonHistoryProvider.overrideWith((ref) => Stream.value(results)),
        latestSeasonResultProvider.overrideWith((ref) => Future.value(latest)),
        bestSeasonResultProvider.overrideWith((ref) => Future.value(best)),
        currentSeasonProvider.overrideWith((ref) => Stream.value(currentSeason)),
        competitiveProgressionProvider.overrideWith((ref) => Stream.value(
              progression ?? PlayerProgression.initial('u1', 's1'),
            )),
        timeServiceProvider.overrideWithValue(MockTimeService(now)),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) => const MaterialApp(
          home: CompetitiveHistoryScreen(),
        ),
      ),
    );
  }

  testWidgets('should show empty state when no results', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Your competitive journey starts here.'), findsOneWidget);
    expect(find.byType(SeasonResultCard), findsNothing);
  });

  testWidgets('should show history list and highlighted results', (tester) async {
    final now = DateTime.now();
    final result = SeasonResult(
      seasonId: 's1',
      userId: 'u1',
      seasonName: 'Alpha',
      seasonNumber: 1,
      finalPosition: 50,
      finalRankPoints: 1200,
      finalTier: 'Gold',
      finalDivision: 2,
      previousTier: 'Silver',
      previousDivision: 1,
      rankChange: 200,
      completedAt: now,
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(createTestWidget(
      results: [result],
      latest: result,
      best: result,
    ));
    await tester.pumpAndSettle();

    expect(find.text('LATEST COMPLETED'), findsOneWidget);
    
    // Use scroll to find "SEASON HISTORY" if it's off-screen
    final historySectionFinder = find.text('SEASON HISTORY');
    await tester.scrollUntilVisible(
      historySectionFinder,
      200.0,
      scrollable: find.byType(Scrollable).first,
    );
    expect(historySectionFinder, findsOneWidget);
    
    final cardFinder = find.byType(SeasonResultCard);
    await tester.scrollUntilVisible(
      cardFinder,
      200.0,
      scrollable: find.byType(Scrollable).first,
    );
    expect(cardFinder, findsOneWidget);
  });
}

class SessionMock extends SessionNotifier {
  @override
  UserSession build() {
    return const UserSession(uid: 'u1', status: SessionStatus.authenticated);
  }
}

class MockTimeService implements TimeService {
  final DateTime _now;
  MockTimeService(this._now);
  @override
  DateTime now() => _now;
  @override
  DateTime nowUtc() => _now.toUtc();
}
