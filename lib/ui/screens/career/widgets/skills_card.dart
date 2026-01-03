import 'package:flutter/material.dart';
import '../../../common/widgets/skill_chip.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';

class SkillsCard extends StatefulWidget {
  final List<String> skills;

  const SkillsCard({super.key, required this.skills});

  @override
  State<SkillsCard> createState() => _SkillsCardState();
}

class _SkillsCardState extends State<SkillsCard> {
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
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
                        Icons.lightbulb_outline,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Required Skills',
                        style: AppTextStyles.h2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.skills.length > 3)
                        Text(
                          '${widget.skills.length}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      if (widget.skills.length > 3) const SizedBox(width: AppSpacing.sm),
                      if (widget.skills.length > 3)
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.white,
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              SkillChips(
                skills: widget.skills,
                maxSkillDisplay: isExpanded ? null : 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
