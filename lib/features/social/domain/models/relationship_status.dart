enum RelationshipStatus {
  /// No relationship or pending request.
  none,

  /// Current user has sent a friend request.
  requestSent,

  /// Current user has received a friend request.
  requestReceived,

  /// Users are friends.
  friends,

  /// Current user has blocked the other user.
  blocked,
  
  /// Current user is blocked by the other user.
  blockedBy,
}
