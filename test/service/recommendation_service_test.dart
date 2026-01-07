import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/service/recommendation_service.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late RecommendationService recommendationService;
  late MockQuestionRepository mockQuestionRepository;
  late MockMajorRepository mockMajorRepository;

  setUp(() {
    mockQuestionRepository = MockQuestionRepository();
    mockMajorRepository = MockMajorRepository();
    recommendationService = RecommendationService(
      mockQuestionRepository,
      mockMajorRepository,
    );
  });

  group('RecommendationService', () {
    group('generateRecommendations', () {
      test('should return recommendations when user has submissions', () async {
        // Arrange
        when(
          mockQuestionRepository.getSubmissionData(),
        ).thenAnswer((_) async => testSubmissions);
        when(
          mockQuestionRepository.getOptionData(),
        ).thenAnswer((_) async => testOptions);
        when(
          mockMajorRepository.getMajorsData(),
        ).thenAnswer((_) async => testMajors);

        // Act
        final result = await recommendationService.generateRecommendations(
          'user1',
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, lessThanOrEqualTo(5)); // Top 5 recommendations
        expect(result.first.matchScore, greaterThan(0));
        verify(mockQuestionRepository.getSubmissionData()).called(1);
        verify(mockQuestionRepository.getOptionData()).called(1);
        verify(mockMajorRepository.getMajorsData()).called(1);
      });

      test('should return empty list when user has no submissions', () async {
        // Arrange
        when(
          mockQuestionRepository.getSubmissionData(),
        ).thenAnswer((_) async => []);

        // Act
        final result = await recommendationService.generateRecommendations(
          'user1',
        );

        // Assert
        expect(result, isEmpty);
        verify(mockQuestionRepository.getSubmissionData()).called(1);
        verifyNever(mockQuestionRepository.getOptionData());
        verifyNever(mockMajorRepository.getMajorsData());
      });

      test(
        'should return empty list when user has no matching submissions',
        () async {
          // Arrange
          when(
            mockQuestionRepository.getSubmissionData(),
          ).thenAnswer((_) async => testSubmissions);

          // Act
          final result = await recommendationService.generateRecommendations(
            'nonexistent_user',
          );

          // Assert
          expect(result, isEmpty);
          verify(mockQuestionRepository.getSubmissionData()).called(1);
          verifyNever(mockQuestionRepository.getOptionData());
          verifyNever(mockMajorRepository.getMajorsData());
        },
      );
    });
  });
}
