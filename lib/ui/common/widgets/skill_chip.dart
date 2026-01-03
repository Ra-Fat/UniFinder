import 'package:flutter/material.dart';

class SkillChips extends StatelessWidget {
  const SkillChips({super.key, required this.skills, this.maxSkillDisplay});

  final List<String> skills;
  final int? maxSkillDisplay;

  @override
  Widget build(BuildContext context) {
    final displayedSkills = maxSkillDisplay != null
        ? skills.take(maxSkillDisplay!).toList()
        : skills;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: displayedSkills.map((skill) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
          ),
          child: Text(
            skill,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}
