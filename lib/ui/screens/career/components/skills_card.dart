import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/widgets/widget.dart';
import '../../../common/widgets/skill_chip.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../theme/app_styles.dart';

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
        borderRadius: BorderRadius.circular(10),
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
                        Icons.lightbulb_outline,
                        size: 20,
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      CustomPrimaryText(
                       text:  'Required Skills',
                       fontSize: 15,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.skills.length > 3) const SizedBox(width: AppSpacing.sm),
                      if (widget.skills.length > 3)
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.textPrimary,
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