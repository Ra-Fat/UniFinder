import 'package:flutter/material.dart';
import '../dream/Domain/mock_data.dart';
import 'widgets/career_header.dart';
import 'widgets/about_this_career_card.dart';
import 'widgets/why_fits_you_card.dart';
import 'widgets/salary_card.dart';
import 'widgets/skills_card.dart';
import 'widgets/education_path_card.dart';
import 'widgets/career_progression_card.dart';
import 'widgets/universities_card.dart';

class CareerDetailScreen extends StatelessWidget {
  final Career career;
  final Major? major;
  final List<Major>? relatedMajors;

  const CareerDetailScreen({
    super.key,
    required this.career,
    this.major,
    this.relatedMajors,
  });

  @override
  Widget build(BuildContext context) {
    // look it up if not provided (Some screens does not give the needed data)
    final careerMajor =
        major ?? allMajors.firstWhere((m) => m.id == career.majorId);
    final careerRelatedMajors =
        relatedMajors ??
        allMajors
            .where((m) => careerMajor.relatedMajorIds.contains(m.id))
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Career Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CareerHeader(career: career),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AboutThisCareerCard(career: career),

                  const SizedBox(height: 10),

                  const WhyFitsYouCard(),

                  const SizedBox(height: 10),

                  SalaryCard(salaryRange: career.salaryRange),

                  const SizedBox(height: 10),

                  SkillsCard(skills: career.skills),

                  const SizedBox(height: 10),

                  EducationPathCard(
                    major: careerMajor,
                    relatedMajors: careerRelatedMajors,
                  ),

                  const SizedBox(height: 10),

                  CareerProgressionCard(progression: career.careerProgression),

                  const SizedBox(height: 10),

                  UniversitiesCard(
                    universityMajors: universityMajors,
                    majorId: career.majorId,
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
