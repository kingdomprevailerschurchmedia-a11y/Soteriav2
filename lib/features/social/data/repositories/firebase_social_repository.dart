import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/friendship.dart';
import '../../domain/models/friend_request.dart';
import '../../domain/models/follow.dart';
import '../../domain/models/relationship_status.dart';
import '../../domain/repositories/social_repository.dart';

class FirebaseSocialRepository implements SocialRepository {
  final FirebaseFirestore _firestore;

  FirebaseSocialRepository(this._firestore);

  @override
  Stream<RelationshipStatus> observeRelationshipStatus(String currentUserId, String otherUserId) {
    // This is complex as it depends on multiple collections.
    // In a real app, a consolidated "relationships" collection or multiple listeners combined might be used.
    // For simplicity, we'll combine checks here or assume the caller handles multi-provider watching.
    // Here we implement a simplified version.
    return _firestore.collection('friendships')
        .where('userIds', arrayContains: currentUserId)
        .snapshots()
        .map((snapshot) {
          final isFriend = snapshot.docs.any((doc) => (doc.data()['userIds'] as List).contains(otherUserId));
          if (isFriend) return RelationshipStatus.friends;
          return RelationshipStatus.none; // Simplified: logic would continue to check requests/blocks
        });
  }

  @override
  Future<RelationshipStatus> getRelationshipStatus(String currentUserId, String otherUserId) async {
    // Check block status first
    final blockDoc = await _firestore.collection('blocks').doc('${currentUserId}_$otherUserId').get();
    if (blockDoc.exists) return RelationshipStatus.blocked;

    final blockedByDoc = await _firestore.collection('blocks').doc('${otherUserId}_$currentUserId').get();
    if (blockedByDoc.exists) return RelationshipStatus.blockedBy;

    // Check friendship
    final friendshipQuery = await _firestore.collection('friendships')
        .where('userIds', arrayContains: currentUserId)
        .get();
    final isFriend = friendshipQuery.docs.any((doc) => (doc.data()['userIds'] as List).contains(otherUserId));
    if (isFriend) return RelationshipStatus.friends;

    // Check requests
    final outgoingRequest = await _firestore.collection('friend_requests')
        .where('senderId', isEqualTo: currentUserId)
        .where('receiverId', isEqualTo: otherUserId)
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();
    if (outgoingRequest.docs.isNotEmpty) return RelationshipStatus.requestSent;

    final incomingRequest = await _firestore.collection('friend_requests')
        .where('senderId', isEqualTo: otherUserId)
        .where('receiverId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();
    if (incomingRequest.docs.isNotEmpty) return RelationshipStatus.requestReceived;

    return RelationshipStatus.none;
  }

  @override
  Future<void> sendFriendRequest(String senderId, String receiverId) async {
    if (senderId == receiverId) {
      throw Exception('You cannot send a friend request to yourself');
    }

    await _firestore.runTransaction((transaction) async {
      // Check if already friends
      final friendshipId = senderId.compareTo(receiverId) < 0
          ? '${senderId}_$receiverId'
          : '${receiverId}_$senderId';
      final friendshipDoc = await transaction.get(_firestore.collection('friendships').doc(friendshipId));
      if (friendshipDoc.exists) {
        throw Exception('You are already friends with this player');
      }

      // Check for existing pending request (either direction)
      final outgoingId = '${senderId}_$receiverId';
      final incomingId = '${receiverId}_$senderId';
      
      final outgoingDoc = await transaction.get(_firestore.collection('friend_requests').doc(outgoingId));
      final incomingDoc = await transaction.get(_firestore.collection('friend_requests').doc(incomingId));

      if (outgoingDoc.exists && outgoingDoc.data()?['status'] == 'pending') {
        throw Exception('A friend request is already pending');
      }
      if (incomingDoc.exists && incomingDoc.data()?['status'] == 'pending') {
        throw Exception('This player has already sent you a friend request');
      }

      // Safe to send
      transaction.set(_firestore.collection('friend_requests').doc(outgoingId), {
        'senderId': senderId,
        'receiverId': receiverId,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> acceptFriendRequest(String requestId) async {
    await _firestore.runTransaction((transaction) async {
      final requestDoc = await transaction.get(_firestore.collection('friend_requests').doc(requestId));
      if (!requestDoc.exists) {
        throw Exception('Friend request not found');
      }

      final data = requestDoc.data()!;
      if (data['status'] != 'pending') {
        throw Exception('Friend request is no longer pending');
      }

      final senderId = data['senderId'];
      final receiverId = data['receiverId'];

      // Update request
      transaction.update(requestDoc.reference, {
        'status': 'accepted',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Create friendship
      final friendshipId = senderId.compareTo(receiverId) < 0
          ? '${senderId}_$receiverId'
          : '${receiverId}_$senderId';

      transaction.set(_firestore.collection('friendships').doc(friendshipId), {
        'userIds': [senderId, receiverId],
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> declineFriendRequest(String requestId) async {
    await _firestore.runTransaction((transaction) async {
      final requestDoc = await transaction.get(_firestore.collection('friend_requests').doc(requestId));
      if (!requestDoc.exists) return;
      if (requestDoc.data()?['status'] != 'pending') return;

      transaction.update(requestDoc.reference, {
        'status': 'declined',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> cancelFriendRequest(String requestId) async {
    await _firestore.runTransaction((transaction) async {
      final requestDoc = await transaction.get(_firestore.collection('friend_requests').doc(requestId));
      if (!requestDoc.exists) return;
      if (requestDoc.data()?['status'] != 'pending') return;

      transaction.update(requestDoc.reference, {
        'status': 'cancelled',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Stream<List<FriendRequest>> observeIncomingRequests(String userId) {
    return _firestore.collection('friend_requests')
        .where('receiverId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => _mapToFriendRequest(doc)).toList());
  }

  @override
  Stream<List<FriendRequest>> observeOutgoingRequests(String userId) {
    return _firestore.collection('friend_requests')
        .where('senderId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => _mapToFriendRequest(doc)).toList());
  }

  @override
  Future<void> removeFriend(String currentUserId, String otherUserId) async {
    final friendshipId = currentUserId.compareTo(otherUserId) < 0 
        ? '${currentUserId}_$otherUserId' 
        : '${otherUserId}_$currentUserId';
    await _firestore.collection('friendships').doc(friendshipId).delete();
  }

  @override
  Stream<List<Friendship>> observeFriends(String userId) {
    return _firestore.collection('friendships')
        .where('userIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => _mapToFriendship(doc)).toList());
  }

  @override
  Future<List<Friendship>> getFriends(String userId) async {
    final snapshot = await _firestore.collection('friendships')
        .where('userIds', arrayContains: userId)
        .get();
    return snapshot.docs.map((doc) => _mapToFriendship(doc)).toList();
  }

  @override
  Future<void> followPlayer(String followerId, String followingId) async {
    final followId = '${followerId}_$followingId';
    await _firestore.collection('follows').doc(followId).set({
      'followerId': followerId,
      'followingId': followingId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> unfollowPlayer(String followerId, String followingId) async {
    final followId = '${followerId}_$followingId';
    await _firestore.collection('follows').doc(followId).delete();
  }

  @override
  Stream<List<Follow>> observeFollowing(String userId) {
    return _firestore.collection('follows')
        .where('followerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => _mapToFollow(doc)).toList());
  }

  @override
  Stream<List<Follow>> observeFollowers(String userId) {
    return _firestore.collection('follows')
        .where('followingId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => _mapToFollow(doc)).toList());
  }

  @override
  Future<void> blockPlayer(String currentUserId, String otherUserId) async {
    final blockId = '${currentUserId}_$otherUserId';
    await _firestore.collection('blocks').doc(blockId).set({
      'blockerId': currentUserId,
      'blockedId': otherUserId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> unblockPlayer(String currentUserId, String otherUserId) async {
    final blockId = '${currentUserId}_$otherUserId';
    await _firestore.collection('blocks').doc(blockId).delete();
  }

  @override
  Stream<List<String>> observeBlockedUsers(String userId) {
    return _firestore.collection('blocks')
        .where('blockerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()['blockedId'] as String).toList());
  }

  // Mappers
  FriendRequest _mapToFriendRequest(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FriendRequest(
      id: doc.id,
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      status: _mapToFriendRequestStatus(data['status']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : null,
    );
  }

  FriendRequestStatus _mapToFriendRequestStatus(String status) {
    switch (status) {
      case 'pending': return FriendRequestStatus.pending;
      case 'accepted': return FriendRequestStatus.accepted;
      case 'declined': return FriendRequestStatus.declined;
      case 'cancelled': return FriendRequestStatus.cancelled;
      default: return FriendRequestStatus.pending;
    }
  }

  Friendship _mapToFriendship(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Friendship(
      id: doc.id,
      userIds: List<String>.from(data['userIds']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      metadata: data['metadata'] ?? {},
    );
  }

  Follow _mapToFollow(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Follow(
      id: doc.id,
      followerId: data['followerId'],
      followingId: data['followingId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
