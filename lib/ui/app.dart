import 'package:flutter/material.dart';
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
        scaffoldBackgroundColor: Color(0xFF0f172a),
      ),
      routerConfig: appRouter,
    );
  }
}
