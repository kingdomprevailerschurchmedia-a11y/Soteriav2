import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'identity_repository.dart';
import '../models/user_identity.dart';
import '../models/user_profile.dart';
import '../models/user_game_profile.dart';
import '../models/user_session.dart';

class FirebaseIdentityRepository implements IdentityRepository {
  FirebaseIdentityRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<UserSession?> getActiveSession() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    return UserSession(
      uid: user.uid,
      status: user.emailVerified ? SessionStatus.authenticated : SessionStatus.guest,
      isOffline: false, // Initial state, will be updated by connection listener
    );
  }

  @override
  Future<UserIdentity?> getUserIdentity(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    
    final data = doc.data()!;
    return UserIdentity(
      uid: data['uid'],
      providerId: data['providerId'] ?? 'email',
      status: _mapStatus(data['status']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  @override
  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('user_profiles').doc(uid).get();
    if (!doc.exists) return null;
    
    final data = doc.data()!;
    return UserProfile(
      firstName: data['firstName'],
      lastName: data['lastName'],
      displayName: data['displayName'],
      username: data['username'],
      email: data['email'],
      avatarUrl: data['avatarUrl'],
      academicLevel: data['academicLevel'],
      institution: data['institution'],
      faculty: data['faculty'],
      department: data['department'],
      country: data['country'] ?? 'Nigeria',
    );
  }

  @override
  Future<UserGameProfile?> getUserGameProfile(String uid) async {
    final doc = await _firestore.collection('user_game_profiles').doc(uid).get();
    if (!doc.exists) return null;
    
    final data = doc.data()!;
    return UserGameProfile(
      xp: data['xp'] ?? 0,
      level: data['level'] ?? 1,
      coins: data['coins'] ?? 0,
      tokens: data['tokens'] ?? 0,
      lives: data['lives'] ?? 5,
      rank: data['rank'] ?? 'Novice',
    );
  }

  @override
  Future<void> saveSession(UserSession session) async {
    // Session metadata can be saved locally via secure storage or to Firestore users metadata
  }

  @override
  Future<void> clearSession() async {
    await _auth.signOut();
  }

  AccountStatus _mapStatus(String? status) {
    switch (status) {
      case 'active': return AccountStatus.active;
      case 'locked': return AccountStatus.locked;
      case 'suspended': return AccountStatus.suspended;
      case 'deleted': return AccountStatus.deleted;
      default: return AccountStatus.unverified;
    }
  }
}
