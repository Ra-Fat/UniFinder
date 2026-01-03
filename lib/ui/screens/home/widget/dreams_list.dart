import 'package:flutter/material.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/constants/app_text_styles.dart';
import 'dream_card.dart';

class DreamsList extends StatelessWidget {
  final List<Dream> dreams;
  final bool isLoading;
  final String searchQuery;

  const DreamsList({
    super.key,
    required this.dreams,
    required this.isLoading,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),
        const Text('Your Dream'),
        const SizedBox(height: AppSpacing.md),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : dreams.isEmpty
            ? Center(
                child: Text(
                  searchQuery.isEmpty
                      ? 'No dreams yet. Add one!'
                      : 'No dreams found.',
                  style: AppTextStyles.bodySmall,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dreams.length,
                itemBuilder: (context, index) {
                  return DreamCard(dream: dreams[index]);
                },
              ),
      ],
    );
  }
}
