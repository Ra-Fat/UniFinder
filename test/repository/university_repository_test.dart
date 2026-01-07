import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/Domain/data/repository/university_repository.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late UniversityRepository universityRepository;
  late MockFileStorage mockFileStorage;

  setUp(() {
    mockFileStorage = MockFileStorage();
    universityRepository = UniversityRepository(mockFileStorage);
  });

  group('UniversityRepository', () {
    group('getUniversitiesData', () {
      test('should return list of universities when data is valid', () async {
        // Arrange
        final rawData = testUniversities.map((u) => u.toMap()).toList();
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await universityRepository.getUniversitiesData();

        // Assert
        expect(result.length, 2);
        expect(result[0].id, '1');
        expect(result[0].name, 'Royal University of Phnom Penh');
        expect(result[1].id, '2');
        expect(result[1].name, 'Institute of Technology of Cambodia');
        verify(mockFileStorage.readJsonData('universities.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await universityRepository.getUniversitiesData();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('universities.json')).called(1);
      });

      test('should handle empty data gracefully', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenAnswer((_) async => []);

        // Act
        final result = await universityRepository.getUniversitiesData();

        // Assert
        expect(result, isEmpty);
      });

      test('should handle invalid data format', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenAnswer((_) async => ['invalid data']);

        // Act
        final result = await universityRepository.getUniversitiesData();

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getUniversityById', () {
      test('should return university when ID exists', () async {
        // Arrange
        final rawData = testUniversities.map((u) => u.toMap()).toList();
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await universityRepository.getUniversityById('1');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, '1');
        expect(result.name, 'Royal University of Phnom Penh');
      });

      test('should return null when university ID does not exist', () async {
        // Arrange
        final rawData = testUniversities.map((u) => u.toMap()).toList();
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await universityRepository.getUniversityById(
          'nonexistent',
        );

        // Assert
        expect(result, isNull);
      });

      test('should return null when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await universityRepository.getUniversityById('1');

        // Assert
        expect(result, isNull);
      });

      test('should handle empty universities list', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('universities.json'),
        ).thenAnswer((_) async => []);

        // Act
        final result = await universityRepository.getUniversityById('1');

        // Assert
        expect(result, isNull);
      });
    });
  });
}
