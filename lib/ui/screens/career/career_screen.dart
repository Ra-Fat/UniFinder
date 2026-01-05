import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/widgets/widget.dart';
import 'package:uni_finder/ui/screens/dream/widgets/career_card.dart';
import '../../../Domain/model/Career/career_model.dart';
import '../../../Domain/model/Major/major_model.dart';
import '../../../service/dream_service.dart';
import '../../../service/major_service.dart';
import '../../../service/university_service.dart';
import '../../theme/app_styles.dart';

class CareerScreen extends StatelessWidget {
  final List<Career> careers;
  final Major? major;
  final List<Major>? relatedMajors;
  final DreamService dreamService;
  final MajorService majorService;
  final UniversityService universityService;

  const CareerScreen({
    super.key,
    required this.careers,
    this.major,
    this.relatedMajors,
    required this.dreamService,
    required this.majorService,
    required this.universityService,
  });

  int _getCrossAxisCount(double width) {
    if (width >= 1200) {
      return 4; // large screen
    } else if (width >= 900) {
      return 3; // medium screen
    } else {
      return 2; // mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

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
            title: CustomPrimaryText(
             text:  'Career Opportunities',
              
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: careers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(screenWidth),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 265, 
          ),
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
      ),
    );
  }
}
