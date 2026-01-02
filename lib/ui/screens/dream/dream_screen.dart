import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/screens/career/career_screen.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
import '../../../model/career_model.dart';
import '../../../model/major_model.dart';
import '../../../service/dream_service.dart';
import 'widgets/career_card.dart';
import 'widgets/major_card.dart';
import 'widgets/section_header.dart';
import 'package:uni_finder/ui/common/widgets/compare_universities_bottom_sheet.dart';

class DreamDetail extends StatefulWidget {
  final int majorId;
  final String? dreamName;
  final DreamService dreamService;

  const DreamDetail({
    super.key,
    required this.majorId,
    this.dreamName,
    required this.dreamService,
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
    final major = await widget.dreamService.getMajorById(widget.majorId);
    if (major == null) {
      throw Exception('Major not found');
    }

    // Get career opportunities for this major
    final careers = await widget.dreamService.getCareersForMajor(
      widget.majorId,
    );

    // Find majors related to the primary major
    final relatedMajors = await widget.dreamService.getRelatedMajorsForPrimary(
      widget.majorId,
    );

    // Collect all major IDs (primary + related) for university lookup
    final allMajorIds = <int>{
      widget.majorId,
      ...relatedMajors.map((m) => m.id).whereType<int>(),
    }.toList();

    // Fetch universities offering any of these majors
    final universityMajors = await widget.dreamService.getUniversitiesForMajors(
      allMajorIds,
    );

    return (major, careers, universityMajors, relatedMajors);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dreamName ?? 'Dream Details',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            tooltip: 'Compare',
            onPressed: () {
              CompareUniversitiesBottomSheet.show(context, widget.dreamService);
            },
          ),
        ],
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
                padding: const EdgeInsets.only(
                  top: AppSpacing.paddingHorizontal,
                  left: AppSpacing.paddingHorizontal,
                  right: AppSpacing.paddingHorizontal,
                ),
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
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Primary Major',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    MajorCard(major: major, universityMajors: universityMajors),
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
