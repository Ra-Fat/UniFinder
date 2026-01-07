import 'package:uni_finder/Domain/data/repository/major_repository.dart';
import 'package:uni_finder/Domain/data/repository/question_repository.dart';
import 'package:uni_finder/Domain/model/Major/major_recommendation_model.dart';

class RecommendationService {
  final QuestionRepository _questionRepository;
  final MajorRepository _majorRepository;

  RecommendationService(this._questionRepository, this._majorRepository);

  Future<List<MajorRecommendation>> generateRecommendations(
    String userId,
  ) async {
    // Get user's quiz submissions
    final submissions = await _questionRepository.getSubmissionData();
    final userSubmission = submissions
        .where((s) => s.userId == userId)
        .toList();

    if (userSubmission.isEmpty) {
      return []; // No quiz taken
    }

    // Get the most recent answers
    final userAnswers = userSubmission.last.answers;

    // Load all options to access category and score data
    final allOptions = await _questionRepository.getOptionData();

    // Calculate total score per category
    final categoryScores = <String, int>{};

    for (final answer in userAnswers) {
      final selectedOption = allOptions.firstWhere(
        (opt) => opt.id == answer.selectedOptionId,
        orElse: () => throw Exception(
          'Option with id ${answer.selectedOptionId} not found',
        ),
      );

      final categoryId = selectedOption.categoryId;
      categoryScores[categoryId] =
          (categoryScores[categoryId] ?? 0) + selectedOption.score;
    }

    // Load all majors
    final allMajors = await _majorRepository.getMajorsData();

    // Calculate match percentage for each major
    final recommendations = <MajorRecommendation>[];
    final totalScore = categoryScores.values.fold<int>(
      0,
      (sum, score) => sum + score,
    );

    for (final major in allMajors) {
      final matchScore = _calculateMatchScore(
        major.categoryId,
        categoryScores,
        totalScore,
      );

      if (matchScore > 0) {
        recommendations.add(
          MajorRecommendation(
            major: major,
            matchScore: matchScore,
          ),
        );
      }
    }

    // Return top 5 matches sorted by score
    recommendations.sort((a, b) => b.matchScore.compareTo(a.matchScore));
    return recommendations.take(5).toList();
  }

  // Calculate match percentage
  double _calculateMatchScore(
    String majorCategoryId,
    Map<String, int> categoryScores,
    int totalScore,
  ) {
    final categoryScore = categoryScores[majorCategoryId] ?? 0;
    if (totalScore == 0) return 0;
    return (categoryScore / totalScore * 100).clamp(0, 100);
  }
}
