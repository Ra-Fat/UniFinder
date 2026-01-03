import 'package:flutter/material.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/service/major_service.dart';
import 'package:uni_finder/service/university_service.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/widgets/skill_chip.dart';
import 'package:uni_finder/ui/screens/career/career_detail_screen.dart';
import '../../../../model/career_model.dart';
import '../../../../model/major_model.dart';

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
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: careers.length,
        itemBuilder: (context, index) {
          final career = careers[index];
          return CareerCard(
            career: career,
            major: major,
            relatedMajors: relatedMajors,
            dreamService: dreamService,
            majorService: majorService,
            universityService: universityService,
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
    return Container(
      width: width ?? 280,
      margin: EdgeInsets.only(right: 12),
      alignment: Alignment.topCenter,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'panels/career.jpg', // Sample image
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image not found
                    return Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    );
                  },
                ),
              ),
              // Dark overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              // Content on top
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CareerDetailScreen(
                        career: career,
                        major: major,
                        relatedMajors: relatedMajors,
                        dreamService: dreamService,
                        majorService: majorService,
                        universityService: universityService,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon and Career Name
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.work_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              career.name,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Description
                      Text(
                        career.shortDescription ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 8),

                      // Skills Chips
                      SkillChips(
                        skills: career.skills ?? [],
                        maxSkillDisplay: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
