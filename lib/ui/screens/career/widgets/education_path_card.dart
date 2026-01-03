import 'package:flutter/material.dart';
import '../../../../model/major_model.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';

class EducationPathCard extends StatefulWidget {
  final Major major;
  final List<Major> relatedMajors;

  const EducationPathCard({
    super.key,
    required this.major,
    required this.relatedMajors,
  });

  @override
  State<EducationPathCard> createState() => _EducationPathCardState();
}

class _EducationPathCardState extends State<EducationPathCard> {
  bool isExpanded = false;

  void onExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: InkWell(
        onTap: widget.relatedMajors.isNotEmpty ? onExpanded : null,
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
                        Icons.school_outlined,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Education Path',
                        style: AppTextStyles.h2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white
                        ),
                      ),
                    ],
                  ),
                  if (widget.relatedMajors.isNotEmpty)
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColors.white,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              // Primary Major
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Primary: ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.major.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              // Related Majors
              if (isExpanded && widget.relatedMajors.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Also consider:',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: widget.relatedMajors.map((relatedMajor) {
                    return Chip(
                      label: Text(
                        relatedMajor.name,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
                      ),
                      labelStyle: AppTextStyles.bodySmall,
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(color: AppColors.border),
                      backgroundColor: Colors.white,
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
