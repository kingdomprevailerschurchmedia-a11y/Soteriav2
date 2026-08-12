import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';

enum SessionStatus { guest, authenticated, expired, locked, suspended, offline }

@freezed
abstract class UserSession with _$UserSession {
  const factory UserSession({
    String? sessionId,
    String? uid,
    @Default(SessionStatus.guest) SessionStatus status,
    DateTime? expiresAt,
    @Default(false) bool isOffline,
    @Default(false) bool hasPendingSync,
  }) = _UserSession;

  const UserSession._();

  bool get isAuthenticated => status == SessionStatus.authenticated;
  bool get isGuest => status == SessionStatus.guest;
  bool get isExpired => status == SessionStatus.expired;
}
