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

  UserIdentity copyWith({
    AccountStatus? status,
    DateTime? lastLoginAt,
  }) {
    return UserIdentity(
      uid: uid,
      providerId: providerId,
      status: status ?? this.status,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}
