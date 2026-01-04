import 'package:flutter/material.dart';
import 'package:uni_finder/Domain/model/University/university_model.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import '../../../theme/app_styles.dart';
import '../../../common/widgets/widget.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomPrimaryText(
           text:  'About',
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
