import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/service/career_service.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late CareerService careerService;
  late MockCareerRepository mockCareerRepository;
  late MockRelationshipRepository mockRelationshipRepository;

  setUp(() {
    mockCareerRepository = MockCareerRepository();
    mockRelationshipRepository = MockRelationshipRepository();
    careerService = CareerService(
      mockCareerRepository,
      mockRelationshipRepository,
    );
  });

  group('CareerService', () {
    group('getCareersData', () {
      test('should return list of careers', () async {
        // Arrange
        when(
          mockCareerRepository.getCareerData(),
        ).thenAnswer((_) async => testCareers);

        // Act
        final result = await careerService.getCareersData();

        // Assert
        expect(result, equals(testCareers));
        verify(mockCareerRepository.getCareerData()).called(1);
      });

      test('should return empty list when no careers', () async {
        // Arrange
        when(mockCareerRepository.getCareerData()).thenAnswer((_) async => []);

        // Act
        final result = await careerService.getCareersData();

        // Assert
        expect(result, isEmpty);
        verify(mockCareerRepository.getCareerData()).called(1);
      });
    });

    group('getCareersForMajor', () {
      test('should return careers for specific major', () async {
        // Arrange
        final expectedCareers = [
          testCareers[0],
        ]; // Software Engineer for CS major
        when(
          mockCareerRepository.getCareerData(),
        ).thenAnswer((_) async => testCareers);
        when(
          mockRelationshipRepository.getCareersByMajor('cs', testCareers),
        ).thenAnswer((_) async => expectedCareers);

        // Act
        final result = await careerService.getCareersForMajor('cs');

        // Assert
        expect(result, equals(expectedCareers));
        verify(mockCareerRepository.getCareerData()).called(1);
        verify(
          mockRelationshipRepository.getCareersByMajor('cs', testCareers),
        ).called(1);
      });

      test('should return empty list when no careers for major', () async {
        // Arrange
        when(
          mockCareerRepository.getCareerData(),
        ).thenAnswer((_) async => testCareers);
        when(
          mockRelationshipRepository.getCareersByMajor(
            'nonexistent',
            testCareers,
          ),
        ).thenAnswer((_) async => []);

        // Act
        final result = await careerService.getCareersForMajor('nonexistent');

        // Assert
        expect(result, isEmpty);
        verify(mockCareerRepository.getCareerData()).called(1);
        verify(
          mockRelationshipRepository.getCareersByMajor(
            'nonexistent',
            testCareers,
          ),
        ).called(1);
      });
    });
  });
}
