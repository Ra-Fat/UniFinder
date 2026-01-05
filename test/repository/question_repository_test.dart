import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/Domain/data/repository/question_repository.dart';
import 'package:uni_finder/Domain/model/Quiz/submission_model.dart';
import 'package:uni_finder/Domain/model/Quiz/answer_model.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late QuestionRepository questionRepository;
  late MockFileStorage mockFileStorage;
  late MockSharedPreferencesStorage mockSharedPreferencesStorage;

  setUp(() {
    mockFileStorage = MockFileStorage();
    mockSharedPreferencesStorage = MockSharedPreferencesStorage();
    questionRepository = QuestionRepository(
      mockFileStorage,
      mockSharedPreferencesStorage,
    );
  });

  group('QuestionRepository', () {
    group('getCategories', () {
      test('should return list of categories when data is valid', () async {
        // Arrange
        final rawData = testCategories.map((c) => c.toMap()).toList();
        when(
          mockFileStorage.readJsonData('categories.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await questionRepository.getCategories();

        // Assert
        expect(result.length, 2);
        expect(result[0].id, 'tech');
        expect(result[0].name, 'Technology');
        expect(result[1].id, 'business');
        expect(result[1].name, 'Business');
        verify(mockFileStorage.readJsonData('categories.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('categories.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await questionRepository.getCategories();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('categories.json')).called(1);
      });
    });

    group('getQuestionData', () {
      test('should return list of questions when data is valid', () async {
        // Arrange
        final rawData = testQuestions.map((q) => q.toMap()).toList();
        when(
          mockFileStorage.readJsonData('questions.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await questionRepository.getQuestionData();

        // Assert
        expect(result.length, 2);
        expect(result[0].id, 'q1');
        expect(result[0].text, 'What type of work environment do you prefer?');
        verify(mockFileStorage.readJsonData('questions.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('questions.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await questionRepository.getQuestionData();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('questions.json')).called(1);
      });
    });

    group('getOptionData', () {
      test('should return list of options when data is valid', () async {
        // Arrange
        final rawData = testOptions.map((o) => o.toMap()).toList();
        when(
          mockFileStorage.readJsonData('options.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await questionRepository.getOptionData();

        // Assert
        expect(result.length, 3);
        expect(result[0].id, 'o1');
        expect(result[0].questionId, 'q1');
        expect(result[0].categoryId, 'tech');
        expect(result[0].score, 10);
        verify(mockFileStorage.readJsonData('options.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('options.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await questionRepository.getOptionData();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('options.json')).called(1);
      });
    });

    group('getOptionsByQuestion', () {
      test('should return options grouped by question ID', () async {
        // Arrange
        final rawData = testOptions.map((o) => o.toMap()).toList();
        when(
          mockFileStorage.readJsonData('options.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await questionRepository.getOptionsByQuestion();

        // Assert
        expect(result.length, 2); // Two questions
        expect(result['q1']!.length, 2); // Two options for q1
        expect(result['q2']!.length, 1); // One option for q2
        expect(result['q1']![0].id, 'o1');
        expect(result['q1']![1].id, 'o2');
        expect(result['q2']![0].id, 'o3');
        verify(mockFileStorage.readJsonData('options.json')).called(1);
      });

      test('should return empty map when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('options.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await questionRepository.getOptionsByQuestion();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('options.json')).called(1);
      });
    });

    group('getSubmissionData', () {
      test('should return list of submissions when data exists', () async {
        // Arrange
        final jsonString =
            '''
        [
          {
            "id": "s1",
            "userId": "user1",
            "answers": [
              {"questionId": "q1", "selectedOptionId": "o1"},
              {"questionId": "q2", "selectedOptionId": "o3"}
            ],
            "completedAt": "${DateTime.now().toIso8601String()}"
          }
        ]
        ''';

        when(
          mockSharedPreferencesStorage.getString('submissions'),
        ).thenAnswer((_) async => jsonString);

        // Act
        final result = await questionRepository.getSubmissionData();

        // Assert
        expect(result.length, 1);
        expect(result[0].id, 's1');
        expect(result[0].userId, 'user1');
        expect(result[0].answers.length, 2);
        verify(mockSharedPreferencesStorage.getString('submissions')).called(1);
      });

      test('should return empty list when no submissions exist', () async {
        // Arrange
        when(
          mockSharedPreferencesStorage.getString('submissions'),
        ).thenAnswer((_) async => null);

        // Act
        final result = await questionRepository.getSubmissionData();

        // Assert
        expect(result, isEmpty);
        verify(mockSharedPreferencesStorage.getString('submissions')).called(1);
      });

      test(
        'should return empty list when shared preferences throws error',
        () async {
          // Arrange
          when(
            mockSharedPreferencesStorage.getString('submissions'),
          ).thenThrow(Exception('Storage error'));

          // Act
          final result = await questionRepository.getSubmissionData();

          // Assert
          expect(result, isEmpty);
          verify(
            mockSharedPreferencesStorage.getString('submissions'),
          ).called(1);
        },
      );
    });

    group('saveSubmission', () {
      test(
        'should save submission successfully when no existing submissions',
        () async {
          // Arrange
          final newSubmission = Submission(
            id: 's1',
            userId: 'user1',
            answers: [Answer(questionId: 'q1', selectedOptionId: 'o1')],
            completedAt: DateTime.now(),
          );

          when(
            mockSharedPreferencesStorage.getString('submissions'),
          ).thenAnswer((_) async => null);
          when(
            mockSharedPreferencesStorage.setString(any, any),
          ).thenAnswer((_) async => {});

          // Act
          await questionRepository.saveSubmission(newSubmission);

          // Assert
          verify(
            mockSharedPreferencesStorage.getString('submissions'),
          ).called(1);
          verify(
            mockSharedPreferencesStorage.setString('submissions', any),
          ).called(1);
        },
      );

      test('should append submission to existing submissions', () async {
        // Arrange
        final existingJson =
            '''
        [
          {
            "id": "s1",
            "userId": "user1",
            "answers": [{"questionId": "q1", "selectedOptionId": "o1"}],
            "completedAt": "${DateTime.now().toIso8601String()}"
          }
        ]
        ''';

        final newSubmission = Submission(
          id: 's2',
          userId: 'user2',
          answers: [Answer(questionId: 'q1', selectedOptionId: 'o2')],
          completedAt: DateTime.now(),
        );

        when(
          mockSharedPreferencesStorage.getString('submissions'),
        ).thenAnswer((_) async => existingJson);
        when(
          mockSharedPreferencesStorage.setString(any, any),
        ).thenAnswer((_) async => {});

        // Act
        await questionRepository.saveSubmission(newSubmission);

        // Assert
        verify(mockSharedPreferencesStorage.getString('submissions')).called(1);
        verify(
          mockSharedPreferencesStorage.setString('submissions', any),
        ).called(1);
      });
    });
  });
}
