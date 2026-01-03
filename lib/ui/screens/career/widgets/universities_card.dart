import 'package:flutter/material.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
import '../../../common/widgets/university_tile.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';

class UniversitiesCard extends StatefulWidget {
  final List<UniversityMajorDetail> universityMajors;
  final String majorId;

  const UniversitiesCard({
    super.key,
    required this.universityMajors,
    required this.majorId,
  });

  @override
  State<UniversitiesCard> createState() => UniversitiesCardState();
}

class UniversitiesCardState extends State<UniversitiesCard> {
  late bool isExpanded = false;

  void onExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredUniversityMajors = widget.universityMajors
        .where((universityMajor) => universityMajor.major.id == widget.majorId)
        .toList();

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onExpanded(),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
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
                        'Related Universities',
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
                      Text(
                        '${filteredUniversityMajors.length}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.lg),
              child: Column(
                children: filteredUniversityMajors.map((universityMajor) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: UniversityTile(
                      name: universityMajor.university.name,
                      price: universityMajor.tuitionRange,
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
