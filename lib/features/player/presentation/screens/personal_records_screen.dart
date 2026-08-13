import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/components/soteria_page_wrapper.dart';
import '../../../../core/design_system/components/soteria_text.dart';
import '../../../../core/design_system/components/soteria_state_views.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/widgets/feedback/soteria_empty_state.dart';
import '../providers/personal_record_providers.dart';
import '../widgets/personal_record_card.dart';
import '../widgets/personal_record_details_sheet.dart';
import '../../domain/models/competitive_personal_record.dart';

class PersonalRecordsScreen extends ConsumerWidget {
  const PersonalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final careerRecordsAsync = ref.watch(careerRecordsProvider);
    final currentSeasonRecordsAsync = ref.watch(currentSeasonRecordsProvider);

    return SoteriaPageWrapper(
      title: 'Personal Records',
      isScrollable: false,
      body: careerRecordsAsync.when(
        data: (careerRecords) {
          if (careerRecords.isEmpty) {
            return SoteriaEmptyState(
              title: 'No Records Yet',
              subtitle: 'Compete in matches to start setting personal records!',
              icon: Icons.emoji_events_outlined,
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(currentUserPersonalRecordsProvider.future),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SoteriaSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('CAREER BESTS', Icons.auto_awesome),
                        const SizedBox(height: 16),
                        ...careerRecords.map(
                          (record) => PersonalRecordCard(
                            record: record,
                            onTap: () => PersonalRecordDetailsSheet.show(context, record),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                currentSeasonRecordsAsync.when(
                  data: (seasonRecords) {
                    if (seasonRecords.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: SoteriaSpacing.xxl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            _buildSectionHeader('CURRENT SEASON', Icons.calendar_today),
                            const SizedBox(height: 16),
                            ...seasonRecords.map(
                              (record) => PersonalRecordCard(
                                record: record,
                                onTap: () => PersonalRecordDetailsSheet.show(context, record),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
                  error: (e, _) => SliverToBoxAdapter(child: Center(child: Text(e.toString()))),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.5)),
        const SizedBox(width: 8),
        SoteriaText.caption(
          title,
          color: Colors.white.withValues(alpha: 0.5),
        ),
      ],
    );
  }
}
