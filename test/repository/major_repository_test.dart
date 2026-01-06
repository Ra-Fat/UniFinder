import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/Domain/data/repository/major_repository.dart';
import 'package:uni_finder/Domain/model/Major/major_relationship.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late MajorRepository majorRepository;
  late MockFileStorage mockFileStorage;

  setUp(() {
    mockFileStorage = MockFileStorage();
    majorRepository = MajorRepository(mockFileStorage);
  });

  group('MajorRepository', () {
    group('getMajorsData', () {
      test('should return list of majors when data is valid', () async {
        // Arrange
        final rawData = testMajors.map((m) => m.toMap()).toList();
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await majorRepository.getMajorsData();

        // Assert
        expect(result.length, 2);
        expect(result[0].id, 'cs');
        expect(result[0].name, 'Computer Science');
        expect(result[1].id, 'eng');
        expect(result[1].name, 'Engineering');
        verify(mockFileStorage.readJsonData('majors.json')).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await majorRepository.getMajorsData();

        // Assert
        expect(result, isEmpty);
        verify(mockFileStorage.readJsonData('majors.json')).called(1);
      });

      test('should handle empty data gracefully', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenAnswer((_) async => []);

        // Act
        final result = await majorRepository.getMajorsData();

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getMajorById', () {
      test('should return major when ID exists', () async {
        // Arrange
        final rawData = testMajors.map((m) => m.toMap()).toList();
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await majorRepository.getMajorById('cs');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, 'cs');
        expect(result.name, 'Computer Science');
      });

      test('should return null when major ID does not exist', () async {
        // Arrange
        final rawData = testMajors.map((m) => m.toMap()).toList();
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await majorRepository.getMajorById('nonexistent');

        // Assert
        expect(result, isNull);
      });

      test('should return null when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await majorRepository.getMajorById('cs');

        // Assert
        expect(result, isNull);
      });
    });

    group('getMajorsByIds', () {
      test('should return majors matching the provided IDs', () async {
        // Arrange
        final rawData = testMajors.map((m) => m.toMap()).toList();
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await majorRepository.getMajorsByIds(['cs']);

        // Assert
        expect(result.length, 1);
        expect(result[0].id, 'cs');
        expect(result[0].name, 'Computer Science');
      });

      test(
        'should return multiple majors when multiple IDs provided',
        () async {
          // Arrange
          final rawData = testMajors.map((m) => m.toMap()).toList();
          when(
            mockFileStorage.readJsonData('majors.json'),
          ).thenAnswer((_) async => rawData);

          // Act
          final result = await majorRepository.getMajorsByIds(['cs', 'eng']);

          // Assert
          expect(result.length, 2);
          expect(result.map((m) => m.id), contains('cs'));
          expect(result.map((m) => m.id), contains('eng'));
        },
      );

      test('should return empty list when no matching IDs', () async {
        // Arrange
        final rawData = testMajors.map((m) => m.toMap()).toList();
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await majorRepository.getMajorsByIds(['nonexistent']);

        // Assert
        expect(result, isEmpty);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await majorRepository.getMajorsByIds(['cs']);

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getRelatedMajors', () {
      test('should return related majors for a given major', () async {
        // Arrange
        final relationships = [
          MajorRelationship(majorId: 'cs', relatedMajorId: 'eng'),
        ];

        final rawMajorsData = testMajors.map((m) => m.toMap()).toList();
        final rawRelationshipsData = relationships
            .map((r) => r.toMap())
            .toList();

        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenAnswer((_) async => rawMajorsData);
        when(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).thenAnswer((_) async => rawRelationshipsData);

        // Act
        final result = await majorRepository.getRelatedMajors('cs');

        // Assert
        expect(result.length, 1);
        expect(result[0].id, 'eng');
        expect(result[0].name, 'Engineering');
      });

      test(
        'should return empty list when major has no relationships',
        () async {
          // Arrange
          final relationships = [
            MajorRelationship(majorId: 'cs', relatedMajorId: 'eng'),
          ];

          final rawMajorsData = testMajors.map((m) => m.toMap()).toList();
          final rawRelationshipsData = relationships
              .map((r) => r.toMap())
              .toList();

          when(
            mockFileStorage.readJsonData('majors.json'),
          ).thenAnswer((_) async => rawMajorsData);
          when(
            mockFileStorage.readJsonData('major_relationships.json'),
          ).thenAnswer((_) async => rawRelationshipsData);

          // Act
          final result = await majorRepository.getRelatedMajors('nonexistent');

          // Assert
          expect(result, isEmpty);
        },
      );

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('majors.json'),
        ).thenThrow(Exception('File not found'));
        when(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await majorRepository.getRelatedMajors('cs');

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getMajorRelationshipsData', () {
      test('should return list of major relationships', () async {
        // Arrange
        final relationships = [
          MajorRelationship(majorId: 'cs', relatedMajorId: 'eng'),
        ];

        final rawData = relationships.map((r) => r.toMap()).toList();
        when(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await majorRepository.getMajorRelationshipsData();

        // Assert
        expect(result.length, 1);
        expect(result[0].majorId, 'cs');
        expect(result[0].relatedMajorId, 'eng');
        verify(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).called(1);
      });

      test('should return empty list when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await majorRepository.getMajorRelationshipsData();

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getMajorRelationships', () {
      test('should return grouped relationships map', () async {
        // Arrange
        final relationships = [
          MajorRelationship(majorId: 'cs', relatedMajorId: 'eng'),
          MajorRelationship(majorId: 'cs', relatedMajorId: 'math'),
          MajorRelationship(majorId: 'eng', relatedMajorId: 'cs'),
        ];

        final rawData = relationships.map((r) => r.toMap()).toList();
        when(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).thenAnswer((_) async => rawData);

        // Act
        final result = await majorRepository.getMajorRelationships();

        // Assert
        expect(result.length, 2);
        expect(result['cs'], contains('eng'));
        expect(result['cs'], contains('math'));
        expect(result['eng'], contains('cs'));
      });

      test('should return empty map when no relationships', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).thenAnswer((_) async => []);

        // Act
        final result = await majorRepository.getMajorRelationships();

        // Assert
        expect(result, isEmpty);
      });

      test('should return empty map when file storage throws error', () async {
        // Arrange
        when(
          mockFileStorage.readJsonData('major_relationships.json'),
        ).thenThrow(Exception('File not found'));

        // Act
        final result = await majorRepository.getMajorRelationships();

        // Assert
        expect(result, isEmpty);
      });
    });
  });
}
