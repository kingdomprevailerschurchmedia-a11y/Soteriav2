import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import '../providers/live_event_providers.dart';
import '../../domain/models/live_event.dart';
import '../widgets/event_countdown_widget.dart';

class LiveEventDetailsScreen extends ConsumerWidget {
  final String eventId;

  const LiveEventDetailsScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailsProvider(eventId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: eventAsync.when(
          data: (event) => event == null
              ? const Center(child: Text('Event not found'))
              : _buildContent(context, event),
          loading: () => const Center(child: SoteriaLoader()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, LiveEvent event) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image
          Stack(
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: SoteriaColors.primary.withValues(alpha: 0.1),
                ),
                child: event.imageUrl != null
                    ? Image.network(event.imageUrl!, fit: BoxFit.cover)
                    : const Icon(Icons.bolt_rounded, size: 80, color: SoteriaColors.primary),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, SoteriaColors.background.withValues(alpha: 0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.name.toUpperCase(),
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    if (event.status == LiveEventStatus.active)
                      EventCountdownWidget(
                        targetDate: event.endAt,
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.md),
                Text(
                  event.description,
                  style: context.bodyLarge.copyWith(color: Colors.white70),
                ),
                SizedBox(height: SoteriaSpacing.xl),

                // Rules
                if (event.rules.isNotEmpty) ...[
                  Text(
                    'RULES',
                    style: context.labelLarge.copyWith(
                      color: SoteriaColors.muted,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.md),
                  ...event.rules.map((rule) => Padding(
                    padding: EdgeInsets.only(bottom: SoteriaSpacing.sm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline_rounded, size: 18, color: SoteriaColors.primary),
                        SizedBox(width: SoteriaSpacing.sm),
                        Expanded(child: Text(rule, style: context.bodyMedium)),
                      ],
                    ),
                  )),
                  SizedBox(height: SoteriaSpacing.xl),
                ],

                // Rewards
                if (event.rewardConfig.isNotEmpty) ...[
                  Text(
                    'REWARDS',
                    style: context.labelLarge.copyWith(
                      color: SoteriaColors.muted,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.md),
                  SoteriaCard(
                    child: Column(
                      children: [
                        if (event.rewardConfig['xp_multiplier'] != null)
                          _RewardTile(
                            icon: Icons.bolt_rounded,
                            title: '${event.rewardConfig['xp_multiplier']}x XP Boost',
                            subtitle: 'Earn more experience in all matches.',
                            color: SoteriaColors.xpColor,
                          ),
                        if (event.rewardConfig['coins'] != null)
                          _RewardTile(
                            icon: Icons.monetization_on_rounded,
                            title: '${event.rewardConfig['coins']} Coins',
                            subtitle: 'Instant reward for participation.',
                            color: SoteriaColors.gold,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.xl),
                ],

                // Action Button
                if (event.status == LiveEventStatus.active)
                  SoteriaButton.primary(
                    label: 'PLAY NOW',
                    onPressed: () {
                      // Participation logic
                    },
                  )
                else if (event.status == LiveEventStatus.upcoming)
                  SoteriaButton.secondary(
                    label: 'REMIND ME',
                    onPressed: () {
                      // Reminder logic
                    },
                  ),
                
                SizedBox(height: SoteriaSpacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _RewardTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: context.bodySmall.copyWith(color: Colors.white60)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
