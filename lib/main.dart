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
import './service/career_service.dart';
import './service/major_service.dart';
import './service/university_service.dart';
import 'package:uni_finder/service/recommendation_service.dart';
import 'package:uni_finder/Domain/data/repository/major_repository.dart';
import 'package:uni_finder/Domain/data/repository/career_repository.dart';
import 'package:uni_finder/Domain/data/repository/university_repository.dart';
import 'package:uni_finder/Domain/data/repository/relationship_repository.dart';

late QuestionService questionService;
late UserService userService;
late DreamService dreamService;
late CareerService careerService;
late MajorService majorService;
late UniversityService universityService;
late final RecommendationService recommendationService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefsStorage = SharedPreferencesStorage();

  final storagePath = kIsWeb
      ? ''
      : '${(await getApplicationDocumentsDirectory()).path}/data';
  final storage = FileStorage(storagePath);

  final questionRepository = QuestionRepository(storage, prefsStorage);
  questionService = QuestionService(questionRepository);

  final userRepository = UserRepository(prefsStorage);
  userService = UserService(userRepository);

  final dreamRepository = DreamRepository(prefsStorage);
  dreamService = DreamService(dreamRepository);

  final majorRepository = MajorRepository(storage);
  final careerRepository = CareerRepository(storage);
  final universityRepository = UniversityRepository(storage);
  final relationshipRepository = RelationshipRepository(storage);

  majorService = MajorService(majorRepository);
  careerService = CareerService(careerRepository, relationshipRepository);
  universityService = UniversityService(
    universityRepository,
    relationshipRepository,
    majorRepository,
  );
  recommendationService = RecommendationService(
    questionRepository,
    majorRepository,
  );

  runApp(const App());
}
