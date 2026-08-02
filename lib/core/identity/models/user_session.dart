import 'package:flutter/foundation.dart';

enum SessionStatus { guest, authenticated, expired, locked, suspended, offline }

@immutable
class UserSession {
  final String? sessionId;
  final String? uid;
  final SessionStatus status;
  final DateTime? expiresAt;
  final bool isOffline;
  final bool hasPendingSync;

  const UserSession({
    this.sessionId,
    this.uid,
    this.status = SessionStatus.guest,
    this.expiresAt,
    this.isOffline = false,
    this.hasPendingSync = false,
  });

  bool get isAuthenticated => status == SessionStatus.authenticated;
  bool get isGuest => status == SessionStatus.guest;
  bool get isExpired => status == SessionStatus.expired;

  UserSession copyWith({
    String? sessionId,
    String? uid,
    SessionStatus? status,
    DateTime? expiresAt,
    bool? isOffline,
    bool? hasPendingSync,
  }) {
    return UserSession(
      sessionId: sessionId ?? this.sessionId,
      uid: uid ?? this.uid,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      isOffline: isOffline ?? this.isOffline,
      hasPendingSync: hasPendingSync ?? this.hasPendingSync,
    );
  }
}
