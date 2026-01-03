import 'package:flutter/material.dart';
import 'dart:ui';

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
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                // Semi-transparent background with blur
                color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Alternative version with more pronounced glassmorphism effect
class SkillChipsGlass extends StatelessWidget {
  const SkillChipsGlass({super.key, required this.skills, this.maxSkillDisplay});

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
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                // Glassmorphism effect
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Text(
                skill,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}