import 'package:flutter/material.dart';
import 'package:uni_finder/service/dream_service.dart';
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

  const CareerCardsList({
    super.key,
    required this.careers,
    this.major,
    this.relatedMajors,
    required this.dreamService,
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
  });

  final Career career;
  final int maxSkillDisplay;
  final double? width;
  final Major? major;
  final List<Major>? relatedMajors;
  final DreamService dreamService;
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
        child: InkWell(
          onTap: () {
            // TODO: Update router to handle career detail with parameters
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CareerDetailScreen(
                  career: career,
                  major: major,
                  relatedMajors: relatedMajors,
                  dreamService: dreamService,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
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
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.work_outline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        career.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Description
                Text(
                  career.shortDescription ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8),

                // Skills Chips
                SkillChips(skills: career.skills ?? [], maxSkillDisplay: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
