import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_season.dart';
import '../domain/models/milestone.dart';
import '../domain/models/rank_progress.dart';
import '../domain/models/rank_tier.dart';
import '../domain/models/season_reward_definition.dart';
import '../presentation/providers/season_providers.dart';
import '../presentation/providers/rank_providers.dart';
import '../presentation/providers/milestone_providers.dart';
import '../presentation/providers/reward_providers.dart';
import '../presentation/providers/leaderboard_providers.dart';
import '../presentation/screens/competitive_season_screen.dart';
import '../domain/models/leaderboard_entry.dart';
import '../domain/repositories/leaderboard_repository.dart';
import '../domain/models/rank_movement_event.dart';
import '../domain/repositories/activity_repository.dart';
import '../domain/models/competitive_activity_event.dart';
import '../presentation/providers/activity_providers.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';
import 'package:soteria/features/social/domain/models/relationship_status.dart';
import '../domain/models/player_profile.dart';
import '../domain/models/player_progression.dart';
import 'package:soteria/features/auth/domain/repositories/auth_repository.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/auth/models/authentication_result.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/identity/models/user_profile.dart' as up;
import 'package:soteria/features/social/domain/repositories/social_repository.dart';
import 'package:soteria/features/social/domain/models/friendship.dart';
import 'package:soteria/features/social/domain/models/friend_request.dart';
import 'package:soteria/features/social/domain/models/follow.dart';

class MockLeaderboardRepository implements LeaderboardRepository {
  @override
  Future<void> syncLeaderboardEntry({
    required PlayerProfile profile,
    required PlayerProgression progression,
    String? seasonId,
    dynamic transaction,
  }) async {}

  @override Future<List<LeaderboardEntry>> getLeaderboardPage({String? seasonId, int limit = 50, lastCursor}) async => [];
  @override Future<LeaderboardEntry?> getPlayerEntry({required String userId, String? seasonId}) async => null;
  @override Future<List<LeaderboardEntry>> getLeaderboardAroundPlayer({required String userId, String? seasonId, int windowSize = 5}) async => [];
  @override Future<int> getPlayerRankPosition({required String userId, String? seasonId}) async => 0;
  @override Future<int> getTotalPlayers({String? seasonId}) async => 0;
  @override Future<List<RankMovementEvent>> getPositionHistory({required String userId, String? seasonId, int limit = 50}) async => [];
  @override Future<void> recordMovement(RankMovementEvent event) async {}
  @override Future<List<LeaderboardEntry>> getEntriesByUserIds(List<String> userIds, {String? seasonId}) async => [];
}

class _MockActivityRepository implements ActivityRepository {
  @override Future<List<CompetitiveActivityEvent>> getSocialActivityFeed(String userId, List<String> userIds, {int limit = 20, CompetitiveActivityEvent? lastEvent, List<ActivityVisibility>? visibilities}) async => [];
  @override Future<List<CompetitiveActivityEvent>> getActivityEvents(String userId, {int limit = 20, CompetitiveActivityEvent? lastEvent}) async => [];
  @override Future<void> recordActivityEvent(CompetitiveActivityEvent event) async {}
  @override Stream<List<CompetitiveActivityEvent>> watchSocialActivity(List<String> userIds, {int limit = 20, List<ActivityVisibility>? visibilities}) => Stream.value([]);
}

class _MockSocialRepository implements SocialRepository {
  @override Stream<RelationshipStatus> observeRelationshipStatus(String currentUserId, String otherUserId) => Stream.value(RelationshipStatus.none);
  @override Future<RelationshipStatus> getRelationshipStatus(String currentUserId, String otherUserId) async => RelationshipStatus.none;
  @override Future<void> sendFriendRequest(String senderId, String receiverId) async {}
  @override Future<void> acceptFriendRequest(String requestId) async {}
  @override Future<void> declineFriendRequest(String requestId) async {}
  @override Future<void> cancelFriendRequest(String requestId) async {}
  @override Stream<List<FriendRequest>> observeIncomingRequests(String userId) => Stream.value([]);
  @override Stream<List<FriendRequest>> observeOutgoingRequests(String userId) => Stream.value([]);
  @override Future<void> removeFriend(String currentUserId, String otherUserId) async {}
  @override Stream<List<Friendship>> observeFriends(String userId) => Stream.value([]);
  @override Future<List<Friendship>> getFriends(String userId) async => [];
  @override Future<void> followPlayer(String followerId, String followingId) async {}
  @override Future<void> unfollowPlayer(String followerId, String followingId) async {}
  @override Stream<List<Follow>> observeFollowing(String userId) => Stream.value([]);
  @override Stream<List<Follow>> observeFollowers(String userId) => Stream.value([]);
  @override Future<void> blockPlayer(String currentUserId, String otherUserId) async {}
  @override Future<void> unblockPlayer(String currentUserId, String otherUserId) async {}
  @override Stream<List<String>> observeBlockedUsers(String userId) => Stream.value([]);
}

class MockAuthRepository implements AuthRepository {
  @override String? get currentUserId => 'u1';
  @override Stream<String?> get userIdChanges => Stream.value('u1');
  @override Future<AuthenticationResult> signInWithEmail(String email, String password) async => const AuthenticationResult.success('u1');
  @override Future<AuthenticationResult> signUpWithEmail(String email, String password) async => const AuthenticationResult.success('u1');
  @override Future<AuthenticationResult> signInWithGoogle() async => const AuthenticationResult.success('u1');
  @override Future<void> signOut() async {}
  @override Future<void> sendPasswordResetEmail(String email) async {}
  @override Future<void> sendEmailVerification() async {}
  @override Future<bool> isEmailVerified() async => true;
}

class MockSessionNotifier extends SessionNotifier {
  @override
  UserSession build() => const UserSession(uid: 'u1', status: SessionStatus.authenticated);
}

class MockProfileNotifier extends ProfileNotifier {
  @override
  up.UserProfile? build() => const up.UserProfile(
    firstName: 'Joseph',
    lastName: 'Ade',
    displayName: 'Joseph Ade',
    username: 'joseph',
    email: 'joseph@ade.com',
  );
}

class MockActivityFeedNotifier extends ActivityFeedNotifier {
  MockActivityFeedNotifier() : super(_MockActivityRepository(), 'u1', ActivityFilter.all, null as dynamic) {
    state = const AsyncValue.data([]);
  }
  @override Future<void> loadInitial() async {}
  @override Future<void> loadMore() async {}
}

class SeasonPreviews {
  static List _overrides({
    required CompetitiveSeason season,
    RankProgress? rank,
  }) {
    return [
      currentSeasonProvider.overrideWith((ref) => Stream.value(season)),
      if (rank != null) rankProgressProvider.overrideWithValue(AsyncValue.data(rank)),
      milestoneProgressProvider.overrideWithValue(const AsyncValue.data([])),
      seasonRewardDefinitionsProvider(season.seasonId).overrideWith((ref) => Future.value([])),
      leaderboardRepositoryProvider.overrideWithValue(MockLeaderboardRepository()),
      authRepositoryProvider.overrideWithValue(MockAuthRepository()),
      sessionProvider.overrideWith(MockSessionNotifier.new),
      profileProvider.overrideWith(MockProfileNotifier.new),
      activityFeedProvider(season.seasonId).overrideWith((ref) => MockActivityFeedNotifier()),
      activityRepositoryProvider.overrideWithValue(_MockActivityRepository()),
      socialRepositoryProvider.overrideWithValue(_MockSocialRepository()),
    ];
  }

  static Widget active() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's1',
        name: 'Cyber Frontier',
        status: SeasonStatus.active,
        startAt: DateTime.now().subtract(const Duration(days: 10)),
        endAt: DateTime.now().add(const Duration(days: 12)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 1,
        description: 'Master the digital world and claim your rewards.',
      ),
      rank: RankProgress(
        currentRank: 'Gold II',
        currentRP: 2450,
        minimumRP: 2000,
        maximumRP: 3000,
        progressPercentage: 0.45,
        tier: const RankTier(id: 'gold', name: 'Gold', promotionThreshold: 2000, demotionThreshold: 1500, displayOrder: 3, maxPoints: 3000, minPoints: 2000, visualToken: 'gold_token'),
        division: 2,
      ),
    ).cast(),
    child: const CompetitiveSeasonScreen(),
  );

  static Widget upcoming() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's2',
        name: 'Neon Nights',
        status: SeasonStatus.upcoming,
        startAt: DateTime.now().add(const Duration(days: 5)),
        endAt: DateTime.now().add(const Duration(days: 35)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 2,
      ),
    ).cast(),
    child: const CompetitiveSeasonScreen(),
  );

  static Widget endingSoon() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's1',
        name: 'Cyber Frontier',
        status: SeasonStatus.ending,
        startAt: DateTime.now().subtract(const Duration(days: 28)),
        endAt: DateTime.now().add(const Duration(hours: 4)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 1,
      ),
    ).cast(),
    child: const CompetitiveSeasonScreen(),
  );

  static Widget completed() => ProviderScope(
    overrides: _overrides(
      season: CompetitiveSeason(
        seasonId: 's0',
        name: 'Legacy Void',
        status: SeasonStatus.completed,
        startAt: DateTime.now().subtract(const Duration(days: 60)),
        endAt: DateTime.now().subtract(const Duration(days: 30)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        seasonNumber: 0,
      ),
    ).cast(),
    child: const CompetitiveSeasonScreen(),
  );
}
