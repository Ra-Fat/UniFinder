import '../data/repository/question_repository.dart';
import '../model/Category/category_model.dart';
import '../model/Quiz/question_model.dart';
import '../model/Quiz/option_model.dart';
import '../model/Quiz/submission_model.dart';

class QuestionService {
  final QuestionRepository _questionRepository;

  QuestionService(this._questionRepository);

  // Get all categories
  Future<List<Category>> getCategories() async {
    return await _questionRepository.getCategories();
  }

  // Get all questions
  Future<List<Question>> getQuestionData() async {
    return await _questionRepository.getQuestionData();
  }

  // Get all options
  Future<List<Option>> getOptionData() async {
    return await _questionRepository.getOptionData();
  }

  // Get options grouped by question
  Future<Map<String, List<Option>>> getOptionsByQuestion() async {
    return await _questionRepository.getOptionsByQuestion();
  }

  // Get submissions
  Future<List<Submission>> getSubmissionData() async {
    return await _questionRepository.getSubmissionData();
  }

  // Save submission
  Future<void> saveSubmission(Submission submit) async {
    return await _questionRepository.saveSubmission(submit);
  }
}
