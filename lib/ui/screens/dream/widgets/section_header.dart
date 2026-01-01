import 'package:flutter/material.dart';
import 'package:uni_finder/ui/screens/dream/Domain/mock_data.dart';

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
          child: Text(
            'See All (${careers.length})',
            style: textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
