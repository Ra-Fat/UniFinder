import '../storage/file_storage.dart';
import '../../model/university_major.dart';
import '../../model/career_major.dart';
import '../../model/career_model.dart';
import '../../model/category_model.dart';
import '../../model/dreams_model.dart';
import '../../model/major_model.dart';
import '../../model/option_model.dart';
import '../../model/question_model.dart';
import '../../model/recommendation_model.dart';
import '../../model/submission_model.dart';
import '../../model/university_model.dart';
import '../../model/user_model.dart';

class DataRepository {
  final FileStorage _storage;

  DataRepository(this._storage);

  // get data from universities
  Future<List<University>> getUniversitiesData() async {
    try {
      final data = await _storage.readJsonData('universities.json');
      return data
          .map((item) => University.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading universities: $err');
      return [];
    }
  }

  // get dreams data
  Future<List<Dream>> getDreams() async {
    try {
      final data = await _storage.readJsonData('dreams.json');
      return data
          .map((item) => Dream.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading dreams: $err');
      return [];
    }
  }

  // get users data
  Future<List<User>> getUsers() async {
    try {
      final data = await _storage.readJsonData('users.json');
      return data
          .map((item) => User.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading users: $err');
      return [];
    }
  }

  // get single user (for offline app with one user)
  Future<User?> getUser() async {
    try {
      final data = await _storage.readJsonData('users.json');
      if (data.isNotEmpty) {
        return User.fromMap(data.first as Map<String, dynamic>);
      }
      return null;
    } catch (err) {
      print('Error loading user: $err');
      return null;
    }
  }

  // get data from Categories
  Future<List<Category>> getCategories() async {
    try {
      final data = await _storage.readJsonData('categories.json');
      return data
          .map((item) => Category.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading categories: $err');
      return [];
    }
  }

  // get option per question
  Future<Map<int, List<Option>>> getOptionsByQuestion() async {
    try {
      final data = await _storage.readJsonData('options.json');
      final options = data
          .map((item) => Option.fromMap(item as Map<String, dynamic>))
          .toList();

      final Map<int, List<Option>> grouped = {};
      for (var option in options) {
        grouped.putIfAbsent(option.questionId, () => []).add(option);
      }
      return grouped;
    } catch (e) {
      print('Error loading options: $e');
      return {};
    }
  }

  // get Major data
  Future<List<Major>> getMajorsData() async {
    try {
      final data = await _storage.readJsonData('majors.json');
      return data
          .map((item) => Major.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading Majors: $err');
      return [];
    }
  }

  // get Careers data
  Future<List<Career>> getCareerData() async {
    try {
      final data = await _storage.readJsonData('careers.json');
      return data
          .map((item) => Career.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading Careers: $err');
      return [];
    }
  }

  // get Category data
  Future<List<Category>> getCategoryData() async {
    try {
      final data = await _storage.readJsonData('categories.json');
      return data
          .map((item) => Category.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading Category: $err');
      return [];
    }
  }

  // get Question data
  Future<List<Question>> getQuestionData() async {
    try {
      final data = await _storage.readJsonData('questions.json');
      return data
          .map((item) => Question.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading Question: $err');
      return [];
    }
  }

  // get Option data
  Future<List<Option>> getOptionData() async {
    try {
      final data = await _storage.readJsonData('options.json');
      return data
          .map((item) => Option.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading Option: $err');
      return [];
    }
  }

  // get User data
  Future<List<User>> getUserData() async {
    try {
      final data = await _storage.readJsonData('user.json');
      return data
          .map((item) => User.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading User: $err');
      return [];
    }
  }

  // save user data
  Future<void> saveUser(User user) async {
    try {
      final users = await getUserData();
      users.add(user);
      final jsonList = users.map((user) => user.toMap()).toList();
      await _storage.writeJson('user.json', jsonList);
    } catch (err) {
      print('Error saving user: $err');
      rethrow;
    }
  }

  // get Submission data
  Future<List<Submission>> getSubmissionData() async {
    try {
      final data = await _storage.readJsonData('submission.json');
      return data
          .map((item) => Submission.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading Submission: $err');
      return [];
    }
  }

  // save submission data
  Future<void> saveSubmission(Submission submit) async {
    try {
      final submissions = await getSubmissionData();
      submissions.add(submit);
      final jsonList = submissions.map((sub) => sub.toMap()).toList();
      await _storage.writeJson('submission.json', jsonList);
    } catch (err) {
      print('Error saving submission: $err');
      rethrow;
    }
  }

  Future<List<Recommendation>> getRecommendations() async {
    try {
      final data = await _storage.readJsonData('recommendations.json');
      return data
          .map((item) => Recommendation.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading recommendations: $err');
      return [];
    }
  }

  Future<void> saveRecommendation(Recommendation recommendation) async {
    try {
      final recommendations = await getRecommendations();
      recommendations.add(recommendation);
      final jsonList = recommendations.map((r) => r.toMap()).toList();
      await _storage.writeJson('recommendations.json', jsonList);
    } catch (err) {
      print('Error saving recommendation: $err');
      rethrow;
    }
  }

  // get CareerMajor relationships
  Future<List<CareerMajor>> getCareerMajorsData() async {
    try {
      final data = await _storage.readJsonData('career_majors.json');
      return data
          .map((item) => CareerMajor.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading career majors: $err');
      return [];
    }
  }

  // get UniversityMajor data
  Future<List<UniversityMajor>> getUniversityMajorsData() async {
    try {
      final data = await _storage.readJsonData('university_majors.json');
      return data
          .map((item) => UniversityMajor.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      print('Error loading university majors: $err');
      return [];
    }
  }

  // get Major relationships
  Future<Map<int, List<int>>> getMajorRelationships() async {
    try {
      final data = await _storage.readJsonData('major_relationships.json');
      final Map<int, List<int>> relationships = {};

      for (var item in data) {
        final majorId = item['major_id'] as int;
        final relatedMajorId = item['related_major_id'] as int;

        relationships.putIfAbsent(majorId, () => []).add(relatedMajorId);
      }

      return relationships;
    } catch (err) {
      print('Error loading major relationships: $err');
      return {};
    }
  }

  // Get careers by major ID
  Future<List<Career>> getCareersByMajor(int majorId) async {
    try {
      final careerMajors = await getCareerMajorsData();
      final careers = await getCareerData();

      final careerIds = careerMajors
          .where((cm) => cm.majorId == majorId)
          .map((cm) => cm.careerId)
          .toSet();

      return careers.where((c) => careerIds.contains(c.id)).toList();
    } catch (err) {
      print('Error getting careers by major: $err');
      return [];
    }
  }

  // Get universities offering a specific major
  Future<List<UniversityMajor>> getUniversitiesForMajor(int majorId) async {
    try {
      final universityMajors = await getUniversityMajorsData();
      return universityMajors.where((um) => um.majorId == majorId).toList();
    } catch (err) {
      print('Error getting universities for major: $err');
      return [];
    }
  }

  // Get related majors for a given major
  Future<List<Major>> getRelatedMajors(int majorId) async {
    try {
      final relationships = await getMajorRelationships();
      final majors = await getMajorsData();

      final relatedIds = relationships[majorId] ?? [];
      return majors.where((m) => relatedIds.contains(m.id)).toList();
    } catch (err) {
      print('Error getting related majors: $err');
      return [];
    }
  }

  //Get major by ID
  Future<Major?> getMajorById(int majorId) async {
    try {
      final majors = await getMajorsData();
      return majors.firstWhere(
        (m) => m.id == majorId,
        orElse: () => throw Exception('Major not found: $majorId'),
      );
    } catch (err) {
      print('Error getting major by ID: $err');
      return null;
    }
  }

  //Get career by ID
  Future<Career?> getCareerById(int careerId) async {
    try {
      final careers = await getCareerData();
      return careers.firstWhere(
        (c) => c.id == careerId,
        orElse: () => throw Exception('Career not found: $careerId'),
      );
    } catch (err) {
      print('Error getting career by ID: $err');
      return null;
    }
  }

  //Get university by ID
  Future<University?> getUniversityById(int universityId) async {
    try {
      final universities = await getUniversitiesData();
      return universities.firstWhere(
        (u) => u.id == universityId,
        orElse: () => throw Exception('University not found: $universityId'),
      );
    } catch (err) {
      print('Error getting university by ID: $err');
      return null;
    }
  }

  //Get majors by IDs (batch operation)
  Future<List<Major>> getMajorsByIds(List<int> majorIds) async {
    try {
      final majors = await getMajorsData();
      return majors.where((m) => majorIds.contains(m.id)).toList();
    } catch (err) {
      print('Error getting majors by IDs: $err');
      return [];
    }
  }

  //Search careers by name
  Future<List<Career>> searchCareers(String query) async {
    try {
      final careers = await getCareerData();
      return careers
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (err) {
      print('Error searching careers: $err');
      return [];
    }
  }

  //Search majors by name
  Future<List<Major>> searchMajors(String query) async {
    try {
      final majors = await getMajorsData();
      return majors
          .where((m) => m.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (err) {
      print('Error searching majors: $err');
      return [];
    }
  }

  //Search universities by name
  Future<List<University>> searchUniversities(String query) async {
    try {
      final universities = await getUniversitiesData();
      return universities
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (err) {
      print('Error searching universities: $err');
      return [];
    }
  }
}
