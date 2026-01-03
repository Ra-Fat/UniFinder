import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import '../../../model/career_model.dart';
import '../../../model/major_model.dart';
import '../../../service/dream_service.dart';
import '../../../service/major_service.dart';
import '../../../service/university_service.dart';
import 'widgets/career_header.dart';
import 'widgets/about_this_career_card.dart';
// import 'widgets/why_fits_you_card.dart';
import 'widgets/salary_card.dart';
import 'widgets/skills_card.dart';
import 'widgets/education_path_card.dart';
import 'widgets/career_progression_card.dart';
import 'widgets/universities_card.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';

class CareerDetailScreen extends StatefulWidget {
  final Career career;
  final Major? major;
  final List<Major>? relatedMajors;
  final DreamService dreamService;
  final MajorService majorService;
  final UniversityService universityService;

  const CareerDetailScreen({
    super.key,
    required this.career,
    this.major,
    this.relatedMajors,
    required this.dreamService,
    required this.majorService,
    required this.universityService,
  });

  @override
  State<CareerDetailScreen> createState() => _CareerDetailScreenState();
}

class _CareerDetailScreenState extends State<CareerDetailScreen> {
  late Future<(Major?, List<Major>, List<UniversityMajorDetail>)>
  _careerDataFuture;

  @override
  void initState() {
    super.initState();
    _careerDataFuture = _loadCareerData();
  }

  Future<(Major?, List<Major>, List<UniversityMajorDetail>)>
  _loadCareerData() async {
    // Use provided data or fetch from service
    Major? major = widget.major;
    List<Major>? relatedMajors = widget.relatedMajors;
    List<UniversityMajorDetail>? universities;

    // If we have a major with an ID, fetch related data
    if (major != null && major.id != null) {
      relatedMajors ??= await widget.majorService.getRelatedMajorsForPrimary(
        major.id!,
      );

      // Fetch universities for primary major + all related majors
      final allMajorIds = <int>{
        major.id!,
        ...relatedMajors.map((m) => m.id).whereType<int>(),
      }.toList();
      universities = await widget.universityService.getUniversitiesForMajors(
        allMajorIds,
      );
    }

    return (major, relatedMajors ?? [], universities ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Career Details')),
      body: FutureBuilder<(Major?, List<Major>, List<UniversityMajorDetail>)>(
        future: _careerDataFuture,
        builder: (context, snapshot) {
          // Show loading spinner while fetching data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Display error if data fetch fails
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Extract data from the future result
          final (major, relatedMajors, universities) =
              snapshot.data ?? (null, <Major>[], <UniversityMajorDetail>[]);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CareerHeader(career: widget.career),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.paddingHorizontal),
                  child: Column(
                    children: [
                      AboutThisCareerCard(career: widget.career),

                      const SizedBox(height: AppSpacing.md),

                      const SizedBox(height: AppSpacing.md),

                      SalaryCard(
                        salaryRange: widget.career.salaryRange ?? 'N/A',
                      ),

                      const SizedBox(height: AppSpacing.md),

                      SkillsCard(skills: widget.career.skills ?? []),

                      const SizedBox(height: AppSpacing.md),

                      if (major != null && relatedMajors.isNotEmpty)
                        EducationPathCard(
                          major: major,
                          relatedMajors: relatedMajors,
                        ),

                      const SizedBox(height: AppSpacing.md),

                      if (widget.career.careerProgression != null)
                        CareerProgressionCard(
                          progression: widget.career.careerProgression!,
                        ),

                      const SizedBox(height: AppSpacing.md),

                      if (universities.isNotEmpty &&
                          major != null &&
                          major.id != null)
                        UniversitiesCard(
                          universityMajors: universities,
                          majorId: major.id!,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
