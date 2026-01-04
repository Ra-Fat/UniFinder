import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/screens/career/career_screen.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
import '../../../model/career_model.dart';
import '../../../model/major_model.dart';
import '../../../service/dream_service.dart';
import '../../../service/major_service.dart';
import '../../../service/career_service.dart';
import '../../../service/university_service.dart';
import 'widgets/career_card.dart';
import 'widgets/major_card.dart';
import '../../theme/app_colors.dart';
import '../../common/widgets/widget.dart';
import '../../theme/app_colors.dart';
import 'widgets/section_header.dart';
import 'package:uni_finder/ui/common/widgets/compare_modal/compare_modal.dart';

class DreamDetail extends StatefulWidget {
  final String majorId;
  final String? dreamName;
  final DreamService dreamService;
  final MajorService majorService;
  final CareerService careerService;
  final UniversityService universityService;

  const DreamDetail({
    super.key,
    required this.majorId,
    this.dreamName,
    required this.dreamService,
    required this.majorService,
    required this.careerService,
    required this.universityService,
  });

  @override
  State<DreamDetail> createState() => _DreamDetailState();
}

class _DreamDetailState extends State<DreamDetail> {
  late Future<(Major, List<Career>, List<UniversityMajorDetail>, List<Major>)>
  _dreamDataFuture;

  @override
  void initState() {
    super.initState();
    _dreamDataFuture = _loadDreamData();
  }

  Future<(Major, List<Career>, List<UniversityMajorDetail>, List<Major>)>
  _loadDreamData() async {
    // Fetch the primary major details
    final major = await widget.majorService.getMajorById(widget.majorId);
    if (major == null) {
      throw Exception('Major not found');
    }

    // Get career opportunities for this major
    final careers = await widget.careerService.getCareersForMajor(
      widget.majorId,
    );

    // Find majors related to the primary major
    final relatedMajors = await widget.majorService.getRelatedMajorsForPrimary(
      widget.majorId,
    );

    // Collect all major IDs (primary + related) for university lookup
    final allMajorIds = <String>{
      widget.majorId,
      ...relatedMajors.map((m) => m.id).whereType<String>(),
    }.toList();

    // Fetch universities offering any of these majors
    final universityMajors = await widget.universityService
        .getUniversitiesForMajors(allMajorIds);

    return (major, careers, universityMajors, relatedMajors);
  }

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
              widget.dreamName ?? 'Dream Details',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Compare',
                  onPressed: () {
                    CompareUniversitiesBottomSheet.show(
                      context,
                      widget.dreamService,
                      widget.majorService,
                      widget.universityService,
                    );
                  },
                ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
        ),
      ),
      body:
          FutureBuilder<
            (Major, List<Career>, List<UniversityMajorDetail>, List<Major>)
          >(
            future: _dreamDataFuture,
            builder: (context, snapshot) {
              // Show loading spinner while fetching data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Display error if data fetch fails
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              // Handle empty data case
              if (!snapshot.hasData) {
                return const Center(child: Text('No data available'));
              }

              // Extract data from the future result
              final (major, careers, universityMajors, relatedMajors) =
                  snapshot.data!;

              return SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Career Opportunities',
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CareerScreen(
                              careers: careers,
                              major: major,
                              relatedMajors: relatedMajors,
                              dreamService: widget.dreamService,
                              majorService: widget.majorService,
                              universityService: widget.universityService,
                            ),
                          ),
                        );
                      },
                      careers: careers,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CareerCardsList(
                      careers: careers,
                      major: major,
                      relatedMajors: relatedMajors,
                      dreamService: widget.dreamService,
                      majorService: widget.majorService,
                      universityService: widget.universityService,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.buttonBackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.school_outlined,
                            color: AppColors.accentBlue,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomPrimaryText(text: "Universities & Program"),
                              const SizedBox(height: 3),
                              CustomSecondaryText(
                                text: 'Institution offering this major',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    MajorCard(major: major, universityMajors: universityMajors, isPrimary: true,),
                    const SizedBox(height: AppSpacing.paddingHorizontal),
                    Text(
                      'Related Majors',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    RelatedMajorList(
                      majors: relatedMajors,
                      universityMajors: universityMajors,
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
