import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/Domain/data/repository/career_repository.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late CareerRepository careerRepository;
  late MockFileStorage mockFileStorage;

  setUp(() {
    mockFileStorage = MockFileStorage();
    careerRepository = CareerRepository(mockFileStorage);
  });

  group('CareerRepository', () {
    group('getCareerData', () {
      test('should return list of careers when data is valid', () async {
        // Arrange
        final rawData = testCareers.map((c) => c.toMap()).toList();
        when(
          mockFileStorage.readJsonData('careers.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await careerRepository.getCareerData();

        // Assert
        expect(result.length, 2);
        expect(result[0].id, 'career1');
        expect(result[0].name, 'Software Engineer');
        expect(result[1].id, 'career2');
        expect(result[1].name, 'Civil Engineer');
        verify(mockFileStorage.readJsonData('careers.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('careers.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await careerRepository.getCareerData();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('careers.json')).called(1);
      });
    });

    group('getCareerById', () {
      test('should return career when ID exists', () async {
        // Arrange
        final rawData = testCareers.map((c) => c.toMap()).toList();
        when(
          mockFileStorage.readJsonData('careers.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await careerRepository.getCareerById('career1');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, 'career1');
        expect(result.name, 'Software Engineer');
        verify(mockFileStorage.readJsonData('careers.json')).called(1);
      });

      test('should return null when career ID does not exist', () async {
        // Arrange
        final rawData = testCareers.map((c) => c.toMap()).toList();
        when(
          mockFileStorage.readJsonData('careers.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await careerRepository.getCareerById('nonexistent');

        // Assert
        expect(result, isNull);
        verify(mockFileStorage.readJsonData('careers.json')).called(1);
      });

      test('should return null when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('careers.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await careerRepository.getCareerById('career1');

        // Assert
        expect(result, isNull);
        verify(mockFileStorage.readJsonData('careers.json')).called(1);
      });
    });
  });
}
