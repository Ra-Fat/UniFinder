import 'package:flutter/material.dart';
import '../../../../../model/university_model.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_colors.dart';

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
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        if (!isMajorSelected)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Please select a major first',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
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
                        ? Colors.grey[200]
                        : (isSelected ? AppColors.primary : Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDisabled
                          ? Colors.grey[300]!
                          : (isSelected
                                ? AppColors.primary
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
                            color: isDisabled
                                ? Colors.grey[400]
                                : (isSelected
                                      ? AppColors.white
                                      : Colors.grey[800]),
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.white,
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
