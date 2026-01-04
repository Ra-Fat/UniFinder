import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import './ui/app.dart';
import 'Domain/data/storage/file_storage.dart';
import 'Domain/data/storage/shared_preferences_storage.dart';
import 'Domain/data/repository/question_repository.dart';
import 'Domain/data/repository/dream_repository.dart';
import 'Domain/data/repository/user_repository.dart';
import './service/question_service.dart';
import './service/user_service.dart';
import './service/dream_service.dart';
import 'package:uni_finder/service/recommendation_service.dart';
import 'package:uni_finder/Domain/data/repository/major_repository.dart';

// Global service instances
late QuestionService questionService;
late UserService userService;
late DreamService dreamService;
late final RecommendationService recommendationService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefsStorage = SharedPreferencesStorage();
  // Initialize services
  if (kIsWeb) {
    final storage = FileStorage('');

    // question repo
    final questionRepository = QuestionRepository(storage, prefsStorage);
    questionService = QuestionService(questionRepository);

    // user repo
    final userRepository = UserRepository(prefsStorage);
    userService = UserService(userRepository);

    // dream repo
    final dreamRepository = DreamRepository(prefsStorage);
    dreamService = DreamService(dreamRepository);
  } else {
    // Get app directory for Android/iOS/Desktop
    final directory = await getApplicationDocumentsDirectory();
    final storage = FileStorage('${directory.path}/data');
    final questionRepository = QuestionRepository(storage, prefsStorage);
    questionService = QuestionService(questionRepository);

    final userRepository = UserRepository(prefsStorage);
    userService = UserService(userRepository);

    final dreamRepository = DreamRepository(prefsStorage);
    dreamService = DreamService(dreamRepository);

    final majorRepository = MajorRepository(storage);
    recommendationService = RecommendationService(
      questionRepository,
      majorRepository,
    );
  }

  runApp(const App());
}
