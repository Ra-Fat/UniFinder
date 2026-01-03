import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import './ui/app.dart';
import './data/storage/file_storage.dart';
import './data/storage/shared_preferences_storage.dart';
import './data/repository/question_repository.dart';
import './data/repository/dream_repository.dart';
import './data/repository/user_repository.dart';
import './service/question_service.dart';
import './service/user_service.dart';
import './service/dream_service.dart';

// Global service instances
late QuestionService questionService;
late UserService userService;
late DreamService dreamService;

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
    final dreamRepository = DreamRepository(storage, prefsStorage);
    dreamService = DreamService(dreamRepository);

  } else {
    // Get app directory for Android/iOS/Desktop
    final directory = await getApplicationDocumentsDirectory();
    final storage = FileStorage('${directory.path}/data');
    final questionRepository = QuestionRepository(storage, prefsStorage);
    questionService = QuestionService(questionRepository);

    final userRepository = UserRepository(prefsStorage);
    userService = UserService(userRepository);

    final dreamRepository = DreamRepository(storage, prefsStorage);
    dreamService = DreamService(dreamRepository);
  }

  runApp(const App());
}
