import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './welcome_screen_components.dart';
import '../q&a/question_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WelcomeScreenComponents(
      title: "Welcome to UniFinder",
      description:
          "Find the university, major, and career path that fit you best.",
      imagePath: "panels/student_panel3.png",
    ),
    WelcomeScreenComponents(
      title: "Discover Your Path",
      description:
          "Answer questions about your interests and get personalized recommendations.",
      imagePath: "panels/selection.png",
    ),
    WelcomeScreenComponents(
      title: "Compare Universities",
      description:
          "Explore and compare Cambodian universities side-by-side.",
      imagePath: "panels/compared.png",
    ),
    WelcomeScreenComponents(
      title: "Plan Your Career",
      description:"Connect your major choices with real career opportunities.",
      imagePath: "panels/recommended.png",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip(){
    _pageController.animateToPage(
      _pages.length-1, 
      duration: Duration(milliseconds: 500), 
      curve: Curves.easeInOut
    );
  }

  void _onNext(){
    if(_currentIndex < _pages.length-1){
      _pageController.nextPage(
        duration: Duration(milliseconds: 500), 
        curve: Curves.easeInOut
      );
    }else{
      _onFinished();
    }
  }

  void _onFinished(){
    Navigator.pushReplacement(
      context, 
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => QuestionScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      )
    );
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
            itemCount: _pages.length,
            itemBuilder: (context, index) => _pages[index],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: TextButton(
              onPressed: _currentIndex == _pages.length -1 ? null : _onSkip, 
              child: Text(
                "Skip",
                style: TextStyle(
                  color: _currentIndex == _pages.length -1 ? Colors.grey : Colors.red  ,
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
                _currentIndex == _pages.length -1 ? "Finish" : "Next",
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
                count: _pages.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
