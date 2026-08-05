import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import '../../firebase/services/firebase_interfaces.dart';
=======
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
import 'identity_repository.dart';
import '../models/user_identity.dart';
import '../models/user_profile.dart';
import '../models/user_game_profile.dart';
import '../models/user_session.dart';

class FirebaseIdentityRepository implements IdentityRepository {
  FirebaseIdentityRepository({
<<<<<<< HEAD
    required IAuthService auth,
    required IDatabaseService database,
  }) : _auth = auth,
       _database = database;

  final IAuthService _auth;
  final IDatabaseService _database;

  @override
  Stream<UserSession?> get sessionChanges => _auth.authStateChanges.map((user) {
    if (user == null) return null;
    return UserSession(
      uid: user.uid,
      status: user.emailVerified
          ? SessionStatus.authenticated
          : SessionStatus.guest,
      isOffline: false,
    );
  });
=======
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30

  @override
  Future<UserSession?> getActiveSession() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    return UserSession(
      uid: user.uid,
<<<<<<< HEAD
      status: user.emailVerified
          ? SessionStatus.authenticated
          : SessionStatus.guest,
      isOffline: false,
=======
      status: user.emailVerified ? SessionStatus.authenticated : SessionStatus.guest,
      isOffline: false, // Initial state, will be updated by connection listener
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    );
  }

  @override
  Future<UserIdentity?> getUserIdentity(String uid) async {
<<<<<<< HEAD
    final doc = await _database.collection('users').doc(uid).get();
    if (!doc.exists) return null;

=======
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    final data = doc.data()!;
    return UserIdentity(
      uid: data['uid'],
      providerId: data['providerId'] ?? 'email',
      status: _mapStatus(data['status']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
<<<<<<< HEAD
      lastLoginAt:
          (data['lastLoginAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
=======
      lastLoginAt: (data['lastLoginAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    );
  }

  @override
  Future<UserProfile?> getUserProfile(String uid) async {
<<<<<<< HEAD
    final doc = await _database.collection('user_profiles').doc(uid).get();
    if (!doc.exists) return null;

=======
    final doc = await _firestore.collection('user_profiles').doc(uid).get();
    if (!doc.exists) return null;
    
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
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
<<<<<<< HEAD
    final doc = await _database.collection('user_game_profiles').doc(uid).get();
    if (!doc.exists) return null;

=======
    final doc = await _firestore.collection('user_game_profiles').doc(uid).get();
    if (!doc.exists) return null;
    
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
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
<<<<<<< HEAD
      case 'active':
        return AccountStatus.active;
      case 'locked':
        return AccountStatus.locked;
      case 'suspended':
        return AccountStatus.suspended;
      case 'deleted':
        return AccountStatus.deleted;
      default:
        return AccountStatus.unverified;
=======
      case 'active': return AccountStatus.active;
      case 'locked': return AccountStatus.locked;
      case 'suspended': return AccountStatus.suspended;
      case 'deleted': return AccountStatus.deleted;
      default: return AccountStatus.unverified;
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    }
  }
}
