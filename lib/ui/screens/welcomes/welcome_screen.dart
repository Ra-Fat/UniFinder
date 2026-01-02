import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../widgets/widget.dart';
import '../../../data/onboarding_pages/onboarding_pages.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    _pageController.animateToPage(
      onboardingPages.length - 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    if (_currentIndex < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _onFinished();
    }
  }

  void _onFinished() {
    context.go('/name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) => onboardingPages[index],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: onboardingPages.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    expansionFactor: 2.5,
                    spacing: 8,
                  ),
                ),
                SizedBox(height: 20),
                CustomizeButton(
                  text: _currentIndex == onboardingPages.length -1 ? "Get Started" : "Next", 
                  onPressed: _onNext
                ),
                if (_currentIndex != onboardingPages.length -1) ...[
                  SizedBox(height: 12),
                  CustomizeButton(
                    text: "Skip",
                    onPressed: _onSkip,
                    isTextButton: true,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
