import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart' as globals;

// Models
import 'package:uni_finder/Domain/model/Dream/dreams_model.dart';
import 'package:uni_finder/Domain/model/Career/career_model.dart';
import 'package:uni_finder/Domain/model/Major/major_model.dart';
import 'package:uni_finder/Domain/model/University/university_model.dart';
import 'package:uni_finder/Domain/model/University/universityMajorDetail.dart';

// Screens
import 'package:uni_finder/ui/screens/home/home_screen.dart';
import '../ui/screens/q&a/question_screen.dart';
import '../ui/screens/recommendation/recommendation.dart';
import '../ui/screens/utils/logo_splash_screen.dart';
import '../ui/screens/welcomes/welcome_screen.dart';
import '../ui/screens/q&a/mutiple_choice_question.dart';
import '../ui/screens/dream/dream_screen.dart';
import '../ui/screens/career/career_detail_screen.dart';
import '../ui/screens/university/university_screen.dart';

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
        return HomeScreen(
          dreamService: globals.dreamService,
          userService: globals.userService,
        );
      },
      routes: [
        GoRoute(
          path: ':dreamId',
          builder: (context, state) {
            final dreamId = state.pathParameters['dreamId']!;
            final extra = state.extra;

            // If dream object passed via extra,
            if (extra != null && extra is Dream) {
              return DreamDetail(
                majorId: extra.majorId,
                dream: extra,
                dreamService: globals.dreamService,
                majorService: globals.majorService,
                careerService: globals.careerService,
                universityService: globals.universityService,
              );
            }

            // Otherwise fetch by ID
            return FutureBuilder<Dream?>(
              future: globals.dreamService.getDreamById(dreamId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                final dream = snapshot.data;

                if (dream == null) {
                  return const Scaffold(
                    body: Center(child: Text('Dream not found')),
                  );
                }

                return DreamDetail(
                  majorId: dream.majorId,
                  dream: dream,
                  dreamService: globals.dreamService,
                  majorService: globals.majorService,
                  careerService: globals.careerService,
                  universityService: globals.universityService,
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
        final extra = state.extra as Map<String, dynamic>;

        return CareerDetailScreen(
          career: extra['career'] as Career,
          major: extra['major'] as Major?,
          relatedMajors: extra['relatedMajors'] as List<Major>?,
          dreamService: globals.dreamService,
          majorService: globals.majorService,
          universityService: globals.universityService,
        );
      },
    ),
    GoRoute(
      path: '/university',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return UniversityScreen(
          university: extra['university'] as University,
          availableMajors:
              extra['availableMajors'] as List<UniversityMajorDetail>,
        );
      },
    ),
    GoRoute(
      path: '/recommendation',
      builder: (context, state) {
        return Recommendation(
          recommendationService: globals.recommendationService,
          userService: globals.userService,
          dreamService: globals.dreamService,
        );
      },
    ),
  ],
);
