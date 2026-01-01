import 'package:flutter/material.dart';
import 'package:uni_finder/ui/screens/career/career_screen.dart';
import 'Domain/mock_data.dart';
import 'Domain/Service/dream_service.dart';
import 'widgets/career_card.dart';
import 'widgets/major_card.dart';
import 'widgets/section_header.dart';

class DreamDetail extends StatelessWidget {
  final Dream dream;
  final DreamService dreamService;

  const DreamDetail({
    super.key,
    required this.dream,
    required this.dreamService,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Get careers related to the primary major
    final careers = dreamService.getCareersForMajor(dream.primaryMajor.id);

    // Get all university-major relationships for displaying university options
    final universityMajors = dreamService.allUniversityMajors;

    // Get majors related to the primary major (based on relatedMajorIds)
    final relatedMajors = dreamService.getRelatedMajorsForPrimary(
      dream.primaryMajor.id,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dream.name,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            tooltip: 'Compare',
            onPressed: () {
              // TODO: implement comparison later
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      major: dream.primaryMajor,
                      relatedMajors: relatedMajors,
                    ),
                  ),
                );
              },
              careers: careers,
            ),

            const SizedBox(height: 10),

            CareerCardsList(
              careers: careers,
              major: dream.primaryMajor,
              relatedMajors: relatedMajors,
            ),

            const SizedBox(height: 5),

            Text(
              'Primary Major',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            MajorCard(
              major: dream.primaryMajor,
              universityMajors: universityMajors,
            ),

            const SizedBox(height: 20),

            Text(
              'Related Majors',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            RelatedMajorList(
              majors: relatedMajors,
              universityMajors: universityMajors,
            ),
          ],
        ),
      ),
    );
  }
}
