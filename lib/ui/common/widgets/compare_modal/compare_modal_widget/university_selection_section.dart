import 'package:flutter/material.dart';
import '../../../../../Domain/model/University/university_model.dart';
import '../../../Theme/app_styles.dart';
import '../../../Theme/app_spacing.dart';
import '../../../../common/widgets/widget.dart';

class UniversitySelectionSection extends StatelessWidget {
  final String title;
  final List<University> universities;
  final String? selectedUniversityId;
  final String? disabledUniversityId;
  final bool isMajorSelected;
  final Function(String) onUniversitySelected;

  const UniversitySelectionSection({
    super.key,
    required this.title,
    required this.universities,
    required this.selectedUniversityId,
    required this.disabledUniversityId,
    required this.isMajorSelected,
    required this.onUniversitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPrimaryText(text: title, fontSize: 14,),
        const SizedBox(height: AppSpacing.sm),

        if (!isMajorSelected)
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Please select a major first',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          )
        else
          ...universities.map((uni) {
            final isSelected = selectedUniversityId == uni.id;
            final isDisabled = disabledUniversityId == uni.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: isDisabled ? null : () => onUniversitySelected(uni.id!),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDisabled
                        ? AppColors.disabled
                        : (isSelected ? AppColors.accentBlue : AppColors.cardBackgroundGradientEnd),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDisabled
                          ? Colors.grey[300]!
                          : (isSelected
                                ? AppColors.textPrimary
                                : Colors.grey[300]!),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          uni.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }
}
