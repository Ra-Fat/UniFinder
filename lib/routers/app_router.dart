import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/model/career_model.dart';
import 'package:uni_finder/model/major_model.dart';
import 'package:uni_finder/model/university_model.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
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
import '../ui/screens/career/career_detail_screen.dart';
import '../ui/screens/university/university_screen.dart';
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
      routes: [
        GoRoute(
          path: ':dreamId',
          builder: (context, state) {
            final fileStorage = FileStorage('assets/data');
            final prefsStorage = SharedPreferencesStorage();

            final dreamRepository = DreamRepository(fileStorage, prefsStorage);
            final careerRepository = CareerRepository(fileStorage);
            final majorRepository = MajorRepository(fileStorage);
            final universityRepository = UniversityRepository(fileStorage);
            final relationshipRepository = RelationshipRepository(fileStorage);

            final dreamService = DreamService(dreamRepository);
            final majorService = MajorService(majorRepository);
            final careerService = CareerService(
              careerRepository,
              relationshipRepository,
            );
            final universityService = UniversityService(
              universityRepository,
              relationshipRepository,
              majorRepository,
            );

            final dreamId = state.pathParameters['dreamId']!;
            final extra = state.extra;

            // If dream object passed via extra,
            if (extra != null && extra is Dream) {
              return DreamDetail(
                majorId: extra.majorId,
                dreamName: extra.title,
                dreamService: dreamService,
                majorService: majorService,
                careerService: careerService,
                universityService: universityService,
              );
            }

            // Otherwise fetch by ID (slower, for refresh/direct URL access)
            return FutureBuilder<Dream?>(
              future: dreamService.getDreamById(dreamId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                final dream = snapshot.data;
                String majorId = dream?.majorId ?? '1';
                String? dreamName = dream?.title;

                return DreamDetail(
                  majorId: majorId,
                  dreamName: dreamName,
                  dreamService: dreamService,
                  majorService: majorService,
                  careerService: careerService,
                  universityService: universityService,
                );
              },
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

        final dreamRepository = DreamRepository(fileStorage, prefsStorage);
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
      path: '/university',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        
        return UniversityScreen(
          university: extra['university'] as University,
          availableMajors: extra['availableMajors'] as List<UniversityMajorDetail>,
        );
      },
    ),
    GoRoute(
      path: '/recommendation',
      builder: (context, state) => const Recommendation(),
    ),
  ],
);
