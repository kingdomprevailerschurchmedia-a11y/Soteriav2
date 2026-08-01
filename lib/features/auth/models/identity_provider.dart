import 'package:flutter/material.dart';

enum IdentityProviderType { google, apple, email, guest }

@immutable
class IdentityProvider {
  final String id;
  final String name;
  final IconData icon;
  final IdentityProviderType type;
  final bool isEnabled;

  const IdentityProvider({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    this.isEnabled = true,
  });
}
