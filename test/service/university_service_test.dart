import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/service/university_service.dart';
import 'package:uni_finder/Domain/model/University/university_major.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late UniversityService universityService;
  late MockUniversityRepository mockUniversityRepository;
  late MockRelationshipRepository mockRelationshipRepository;
  late MockMajorRepository mockMajorRepository;

  setUp(() {
    mockUniversityRepository = MockUniversityRepository();
    mockRelationshipRepository = MockRelationshipRepository();
    mockMajorRepository = MockMajorRepository();

    universityService = UniversityService(
      mockUniversityRepository,
      mockRelationshipRepository,
      mockMajorRepository,
    );
  });

  group('UniversityService', () {
    group('getUniversitiesData', () {
      test('should return list of universities', () async {
        // Arrange
        when(
          mockUniversityRepository.getUniversitiesData(),
        ).thenAnswer((_) async => testUniversities);

        // Act
        final result = await universityService.getUniversitiesData();

        // Assert
        expect(result, equals(testUniversities));
        verify(mockUniversityRepository.getUniversitiesData()).called(1);
      });

      test('should return empty list when no universities', () async {
        // Arrange
        when(
          mockUniversityRepository.getUniversitiesData(),
        ).thenAnswer((_) async => []);

        // Act
        final result = await universityService.getUniversitiesData();

        // Assert
        expect(result, isEmpty);
        verify(mockUniversityRepository.getUniversitiesData()).called(1);
      });
    });

    group('getUniversityMajorsData', () {
      test('should return list of university-major relationships', () async {
        // Arrange
        when(
          mockRelationshipRepository.getUniversityMajorsData(),
        ).thenAnswer((_) async => testUniversityMajors);

        // Act
        final result = await universityService.getUniversityMajorsData();

        // Assert
        expect(result, equals(testUniversityMajors));
        verify(mockRelationshipRepository.getUniversityMajorsData()).called(1);
      });
    });

    group('getUniversitiesForMajor', () {
      test('should return universities offering specific major', () async {
        // Arrange
        when(
          mockRelationshipRepository.getUniversityMajorsData(),
        ).thenAnswer((_) async => testUniversityMajors);
        when(
          mockUniversityRepository.getUniversitiesData(),
        ).thenAnswer((_) async => testUniversities);

        // Act
        final result = await universityService.getUniversitiesForMajor('cs');

        // Assert
        expect(result.length, 2); // Both universities offer CS
        expect(result.map((u) => u.id), contains('1'));
        expect(result.map((u) => u.id), contains('2'));
        verify(mockRelationshipRepository.getUniversityMajorsData()).called(1);
        verify(mockUniversityRepository.getUniversitiesData()).called(1);
      });

      test('should return empty list when major not found', () async {
        // Arrange
        when(
          mockRelationshipRepository.getUniversityMajorsData(),
        ).thenAnswer((_) async => testUniversityMajors);
        when(
          mockUniversityRepository.getUniversitiesData(),
        ).thenAnswer((_) async => testUniversities);

        // Act
        final result = await universityService.getUniversitiesForMajor(
          'nonexistent',
        );

        // Assert
        expect(result, isEmpty);
      });

      test('should remove duplicate universities', () async {
        // Arrange - create data with duplicate university for same major
        final duplicateMajors = [
          ...testUniversityMajors,
          UniversityMajor(
            id: '4',
            universityId: '1', // Same university, different major relationship
            majorId: 'cs',
            pricePerYear: 1000,
            durationYears: 4,
            degree: 'Bachelor',
          ),
        ];

        when(
          mockRelationshipRepository.getUniversityMajorsData(),
        ).thenAnswer((_) async => duplicateMajors);
        when(
          mockUniversityRepository.getUniversitiesData(),
        ).thenAnswer((_) async => testUniversities);

        // Act
        final result = await universityService.getUniversitiesForMajor('cs');

        // Assert
        expect(result.length, 2); // Should still be 2, not 3 (no duplicates)
        expect(result.map((u) => u.id).toSet().length, 2);
      });
    });

    group('getUniversitiesForMajors', () {
      test(
        'should return detailed university-major info for multiple majors',
        () async {
          // Arrange
          when(
            mockRelationshipRepository.getUniversityMajorsData(),
          ).thenAnswer((_) async => testUniversityMajors);
          when(
            mockUniversityRepository.getUniversitiesData(),
          ).thenAnswer((_) async => testUniversities);
          when(
            mockMajorRepository.getMajorsData(),
          ).thenAnswer((_) async => testMajors);

          // Act
          final result = await universityService.getUniversitiesForMajors([
            'cs',
            'eng',
          ]);

          // Assert
          expect(result.length, 3); // All relationships for both majors
          expect(
            result.every((detail) => ['cs', 'eng'].contains(detail.major.id)),
            isTrue,
          );
          verify(
            mockRelationshipRepository.getUniversityMajorsData(),
          ).called(1);
          verify(mockUniversityRepository.getUniversitiesData()).called(1);
          verify(mockMajorRepository.getMajorsData()).called(1);
        },
      );

      test('should return empty list when majorIds is empty', () async {
        // Act
        final result = await universityService.getUniversitiesForMajors([]);

        // Assert
        expect(result, isEmpty);
        verifyNever(mockRelationshipRepository.getUniversityMajorsData());
        verifyNever(mockUniversityRepository.getUniversitiesData());
        verifyNever(mockMajorRepository.getMajorsData());
      });

      test('should throw exception when university not found', () async {
        // Arrange
        when(
          mockRelationshipRepository.getUniversityMajorsData(),
        ).thenAnswer((_) async => testUniversityMajors);
        when(
          mockUniversityRepository.getUniversitiesData(),
        ).thenAnswer((_) async => []); // Empty universities
        when(
          mockMajorRepository.getMajorsData(),
        ).thenAnswer((_) async => testMajors);

        // Act & Assert
        expect(
          () => universityService.getUniversitiesForMajors(['cs']),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('University not found'),
            ),
          ),
        );
      });

      test('should throw exception when major not found', () async {
        // Arrange
        when(
          mockRelationshipRepository.getUniversityMajorsData(),
        ).thenAnswer((_) async => testUniversityMajors);
        when(
          mockUniversityRepository.getUniversitiesData(),
        ).thenAnswer((_) async => testUniversities);
        when(
          mockMajorRepository.getMajorsData(),
        ).thenAnswer((_) async => []); // Empty majors

        // Act & Assert
        expect(
          () => universityService.getUniversitiesForMajors(['cs']),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Major not found'),
            ),
          ),
        );
      });
    });
  });
}
