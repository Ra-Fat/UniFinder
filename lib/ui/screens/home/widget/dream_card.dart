import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/ui/common/constants/app_colors.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/constants/app_text_styles.dart';

class DreamCard extends StatelessWidget {
  final Dream dream;

  const DreamCard({super.key, required this.dream});

  static final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final String formattedDate = _dateFormatter.format(dream.createdAt);
    final String displayTitle = dream.title ?? 'Untitled Dream';

    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(displayTitle, style: AppTextStyles.h2),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                'Created: $formattedDate',
                style: AppTextStyles.bodySmall,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.border),
                  backgroundColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingVertical,
                  ),
                ),
                onPressed: () {
                  context.push('/dream', extra: dream);
                },
                child: const Text(
                  'View Detail',
                  style: AppTextStyles.buttonBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
