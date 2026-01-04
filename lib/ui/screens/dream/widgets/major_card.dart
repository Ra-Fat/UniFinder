import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/ui/common/widgets/widget.dart';
import '../../../../model/major_model.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
import '../../../theme/app_colors.dart';

class MajorCard extends StatefulWidget {
  final Major major;
  final List<UniversityMajorDetail> universityMajors;
  final bool isPrimary;

  const MajorCard({
    super.key,
    required this.major,
    required this.universityMajors,
    this.isPrimary = false,
  });

  @override
  State<MajorCard> createState() => _MajorCardState();
}

class _MajorCardState extends State<MajorCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final filtered = widget.universityMajors
        .where((e) => e.major.id == widget.major.id)
        .toList();

    return Container(
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(filtered.length),
          if (widget.isPrimary || isExpanded) _buildUniversityList(filtered),
        ],
      ),
    );
  }

  Widget _buildHeader(int count) {
    return InkWell(
      onTap: widget.isPrimary
          ? null
          : () => setState(() => isExpanded = !isExpanded),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _iconBox(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.major.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$count ${count == 1 ? 'University' : 'Universities'}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            if (!widget.isPrimary)
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUniversityList(List<UniversityMajorDetail> list) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
      child: Column(children: list.map(_universityTile).toList()),
    );
  }

  Widget _universityTile(UniversityMajorDetail item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          // Get all majors for this university
          final universityMajors = widget.universityMajors
              .where((e) => e.university.id == item.university.id)
              .toList();
          
          context.push('/university', extra: {
            'university': item.university,
            'availableMajors': universityMajors,
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundGradientEnd,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.cardBorder),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _iconBox(size: widget.isPrimary ? 40 : 32),
              const SizedBox(width: 12),
              Expanded(child: CustomSecondaryText(text: item.university.name)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBox({double size = 40}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.buttonBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.school, size: size / 2, color: Colors.grey[400]),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: widget.isPrimary
          ? AppColors.cardBackgroundGradientStart
          : AppColors.cardBackground,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.cardBorder),
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
    return Column(
      children: [
        for (int i = 0; i < majors.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i < majors.length - 1 ? 12 : 0),
            child: MajorCard(
              major: majors[i],
              universityMajors: universityMajors,
            ),
          ),
      ],
    );
  }
}
