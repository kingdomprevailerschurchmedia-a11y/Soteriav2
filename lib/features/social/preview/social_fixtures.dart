import '../../social/domain/models/friendship.dart';
import '../../social/domain/models/friend_request.dart';

class SocialFixtures {
  static Friendship friendship({String? otherUserId}) => Friendship(
    id: 'friendship_123',
    userIds: ['current_user', otherUserId ?? 'other_user'],
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
  );

  static FriendRequest incomingRequest({String? senderId}) => FriendRequest(
    id: 'request_incoming',
    senderId: senderId ?? 'other_user',
    receiverId: 'current_user',
    status: FriendRequestStatus.pending,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  );

  static FriendRequest outgoingRequest({String? receiverId}) => FriendRequest(
    id: 'request_outgoing',
    senderId: 'current_user',
    receiverId: receiverId ?? 'other_user',
    status: FriendRequestStatus.pending,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  );
}
