import 'package:flutter/material.dart';
import '../ui/common/Theme/app_styles.dart';
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
        scaffoldBackgroundColor: AppColors.darkBackground,
      ),
      routerConfig: appRouter,
    );
  }
}
