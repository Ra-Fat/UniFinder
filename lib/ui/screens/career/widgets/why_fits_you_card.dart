import 'package:flutter/material.dart';

class WhyFitsYouCard extends StatefulWidget {
  const WhyFitsYouCard({super.key});

  @override
  State<WhyFitsYouCard> createState() => _WhyFitsYouCardState();
}

class _WhyFitsYouCardState extends State<WhyFitsYouCard> {
  bool isExpanded = false;

  void onExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onExpanded,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Why This Career Fits You',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorScheme.primary,
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                //TODO: Need to update to replace with user's answer
                const Text('• You enjoy problem-solving'),
                const SizedBox(height: 4),
                const Text('• You like working with technology'),
                const SizedBox(height: 4),
                const Text('• You prefer structured and logical tasks'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
