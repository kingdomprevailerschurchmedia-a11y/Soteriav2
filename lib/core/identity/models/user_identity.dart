import 'package:flutter/foundation.dart';

enum AccountStatus { active, unverified, locked, suspended, deleted }

@immutable
class UserIdentity {
  final String uid;
  final String providerId; // google, apple, email
  final AccountStatus status;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  const UserIdentity({
    required this.uid,
    required this.providerId,
    this.status = AccountStatus.unverified,
    required this.createdAt,
    required this.lastLoginAt,
  });

<<<<<<< HEAD
  UserIdentity copyWith({AccountStatus? status, DateTime? lastLoginAt}) {
=======
  UserIdentity copyWith({
    AccountStatus? status,
    DateTime? lastLoginAt,
  }) {
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    return UserIdentity(
      uid: uid,
      providerId: providerId,
      status: status ?? this.status,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}
