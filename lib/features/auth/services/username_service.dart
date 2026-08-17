import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsernameService {
  Future<bool> isUsernameAvailable(String username);
  bool isReserved(String username);
}

class FirebaseUsernameService implements UsernameService {
  FirebaseUsernameService(this._firestore);
  final FirebaseFirestore _firestore;

  final _reserved = {'admin', 'soteria', 'moderator'};

  @override
  Future<bool> isUsernameAvailable(String username) async {
    final normalized = username.trim().toLowerCase();
    if (isReserved(normalized)) return false;

    final doc = await _firestore.collection('usernames').doc(normalized).get();
    return !doc.exists;
  }

  @override
  bool isReserved(String username) =>
      _reserved.contains(username.toLowerCase());
}

class MockUsernameService implements UsernameService {
  final _reserved = {'admin', 'soteria', 'moderator'};

  @override
  Future<bool> isUsernameAvailable(String username) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return !username.contains('taken');
  }

  @override
  bool isReserved(String username) =>
      _reserved.contains(username.toLowerCase());
}
