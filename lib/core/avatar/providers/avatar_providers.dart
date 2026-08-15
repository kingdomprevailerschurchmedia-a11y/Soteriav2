import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../identity/providers/identity_providers.dart';
import '../../../features/player/providers/player_providers.dart';
import '../data/avatar_catalog.dart';
import '../domain/avatar.dart';

final avatarCatalogProvider = Provider<AvatarCatalog>((ref) {
  return AvatarCatalog();
});

final selectedAvatarIdProvider = Provider<String>((ref) {
  final profile = ref.watch(profileProvider);
  if (profile?.selectedAvatarId != null && profile!.selectedAvatarId.isNotEmpty) {
    return profile.selectedAvatarId;
  }
  
  final player = ref.watch(currentPlayerProvider);
  return player?.selectedAvatarId ?? 'socrates';
});

final selectedAvatarProvider = Provider<Avatar>((ref) {
  final catalog = ref.watch(avatarCatalogProvider);
  final id = ref.watch(selectedAvatarIdProvider);
  return catalog.getById(id) ?? catalog.defaultAvatar;
});
