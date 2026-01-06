import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/service/question_service.dart';
import 'package:uni_finder/Domain/model/Quiz/submission_model.dart';
import 'package:uni_finder/Domain/model/Quiz/answer_model.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late QuestionService questionService;
  late MockQuestionRepository mockQuestionRepository;

  setUp(() {
    mockQuestionRepository = MockQuestionRepository();
    questionService = QuestionService(mockQuestionRepository);
  });

  group('QuestionService', () {
    group('getCategories', () {
      test('should return list of categories', () async {
        // Arrange
        when(
          mockQuestionRepository.getCategories(),
        ).thenAnswer((_) async => testCategories);

        // Act
        final result = await questionService.getCategories();

        // Assert
        expect(result, equals(testCategories));
        verify(mockQuestionRepository.getCategories()).called(1);
      });

      test('should return empty list when no categories', () async {
        // Arrange
        when(
          mockQuestionRepository.getCategories(),
        ).thenAnswer((_) async => []);

        // Act
        final result = await questionService.getCategories();

        // Assert
        expect(result, isEmpty);
        verify(mockQuestionRepository.getCategories()).called(1);
      });
    });

    group('getQuestionData', () {
      test('should return list of questions', () async {
        // Arrange
        when(
          mockQuestionRepository.getQuestionData(),
        ).thenAnswer((_) async => testQuestions);

        // Act
        final result = await questionService.getQuestionData();

        // Assert
        expect(result, equals(testQuestions));
        verify(mockQuestionRepository.getQuestionData()).called(1);
      });

      test('should return empty list when no questions', () async {
        // Arrange
        when(
          mockQuestionRepository.getQuestionData(),
        ).thenAnswer((_) async => []);

        // Act
        final result = await questionService.getQuestionData();

        // Assert
        expect(result, isEmpty);
        verify(mockQuestionRepository.getQuestionData()).called(1);
      });
    });

    group('getOptionData', () {
      test('should return list of options', () async {
        // Arrange
        when(
          mockQuestionRepository.getOptionData(),
        ).thenAnswer((_) async => testOptions);

        // Act
        final result = await questionService.getOptionData();

        // Assert
        expect(result, equals(testOptions));
        verify(mockQuestionRepository.getOptionData()).called(1);
      });

      test('should return empty list when no options', () async {
        // Arrange
        when(
          mockQuestionRepository.getOptionData(),
        ).thenAnswer((_) async => []);

        // Act
        final result = await questionService.getOptionData();

        // Assert
        expect(result, isEmpty);
        verify(mockQuestionRepository.getOptionData()).called(1);
      });
    });

    group('getOptionsByQuestion', () {
      test('should return options grouped by question', () async {
        // Arrange
        final groupedOptions = {
          'q1': [testOptions[0], testOptions[1]],
          'q2': [testOptions[2]],
        };

        when(
          mockQuestionRepository.getOptionsByQuestion(),
        ).thenAnswer((_) async => groupedOptions);

        // Act
        final result = await questionService.getOptionsByQuestion();

        // Assert
        expect(result, equals(groupedOptions));
        verify(mockQuestionRepository.getOptionsByQuestion()).called(1);
      });

      test('should return empty map when no options', () async {
        // Arrange
        when(
          mockQuestionRepository.getOptionsByQuestion(),
        ).thenAnswer((_) async => {});

        // Act
        final result = await questionService.getOptionsByQuestion();

        // Assert
        expect(result, isEmpty);
        verify(mockQuestionRepository.getOptionsByQuestion()).called(1);
      });
    });

    group('getSubmissionData', () {
      test('should return list of submissions', () async {
        // Arrange
        when(
          mockQuestionRepository.getSubmissionData(),
        ).thenAnswer((_) async => testSubmissions);

        // Act
        final result = await questionService.getSubmissionData();

        // Assert
        expect(result, equals(testSubmissions));
        verify(mockQuestionRepository.getSubmissionData()).called(1);
      });

      test('should return empty list when no submissions', () async {
        // Arrange
        when(
          mockQuestionRepository.getSubmissionData(),
        ).thenAnswer((_) async => []);

        // Act
        final result = await questionService.getSubmissionData();

        // Assert
        expect(result, isEmpty);
        verify(mockQuestionRepository.getSubmissionData()).called(1);
      });
    });

    group('saveSubmission', () {
      test('should save submission successfully', () async {
        // Arrange
        final submission = Submission(
          id: 's1',
          userId: 'user1',
          answers: [Answer(questionId: 'q1', selectedOptionId: 'o1')],
          completedAt: DateTime.now(),
        );

        when(
          mockQuestionRepository.saveSubmission(submission),
        ).thenAnswer((_) async => {});

        // Act
        await questionService.saveSubmission(submission);

        // Assert
        verify(mockQuestionRepository.saveSubmission(submission)).called(1);
      });

      test('should handle repository errors gracefully', () async {
        // Arrange
        final submission = Submission(
          id: 's1',
          userId: 'user1',
          answers: [],
          completedAt: DateTime.now(),
        );

        when(
          mockQuestionRepository.saveSubmission(submission),
        ).thenThrow(Exception('Save failed'));

        // Act & Assert
        expect(
          () => questionService.saveSubmission(submission),
          throwsA(isA<Exception>()),
        );
        verify(mockQuestionRepository.saveSubmission(submission)).called(1);
      });
    });

    group('Integration scenarios', () {
      test('should handle complete quiz workflow', () async {
        // Arrange
        final groupedOptions = {
          'q1': [testOptions[0], testOptions[1]],
          'q2': [testOptions[2]],
        };

        final submission = Submission(
          id: 's1',
          userId: 'user1',
          answers: [
            Answer(questionId: 'q1', selectedOptionId: 'o1'),
            Answer(questionId: 'q2', selectedOptionId: 'o3'),
          ],
          completedAt: DateTime.now(),
        );

        when(
          mockQuestionRepository.getCategories(),
        ).thenAnswer((_) async => testCategories);
        when(
          mockQuestionRepository.getQuestionData(),
        ).thenAnswer((_) async => testQuestions);
        when(
          mockQuestionRepository.getOptionsByQuestion(),
        ).thenAnswer((_) async => groupedOptions);
        when(
          mockQuestionRepository.saveSubmission(submission),
        ).thenAnswer((_) async => {});
        when(
          mockQuestionRepository.getSubmissionData(),
        ).thenAnswer((_) async => [submission]);

        // Act
        final categories = await questionService.getCategories();
        final questions = await questionService.getQuestionData();
        final options = await questionService.getOptionsByQuestion();
        await questionService.saveSubmission(submission);
        final submissions = await questionService.getSubmissionData();

        // Assert
        expect(categories.length, 2);
        expect(questions.length, 2);
        expect(options.length, 2);
        expect(submissions.length, 1);
        expect(submissions[0].answers.length, 2);

        verify(mockQuestionRepository.getCategories()).called(1);
        verify(mockQuestionRepository.getQuestionData()).called(1);
        verify(mockQuestionRepository.getOptionsByQuestion()).called(1);
        verify(mockQuestionRepository.saveSubmission(submission)).called(1);
        verify(mockQuestionRepository.getSubmissionData()).called(1);
      });
    });
  });
}
