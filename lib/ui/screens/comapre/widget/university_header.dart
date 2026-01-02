import 'package:flutter/material.dart';
import '../../../../model/university_model.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';

class UniversityHeader extends StatelessWidget {
  final University university;

  const UniversityHeader({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: AppColors.background,
        child: Column(
          children: [
            // Logo placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withAlpha(150),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.account_balance,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              university.name,
              style: AppTextStyles.h2.copyWith(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
