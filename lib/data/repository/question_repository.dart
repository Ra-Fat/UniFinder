import 'package:flutter/widgets.dart';

import '../storage/file_storage.dart';
import '../storage/shared_preferences_storage.dart';
import 'dart:convert';
import '../../model/category_model.dart';
import '../../model/question_model.dart';
import '../../model/option_model.dart';
import '../../model/submission_model.dart';
import '../../model/recommendation_model.dart';

class QuestionRepository {
  final FileStorage _fileStorage;
  final SharedPreferencesStorage _sharedPreferencesStorage;

  QuestionRepository(this._fileStorage, this._sharedPreferencesStorage);

  // get data from Categories
  Future<List<Category>> getCategories() async {
    try {
      final data = await _fileStorage.readJsonData('categories.json');
      return data
          .map((item) => Category.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading categories: $err');
      return [];
    }
  }

  // get Question data
  Future<List<Question>> getQuestionData() async {
    try {
      final data = await _fileStorage.readJsonData('questions.json');
      return data
          .map((item) => Question.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading Question: $err');
      return [];
    }
  }

  // get Option data
  Future<List<Option>> getOptionData() async {
    try {
      final data = await _fileStorage.readJsonData('options.json');
      return data
          .map((item) => Option.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading Option: $err');
      return [];
    }
  }

  // get option per question
  Future<Map<int, List<Option>>> getOptionsByQuestion() async {
    try {
      final data = await _fileStorage.readJsonData('options.json');
      final options = data
          .map((item) => Option.fromMap(item as Map<String, dynamic>))
          .toList();

      final Map<int, List<Option>> grouped = {};
      for (var option in options) {
        grouped.putIfAbsent(option.questionId, () => []).add(option);
      }
      return grouped;
    } catch (e) {
      debugPrint('Error loading options: $e');
      return {};
    }
  }

  // get Submission data
  Future<List<Submission>> getSubmissionData() async {
    try {
      final jsonString = await _sharedPreferencesStorage.getString(
        'submissions',
      );
      if (jsonString == null) return [];
      final data = jsonDecode(jsonString) as List;
      return data
          .map((item) => Submission.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading Submission: $err');
      return [];
    }
  }

  // save submission data
  Future<void> saveSubmission(Submission submit) async {
    try {
      final submissions = await getSubmissionData();
      submissions.add(submit);
      final jsonString = jsonEncode(
        submissions.map((sub) => sub.toMap()).toList(),
      );
      await _sharedPreferencesStorage.setString('submissions', jsonString);
    } catch (err) {
      debugPrint('Error saving submission: $err');
      rethrow;
    }
  }

  Future<List<Recommendation>> getRecommendations() async {
    try {
      final jsonString = await _sharedPreferencesStorage.getString(
        'recommendations',
      );
      if (jsonString == null) return [];
      final data = jsonDecode(jsonString) as List;
      return data
          .map((item) => Recommendation.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading recommendations: $err');
      return [];
    }
  }

  Future<void> saveRecommendation(Recommendation recommendation) async {
    try {
      final recommendations = await getRecommendations();
      recommendations.add(recommendation);
      final jsonString = jsonEncode(
        recommendations.map((r) => r.toMap()).toList(),
      );
      await _sharedPreferencesStorage.setString('recommendations', jsonString);
    } catch (err) {
      debugPrint('Error saving recommendation: $err');
      rethrow;
    }
  }
}
