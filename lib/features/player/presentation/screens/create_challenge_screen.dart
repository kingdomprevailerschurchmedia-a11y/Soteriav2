import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../social/domain/models/friendship.dart';
import '../../../social/presentation/providers/social_providers.dart';
import '../providers/challenge_providers.dart';
import '../../domain/models/competitive_challenge.dart';
import '../providers/public_profile_providers.dart';

class CreateChallengeScreen extends ConsumerStatefulWidget {
  final String? initialOpponentId;

  const CreateChallengeScreen({super.key, this.initialOpponentId});

  @override
  ConsumerState<CreateChallengeScreen> createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends ConsumerState<CreateChallengeScreen> {
  String? _selectedOpponentId;
  ChallengeType _selectedType = ChallengeType.matchWins;
  double _target = 3;
  Duration _duration = const Duration(days: 3);

  @override
  void initState() {
    super.initState();
    _selectedOpponentId = widget.initialOpponentId;
  }

  @override
  Widget build(BuildContext context) {
    final friendsAsync = ref.watch(friendsProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('CREATE CHALLENGE'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CHOOSE OPPONENT', style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2)),
            SizedBox(height: SoteriaSpacing.md),
            friendsAsync.when(
              data: (friends) => _buildOpponentSelector(friends),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error loading friends: $err'),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Text('CHALLENGE TYPE', style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2)),
            SizedBox(height: SoteriaSpacing.md),
            _buildTypeSelector(),
            SizedBox(height: SoteriaSpacing.xl),
            Text('TARGET', style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2)),
            SizedBox(height: SoteriaSpacing.md),
            _buildTargetSelector(),
            SizedBox(height: SoteriaSpacing.xl),
            Text('DURATION', style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2)),
            SizedBox(height: SoteriaSpacing.md),
            _buildDurationSelector(),
            SizedBox(height: SoteriaSpacing.xxl),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOpponentSelector(List<Friendship> friends) {
    if (friends.isEmpty) {
      return const Text('You need friends to create a challenge.');
    }

    final currentUserId = ref.read(authRepositoryProvider).currentUserId;

    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friendship = friends[index];
          final otherUserId = friendship.userIds.firstWhere(
            (id) => id != currentUserId,
            orElse: () => '',
          );
          
          return _FriendSelectorItem(
            userId: otherUserId,
            isSelected: _selectedOpponentId == otherUserId,
            onTap: () => setState(() => _selectedOpponentId = otherUserId),
          );
        },
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ChallengeType.values.map((type) {
        final isSelected = _selectedType == type;
        return ChoiceChip(
          label: Text(_formatTypeName(type)),
          selected: isSelected,
          onSelected: (selected) => setState(() => _selectedType = type),
          selectedColor: SoteriaColors.primary,
          backgroundColor: SoteriaColors.surface,
          labelStyle: TextStyle(color: isSelected ? Colors.white : SoteriaColors.textSecondary),
        );
      }).toList(),
    );
  }

  String _formatTypeName(ChallengeType type) {
    switch (type) {
      case ChallengeType.matchWins: return 'Match Wins';
      case ChallengeType.matchScore: return 'Highest Match Score';
      case ChallengeType.winStreak: return 'Win Streak';
      case ChallengeType.totalPoints: return 'Total Points';
      case ChallengeType.accuracy: return 'Accuracy';
      case ChallengeType.categoryPerformance: return 'Category Mastery';
      case ChallengeType.headToHeadWins: return 'H2H Wins';
    }
  }

  Widget _buildTargetSelector() {
    return GlassSurface(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md, vertical: SoteriaSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _target > 1 ? () => setState(() => _target--) : null,
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text(
            _target.toInt().toString(),
            style: context.headlineSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => setState(() => _target++),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSelector() {
    final durations = {
      '24 Hours': const Duration(days: 1),
      '3 Days': const Duration(days: 3),
      '7 Days': const Duration(days: 7),
      'Season': const Duration(days: 30), // Placeholder
    };

    return Wrap(
      spacing: 8,
      children: durations.entries.map((entry) {
        final isSelected = _duration == entry.value;
        return ChoiceChip(
          label: Text(entry.key),
          selected: isSelected,
          onSelected: (selected) => setState(() => _duration = entry.value),
          selectedColor: SoteriaColors.primary,
          backgroundColor: SoteriaColors.surface,
          labelStyle: TextStyle(color: isSelected ? Colors.white : SoteriaColors.textSecondary),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton() {
    final status = ref.watch(challengeControllerProvider);
    final canSubmit = _selectedOpponentId != null && !status.isLoading;

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: canSubmit ? _submit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: SoteriaColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
        child: status.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('SEND CHALLENGE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
      ),
    );
  }

  Future<void> _submit() async {
    await ref.read(challengeControllerProvider.notifier).sendChallenge(
      challengedPlayerId: _selectedOpponentId!,
      type: _selectedType,
      target: _target,
      duration: _duration,
    );

    if (mounted) {
      if (ref.read(challengeControllerProvider).hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send challenge: ${ref.read(challengeControllerProvider).error}')),
        );
      } else {
        context.pop();
      }
    }
  }
}

class _FriendSelectorItem extends ConsumerWidget {
  final String userId;
  final bool isSelected;
  final VoidCallback onTap;

  const _FriendSelectorItem({
    required this.userId,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(userId));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: const EdgeInsets.only(right: 12),
        child: profileAsync.when(
          data: (profile) {
            if (profile == null) return const SizedBox.shrink();
            return Column(
              children: [
                Stack(
                  children: [
                    SoteriaAvatar(
                      avatar: AvatarCatalog().getById(profile.avatarId),
                      size: 56,
                      imageUrl: profile.photoUrl,
                    ),
                    if (isSelected)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: SoteriaColors.success,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(Icons.check, size: 14, color: Colors.white),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  profile.displayName,
                  style: context.bodySmall.copyWith(
                    color: isSelected ? Colors.white : SoteriaColors.muted,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          error: (_, _) => const Icon(Icons.error_outline, color: SoteriaColors.error),
        ),
      ),
    );
  }
}
