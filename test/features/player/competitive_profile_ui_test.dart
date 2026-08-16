import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/player/domain/models/competitive_profile.dart';
import 'package:soteria/features/player/presentation/providers/competitive_profile_provider.dart';
import 'package:soteria/features/player/presentation/screens/competitive_profile_screen.dart';
import 'package:soteria/features/player/preview/competitive_profile_previews.dart';

import 'package:soteria/features/player/presentation/providers/identity_providers.dart';
import 'package:soteria/features/player/domain/models/rank_progress.dart';
import 'package:soteria/features/player/domain/models/competitive_identity.dart';
import 'package:soteria/features/player/domain/config/progression_config.dart';

import 'package:soteria/core/avatar/domain/avatar.dart';
import 'package:soteria/core/avatar/providers/avatar_providers.dart';

import 'package:soteria/features/player/presentation/providers/rank_providers.dart';
import 'package:soteria/features/player/presentation/providers/goal_providers.dart';
import 'package:soteria/features/player/presentation/providers/streak_providers.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'package:soteria/features/player/presentation/providers/milestone_providers.dart';
import 'package:soteria/core/network/providers/connectivity_providers.dart';

void main() {
  Widget createTestWidget({
    required CompetitiveProfile profile,
    bool isLoading = false,
    Object? error,
  }) {
    final rankProgress = RankProgress(
      currentRank: profile.progression.currentRank,
      currentRP: profile.progression.rankPoints,
      minimumRP: 0,
      maximumRP: 10000,
      progressPercentage: profile.progression.rankProgress,
      tier: ProgressionConfig.rankTiers.firstWhere(
        (t) => t.id == profile.progression.currentRankTier.toLowerCase(),
        orElse: () => ProgressionConfig.rankTiers.first,
      ),
      division: 1,
    );

    final identity = CompetitiveIdentity(
      userId: profile.identity.uid,
      profile: profile.identity,
      progression: profile.progression,
      rankProgress: rankProgress,
    );

    return ProviderScope(
      overrides: [
        competitiveProfileProvider.overrideWithValue(
          isLoading
              ? const AsyncValue.loading()
              : error != null
              ? AsyncValue.error(error, StackTrace.current)
              : AsyncValue.data(profile),
        ),
        competitiveIdentityProvider.overrideWith(
          (ref) => isLoading 
            ? Future.value(null)
            : Future.value(identity),
        ),
        rankProgressProvider.overrideWithValue(
          isLoading 
            ? const AsyncValue.loading()
            : AsyncValue.data(rankProgress),
        ),
        selectedAvatarProvider.overrideWithValue(
          const Avatar(
            id: 'socrates',
            name: 'Socrates',
            displayName: 'Socrates',
            assetPath: 'assets/avatars/socrates.png',
            category: AvatarCategory.scholar,
            rarity: AvatarRarity.common,
          ),
        ),
        goalProgressProvider.overrideWithValue(const AsyncValue.data([])),
        nextGoalProvider.overrideWithValue(const AsyncValue.data(null)),
        currentWinStreakProvider.overrideWithValue(const AsyncValue.data(null)),
        currentMomentumProvider.overrideWithValue(const AsyncValue.data(null)),
        currentUserMatchHistoryProvider.overrideWithValue(const AsyncValue.data([])),
        nextCompetitiveMilestoneProvider.overrideWithValue(const AsyncValue.data(null)),
        isOnlineProvider.overrideWithValue(true),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 2000), // Larger height for tests
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: const CompetitiveProfileScreen(),
          ),
        ),
      ),
    );
  }

  testWidgets('should show loading state', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        profile: CompetitiveProfilePreviews.rankedPlayer(),
        isLoading: true,
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('should show error state', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        profile: CompetitiveProfilePreviews.rankedPlayer(),
        error: 'Failed',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Profile Unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('should show profile content for ranked player', (tester) async {
    final profile = CompetitiveProfilePreviews.rankedPlayer();
    await tester.pumpWidget(createTestWidget(profile: profile));
    await tester.pumpAndSettle();

    expect(find.text('CompetitivePro'), findsWidgets);
    expect(find.textContaining('873'), findsWidgets); // Wins
    expect(find.textContaining('DIAMOND'), findsWidgets);
    expect(find.textContaining('2840'), findsWidgets);
  });

  testWidgets('should show empty states for unranked player', (tester) async {
    final profile = CompetitiveProfilePreviews.unrankedPlayer();
    await tester.pumpWidget(createTestWidget(profile: profile));
    await tester.pumpAndSettle();

    expect(find.text('NewChallenger'), findsWidgets);
    expect(find.textContaining('UNRANKED'), findsWidgets);
    
    // Scroll and check for rewards empty state
    final rewardsText = find.textContaining('No rewards');
    await tester.scrollUntilVisible(
      rewardsText,
      500,
      scrollable: find.byType(Scrollable).first,
    );
    expect(rewardsText, findsWidgets);
  });
}
