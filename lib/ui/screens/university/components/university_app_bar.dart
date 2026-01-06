import 'package:flutter/material.dart';
import 'package:uni_finder/Domain/model/University/university_model.dart';
import '../../../common/Theme/app_styles.dart';

class UniversityAppBar extends StatelessWidget {
  final University university;

  const UniversityAppBar({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              university.coverImagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.cardBackgroundGradientStart,
                  child: Icon(Icons.school, size: 80, color: Colors.grey[600]),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.darkBackground,
    );
  }
}
