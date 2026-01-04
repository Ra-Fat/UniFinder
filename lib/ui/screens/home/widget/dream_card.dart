import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
// import 'package:uni_finder/ui/common/constants/app_colors.dart';
import '../../../theme/app_colors.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import '../../../common/widgets/widget.dart';

class DreamCard extends StatelessWidget {
  final Dream dream;

  const DreamCard({super.key, required this.dream});

  static final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final String formattedDate = _dateFormatter.format(dream.createdAt);
    final String displayTitle = dream.title ?? 'Untitled Dream';

    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        side: BorderSide(
          color: AppColors.cardBorder,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: CustomPrimaryText(text: displayTitle),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: CustomSecondaryText(
                text: 'Created: $formattedDate',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CustomizeButton(
                text: 'View Detail', 
                icon: Icons.arrow_forward,
                borderWidth: 1,
                borderColor: AppColors.buttonBorder,
                backgroundColor: AppColors.buttonBackground,
                onPressed: () {
                  context.go('/home/${dream.id}', extra: dream);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
