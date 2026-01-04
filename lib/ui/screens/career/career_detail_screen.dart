import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../Domain/model/Career/career_model.dart';
import '../../../Domain/model/Major/major_model.dart';
import '../../../service/dream_service.dart';
import '../../../service/major_service.dart';
import '../../../service/university_service.dart';
import 'widgets/career_header.dart';
import 'widgets/about_this_career_card.dart';
import '../../theme/app_styles.dart';
import '../../common/widgets/widget.dart';
import 'widgets/salary_card.dart';
import 'widgets/skills_card.dart';
import 'widgets/education_path_card.dart';
import 'widgets/career_progression_card.dart';
import 'widgets/universities_card.dart';
import 'package:uni_finder/Domain/model/University/universityMajorDetail.dart';

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
      final allMajorIds = <String>{
        major.id!,
        ...relatedMajors.map((m) => m.id!).whereType<String>(),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkBackground.withOpacity(0.7),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
              ),
              child: AppBar(
                title: CustomPrimaryText(text: widget.career.name),
                backgroundColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ),

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
                  // padding: const EdgeInsets.all(AppSpacing.paddingHorizontal),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      AboutThisCareerCard(career: widget.career),

                      SalaryCard(
                        salaryRange: widget.career.salaryRange ?? 'N/A',
                      ),

                      SkillsCard(skills: widget.career.skills ?? []),

                      if (major != null && relatedMajors.isNotEmpty)
                        EducationPathCard(
                          major: major,
                          relatedMajors: relatedMajors,
                        ),

                      if (widget.career.careerProgression != null)
                        CareerProgressionCard(
                          progression: widget.career.careerProgression!,
                        ),

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
