import 'package:flutter/material.dart';
import '../../../common/widgets/info_card.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';

class SalaryCard extends StatelessWidget {
  final String salaryRange;

  const SalaryCard({super.key, required this.salaryRange});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Estimated Salary Range',
      icon: Icons.attach_money,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            salaryRange,
            style: AppTextStyles.h2.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Varies by experience, company, and location',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
