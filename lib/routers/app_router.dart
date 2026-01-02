import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/ui/screens/home/home_screen.dart';
import '../ui/screens/q&a/question_screen.dart';
import '../ui/screens/utils/logo_splash_screen.dart';
import '../ui/screens/welcomes/welcome_screen.dart';
import '../ui/screens/q&a/mutiple_choice_question.dart';
import '../ui/screens/dream/dream_screen.dart';
import '../data/repository/data_repository.dart';
import '../data/storage/file_storage.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home', // Start directly at dream screen for testing
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LogoSplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(path: '/name', builder: (context, state) => const QuestionScreen()),
    GoRoute(
      path: '/questions',
      builder: (context, state) => const MutipleChoiceQuestionScreen(),
    ),
    GoRoute(
      path: '/dream',
      builder: (context, state) {
        final repository = DataRepository(
          FileStorage('lib/data/storage/file_storage.dart'),
        );
        final dreamService = DreamService(repository);

        // Get majorId from extra parameter if available
        final extra = state.extra;
        int majorId = 1; // Default value

        if (extra != null && extra is Dream) {
          majorId = extra.majorId;
        }

        return DreamDetail(majorId: majorId, dreamService: dreamService);
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final repository = DataRepository(
          FileStorage('lib/data/storage/file_storage.dart'),
        );
        final dreamService = DreamService(repository);
        return HomeScreen(dreamService: dreamService);
      },
    ),
  ],
);
