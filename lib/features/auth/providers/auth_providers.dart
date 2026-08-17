import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'package:soteria/core/firebase/data_sources/auth_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/username_service.dart';
import '../data/repositories/firebase_auth_repository.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/use_cases/check_auth_state_use_case.dart';
import '../domain/use_cases/forgot_password_use_case.dart';
import '../domain/use_cases/google_sign_in_use_case.dart';
import '../domain/use_cases/logout_use_case.dart';
import '../domain/use_cases/send_email_verification_use_case.dart';
import '../domain/use_cases/sign_in_use_case.dart';
import '../domain/use_cases/sign_up_use_case.dart';

// --- Data Sources ---
final googleSignInProvider = Provider<gsi.GoogleSignIn>((ref) {
  return gsi.GoogleSignIn.instance;
});

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return FirebaseAuthDataSource(googleSignIn: ref.watch(googleSignInProvider));
});

// --- Repositories ---
final usernameServiceProvider = Provider<UsernameService>((ref) {
  return FirebaseUsernameService(FirebaseFirestore.instance);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(dataSource: ref.watch(authDataSourceProvider));
});

// --- Use Cases ---
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

final googleSignInUseCaseProvider = Provider<GoogleSignInUseCase>((ref) {
  return GoogleSignInUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUseCase>((ref) {
  return ForgotPasswordUseCase(ref.watch(authRepositoryProvider));
});

final sendEmailVerificationUseCaseProvider =
    Provider<SendEmailVerificationUseCase>((ref) {
      return SendEmailVerificationUseCase(ref.watch(authRepositoryProvider));
    });

final checkAuthStateUseCaseProvider = Provider<CheckAuthStateUseCase>((ref) {
  return CheckAuthStateUseCase(ref.watch(authRepositoryProvider));
});
