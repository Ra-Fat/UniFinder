import 'package:flutter/material.dart';
import '../../../../../Domain/model/Major/major_model.dart';
import '../../../Theme/app_styles.dart';
import '../../../Theme/app_spacing.dart';
import '../../../../common/widgets/widget.dart';

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
          child: CustomPrimaryText(
          text:   'Search For Majors',
          fontSize: 15,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Search Major Section
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.buttonBorder, width: 1.5),
          ),
          child: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.white),
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search for a major',
              hintStyle: const TextStyle(color: Colors.white),
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
              // color: AppColors.,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.buttonBorder, width: 1.5),
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
                      color: Colors.white,
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
