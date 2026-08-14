import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../providers/competitive_profile_provider.dart';
import '../widgets/season_result_card.dart';
import '../widgets/season_result_details.dart';
import '../../domain/models/season_result.dart';

class SeasonHistoryScreen extends ConsumerWidget {
  const SeasonHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(competitiveProfileProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Season History'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: profileAsync.when(
        data: (profile) => _buildList(context, profile.history.results),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<SeasonResult> results) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_toggle_off, size: 64.w, color: SoteriaColors.muted),
            SizedBox(height: SoteriaSpacing.md),
            const Text('No completed seasons yet.'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
        vertical: SoteriaSpacing.md,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Padding(
          padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
          child: SeasonResultCard(
            result: result,
            onTap: () => _showResultDetails(context, result),
          ),
        );
      },
    );
  }

  void _showResultDetails(BuildContext context, SeasonResult result) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SeasonResultDetailsView(result: result),
    );
  }
}
