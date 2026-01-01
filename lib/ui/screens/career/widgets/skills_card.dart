import 'package:flutter/material.dart';
import '../../../common/widgets/skill_chip.dart';

class SkillsCard extends StatefulWidget {
  final List<String> skills;

  const SkillsCard({super.key, required this.skills});

  @override
  State<SkillsCard> createState() => _SkillsCardState();
}

class _SkillsCardState extends State<SkillsCard> {
  bool isExpanded = false;

  void onExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                        Icons.lightbulb_outline,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Required Skills',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.skills.length > 3)
                        Text(
                          '${widget.skills.length}',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      if (widget.skills.length > 3) const SizedBox(width: 8),
                      if (widget.skills.length > 3)
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: colorScheme.primary,
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SkillChips(
                skills: widget.skills,
                maxSkillDisplay: isExpanded ? null : 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
