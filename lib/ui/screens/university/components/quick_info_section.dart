import 'package:flutter/material.dart';
import 'package:uni_finder/model/university_model.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/theme/app_colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.primaryBlue),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
