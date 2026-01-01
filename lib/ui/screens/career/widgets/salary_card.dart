import 'package:flutter/material.dart';
import '../../../common/widgets/info_card.dart';

class SalaryCard extends StatelessWidget {
  final String salaryRange;

  const SalaryCard({super.key, required this.salaryRange});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InfoCard(
      title: 'Estimated Salary Range',
      icon: Icons.attach_money,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            salaryRange,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Varies by experience, company, and location',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
