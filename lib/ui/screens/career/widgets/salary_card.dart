import 'package:flutter/material.dart';
import '../../../common/widgets/info_card.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/widgets/widget.dart';
import '../../../theme/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';

class SalaryCard extends StatelessWidget {
  final String salaryRange;

  const SalaryCard({super.key, required this.salaryRange});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.attach_money, size: 20, color: AppColors.accentBlue,),
                const SizedBox(width: AppSpacing.sm),
                CustomPrimaryText(text: 'Estimated Salary Range'),
              ],
            ),
            const SizedBox(height: AppSpacing.sm ,),
            CustomPrimaryText(text: salaryRange, fontSize: 15,),
            const SizedBox(height: AppSpacing.xs),
            CustomSecondaryText(text: 'Varies by experience, company, and location', textColor: AppColors.textSecondary,)
          ],
        ),
      ),
    );
  }
}
