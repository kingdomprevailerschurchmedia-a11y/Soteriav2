import '../models/friendship.dart';
import '../models/friend_request.dart';
import '../models/follow.dart';
import '../models/relationship_status.dart';

abstract interface class SocialRepository {
  // Relationship Status
  Stream<RelationshipStatus> observeRelationshipStatus(String currentUserId, String otherUserId);
  Future<RelationshipStatus> getRelationshipStatus(String currentUserId, String otherUserId);

  // Friend Requests
  Future<void> sendFriendRequest(String senderId, String receiverId);
  Future<void> acceptFriendRequest(String requestId);
  Future<void> declineFriendRequest(String requestId);
  Future<void> cancelFriendRequest(String requestId);
  Stream<List<FriendRequest>> observeIncomingRequests(String userId);
  Stream<List<FriendRequest>> observeOutgoingRequests(String userId);

  // Friendships
  Future<void> removeFriend(String currentUserId, String otherUserId);
  Stream<List<Friendship>> observeFriends(String userId);
  Future<List<Friendship>> getFriends(String userId);

  // Following
  Future<void> followPlayer(String followerId, String followingId);
  Future<void> unfollowPlayer(String followerId, String followingId);
  Stream<List<Follow>> observeFollowing(String userId);
  Stream<List<Follow>> observeFollowers(String userId);

  // Blocking
  Future<void> blockPlayer(String currentUserId, String otherUserId);
  Future<void> unblockPlayer(String currentUserId, String otherUserId);
  Stream<List<String>> observeBlockedUsers(String userId);
}
