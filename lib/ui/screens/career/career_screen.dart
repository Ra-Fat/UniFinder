import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/screens/dream/widgets/career_card.dart';
import '../../../Domain/model/Career/career_model.dart';
import '../../../Domain/model/Major/major_model.dart';
import '../../../service/dream_service.dart';
import '../../../service/major_service.dart';
import '../../../service/university_service.dart';
import '../../theme/app_styles.dart';

class CareerScreen extends StatelessWidget {
  final List<Career> careers;
  final Major? major;
  final List<Major>? relatedMajors;
  final DreamService dreamService;
  final MajorService majorService;
  final UniversityService universityService;

  const CareerScreen({
    super.key,
    required this.careers,
    this.major,
    this.relatedMajors,
    required this.dreamService,
    required this.majorService,
    required this.universityService,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkBackground,
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1.0,
              ),
            ),
          ),
          child: AppBar(
            title: Text(
              'Career Opportunities',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: careers.map((career) {
                final screenWidth = MediaQuery.of(context).size.width;
                final cardWidth =
                    (screenWidth - (AppSpacing.paddingHorizontal * 2) - 12) / 2;

                return SizedBox(
                  width: cardWidth,
                  child: CareerCard(
                    career: career,
                    width: cardWidth,
                    major: major,
                    relatedMajors: relatedMajors,
                    dreamService: dreamService,
                    majorService: majorService,
                    universityService: universityService,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
