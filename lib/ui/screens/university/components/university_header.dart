import 'package:flutter/material.dart';
import 'package:uni_finder/Domain/model/University/university_model.dart';
import 'package:uni_finder/ui/common/Theme/app_spacing.dart';
import '../../../common/widgets/widget.dart';
import '../../../common/Theme/app_styles.dart';

class UniversityHeader extends StatelessWidget {
  final University university;

  const UniversityHeader({super.key, required this.university});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                university.logoPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.school, size: 40, color: AppColors.textSecondary);
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPrimaryText(text: university.name),
                if (university.shortName != null)
                  CustomSecondaryText(text: university.shortName!),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: CustomSecondaryText(text: university.location),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
