import 'package:flutter/material.dart';
import 'package:uni_finder/ui/screens/dream-detail/dream_detail.dart';
import 'package:uni_finder/ui/screens/home/home_screen.dart';
import './screens/dream-detail/mock_data.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: DreamDetail(dream: dream, universityMajors: universityMajors,),
    );
  }
}