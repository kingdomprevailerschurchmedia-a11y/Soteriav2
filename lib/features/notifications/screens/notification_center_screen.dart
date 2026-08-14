import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';
import '../domain/models/app_notification.dart';
import '../widgets/competitive_notification_card.dart';
import '../providers/notification_providers.dart';
import 'package:intl/intl.dart';

class NotificationCenterScreen extends ConsumerWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationListProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'NOTIFICATIONS',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.done_all_rounded,
              color: SoteriaColors.muted,
            ),
            onPressed: () {
              // Mark all as read logic if available
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.clear_all_rounded,
              color: SoteriaColors.muted,
            ),
            onPressed: () =>
                ref.read(notificationListProvider.notifier).clearAll(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: notificationsAsync.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return const Center(
                child: SoteriaEmptyState(
                  title: 'ALL CAUGHT UP',
                  subtitle:
                      'Your notification center is clear. New updates will appear here.',
                  icon: Icons.notifications_none_rounded,
                ),
              );
            }

            final grouped = _groupNotifications(notifications);
            final categories = grouped.keys.toList();

            return ListView.builder(
              padding: EdgeInsets.fromLTRB(
                SoteriaSpacing.lg,
                kToolbarHeight + SoteriaSpacing.xl,
                SoteriaSpacing.lg,
                SoteriaSpacing.xl,
              ),
              itemCount: categories.length,
              itemBuilder: (context, catIndex) {
                final category = categories[catIndex];
                final items = grouped[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
                      child: Text(
                        category.toUpperCase(),
                        style: context.labelMedium.copyWith(
                          color: SoteriaColors.muted,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...items.map((n) => _NotificationWrapper(notification: n)),
                  ],
                );
              },
            );
          },
          loading: () => const Center(child: SoteriaLoader()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Map<String, List<AppNotification>> _groupNotifications(
    List<AppNotification> notifications,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final groups = <String, List<AppNotification>>{};
    
    for (final n in notifications) {
      String key;
      if (n.type == NotificationType.seasonStarted || 
          n.type == NotificationType.seasonEnding ||
          n.type == NotificationType.seasonCompleted ||
          n.type == NotificationType.seasonResult) {
        key = 'Season';
      } else {
        final nDate = DateTime(n.createdAt.year, n.createdAt.month, n.createdAt.day);
        if (nDate == today) {
          key = 'Today';
        } else {
          key = 'Earlier';
        }
      }
      
      groups.putIfAbsent(key, () => []).add(n);
    }
    
    // Sort keys: Today first, then Season, then Earlier
    final sortedGroups = <String, List<AppNotification>>{};
    if (groups.containsKey('Today')) sortedGroups['Today'] = groups['Today']!;
    if (groups.containsKey('Season')) sortedGroups['Season'] = groups['Season']!;
    if (groups.containsKey('Earlier')) sortedGroups['Earlier'] = groups['Earlier']!;
    
    return sortedGroups;
  }
}

class _NotificationWrapper extends ConsumerWidget {
  final AppNotification notification;
  const _NotificationWrapper({required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Dismissible(
        key: Key(notification.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) =>
            ref.read(notificationListProvider.notifier).delete(notification.id),
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: SoteriaSpacing.xl),
          decoration: BoxDecoration(
            color: SoteriaColors.error.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: SoteriaColors.error,
          ),
        ),
        child: CompetitiveNotificationCard(
          notification: notification,
          onTap: () {
            if (!notification.read) {
              ref
                  .read(notificationListProvider.notifier)
                  .markAsRead(notification.id);
            }
            // Coordinator will handle navigation
          },
        ),
      ),
    );
  }
}
