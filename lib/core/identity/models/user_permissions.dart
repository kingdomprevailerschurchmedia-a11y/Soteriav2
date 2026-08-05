import 'package:flutter/foundation.dart';

enum UserRole { free, premium, moderator, ambassador, administrator }

@immutable
class UserPermissions {
  final UserRole role;
  final Set<String> grantedFeatures;

  const UserPermissions({
    this.role = UserRole.free,
    this.grantedFeatures = const {},
  });

  bool can(String feature) {
    if (role == UserRole.administrator) return true;
    return grantedFeatures.contains(feature);
  }

  UserPermissions copyWith({UserRole? role, Set<String>? grantedFeatures}) {
    return UserPermissions(
      role: role ?? this.role,
      grantedFeatures: grantedFeatures ?? this.grantedFeatures,
    );
  }
}
