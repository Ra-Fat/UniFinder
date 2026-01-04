import 'package:flutter/material.dart';
import 'package:uni_finder/model/university_model.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/theme/app_colors.dart';

class AboutSection extends StatelessWidget {
  final University university;

  const AboutSection({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Text(
              university.description,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.grey[300],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
