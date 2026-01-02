import 'package:flutter/material.dart';
import '../../widgets/widget.dart';


class WelcomeScreenComponents extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  const WelcomeScreenComponents({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 160,),
          SizedBox(height: 30,),
          CustomPrimaryText(
            text: title,
            fontSize: 24,
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomSecondaryText(
              text: description,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}