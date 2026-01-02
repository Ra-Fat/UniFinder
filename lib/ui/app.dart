import 'package:flutter/material.dart';
import 'package:uni_finder/ui/screens/dream/dream_screen.dart';
import 'screens/dream/Domain/mock_data.dart';
import 'screens/dream/Domain/Service/dream_service.dart';
// import './screens/welcomes/welcome_screen.dart';
// import '../ui/screens/q&a/question_screen.dart';
// import './screens/utils/logo_splash_screen.dart';
import '../routers/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color.fromARGB(255, 147, 229, 250),
        //   brightness: Brightness.dark,
        //   surface: const Color.fromARGB(255, 42, 51, 59),
        // ),
        scaffoldBackgroundColor: Color(0xFF0f172a),
      ),
      // home: LogoSplashScreen(),
      // home: HomeScreen(),
      home: DreamDetail(
        dream: dream,
        dreamService: DreamService(
          allCareers: careers,
          allUniversityMajors: universityMajors,
          allMajors: allMajors,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
