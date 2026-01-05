import 'package:flutter/material.dart';
import '../../../ui/screens/welcomes/components/welcome_screen_components.dart';

final List<Widget> onboardingPages  = [
    WelcomeScreenComponents(
      title: "Welcome to UniFinder",
      description:
          "Find the university, major, and career path that fit you best.",
      imagePath: "assets/panels/student.png",
    ),
    WelcomeScreenComponents(
      title: "Discover Your Path",
      description:
          "Answer questions about your interests and get personalized recommendations.",
      imagePath: "assets/panels/selection.png",
    ),
    WelcomeScreenComponents(
      title: "Compare Universities",
      description: "Explore and compare Cambodian universities side-by-side.",
      imagePath: "assets/panels/compared.png",
    ),
    WelcomeScreenComponents(
      title: "Plan Your Career",
      description: "Connect your major choices with real career opportunities.",
      imagePath: "assets/panels/recommended.png",
    ),
];