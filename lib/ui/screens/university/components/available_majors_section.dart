import 'package:flutter/material.dart';
import 'package:uni_finder/Domain/model/University/universityMajorDetail.dart';
import 'package:uni_finder/ui/common/Theme/app_spacing.dart';
import '../../../common/widgets/widget.dart';
import './major_item.dart';

class AvailableMajorsSection extends StatelessWidget {
  final List<UniversityMajorDetail> availableMajors;

  const AvailableMajorsSection({
    super.key,
    required this.availableMajors,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomPrimaryText(
          text:   'Available Majors (${availableMajors.length})',
          ),
          const SizedBox(height: AppSpacing.md),
          ...availableMajors.map((detail) => MajorItem(detail: detail)),
        ],
      ),
    );
  }
}