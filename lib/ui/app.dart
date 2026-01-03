import 'package:flutter/material.dart';
// import './screens/welcomes/welcome_screen.dart';
// import '../ui/screens/q&a/question_screen.dart';
// import './screens/utils/logo_splash_screen.dart';
import '../routers/app_router.dart';
import './theme/app_colors.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: AppColors.darkBackground,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
      ),
      routerConfig: appRouter,
    );
  }
}