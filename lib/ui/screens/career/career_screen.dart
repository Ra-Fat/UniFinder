import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/widgets/appbar_widget.dart';
import 'package:uni_finder/ui/screens/dream/components/career_card.dart';
import '../../../Domain/model/Career/career_model.dart';
import '../../../Domain/model/Major/major_model.dart';
import '../../../service/dream_service.dart';
import '../../../service/major_service.dart';
import '../../../service/university_service.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const GlobalAppBar(title: 'Career Opportunities'),
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
