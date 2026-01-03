import 'package:flutter/material.dart';
import '../../../../model/career_model.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';

class AboutThisCareerCard extends StatefulWidget {
  final Career career;

  const AboutThisCareerCard({super.key, required this.career});

  @override
  State<AboutThisCareerCard> createState() => _AboutThisCareerCardState();
}

class _AboutThisCareerCardState extends State<AboutThisCareerCard> {
  bool isExpanded = false;

  void onExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.career.description;
    final maxLines = 2;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: InkWell(
        onTap: onExpanded,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'About This Career',
                        style: AppTextStyles.h2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.white,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(height: 1.5, color: AppColors.white),
                maxLines: isExpanded ? null : maxLines,
                overflow: isExpanded ? null : TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
