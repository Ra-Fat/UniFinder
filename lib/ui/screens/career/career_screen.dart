import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/screens/dream/widgets/career_card.dart';
import '../../../Domain/model/Career/career_model.dart';
import '../../../Domain/model/Major/major_model.dart';
import '../../../Domain/service/dream_service.dart';
import '../../../Domain/service/major_service.dart';
import '../../../Domain/service/university_service.dart';

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
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Career Opportunities',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (major != null)
              Text(
                'For ${major!.name}',
                style: textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingHorizontal),
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
