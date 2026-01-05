import 'package:flutter/material.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../theme/app_styles.dart';
import '../../../common/widgets/widget.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value1;
  final String value2;

  const InfoRow({
    super.key,
    required this.label,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 4,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSecondaryText(text: label , fontSize: 12,),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  value1,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(width: 1, height: 20, color: Colors.grey[300]),
              Expanded(
                child: Text(
                  value2,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
