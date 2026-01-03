import 'package:go_router/go_router.dart';
import '../ui/screens/q&a/question_screen.dart';
import '../ui/screens/recommendation/recommendation.dart';
import '../ui/screens/utils/logo_splash_screen.dart';
import '../ui/screens/welcomes/welcome_screen.dart';
import '../ui/screens/q&a/mutiple_choice_question.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LogoSplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/name',
      builder: (context, state) => const QuestionScreen(),
    ),
    GoRoute(
      path: '/questions',
      builder: (context, state) => const MutipleChoiceQuestionScreen(),
    ),
    GoRoute(
      path: '/recommendation',
      builder: (context, state) => const Recommendation(),
    ),
  ]
);