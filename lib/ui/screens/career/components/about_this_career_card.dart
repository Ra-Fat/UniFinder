import 'package:flutter/material.dart';
import '../../../../Domain/model/Career/career_model.dart';
// import '../../../common/constants/app_colors.dart';
import '../../../common/Theme/app_spacing.dart';
import '../../../common/Theme/app_styles.dart';
import '../../../common/widgets/widget.dart';
import '../../../common/Theme/app_text_styles.dart';

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
      color: AppColors.cardBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppColors.cardBorder,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onExpanded,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
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
                        color: AppColors.accentBlue,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      CustomPrimaryText(
                        text: 'About This Career',
                        fontSize: 16,
                      ),
                    ],
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(height: 1.5, color: AppColors.textSecondary),
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
