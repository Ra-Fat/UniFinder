import 'package:flutter/material.dart';
import '../../../model/university_model.dart';
import '../../../model/major_model.dart';
import '../../../model/university_major.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_spacing.dart';
import '../../common/constants/app_text_styles.dart';
import 'widget/university_header.dart';
import 'widget/info_row.dart';
import 'widget/price_bar.dart';
import 'widget/contact_row.dart';

class CompareScreen extends StatefulWidget {
  final University university1;
  final University university2;
  final Major selectedMajor;
  final UniversityMajor universityMajor1;
  final UniversityMajor universityMajor2;

  const CompareScreen({
    super.key,
    required this.university1,
    required this.university2,
    required this.selectedMajor,
    required this.universityMajor1,
    required this.universityMajor2,
  });

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        title: const Text(
          'Compare Universities',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Major Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              color: AppColors.background,
              child: Column(
                children: [
                  const Icon(Icons.school, color: Colors.white, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    widget.selectedMajor.name,
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // University Headers
            Container(
              color: AppColors.background,
              child: Row(
                children: [
                  UniversityHeader(university: widget.university1),
                  Container(width: 1, height: 140, color: Colors.grey[300]),
                  UniversityHeader(university: widget.university2),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Basic Info
            InfoRow(
              label: 'Type',
              value1: widget.university1.type,
              value2: widget.university2.type,
            ),
            InfoRow(
              label: 'Established',
              value1: widget.university1.establishedYear.toString(),
              value2: widget.university2.establishedYear.toString(),
            ),

            const SizedBox(height: 8),

            // Price Comparison Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(150),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Cost Comparison',
                        style: AppTextStyles.h2.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PriceBar(
                    label: 'Price per Year',
                    price1: widget.universityMajor1.pricePerYear,
                    price2: widget.universityMajor2.pricePerYear,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PriceBar(
                    label: 'Total Program Cost',
                    price1:
                        widget.universityMajor1.pricePerYear *
                        widget.universityMajor1.durationYears,
                    price2:
                        widget.universityMajor2.pricePerYear *
                        widget.universityMajor2.durationYears,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Program Details
            InfoRow(
              label: 'Duration',
              value1: '${widget.universityMajor1.durationYears} years',
              value2: '${widget.universityMajor2.durationYears} years',
            ),
            InfoRow(
              label: 'Degree',
              value1: widget.universityMajor1.degree,
              value2: widget.universityMajor2.degree,
            ),

            const SizedBox(height: 8),

            // Contact Info
            ContactRow(
              icon: Icons.language,
              value1: widget.university1.website,
              value2: widget.university2.website,
            ),
            ContactRow(
              icon: Icons.phone,
              value1: widget.university1.phone,
              value2: widget.university2.phone,
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
