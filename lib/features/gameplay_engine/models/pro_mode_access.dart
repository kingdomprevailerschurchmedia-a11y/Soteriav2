import 'package:flutter/foundation.dart';

enum ProModeAccessState {
  available,
  locked,
  insufficientTokens,
  requiresPremium,
  insufficientContent,
  unavailable,
  loading,
  error;

  bool get isAllowed => this == ProModeAccessState.available;
}

@immutable
class ProModeAccessResult {
  final ProModeAccessState state;
  final String? message;
  final Map<String, dynamic>? metadata;

  const ProModeAccessResult({
    required this.state,
    this.message,
    this.metadata,
  });

  const ProModeAccessResult.available() : state = ProModeAccessState.available, message = null, metadata = null;
  const ProModeAccessResult.loading() : state = ProModeAccessState.loading, message = null, metadata = null;

  bool get isAllowed => state.isAllowed;
}
