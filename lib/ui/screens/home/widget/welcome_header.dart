import 'package:flutter/material.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/ui/common/constants/app_colors.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/constants/app_text_styles.dart';
import '../../../common/widgets/widget.dart';
import './search_field.dart';

class WelcomeHeader extends StatelessWidget {
  final String userName;
  final DreamService dreamService;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const WelcomeHeader({
    super.key,
    required this.userName,
    required this.dreamService,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        SizedBox(height: 8),
        CustomSecondaryText(text: 'Discover your dream here'),
        SizedBox(height: 15),
        SearchField(controller: searchController, onChanged: onSearchChanged),
      ],
    );
  }
}
