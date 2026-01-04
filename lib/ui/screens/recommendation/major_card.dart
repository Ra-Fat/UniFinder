import 'package:flutter/material.dart';
import '../../theme/app_styles.dart';
import '../../common/widgets/widget.dart';
import './components/major_card_helpers.dart';

class MajorCard extends StatelessWidget {
  final String majorName;
  final IconData? icon;
  final String description;
  final double matchScore;
  final bool isSelected;
  final List<String> keySkills;
  final VoidCallback onTab;

  const MajorCard({
    super.key,
    required this.majorName,
    required this.isSelected,
    required this.description,
    required this.matchScore,
    required this.keySkills,
    required this.onTab,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTab,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.accentBlue
                    : const Color(0xFF334155).withOpacity(0.5),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPrimaryText(
                            text: majorName,
                            textColor: AppColors.accentBlue,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.accentBlue.withOpacity(0.2)
                                  : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.check_circle : Icons.star,
                                  color: isSelected
                                      ? AppColors.accentBlue
                                      : Color(0xFFFCD34D),
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '$matchScore %',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomSecondaryText(
                        text: description,
                        textColor: AppColors.textSecondary,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Key Skills You'll Develop",
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...keySkills.map((skill) => skillsCard(skill)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
