import 'package:flutter/material.dart';
import '../../../../Domain/model/Career/career_model.dart';
import '../../../common/widgets/widget.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final List<Career> careers;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    required this.careers,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: CustomSecondaryText(
            text: 'See All (${careers.length})',
            textColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
