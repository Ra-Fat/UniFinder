import '../storage/file_storage.dart';
// import '../../model/university_major.dart';
// import '../../model/answer_model.dart';
// import '../../model/career_major.dart';
import '../../model/career_model.dart';
import '../../model/category_model.dart';
// import '../../model/dreams_model.dart';
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
  Future<List<University>> getUniversitiesData() async{
    try{
      final data = await _storage.readJsonData('universities.json');
      return data.map((item)=> University.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading universities: $err');
      return[];
    }
  }

  // get data from Categories
  Future<List<Category>> getCategories() async{
    try{
      final data = await _storage.readJsonData('categories.json');
      return data.map((item)=> Category.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading categories: $err');
      return[];
    }
  }

  // get option per question
  Future<Map<int, List<Option>>> getOptionsByQuestion() async {
    try {
      final data = await _storage.readJsonData('options.json');
      final options = data.map((item) => Option.fromMap(item as Map<String, dynamic>)).toList();
      
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
  Future<List<Major>> getMajorsData() async{
    try{
      final data = await _storage.readJsonData('majors.json');
      return data.map((item)=> Major.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading Majors: $err');
      return[];
    }
  }

  // get Careers data
  Future<List<Career>> getCareerData() async{
    try{
      final data = await _storage.readJsonData('careers.json');
      return data.map((item)=> Career.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading Careers: $err');
      return[];
    }
  }

  // get Category data
  Future<List<Category>> getCategoryData() async{
    try{
      final data = await _storage.readJsonData('categories.json');
      return data.map((item)=> Category.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading Category: $err');
      return[];
    }
  }

  // get Question data
  Future<List<Question>> getQuestionData() async{
    try{
      final data = await _storage.readJsonData('questions.json');
      return data.map((item)=> Question.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading Question: $err');
      return[];
    }
  }

  // get Option data
  Future<List<Option>> getOptionData() async{
    try{
      final data = await _storage.readJsonData('options.json');
      return data.map((item)=> Option.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading Option: $err');
      return[];
    }
  }

  // get User data
  Future<List<User>> getUserData() async{
    try{
      final data = await _storage.readJsonData('user.json');
      return data.map((item)=> User.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading User: $err');
      return[];
    }
  }

  // save user data 
  Future<void> saveUser(User user) async{
    try{
      final users = await getUserData();
      users.add(user);
      final jsonList = users.map((user)=> user.toMap()).toList();
      await _storage.writeJson('user.json', jsonList);
    }catch(err){
      print('Error saving user: $err');
      rethrow;
    }
  }

  // get Submission data
  Future<List<Submission>> getSubmissionData() async{
    try{
      final data = await _storage.readJsonData('submission.json');
      return data.map((item)=> Submission.fromMap(item as Map<String, dynamic>)).toList();
    }catch(err){
      print('Error loading Submission: $err');
      return[];
    }
  }

  // save submission data 
  Future<void> saveSubmission(Submission submit) async{
    try{
      final submissions = await getSubmissionData();
      submissions.add(submit);
      final jsonList = submissions.map((sub)=> sub.toMap()).toList();
      await _storage.writeJson('submission.json', jsonList);
    }catch(err){
      print('Error saving submission: $err');
      rethrow;
    }
  }

  Future<List<Recommendation>> getRecommendations() async {
    try {
      final data = await _storage.readJsonData('recommendations.json');
      return data.map((item) => Recommendation.fromMap(item as Map<String, dynamic>)).toList();
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
}
