import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/service/major_service.dart';
import 'package:uni_finder/service/university_service.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/widgets/skill_chip.dart';
import 'package:uni_finder/Domain/model/Career/career_model.dart';
import 'package:uni_finder/Domain/model/Major/major_model.dart';
import '../../../theme/app_styles.dart';

class CareerCardsList extends StatelessWidget {
  final List<Career> careers;
  final Major? major;
  final List<Major>? relatedMajors;
  final DreamService dreamService;
  final MajorService majorService;
  final UniversityService universityService;

  const CareerCardsList({
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
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: careers.length,
        itemBuilder: (context, index) {
          final career = careers[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index < careers.length - 1 ? 12 : 0,
            ),
            child: CareerCard(
              career: career,
              major: major,
              relatedMajors: relatedMajors,
              dreamService: dreamService,
              majorService: majorService,
              universityService: universityService,
            ),
          );
        },
      ),
    );
  }
}

class CareerCard extends StatelessWidget {
  const CareerCard({
    super.key,
    required this.career,
    this.maxSkillDisplay = 2,
    this.width,
    this.major,
    this.relatedMajors,
    required this.dreamService,
    required this.majorService,
    required this.universityService,
  });

  final Career career;
  final int maxSkillDisplay;
  final double? width;
  final Major? major;
  final List<Major>? relatedMajors;
  final DreamService dreamService;
  final MajorService majorService;
  final UniversityService universityService;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '/career',
          extra: {
            'career': career,
            'major': major,
            'relatedMajors': relatedMajors,
          },
        );
      },
      child: Container(
        width: width ?? 320,
        decoration: BoxDecoration(
          color: Colors.grey[900]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Career Image Section
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSpacing.radiusLg),
                topRight: Radius.circular(AppSpacing.radiusLg),
              ),
              child: Stack(
                children: [
                  // Background Image
                  Container(
                    height: 130,
                    width: double.infinity,
                    child: Image.asset(
                      career.imagePath ?? 'career/data.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.grey[900]!],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.work_outline,
                          color: AppColors.accentBlue,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              career.name,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Text(
                              career.shortDescription ?? '',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Skills Chips
                  SkillChips(
                    skills: career.skills ?? [],
                    maxSkillDisplay: maxSkillDisplay,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
