import 'package:flutter/material.dart';
import '../../../../Domain/model/Major/major_model.dart';
import 'package:uni_finder/Domain/model/University/universityMajorDetail.dart';
import '../../../common/widgets/university_tile.dart';

class MajorCard extends StatefulWidget {
  final Major major;
  final List<UniversityMajorDetail> universityMajors;

  const MajorCard({
    super.key,
    required this.major,
    required this.universityMajors,
  });

  @override
  State<MajorCard> createState() => _MajorCardState();
}

class _MajorCardState extends State<MajorCard> {
  bool isExpanded = false;

  void onExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter to get only universities that offer this specific major
    final filtered = widget.universityMajors
        .where((universityMajor) => universityMajor.major.id == widget.major.id)
        .toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Collapse
          InkWell(
            onTap: () => onExpanded(),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.major.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${filtered.length} ${filtered.length == 1 ? 'University' : 'Universities'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Expand
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: filtered.map((universityMajor) {
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

class RelatedMajorList extends StatelessWidget {
  final List<Major> majors;
  final List<UniversityMajorDetail> universityMajors;

  const RelatedMajorList({
    super.key,
    required this.majors,
    required this.universityMajors,
  });

  @override
  Widget build(BuildContext context) {
    final relatedMajors = majors
        .map(
          (major) =>
              MajorCard(major: major, universityMajors: universityMajors),
        )
        .toList();

    return Column(children: relatedMajors);
  }
}
