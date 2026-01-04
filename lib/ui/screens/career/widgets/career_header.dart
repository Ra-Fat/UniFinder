import 'package:flutter/material.dart';
import '../../../../Domain/model/Career/career_model.dart';

class CareerHeader extends StatelessWidget {
  final Career career;

  const CareerHeader({super.key, required this.career});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(career.imagePath ?? 'career/data.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
