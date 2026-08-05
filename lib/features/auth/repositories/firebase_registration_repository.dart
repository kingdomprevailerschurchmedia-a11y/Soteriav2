import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_repository.dart';
import '../models/registration_draft.dart';
import '../../../core/identity/repositories/firebase_error_mapper.dart';

class FirebaseRegistrationRepository implements RegistrationRepository {
  FirebaseRegistrationRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
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

      // 2. Batch write all profile documents to maintain atomicity
      final batch = _firestore.batch();

      // users/uid (Base Account)
      batch.set(_firestore.collection('users').doc(uid), {
        'uid': uid,
        'email': draft.email,
        'status': 'unverified',
        'createdAt': now,
        'updatedAt': now,
        'schemaVersion': schemaVersion,
      });

      // user_profiles/uid (Personal Info)
      batch.set(_firestore.collection('user_profiles').doc(uid), {
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
      batch.set(_firestore.collection('user_game_profiles').doc(uid), {
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
      batch.set(_firestore.collection('user_preferences').doc(uid), {
        'notificationsEnabled': true,
        'dailyChallengeReminders': true,
        'createdAt': now,
        'updatedAt': now,
        'schemaVersion': schemaVersion,
      });

      await batch.commit();

      // 3. Send Verification Email
      await userCredential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorMapper.mapFirebaseAuthException(e);
    } catch (e) {
      rethrow;
    }
  }
}
