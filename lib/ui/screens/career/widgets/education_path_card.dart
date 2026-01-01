import 'package:flutter/material.dart';
import '../../dream/Domain/mock_data.dart';

class EducationPathCard extends StatefulWidget {
  final Major major;
  final List<Major> relatedMajors;

  const EducationPathCard({
    super.key,
    required this.major,
    required this.relatedMajors,
  });

  @override
  State<EducationPathCard> createState() => _EducationPathCardState();
}

class _EducationPathCardState extends State<EducationPathCard> {
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
        onTap: widget.relatedMajors.isNotEmpty ? onExpanded : null,
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
                        Icons.school_outlined,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Education Path',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (widget.relatedMajors.isNotEmpty)
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: colorScheme.primary,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Primary Major
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Primary: ',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.major.name,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              // Related Majors
              if (isExpanded && widget.relatedMajors.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Also consider:',
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.relatedMajors.map((relatedMajor) {
                    return Chip(
                      label: Text(relatedMajor.name),
                      labelStyle: textTheme.bodySmall,
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(color: Colors.grey.shade300),
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
