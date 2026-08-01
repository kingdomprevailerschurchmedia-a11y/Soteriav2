import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SoteriaGuard {
  Future<String?> check(String currentPath);
}

final authGuardProvider = Provider<SoteriaGuard>((ref) => _AuthGuard());
final guestGuardProvider = Provider<SoteriaGuard>((ref) => _GuestGuard());
final premiumGuardProvider = Provider<SoteriaGuard>((ref) => _PremiumGuard());

class _AuthGuard implements SoteriaGuard {
  @override
  Future<String?> check(String currentPath) async {
    // Abstraction: Future implementation will check user auth state
    return null; 
  }
}

class _GuestGuard implements SoteriaGuard {
  @override
  Future<String?> check(String currentPath) async {
    // Abstraction: Future implementation will redirect authenticated users away from login
    return null;
  }
}

class _PremiumGuard implements SoteriaGuard {
  @override
  Future<String?> check(String currentPath) async {
    // Abstraction: Future implementation will check subscription status
    return null;
  }
}
