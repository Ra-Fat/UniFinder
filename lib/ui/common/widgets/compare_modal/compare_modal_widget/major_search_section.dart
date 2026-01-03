import 'package:flutter/material.dart';
import '../../../../../model/major_model.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_spacing.dart';
import '../../../../common/constants/app_text_styles.dart';

class MajorSearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final List<Major> filteredMajors;
  final bool showMajorResults;
  final Function(String) onSearchChanged;
  final Function(Major) onMajorSelected;
  final VoidCallback onClearSearch;

  const MajorSearchSection({
    super.key,
    required this.searchController,
    required this.filteredMajors,
    required this.showMajorResults,
    required this.onSearchChanged,
    required this.onMajorSelected,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Search For Majors',
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Search Major Section
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!, width: 1.5),
          ),
          child: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.black),
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search for a major',
              hintStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: onClearSearch,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),

        // Major Search Results
        if (showMajorResults && filteredMajors.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1.5),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filteredMajors.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey[200]),
              itemBuilder: (context, index) {
                final major = filteredMajors[index];
                return ListTile(
                  title: Text(
                    major.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () => onMajorSelected(major),
                );
              },
            ),
          ),

        if (showMajorResults && filteredMajors.isEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'No majors found',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
      ],
    );
  }
}
