import 'package:flutter/material.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
import '../../../common/widgets/university_tile.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/widget.dart';
import '../../../theme/app_colors.dart';

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
      color: AppColors.cardBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppColors.cardBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onExpanded(),
            borderRadius: BorderRadius.circular(10),
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
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Related Universities',
                        style: AppTextStyles.h2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary
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
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: AppColors.textPrimary,
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
