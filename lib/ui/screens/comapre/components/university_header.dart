import 'package:flutter/material.dart';
import '../../../../Domain/model/University/university_model.dart';
import '../../../common/Theme/app_colors.dart';
import '../../../common/Theme/app_spacing.dart';
import '../../../common/Theme/app_text_styles.dart';

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
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  university.logoPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.account_balance, size: 40, color: AppColors.primary.withAlpha(150));
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              university.name,
              style: AppTextStyles.h2.copyWith(
                fontSize: 14,
                color: AppColors.textPrimary,
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
