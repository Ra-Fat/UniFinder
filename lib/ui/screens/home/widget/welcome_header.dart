import 'package:flutter/material.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/ui/common/constants/app_colors.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/constants/app_text_styles.dart';
import 'package:uni_finder/ui/common/widgets/compare_modal/compare_modal.dart';

class WelcomeHeader extends StatelessWidget {
  final String userName;
  final DreamService dreamService;

  const WelcomeHeader({
    super.key,
    required this.userName,
    required this.dreamService,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text('Welcome,', style: AppTextStyles.h1White),
            const SizedBox(width: AppSpacing.sm),
            Text(
              userName,
              style: AppTextStyles.h1.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.compare_arrows),
          tooltip: 'Compare',
          onPressed: () {
            CompareUniversitiesBottomSheet.show(context, dreamService);
          },
        ),
      ],
    );
  }
}
