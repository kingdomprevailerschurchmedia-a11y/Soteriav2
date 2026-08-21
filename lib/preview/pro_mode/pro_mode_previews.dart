import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/screens/pro_lobby_screen.dart';
import 'package:soteria/features/dashboard/presentation/providers/pro_lobby_providers.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_access.dart';

class ProModePreviews {
  static Widget available() {
    return _withState(const ProLobbyState(
      access: ProModeAccessResult.available(),
    ));
  }

  static Widget locked() {
    return _withState(const ProLobbyState(
      access: ProModeAccessResult(
        state: ProModeAccessState.locked,
        message: 'MINIMUM LEVEL 10 REQUIRED',
      ),
    ));
  }

  static Widget insufficientCoins() {
    return _withState(const ProLobbyState(
      access: ProModeAccessResult(state: ProModeAccessState.insufficientTokens),
    ));
  }

  static Widget insufficientQuestions() {
    return _withState(const ProLobbyState(
      access: ProModeAccessResult(
        state: ProModeAccessState.insufficientContent,
        message: 'Not enough questions available for this configuration.',
      ),
    ));
  }

  static Widget offline() {
    return _withState(const ProLobbyState(
      isOffline: true,
      access: ProModeAccessResult.available(),
    ));
  }

  static Widget loading() {
    return _withState(const ProLobbyState(
      isLoading: true,
    ));
  }

  static Widget error() {
    return _withState(const ProLobbyState(
      error: 'Failed to initialize session. Please try again.',
    ));
  }

  static Widget _withState(ProLobbyState state) {
    return ProviderScope(
      overrides: [
        proLobbyProvider.overrideWith(() => _FakeProLobbyNotifier(state)),
      ],
      child: const ProLobbyScreen(),
    );
  }
}

class _FakeProLobbyNotifier extends ProLobbyNotifier {
  final ProLobbyState _state;
  _FakeProLobbyNotifier(this._state);

  @override
  ProLobbyState build() => _state;

  @override
  void updateDifficulty(dynamic d) {}
  @override
  void updateQuestionCount(int c) {}
}
