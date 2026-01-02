import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/screens/dream/widgets/career_card.dart';
import '../../../model/career_model.dart';
import '../../../model/major_model.dart';
import '../../../service/dream_service.dart';

class CareerScreen extends StatelessWidget {
  final List<Career> careers;
  final Major? major;
  final List<Major>? relatedMajors;
  final DreamService dreamService;

  const CareerScreen({
    super.key,
    required this.careers,
    this.major,
    this.relatedMajors,
    required this.dreamService,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Career Opportunities',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (major != null)
              Text(
                'For ${major!.name}',
                style: textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: careers.map((career) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: (MediaQuery.of(context).size.width - 40) / 2,
                  ),
                  child: CareerCard(
                    career: career,
                    width: (MediaQuery.of(context).size.width - 40) / 2 - 12,
                    major: major,
                    relatedMajors: relatedMajors,
                    dreamService: dreamService,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
