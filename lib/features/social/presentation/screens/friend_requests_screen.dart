import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../providers/social_providers.dart';

class FriendRequestsScreen extends ConsumerWidget {
  const FriendRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomingRequests = ref.watch(incomingRequestsProvider);
    final outgoingRequests = ref.watch(outgoingRequestsProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('REQUESTS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              indicatorColor: SoteriaColors.primary,
              labelColor: Colors.white,
              unselectedLabelColor: SoteriaColors.muted,
              tabs: [
                Tab(text: 'INCOMING'),
                Tab(text: 'OUTGOING'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _RequestsList(requestsAsync: incomingRequests, isIncoming: true),
                  _RequestsList(requestsAsync: outgoingRequests, isIncoming: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestsList extends ConsumerWidget {
  final AsyncValue<List<dynamic>> requestsAsync;
  final bool isIncoming;

  const _RequestsList({required this.requestsAsync, required this.isIncoming});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return requestsAsync.when(
      data: (requests) {
        if (requests.isEmpty) {
          return Center(
            child: Text(
              isIncoming ? 'No pending requests.' : 'No sent requests.',
              style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            final otherUserId = isIncoming ? request.senderId : request.receiverId;
            return _RequestTile(userId: otherUserId, requestId: request.id, isIncoming: isIncoming);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: SoteriaColors.primary)),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }
}

class _RequestTile extends ConsumerWidget {
  final String userId;
  final String requestId;
  final bool isIncoming;

  const _RequestTile({required this.userId, required this.requestId, required this.isIncoming});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(userId));

    return profileAsync.when(
      data: (profile) {
        if (profile == null) return const SizedBox.shrink();
        return ListTile(
          leading: SoteriaAvatar(
            avatar: AvatarCatalog().getById(profile.avatarId),
            size: 40,
            imageUrl: profile.photoUrl,
          ),
          title: Text(profile.displayName, style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          subtitle: Text(profile.currentRank, style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
          trailing: isIncoming
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check_circle_rounded, color: SoteriaColors.success),
                      onPressed: () => ref.read(socialControllerProvider.notifier).acceptRequest(requestId, userId),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel_rounded, color: SoteriaColors.error),
                      onPressed: () => ref.read(socialControllerProvider.notifier).declineRequest(requestId, userId),
                    ),
                  ],
                )
              : TextButton(
                  onPressed: () => ref.read(socialControllerProvider.notifier).cancelRequest(requestId, userId),
                  child: Text('CANCEL', style: context.labelSmall.copyWith(color: SoteriaColors.error)),
                ),
        );
      },
      loading: () => const SizedBox(height: 56),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
