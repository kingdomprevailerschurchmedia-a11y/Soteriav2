import 'friendship.dart';

extension FriendshipX on Friendship {
  /// Gets the ID of the friend in the friendship (the user who is NOT the current user).
  String getFriendId(String currentUserId) {
    return userIds.firstWhere((id) => id != currentUserId, orElse: () => '');
  }
}
