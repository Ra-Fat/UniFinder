import 'package:flutter/material.dart';
import '../../dream/Domain/mock_data.dart';
import '../../../common/widgets/university_tile.dart';

class UniversitiesCard extends StatefulWidget {
  final List<UniversityMajor> universityMajors;
  final String majorId;

  const UniversitiesCard({
    super.key,
    required this.universityMajors,
    required this.majorId,
  });

  @override
  State<UniversitiesCard> createState() => UniversitiesCardState();
}

class UniversitiesCardState extends State<UniversitiesCard> {
  late bool isExpanded = false;

  void onExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final filteredUniversityMajors = widget.universityMajors
        .where((universityMajor) => universityMajor.major.id == widget.majorId)
        .toList();

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onExpanded(),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school_outlined,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Related Universities',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${filteredUniversityMajors.length}',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: filteredUniversityMajors.map((universityMajor) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: UniversityTile(
                      name: universityMajor.university.name,
                      price: universityMajor.tuitionRange,
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
