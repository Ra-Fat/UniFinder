import 'package:flutter/material.dart';
import 'package:uni_finder/Domain/model/University/university_model.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import './info_card.dart';

class QuickInfoSection extends StatelessWidget {
  final University university;
  final int majorsCount;

  const QuickInfoSection({
    super.key,
    required this.university,
    required this.majorsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: InfoCard(
              icon: Icons.calendar_today,
              label: 'Established',
              value: university.establishedYear.toString(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InfoCard(
              icon: Icons.account_balance,
              label: 'Type',
              value: university.type,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InfoCard(
              icon: Icons.school,
              label: 'Majors',
              value: majorsCount.toString(),
            ),
          ),
        ],
      ),
    );
  }
}