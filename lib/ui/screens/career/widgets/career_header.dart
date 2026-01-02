import 'package:flutter/material.dart';
import '../../../../model/career_model.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';

class CareerHeader extends StatelessWidget {
  final Career career;

  const CareerHeader({super.key, required this.career});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryLight,
            // ignore: deprecated_member_use
            AppColors.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.work_outline, size: 48, color: AppColors.white),
          const SizedBox(height: AppSpacing.sm),
          Text(
            career.name,
            style: AppTextStyles.h1White,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            career.shortDescription ?? '',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
