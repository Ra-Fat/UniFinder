import 'package:mockito/annotations.dart';
import 'package:uni_finder/Domain/data/repository/university_repository.dart';
import 'package:uni_finder/Domain/data/repository/relationship_repository.dart';
import 'package:uni_finder/Domain/data/repository/major_repository.dart';
import 'package:uni_finder/Domain/data/repository/dream_repository.dart';
import 'package:uni_finder/Domain/data/repository/question_repository.dart';
import 'package:uni_finder/Domain/data/repository/user_repository.dart';
import 'package:uni_finder/Domain/data/repository/career_repository.dart';
import 'package:uni_finder/Domain/data/storage/shared_preferences_storage.dart';
import 'package:uni_finder/Domain/data/storage/file_storage.dart';

// Generate mocks for all repositories and storage classes
@GenerateMocks([
  UniversityRepository,
  RelationshipRepository,
  MajorRepository,
  DreamRepository,
  QuestionRepository,
  UserRepository,
  CareerRepository,
  SharedPreferencesStorage,
  FileStorage,
])
void main() {}
