import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/Theme/app_colors.dart';
import 'package:uni_finder/ui/common/Theme/app_spacing.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Search',
        prefixIcon: const Icon(Icons.search, size: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
