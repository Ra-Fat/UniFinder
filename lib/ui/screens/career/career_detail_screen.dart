import 'package:flutter/material.dart';
import '../../../Domain/model/Career/career_model.dart';
import '../../../Domain/model/Major/major_model.dart';
import '../../../service/dream_service.dart';
import '../../../service/major_service.dart';
import '../../../service/university_service.dart';
import 'components/career_header.dart';
import 'components/about_this_career_card.dart';
import 'components/salary_card.dart';
import 'components/skills_card.dart';
import 'components/career_progression_card.dart';
import 'components/quick_fact.dart';
import '../../common/widgets/appbar_widget.dart';
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

      appBar:  GlobalAppBar(title: widget.career.name,),

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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CareerHeader(career: widget.career),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      QuickFactSection(career: widget.career),
                      SizedBox(height: 7),
                      AboutThisCareerCard(career: widget.career),
                      SizedBox(height: 7),

                      SalaryCard(
                        salaryRange: widget.career.salaryRange ?? 'N/A',
                      ),
                      SizedBox(height: 7),

                      SkillsCard(skills: widget.career.skills ?? []),
                      SizedBox(height: 7,),
                      if (widget.career.careerProgression != null)
                        CareerProgressionCard(
                          progression: widget.career.careerProgression!,
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
