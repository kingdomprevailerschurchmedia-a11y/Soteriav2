import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_repository.dart';
import '../models/registration_draft.dart';
import '../../../core/identity/repositories/firebase_error_mapper.dart';

class FirebaseRegistrationRepository implements RegistrationRepository {
  FirebaseRegistrationRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<void> register(RegistrationDraft draft) async {
    try {
      // 1. Create Auth User
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: draft.email,
        password: draft.password,
      );

      final uid = userCredential.user!.uid;
      final now = FieldValue.serverTimestamp();
      const schemaVersion = 1;

      // 2. Run Firestore Transaction to assign registration order and set profiles
      await _firestore.runTransaction((transaction) async {
        final systemMetaRef = _firestore.collection('metadata').doc('system');
        final systemMetaDoc = await transaction.get(systemMetaRef);

        int currentCount = 3; // Start from 3 because seeds are 1, 2, 3
        if (systemMetaDoc.exists) {
          currentCount = systemMetaDoc.data()?['userCount'] ?? 3;
        }
        
        final nextOrder = currentCount + 1;

        // Update global counter
        transaction.set(systemMetaRef, {'userCount': nextOrder}, SetOptions(merge: true));

        // users/uid (Base Account)
        transaction.set(_firestore.collection('users').doc(uid), {
          'uid': uid,
          'email': draft.email,
          'status': 'unverified',
          'registrationOrder': nextOrder,
          'createdAt': now,
          'updatedAt': now,
          'schemaVersion': schemaVersion,
        });

        // user_profiles/uid (Personal Info)
        transaction.set(_firestore.collection('user_profiles').doc(uid), {
          'firstName': draft.firstName,
          'lastName': draft.lastName,
          'displayName': draft.displayName ?? draft.firstName,
          'username': draft.username,
          'email': draft.email,
          'academicLevel': draft.academicLevel,
          'interests': draft.interests.toList(),
          'goals': draft.goals.toList(),
          'createdAt': now,
          'updatedAt': now,
          'schemaVersion': schemaVersion,
        });

        // user_game_profiles/uid (Game Stats)
        transaction.set(_firestore.collection('user_game_profiles').doc(uid), {
          'xp': 0,
          'level': 1,
          'coins': 0,
          'tokens': 0,
          'lives': 5,
          'rank': 'Novice',
          'createdAt': now,
          'updatedAt': now,
          'schemaVersion': schemaVersion,
        });

        // user_preferences/uid (Settings)
        transaction.set(_firestore.collection('user_preferences').doc(uid), {
          'notificationsEnabled': true,
          'dailyChallengeReminders': true,
          'createdAt': now,
          'updatedAt': now,
          'schemaVersion': schemaVersion,
        });

        // welcome_bonus milestone (New User Reward)
        transaction.set(
          _firestore.collection('users').doc(uid).collection('milestones').doc('welcome_bonus'),
          {
            'userId': uid,
            'milestoneId': 'welcome_bonus',
            'status': 'completed',
            'currentProgress': 1.0,
            'unlockedAt': DateTime.now().toIso8601String(),
            'schemaVersion': 1,
          },
        );
      });

      // 3. Send Verification Email
      await userCredential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorMapper.mapFirebaseAuthException(e);
    } catch (e) {
      rethrow;
    }
  }
}
