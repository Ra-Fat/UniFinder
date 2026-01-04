import 'package:go_router/go_router.dart';
import 'package:uni_finder/Domain/model/Dream/dreams_model.dart';
import 'package:uni_finder/Domain/model/Career/career_model.dart';
import 'package:uni_finder/Domain/model/Major/major_model.dart';
import 'package:uni_finder/Domain/service/dream_service.dart';
import 'package:uni_finder/Domain/service/user_service.dart';
import 'package:uni_finder/Domain/service/career_service.dart';
import 'package:uni_finder/Domain/service/major_service.dart';
import 'package:uni_finder/Domain/service/university_service.dart';
import 'package:uni_finder/ui/screens/home/home_screen.dart';
import '../ui/screens/q&a/question_screen.dart';
import '../ui/screens/recommendation/recommendation.dart';
import '../ui/screens/utils/logo_splash_screen.dart';
import '../ui/screens/welcomes/welcome_screen.dart';
import '../ui/screens/q&a/mutiple_choice_question.dart';
import '../ui/screens/dream/dream_screen.dart';
import '../ui/screens/career/career_detail_screen.dart';
import '../Domain/data/repository/dream_repository.dart';
import '../Domain/data/repository/user_repository.dart';
import '../Domain/data/repository/career_repository.dart';
import '../Domain/data/repository/major_repository.dart';
import '../Domain/data/repository/university_repository.dart';
import '../Domain/data/repository/relationship_repository.dart';
import '../Domain/data/repository/question_repository.dart';
import '../Domain/data/storage/file_storage.dart';
import '../Domain/data/storage/shared_preferences_storage.dart';
import '../Domain/service/recommendation_service.dart';

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
      path: '/home',
      builder: (context, state) {
        final prefsStorage = SharedPreferencesStorage();

        final dreamRepository = DreamRepository(prefsStorage);
        final userRepository = UserRepository(prefsStorage);

        final userService = UserService(userRepository);
        final dreamService = DreamService(dreamRepository);
        return HomeScreen(dreamService: dreamService, userService: userService);
      },
      routes: [
        GoRoute(
          path: ':dreamId',
          builder: (context, state) {
            final fileStorage = FileStorage('assets/data');
            final prefsStorage = SharedPreferencesStorage();

            final dreamRepository = DreamRepository(prefsStorage);
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

            // Get dreamId from path parameter
            final dreamId = state.pathParameters['dreamId'] ?? '1';

            // Get majorId and dreamName from extra parameter if available
            final extra = state.extra;
            String majorId = dreamId;
            String? dreamName;

            if (extra != null && extra is Dream) {
              majorId = extra.majorId;
              dreamName = extra.title;
            }

            return DreamDetail(
              majorId: majorId,
              dreamName: dreamName,
              dreamService: dreamService,
              majorService: majorService,
              careerService: careerService,
              universityService: universityService,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/career',
      builder: (context, state) {
        final fileStorage = FileStorage('assets/data');
        final prefsStorage = SharedPreferencesStorage();

        final dreamRepository = DreamRepository(prefsStorage);
        final majorRepository = MajorRepository(fileStorage);
        final universityRepository = UniversityRepository(fileStorage);
        final relationshipRepository = RelationshipRepository(fileStorage);

        final dreamService = DreamService(dreamRepository);
        final majorService = MajorService(majorRepository);
        final universityService = UniversityService(
          universityRepository,
          relationshipRepository,
          majorRepository,
        );

        final extra = state.extra as Map<String, dynamic>;

        return CareerDetailScreen(
          career: extra['career'] as Career,
          major: extra['major'] as Major?,
          relatedMajors: extra['relatedMajors'] as List<Major>?,
          dreamService: dreamService,
          majorService: majorService,
          universityService: universityService,
        );
      },
    ),
    GoRoute(
      path: '/recommendation',
      builder: (context, state) {
        final fileStorage = FileStorage('assets/data');
        final prefsStorage = SharedPreferencesStorage();

        final questionRepository = QuestionRepository(
          fileStorage,
          prefsStorage,
        );
        final majorRepository = MajorRepository(fileStorage);
        final userRepository = UserRepository(prefsStorage);
        final dreamRepository = DreamRepository(prefsStorage);

        final recommendationService = RecommendationService(
          questionRepository,
          majorRepository,
        );
        final userService = UserService(userRepository);
        final dreamService = DreamService(dreamRepository);

        return Recommendation(
          recommendationService: recommendationService,
          userService: userService,
          dreamService: dreamService,
        );
      },
    ),
  ],
);
