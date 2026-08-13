import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/player/domain/models/competitive_profile.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/presentation/providers/competitive_profile_provider.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';
import 'package:soteria/features/player/presentation/providers/season_providers.dart';
import 'package:soteria/features/player/presentation/providers/leaderboard_providers.dart';
import 'package:soteria/features/player/presentation/providers/history_providers.dart';
import 'package:soteria/features/player/presentation/providers/reward_providers.dart';
import 'package:soteria/features/player/presentation/providers/milestone_providers.dart';
import 'package:soteria/features/player/presentation/providers/personal_record_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/auth/domain/repositories/auth_repository.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/auth/models/authentication_result.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_session.dart';

void main() {
  group('CompetitiveProfileProvider Tests', () {
    late PlayerProfile mockIdentity;
    late PlayerProgression mockProgression;

    setUp(() {
      mockIdentity = PlayerProfile(
        uid: 'u1',
        displayName: 'Test User',
        email: 'test@soteria.com',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      mockProgression = PlayerProgression.initial('u1', 's1');
    });

    test('should return loading when identity is loading', () {
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(AuthMock()),
          sessionProvider.overrideWith(() => SessionMock()),
          currentPlayerStreamProvider.overrideWith(
            (ref) => const Stream.empty(),
          ),
          competitiveProgressionProvider.overrideWith(
            (ref) => Stream.value(mockProgression),
          ),
          competitiveHistorySummaryProvider.overrideWithValue(
            const AsyncValue.loading(),
          ),
          currentUserPersonalRecordsProvider.overrideWith((ref) => const Stream.empty()),
        ],
      );

      final profileAsync = container.read(competitiveProfileProvider);
      expect(profileAsync.isLoading, isTrue);
    });

    test('should return success when basic data is available', () async {
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(AuthMock()),
          sessionProvider.overrideWith(() => SessionMock()),
          currentPlayerStreamProvider.overrideWith(
            (ref) => Stream.value(mockIdentity),
          ),
          competitiveProgressionProvider.overrideWith(
            (ref) => Stream.value(mockProgression),
          ),
          currentSeasonProvider.overrideWith((ref) => Stream.value(null)),
          playerRankPositionProvider.overrideWith((ref) => Future.value(-1)),
          competitiveHistorySummaryProvider.overrideWithValue(
            AsyncValue.data(CompetitiveHistory(userId: 'u1')),
          ),
          playerRewardsProvider.overrideWith((ref) => Stream.value([])),
          playerMilestonesProvider.overrideWith((ref) => Stream.value([])),
          milestoneDefinitionsProvider.overrideWith((ref) => Future.value([])),
          currentUserPersonalRecordsProvider.overrideWith((ref) => Stream.value([])),
        ],
      );

      // Wait for the providers to settle
      container.listen(competitiveProfileProvider, (prev, next) {});
      await container.pump();
      await container.pump(); // Double pump for nested streams

      final profileAsync = container.read(competitiveProfileProvider);
      expect(profileAsync.hasValue, isTrue);
      final profile = profileAsync.value!;
      expect(profile.identity.uid, 'u1');
      expect(profile.progression.userId, 'u1');
    });
    group('Error Handling', () {
      test('should return error when critical provider fails', () async {
        final container = ProviderContainer(
          overrides: [
            authRepositoryProvider.overrideWithValue(AuthMock()),
            sessionProvider.overrideWith(() => SessionMock()),
            currentPlayerStreamProvider.overrideWith(
              (ref) => Stream<PlayerProfile?>.error('Auth failure', StackTrace.current),
            ),
            competitiveProgressionProvider.overrideWith(
              (ref) => Stream.value(mockProgression),
            ),
            competitiveHistorySummaryProvider.overrideWithValue(
              AsyncValue.data(CompetitiveHistory(userId: 'u1')),
            ),
            playerRankPositionProvider.overrideWith((ref) => Future.value(-1)),
            playerRewardsProvider.overrideWith((ref) => Stream.value([])),
            playerMilestonesProvider.overrideWith((ref) => Stream.value([])),
            milestoneDefinitionsProvider.overrideWith((ref) => Future.value([])),
            currentUserPersonalRecordsProvider.overrideWith((ref) => Stream.value([])),
          ],
        );

        // Force rebuild and wait for error propagation
        container.listen(competitiveProfileProvider, (prev, next) {});
        await container.pump();
        await container.pump();
        await container.pump();

        final profileAsync = container.read(competitiveProfileProvider);
        expect(profileAsync.hasError, isTrue);
      });
    });
  });
}

class SessionMock extends SessionNotifier {
  @override
  UserSession build() {
    return const UserSession(uid: 'u1', status: SessionStatus.authenticated);
  }
}

class AuthMock implements AuthRepository {
  @override
  String? get currentUserId => 'u1';
  @override
  Stream<String?> get userIdChanges => Stream.value('u1');
  @override
  Future<AuthenticationResult> signInWithEmail(String email, String password) async => throw UnimplementedError();
  @override
  Future<AuthenticationResult> signUpWithEmail(String email, String password) async => throw UnimplementedError();
  @override
  Future<AuthenticationResult> signInWithGoogle() async => throw UnimplementedError();
  @override
  Future<void> signOut() async {}
  @override
  Future<void> sendPasswordResetEmail(String email) async {}
  @override
  Future<void> sendEmailVerification() async {}
  @override
  Future<bool> isEmailVerified() async => true;
}

extension on ProviderContainer {
  Future<void> pump() async {
    await Future.delayed(Duration.zero);
  }
}
