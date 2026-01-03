import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/service/user_service.dart';
import 'package:uni_finder/service/career_service.dart';
import 'package:uni_finder/service/major_service.dart';
import 'package:uni_finder/service/university_service.dart';
import 'package:uni_finder/ui/screens/home/home_screen.dart';
import '../ui/screens/q&a/question_screen.dart';
import '../ui/screens/recommendation/recommendation.dart';
import '../ui/screens/utils/logo_splash_screen.dart';
import '../ui/screens/welcomes/welcome_screen.dart';
import '../ui/screens/q&a/mutiple_choice_question.dart';
import '../ui/screens/dream/dream_screen.dart';
import '../data/repository/dream_repository.dart';
import '../data/repository/user_repository.dart';
import '../data/repository/career_repository.dart';
import '../data/repository/major_repository.dart';
import '../data/repository/university_repository.dart';
import '../data/repository/relationship_repository.dart';
import '../data/storage/file_storage.dart';
import '../data/storage/shared_preferences_storage.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
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
        final fileStorage = FileStorage('assets/data');
        final prefsStorage = SharedPreferencesStorage();

        final dreamRepository = DreamRepository(fileStorage, prefsStorage);
        final careerRepository = CareerRepository(fileStorage);
        final majorRepository = MajorRepository(fileStorage);
        final universityRepository = UniversityRepository(fileStorage);
        final relationshipRepository = RelationshipRepository(fileStorage);

        final careerService = CareerService(
          careerRepository,
          relationshipRepository,
        );
        final majorService = MajorService(majorRepository);
        final universityService = UniversityService(
          universityRepository,
          relationshipRepository,
          majorRepository,
        );
        final dreamService = DreamService(dreamRepository);

        // Get majorId from extra parameter if available
        final extra = state.extra;
        int majorId = 1; // Default value

        if (extra != null && extra is Dream) {
          majorId = extra.majorId;
        }

        return DreamDetail(
          majorId: majorId,
          dreamService: dreamService,
          majorService: majorService,
          careerService: careerService,
          universityService: universityService,
        );
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final fileStorage = FileStorage('assets/data');
        final prefsStorage = SharedPreferencesStorage();

        final dreamRepository = DreamRepository(fileStorage, prefsStorage);
        final userRepository = UserRepository(prefsStorage);

        final userService = UserService(userRepository);
        final dreamService = DreamService(dreamRepository);
        return HomeScreen(dreamService: dreamService, userService: userService);
      },
    ),
    GoRoute(
      path: '/recommendation',
      builder: (context, state) => const Recommendation(),
    ),
  ],
);
