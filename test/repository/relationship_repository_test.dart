import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/Domain/data/repository/relationship_repository.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late RelationshipRepository relationshipRepository;
  late MockFileStorage mockFileStorage;

  setUp(() {
    mockFileStorage = MockFileStorage();
    relationshipRepository = RelationshipRepository(mockFileStorage);
  });

  group('RelationshipRepository', () {
    group('getCareerMajorsData', () {
      test('should return list of career majors when data is valid', () async {
        // Arrange
        final rawData = testCareerMajors.map((cm) => cm.toMap()).toList();
        when(
          mockFileStorage.readJsonData('career_majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await relationshipRepository.getCareerMajorsData();

        // Assert
        expect(result.length, 2);
        expect(result[0].careerId, 'career1');
        expect(result[0].majorId, 'cs');
        expect(result[1].careerId, 'career2');
        expect(result[1].majorId, 'eng');
        verify(mockFileStorage.readJsonData('career_majors.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('career_majors.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await relationshipRepository.getCareerMajorsData();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('career_majors.json')).called(1);
      });
    });

    group('getUniversityMajorsData', () {
      test(
        'should return list of university majors when data is valid',
        () async {
          // Arrange
          final rawData = testUniversityMajors.map((um) => um.toMap()).toList();
          when(
            mockFileStorage.readJsonData('university_majors.json'),
          ).thenAnswer((_) async => rawData);

          // Act
          final result = await relationshipRepository.getUniversityMajorsData();

          // Assert
          expect(result.length, 3);
          expect(result[0].universityId, '1');
          expect(result[0].majorId, 'cs');
          expect(result[1].universityId, '1');
          expect(result[1].majorId, 'eng');
          verify(
            mockFileStorage.readJsonData('university_majors.json'),
          ).called(1);
        },
      );

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('university_majors.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await relationshipRepository.getUniversityMajorsData();

        // Assert
        expect(result, isEmpty);
        verify(
          mockFileStorage.readJsonData('university_majors.json'),
        ).called(1);
      });
    });

    group('getCareersByMajor', () {
      test('should return careers for specific major', () async {
        // Arrange
        final rawData = testCareerMajors.map((cm) => cm.toMap()).toList();
        when(
          mockFileStorage.readJsonData('career_majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await relationshipRepository.getCareersByMajor(
          'cs',
          testCareers,
        );

        // Assert
        expect(result.length, 1);
        expect(result[0].id, 'career1');
        expect(result[0].name, 'Software Engineer');
        verify(mockFileStorage.readJsonData('career_majors.json')).called(1);
      });

      test('should return empty list when no careers for major', () async {
        // Arrange
        final rawData = testCareerMajors.map((cm) => cm.toMap()).toList();
        when(
          mockFileStorage.readJsonData('career_majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await relationshipRepository.getCareersByMajor(
          'nonexistent',
          testCareers,
        );

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('career_majors.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('career_majors.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await relationshipRepository.getCareersByMajor(
          'cs',
          testCareers,
        );

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('career_majors.json')).called(1);
      });
    });

    group('getUniversitiesForMajor', () {
      test('should return universities offering specific major', () async {
        // Arrange
        final rawData = testUniversityMajors.map((um) => um.toMap()).toList();
        when(
          mockFileStorage.readJsonData('university_majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await relationshipRepository.getUniversitiesForMajor(
          'cs',
        );

        // Assert
        expect(result.length, 2);
        expect(result[0].universityId, '1');
        expect(result[0].majorId, 'cs');
        expect(result[1].universityId, '2');
        expect(result[1].majorId, 'cs');
        verify(
          mockFileStorage.readJsonData('university_majors.json'),
        ).called(1);
      });

      test(
        'should return empty list when no universities offer major',
        () async {
          // Arrange
          final rawData = testUniversityMajors.map((um) => um.toMap()).toList();
          when(
            mockFileStorage.readJsonData('university_majors.json'),
          ).thenAnswer((_) async => rawData);

          // Act
          final result = await relationshipRepository.getUniversitiesForMajor(
            'nonexistent',
          );

          // Assert
          expect(result, isEmpty);
          verify(
            mockFileStorage.readJsonData('university_majors.json'),
          ).called(1);
        },
      );

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('university_majors.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await relationshipRepository.getUniversitiesForMajor(
          'cs',
        );

        // Assert
        expect(result, isEmpty);
        verify(
          mockFileStorage.readJsonData('university_majors.json'),
        ).called(1);
      });
    });
  });
}
