import 'package:flutter/material.dart';
import 'dart:ui';
import '../../theme/app_styles.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.buttonBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            skill,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[300],
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SkillChipsGlass extends StatelessWidget {
  const SkillChipsGlass({
    super.key,
    required this.skills,
    this.maxSkillDisplay,
  });

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
