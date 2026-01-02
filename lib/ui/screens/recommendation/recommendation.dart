import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/ui/app.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widget.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPrimaryText(
                    text: "Your Perfect Majors"
                  ),
                  SizedBox(height: 10,),
                  CustomSecondaryText(
                    text: 'Choose one major to save as your dream'
                  ),
                ]
              ),
            ),
          ],
        ),
        toolbarHeight: 80,
      ),
    );
  }
}
