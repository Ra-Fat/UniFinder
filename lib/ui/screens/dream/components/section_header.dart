import 'package:flutter/material.dart';
import '../../../../Domain/model/Career/career_model.dart';
import '../../../common/widgets/widget.dart';
import '../../../common/Theme/app_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final List<Career> careers;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    required this.careers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon Container
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.buttonBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.work_outline,
            color: AppColors.accentBlue,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPrimaryText(text: title),
              const SizedBox(height: 3),
              CustomSecondaryText(text: 'Explore potential career paths'),
            ],
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: CustomSecondaryText(
            text: 'See All (${careers.length})',
            textColor: AppColors.accentBlue,
          ),
        ),
      ],
    );
  }
}
