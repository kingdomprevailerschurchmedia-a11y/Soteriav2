import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/presentation/widgets/player_progression_card.dart';
import 'package:soteria/features/player/presentation/widgets/rank_badge.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_profile.dart';

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [
        profileProvider.overrideWith(() => ProfileMock()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => MaterialApp(
          theme: SoteriaTheme.darkTheme,
          home: Scaffold(body: Center(child: child)),
        ),
      ),
    );
  }

  final mockProgression = PlayerProgression(
    userId: 'user123',
    currentLevel: 10,
    currentXp: 500,
    lifetimeXp: 15000,
    xpRequiredForCurrentLevel: 10000,
    xpRequiredForNextLevel: 12000,
    xpProgress: 0.25,
    currentRank: 'Gold II',
    currentRankTier: 'gold',
    rankPoints: 1250,
    rankProgress: 0.45,
    seasonId: 'season_1',
    seasonXp: 500,
    seasonRankPoints: 1250,
    lastUpdated: DateTime.now(),
  );

  group('Progression UI Components', () {
    testWidgets('RankBadge should display correct rank name', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrap(const RankBadge(rankName: 'Gold II', tierId: 'gold')),
      );

      expect(find.text('GOLD II'), findsOneWidget);
    });

    testWidgets('PlayerProgressionCard should render all progression data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          PlayerProgressionCard(
            progression: mockProgression,
            displayName: 'Joseph Ade',
          ),
        ),
      );

      expect(find.text('Joseph Ade'), findsOneWidget);
      expect(find.text('Level 10'), findsOneWidget);
      expect(find.text('GOLD II'), findsOneWidget);
      expect(
        find.text('500 / 2000 XP'),
        findsOneWidget,
      ); // 12000 - 10000 = 2000
      expect(find.text('45%'), findsOneWidget);
    });
  });
}

class ProfileMock extends ProfileNotifier {
  @override
  UserProfile? build() => null;
}
