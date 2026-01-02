import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
            bottom: 40,
            left: 20,
            child: TextButton(
              onPressed: _currentIndex == onboardingPages.length -1 ? null : _onSkip,
              child: Text(
                "Skip",
                style: TextStyle(
                  color: _currentIndex == onboardingPages.length -1 ? Colors.grey : Colors.red  ,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              )
            )
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: TextButton(
              onPressed: _onNext,
              child: Text(
                _currentIndex == onboardingPages.length -1 ? "Finished" : "Next",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              )
            )
          ),
          Positioned(
            bottom: 40,
            right: 0,
            left: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: onboardingPages.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue
                ),
              ),
            ),
          )
          // Positioned(
          //   bottom: 40,
          //   left: 20,
          //   right: 20,
          //   child: Column(
          //     children: [
          //       // NEXT BUTTON
          //       SizedBox(
          //         width: double.infinity,
          //         height: 52,
          //         child: ElevatedButton(
          //           onPressed: _onNext,
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: const Color.fromARGB(255, 17, 55, 144),
          //             foregroundColor: Colors.white,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(14),
          //             ),
          //             elevation: 0,
          //           ),
          //           child: Text(
          //             _currentIndex == onboardingPages.length - 1 ? "Get Started" : "Next",
          //             style: const TextStyle(
          //               fontFamily: 'Roboto',
          //               fontSize: 16,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
