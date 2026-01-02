import 'package:flutter/material.dart';
import '../../../../model/career_model.dart';

class CareerHeader extends StatelessWidget {
  final Career career;

  const CareerHeader({super.key, required this.career});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.work_outline, size: 48, color: colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            career.name,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            career.shortDescription ?? '',
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
