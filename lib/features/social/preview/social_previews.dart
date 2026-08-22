import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/auth/domain/repositories/auth_repository.dart';
import 'package:soteria/features/auth/models/authentication_result.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import 'package:soteria/features/social/presentation/screens/friends_screen.dart';
import 'package:soteria/features/social/presentation/screens/friend_requests_screen.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';
import 'package:soteria/features/social/presentation/providers/social_leaderboard_providers.dart';
import 'package:soteria/features/social/presentation/providers/rivalry_providers.dart';
import 'social_fixtures.dart';
import 'rivalry_fixtures.dart';
import '../presentation/widgets/social_activity_feed.dart';
import '../presentation/widgets/rivalry_card.dart';
import '../presentation/screens/head_to_head_screen.dart';
import 'package:soteria/features/social/domain/models/relationship_status.dart';
import 'package:soteria/features/player/domain/models/competitive_activity_event.dart';
import 'package:soteria/features/player/domain/models/competitive_event.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';

import 'package:soteria/features/player/domain/models/public_competitive_profile.dart';
import 'package:soteria/features/player/presentation/widgets/search/player_search_result_card.dart';

class SocialPreviews extends StatelessWidget {
  const SocialPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Previews')),
      body: ListView(
        children: [
          _section('FRIENDS LEADERBOARD'),
          ListTile(
            title: const Text('Friends Leaderboard (With Friends)'),
            onTap: () => _show(context, const FriendsScreen(), overrides: [
              friendsProvider.overrideWith((ref) => Stream.value([
                SocialFixtures.friendship(otherUserId: 'rival_1'),
                SocialFixtures.friendship(otherUserId: 'rival_2'),
              ])),
              friendsLeaderboardProvider.overrideWith((ref) => Future.value([
                _mockEntry('rival_1', 'Alex', 2850, 1),
                _mockEntry('current_user', 'You', 2450, 2),
                _mockEntry('rival_2', 'Jordan', 2310, 3),
              ])),
            ]),
          ),
          
          _section('RELATIONSHIP ACTIONS (SEARCH)'),
          ListTile(
            title: const Text('Search Result - None (Add Friend)'),
            onTap: () => _show(context, Padding(
              padding: const EdgeInsets.all(16),
              child: PlayerSearchResultCard(
                profile: _mockProfile('rival_3', 'Riley'),
                onTap: () {},
              ),
            ), overrides: [
              relationshipStatusProvider('rival_3').overrideWith((ref) => Future.value(RelationshipStatus.none)),
              authRepositoryProvider.overrideWith((ref) => _MockAuthRepo('current_user')),
            ]),
          ),
          ListTile(
            title: const Text('Search Result - Pending (Request Sent)'),
            onTap: () => _show(context, Padding(
              padding: const EdgeInsets.all(16),
              child: PlayerSearchResultCard(
                profile: _mockProfile('rival_4', 'Casey'),
                onTap: () {},
              ),
            ), overrides: [
              relationshipStatusProvider('rival_4').overrideWith((ref) => Future.value(RelationshipStatus.requestSent)),
              authRepositoryProvider.overrideWith((ref) => _MockAuthRepo('current_user')),
            ]),
          ),
          ListTile(
            title: const Text('Search Result - Incoming (Accept/Decline)'),
            onTap: () => _show(context, Padding(
              padding: const EdgeInsets.all(16),
              child: PlayerSearchResultCard(
                profile: _mockProfile('rival_5', 'Taylor'),
                onTap: () {},
              ),
            ), overrides: [
              relationshipStatusProvider('rival_5').overrideWith((ref) => Future.value(RelationshipStatus.requestReceived)),
              authRepositoryProvider.overrideWith((ref) => _MockAuthRepo('current_user')),
            ]),
          ),
          ListTile(
            title: const Text('Search Result - Friends (Remove)'),
            onTap: () => _show(context, Padding(
              padding: const EdgeInsets.all(16),
              child: PlayerSearchResultCard(
                profile: _mockProfile('rival_6', 'Morgan'),
                onTap: () {},
              ),
            ), overrides: [
              relationshipStatusProvider('rival_6').overrideWith((ref) => Future.value(RelationshipStatus.friends)),
              authRepositoryProvider.overrideWith((ref) => _MockAuthRepo('current_user')),
            ]),
          ),
          
          _section('RIVALRIES'),
          ListTile(
            title: const Text('Rivalry Card'),
            onTap: () => _show(context, Padding(
              padding: const EdgeInsets.all(16),
              child: RivalryCard(rivalry: RivalryFixtures.rivalry()),
            )),
          ),
          ListTile(
            title: const Text('Head-to-Head Screen'),
            onTap: () => _show(context, const HeadToHeadScreen(rivalId: 'rival_alex'), overrides: [
              headToHeadProvider('rival_alex').overrideWith((ref) => Future.value(RivalryFixtures.headToHeadSummary())),
              headToHeadMatchesProvider('rival_alex').overrideWith((ref) => Future.value([])),
            ]),
          ),

          _section('SOCIAL ACTIVITY'),
          ListTile(
            title: const Text('Activity Feed'),
            onTap: () => _show(context, Padding(
              padding: const EdgeInsets.all(16),
              child: SocialActivityFeed(activities: [
                CompetitiveActivityEvent(
                  id: '1',
                  userId: 'rival_1',
                  type: CompetitiveEventType.rankPromoted,
                  title: 'Tier Promotion!',
                  description: 'Alex reached Gold I',
                  createdAt: DateTime.now().subtract(const Duration(hours: 2)),
                  importance: ActivityImportance.high,
                  metadata: {'rank': 'Gold I'},
                ),
                CompetitiveActivityEvent(
                  id: '2',
                  userId: 'current_user',
                  type: CompetitiveEventType.personalBest,
                  title: 'New Career Best!',
                  description: 'You moved ahead of Jordan',
                  createdAt: DateTime.now().subtract(const Duration(hours: 4)),
                  importance: ActivityImportance.normal,
                ),
              ]),
            )),
          ),

          _section('OLD PREVIEWS'),
          ListTile(
            title: const Text('Friends List (Empty)'),
            onTap: () => _show(context, const FriendsScreen(), overrides: [
              friendsProvider.overrideWith((ref) => Stream.value([])),
            ]),
          ),
          ListTile(
            title: const Text('Friend Requests'),
            onTap: () => _show(context, const FriendRequestsScreen(), overrides: [
              incomingRequestsProvider.overrideWith((ref) => Stream.value([
                SocialFixtures.incomingRequest(senderId: 'rival_1'),
              ])),
              outgoingRequestsProvider.overrideWith((ref) => Stream.value([
                SocialFixtures.outgoingRequest(receiverId: 'rival_2'),
              ])),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  LeaderboardEntry _mockEntry(String userId, String name, int rp, int position) {
    return LeaderboardEntry(
      userId: userId,
      displayName: name,
      avatarId: 'socrates',
      rankTier: rp > 2500 ? 'Gold' : 'Silver',
      rankPoints: rp,
      xp: rp * 10,
      division: 1,
      position: position,
      lastUpdated: DateTime.now(),
    );
  }

  PublicCompetitiveProfile _mockProfile(String userId, String name) {
    return PublicCompetitiveProfile(
      userId: userId,
      displayName: name,
      avatarId: 'socrates',
      currentRank: 'Gold I',
      rankTier: 'Gold',
      rankPoints: 2450,
      division: 1,
      careerHighlights: CareerStatistics(
        gamesPlayed: 150,
        gamesWon: 85,
        gamesLost: 65,
        winRate: 85 / 150,
        accuracy: 0.72,
        totalQuestionsAnswered: 1000,
        correctAnswers: 720,
        currentStreak: 5,
        highestStreak: 12,
        bestRank: 'Gold I',
        peakPosition: 500,
        seasonsPlayed: 2,
      ),
      updatedAt: DateTime.now(),
    );
  }

  void _show(BuildContext context, Widget screen, {List<dynamic> overrides = const []}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProviderScope(
          overrides: [
            ...overrides,
          ],
          child: screen,
        ),
      ),
    );
  }
}

class _MockAuthRepo implements AuthRepository {
  @override
  final String? currentUserId;
  _MockAuthRepo(this.currentUserId);

  @override
  Stream<String?> get userIdChanges => Stream.value(currentUserId);

  @override
  Future<AuthenticationResult> signInWithEmail(String email, String password) async => AuthenticationResult.success(currentUserId ?? 'mock_uid');

  @override
  Future<AuthenticationResult> signUpWithEmail(String email, String password) async => AuthenticationResult.success(currentUserId ?? 'mock_uid');

  @override
  Future<AuthenticationResult> signInWithGoogle() async => AuthenticationResult.success(currentUserId ?? 'mock_uid');

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<bool> isEmailVerified() async => true;
}
