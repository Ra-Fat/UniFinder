import 'package:flutter/material.dart';
import 'package:uni_finder/model/university_model.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'components/university_app_bar.dart';
import 'components/university_header.dart';
import 'components/quick_info_section.dart';
import 'components/about_section.dart';
import 'components/contact_section.dart';
import 'components/available_majors_section.dart';

class UniversityScreen extends StatelessWidget {
  final University university;
  final List<UniversityMajorDetail> availableMajors;

  const UniversityScreen({
    super.key,
    required this.university,
    required this.availableMajors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          UniversityAppBar(university: university),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UniversityHeader(university: university),
                const SizedBox(height: AppSpacing.lg),
                QuickInfoSection(
                  university: university,
                  majorsCount: availableMajors.length,
                ),
                const SizedBox(height: AppSpacing.lg),
                AboutSection(university: university),
                const SizedBox(height: AppSpacing.lg),
                ContactSection(university: university),
                const SizedBox(height: AppSpacing.lg),
                AvailableMajorsSection(availableMajors: availableMajors),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}