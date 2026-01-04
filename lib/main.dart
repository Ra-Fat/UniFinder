import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import './ui/app.dart';
import './data/storage/file_storage.dart';
import './data/storage/shared_preferences_storage.dart';
import './data/repository/question_repository.dart';
import './data/repository/dream_repository.dart';
import './data/repository/user_repository.dart';
import './data/repository/career_repository.dart';
import './data/repository/major_repository.dart';
import './data/repository/university_repository.dart';
import './data/repository/relationship_repository.dart';
import './service/question_service.dart';
import './service/user_service.dart';
import './service/dream_service.dart';
import './service/career_service.dart';
import './service/major_service.dart';
import './service/university_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create services
  late FileStorage fileStorage;
  late SharedPreferencesStorage prefsStorage;
  
  if (kIsWeb) {
    fileStorage = FileStorage('assets/data');
  } else {
    final directory = await getApplicationDocumentsDirectory();
    fileStorage = FileStorage('${directory.path}/data');
  }
  
  prefsStorage = SharedPreferencesStorage();

  // Create repositories
  final questionRepository = QuestionRepository(fileStorage, prefsStorage);
  final dreamRepository = DreamRepository(fileStorage, prefsStorage);
  final userRepository = UserRepository(prefsStorage);
  final careerRepository = CareerRepository(fileStorage);
  final majorRepository = MajorRepository(fileStorage);
  final universityRepository = UniversityRepository(fileStorage);
  final relationshipRepository = RelationshipRepository(fileStorage);

  // Create services
  final questionService = QuestionService(questionRepository);
  final userService = UserService(userRepository);
  final dreamService = DreamService(dreamRepository);
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

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: questionService),
        Provider.value(value: userService),
        Provider.value(value: dreamService),
        Provider.value(value: careerService),
        Provider.value(value: majorService),
        Provider.value(value: universityService),
      ],
      child: const App(),
    ),
  );
}
