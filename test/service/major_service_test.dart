import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/service/major_service.dart';
import 'package:uni_finder/Domain/model/Major/major_model.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late MajorService majorService;
  late MockMajorRepository mockMajorRepository;

  setUp(() {
    mockMajorRepository = MockMajorRepository();
    majorService = MajorService(mockMajorRepository);
  });

  group('MajorService', () {
    group('getMajorsData', () {
      test('should return list of majors', () async {
        // Arrange
        when(
          mockMajorRepository.getMajorsData(),
        ).thenAnswer((_) async => testMajors);

        // Act
        final result = await majorService.getMajorsData();

        // Assert
        expect(result, equals(testMajors));
        verify(mockMajorRepository.getMajorsData()).called(1);
      });

      test('should return empty list when no majors', () async {
        // Arrange
        when(mockMajorRepository.getMajorsData()).thenAnswer((_) async => []);

        // Act
        final result = await majorService.getMajorsData();

        // Assert
        expect(result, isEmpty);
        verify(mockMajorRepository.getMajorsData()).called(1);
      });
    });

    group('getMajorById', () {
      test('should return major when ID exists', () async {
        // Arrange
        when(
          mockMajorRepository.getMajorById('cs'),
        ).thenAnswer((_) async => testMajors[0]);

        // Act
        final result = await majorService.getMajorById('cs');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, 'cs');
        expect(result.name, 'Computer Science');
        verify(mockMajorRepository.getMajorById('cs')).called(1);
      });

      test('should return null when major ID does not exist', () async {
        // Arrange
        when(
          mockMajorRepository.getMajorById('nonexistent'),
        ).thenAnswer((_) async => null);

        // Act
        final result = await majorService.getMajorById('nonexistent');

        // Assert
        expect(result, isNull);
        verify(mockMajorRepository.getMajorById('nonexistent')).called(1);
      });
    });

    group('getRelatedMajorsForPrimary', () {
      test('should return related majors for a primary major', () async {
        // Arrange
        final relatedMajors = [testMajors[1]]; // Engineering
        when(
          mockMajorRepository.getRelatedMajors('cs'),
        ).thenAnswer((_) async => relatedMajors);

        // Act
        final result = await majorService.getRelatedMajorsForPrimary('cs');

        // Assert
        expect(result.length, 1);
        expect(result[0].id, 'eng');
        expect(result[0].name, 'Engineering');
        verify(mockMajorRepository.getRelatedMajors('cs')).called(1);
      });

      test(
        'should return empty list when major has no related majors',
        () async {
          // Arrange
          when(
            mockMajorRepository.getRelatedMajors('isolated'),
          ).thenAnswer((_) async => []);

          // Act
          final result = await majorService.getRelatedMajorsForPrimary(
            'isolated',
          );

          // Assert
          expect(result, isEmpty);
          verify(mockMajorRepository.getRelatedMajors('isolated')).called(1);
        },
      );

      test('should handle repository errors gracefully', () async {
        // Arrange
        when(
          mockMajorRepository.getRelatedMajors('cs'),
        ).thenThrow(Exception('Repository error'));

        // Act & Assert
        expect(
          () => majorService.getRelatedMajorsForPrimary('cs'),
          throwsA(isA<Exception>()),
        );
        verify(mockMajorRepository.getRelatedMajors('cs')).called(1);
      });
    });

    group('Integration scenarios', () {
      test('should handle complete major lookup workflow', () async {
        // Arrange
        when(
          mockMajorRepository.getMajorsData(),
        ).thenAnswer((_) async => testMajors);
        when(
          mockMajorRepository.getMajorById('cs'),
        ).thenAnswer((_) async => testMajors[0]);
        when(
          mockMajorRepository.getRelatedMajors('cs'),
        ).thenAnswer((_) async => [testMajors[1]]);

        // Act
        final allMajors = await majorService.getMajorsData();
        final specificMajor = await majorService.getMajorById('cs');
        final relatedMajors = await majorService.getRelatedMajorsForPrimary(
          'cs',
        );

        // Assert
        expect(allMajors.length, 2);
        expect(specificMajor!.id, 'cs');
        expect(relatedMajors.length, 1);
        expect(relatedMajors[0].id, 'eng');

        verify(mockMajorRepository.getMajorsData()).called(1);
        verify(mockMajorRepository.getMajorById('cs')).called(1);
        verify(mockMajorRepository.getRelatedMajors('cs')).called(1);
      });
    });
  });
}
