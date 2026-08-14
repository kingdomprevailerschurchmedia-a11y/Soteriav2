import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import 'package:soteria/features/player/presentation/providers/leaderboard_providers.dart';
import 'package:soteria/features/social/presentation/screens/friends_screen.dart';
import 'package:soteria/features/social/presentation/screens/friend_requests_screen.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';
import 'package:soteria/features/social/presentation/providers/social_leaderboard_providers.dart';
import 'package:soteria/features/social/presentation/providers/rivalry_providers.dart';
import 'social_fixtures.dart';
import 'rivalry_fixtures.dart';
import '../domain/models/social_activity_event.dart';
import '../presentation/widgets/social_activity_feed.dart';
import '../presentation/widgets/rivalry_card.dart';
import '../presentation/screens/head_to_head_screen.dart';

class SocialPreviews extends StatelessWidget {
  const SocialPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Previews')),
      body: ListView(
        children: [
          _Section('FRIENDS LEADERBOARD'),
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
          
          _Section('RIVALRIES'),
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
              headToHeadProvider('rival_alex').overrideWith((ref) => Future.value(RivalryFixtures.rivalry())),
              headToHeadMatchesProvider('rival_alex').overrideWith((ref) => Future.value([])),
            ]),
          ),

          _Section('SOCIAL ACTIVITY'),
          ListTile(
            title: const Text('Activity Feed'),
            onTap: () => _show(context, Padding(
              padding: const EdgeInsets.all(16),
              child: SocialActivityFeed(activities: [
                SocialActivityEvent(
                  id: '1',
                  userId: 'current_user',
                  otherUserId: 'rival_1',
                  otherDisplayName: 'Alex',
                  type: SocialActivityType.friendRankUp,
                  message: 'Alex reached Gold I',
                  createdAt: DateTime.now().subtract(const Duration(hours: 2)),
                ),
                SocialActivityEvent(
                  id: '2',
                  userId: 'current_user',
                  otherUserId: 'rival_2',
                  otherDisplayName: 'Jordan',
                  type: SocialActivityType.overtake,
                  message: 'You moved ahead of Jordan',
                  createdAt: DateTime.now().subtract(const Duration(hours: 4)),
                ),
              ]),
            )),
          ),

          _Section('OLD PREVIEWS'),
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

  Widget _Section(String title) {
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
      division: 1,
      position: position,
      lastUpdated: DateTime.now(),
    );
  }

  void _show(BuildContext context, Widget screen, {List<Override> overrides = const []}) {
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
